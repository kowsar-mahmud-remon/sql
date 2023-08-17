-- ## DELETE DATABASE
-- DROP DATABASE university_management

-- ## create database
-- CREATE DATABASE text2

-- ## Rename DATABASE
-- ALTER DATABASE text2 RENAME TO test1;

-- ## create a student TABLE
-- CREATE TABLE student (
--   student_id INT ,
--   first_name VARCHAR(50),
--   last_name VARCHAR(50),
--   cgpa NUMERIC(1,2)
-- )

-- ## Rename a table name
-- ALTER TABLE student RENAME TO learners

-- ## Delete a TABLE
-- DROP TABLE learners

-- ## create a table with constraints
-- CREATE TABLE newUser(
--   user_id SERIAL PRIMARY KEY,
--   username VARCHAR(255) UNIQUE NOT NULL,
--   email VARCHAR(255) UNIQUE
-- )

-- CREATE TABLE newUser2(
--   user_id SERIAL,
--   username VARCHAR(255)  NOT NULL,
--   email VARCHAR(255) ,
--   PRIMARY KEY(user_id, username),
--   UNIQUE(username,email),
--   age INT DEFAULT 18
-- )

-- insert into newUser2 VALUES (1,'abc','abc@gmail.com');

-- SELECT * FROM newuser2;

-- ## Alter TABLE
-- add a column, drop a column, change datatype of column
-- Rename a column, set Default value for a COLUMN
-- add constraint to a column, drop constraint for a column
-- table rename
-- ALTER TABLE table_name action  

-- add a column
-- ALTER TABLE newuser
-- add column password VARCHAR(255) DEFAULT 'admin123
-- ' not null

-- ALTER TABLE newuser add COLUMN demo int

-- delete a column
-- ALTER TABLE newuser
-- drop column password

-- change datatype of a column
-- ALTER TABLE newuser
-- alter COLUMN demo type text

-- set default value
-- AlTER TABLE newuser
-- alter COLUMN demo set DEFAULT 'bangladesh'

-- remove default VALUES
-- AlTER TABLE newuser
-- alter COLUMN demo DROP DEFAULT;

-- rename a column
-- ALTER TABLE newuser
-- RENAME COLUMN demo to country;

-- Add CONSTRAINT
-- ALTER TABLE newuser
-- alter COLUMN country set not NULL;

-- drop a CONSTRAINT
-- ALTER TABLE newuser
-- alter COLUMN country drop not NULL;

-- add a CONSTRAINT
-- ALTER TABLE newuser
-- ADD constraint UNIQUE_email UNIQUE(email);

-- DELETE a CONSTRAINT 
-- ALTER TABLE newuser
-- DROP constraint UNIQUE_email;

-- remove all table DATA
-- TRUNCATE TABLE newuser;

-- add new value 
-- insert into newuser values (3, 'kowsar','kowsar@gmail.com')

-- see all data from table
SELECT * FROM newuser;









------------------------------------
------------------------------------

-- Department TABLE
-- Each department has many employees
-- create TABLE Department (
-- deptId SERIAL PRIMARY KEY,
-- deptName VARCHAR(50)
-- );

insert into Department values (1,'IT');
DELETE FROM Department where deptId = 1;

SELECT * FROM Department;



-- Employ TABLE
-- Each employ belongs to a department 
create TABLE Employee(
empId SERIAL PRIMARY KEY,
empName VARCHAR(50) NOT NULL,
departmentId INT,
constraint fk_constrain_dept
FOREIGN KEY(departmentId)
REFERENCES Department(deptId)
);


insert into Employee values (1,'Remon',1);

DELETE FROM Employee where empId = 1;


-- create a table
CREATE TABLE courses(
  course_id serial PRIMARY KEY,
  course_name VARCHAR(255) NOT NULL,
  description VARCHAR(255),
  published_date DATE
);

-- add value in TABLE
INSERT INTO
courses(course_name,description,published_date)
VALUES('PostgreSQL for Developers','A complete PostgreSQL for Developers','2023-08-09');

-- update a table row
UPDATE courses
SET
course_name = 'PostgreSQL for Beginners',
description = 'PostgreSQL Developers'
-- WHERE course_id > 4;
-- WHERE course_id > 1 OR course_id <5;
-- WHERE course_id > 1 AND course_id <5;
WHERE course_id = 1;


-- delete row
DELETE FROM courses
WHERE course_id = 2;

--------------------------------
-- SELECT some column 
--------------------------------
SELECT course_id,description FROM courses;
-- SELECT DISTINCT course_id FROM courses;

-- find data 
SELECT * FROM courses
-- WHERE salary > 1000;
-- WHERE salary > 1000 AND salary < 90000;
-- WHERE salary < 1000 OR salary > 90000;
-- WHERE published_date >= '2024-01-01';
WHERE  course_name <> 'PostgreSQL for Developers';

-- sort value 
SELECT * FROM courses ORDER BY description ASC LIMIT 2;
SELECT * FROM courses ORDER BY description DESC LIMIT 1 OFFSET 1;


-------------------------------------
-- IN, NOT IN, BETWEEN, LIKE
-------------------------------------
SELECT * FROM courses WHERE course_id IN(1,2);

SELECT * FROM courses WHERE course_id NOT IN(1,2);

SELECT * FROM courses WHERE course_id BETWEEN 1 AND 3;

-- LIKE
SELECT * FROM courses WHERE  course_name LIKE 'P%';
SELECT * FROM courses WHERE  course_name LIKE '%P';
SELECT * FROM courses WHERE  course_name LIKE '%P%';

-- SPECIFIC position
SELECT * FROM courses WHERE  course_name LIKE '_P%';
SELECT * FROM courses WHERE  course_name LIKE '__P__';
SELECT * FROM courses WHERE  course_name LIKE 'P%s';
SELECT * FROM courses WHERE  course_name IS NULL;



-------------------------
-- JOIN
-------------------------

-- INNER JOIN
-- SELECT employee.full_name, employee.job_role, department.department_name
SELECT *
FROM employee
INNER JOIN department ON department.department_id = employee.department_id;

-- LEFT JOIN
SELECT *
FROM employee
LEFT JOIN department ON department.department_id = employee.department_id;

-- RIGHT JOIN
SELECT *
FROM employee
RIGHT JOIN department ON department.department_id = employee.department_id;

-- FULL JOIN
SELECT *
FROM employee
FULL JOIN department ON department.department_id = employee.department_id;

-- FULL JOIN
SELECT *
FROM employee
NATURAl JOIN department;

--------------------------------
-- Aggregate Function
--------------------------------
SELECT AVG(salary) FROM employee;

SELECT AVG(salary) AS AverageSalary FROM employee;

SELECT MIN(salary) AS AverageSalary FROM employee;

SELECT MAX(salary) AS AverageSalary FROM employee;

SELECT SUM(salary) AS AverageSalary FROM employee;

SELECT deptId, AVG(salary) FROM employee GROUP BY deptId;

SELECT deptId, SUM(salary) FROM employee GROUP BY deptId;

SELECT d.name, AVG(e.salary), SUM(e.salary), MAX(e.salary) FROM employees e
FULL JOIN departments d on e.deptId = d.deptId
GROUP BY d.name;

SELECT d.name, AVG(e.salary), SUM(e.salary), MAX(e.salary) FROM employees e
FULL JOIN departments d on e.deptId = d.deptId
GROUP BY d.name HAVING avg(e.salary) > 60000;

------------------------------
-- sub query 
------------------------------
SELECT * FROM employees WHERE salary = (
  SELECT max(salary) FROM employees
);

SELECT * FROM employees WHERE salary IN (
  SELECT salary FROM employees WHERE name LIKE '%a%'
);

SELECT * FROM employees WHERE salary > (
  SELECT AVG(salary) FROM employees
)


----------------------------
-- VIEW 
----------------------------
CREATE VIEW view_name
AS
SELECT emp_name FROM employees;

CREATE VIEW department_emp_count
AS
SELECT department_name, COUNT(emp_id) FROM employees e
JOIN department d ON d.department = e.department_id
GROUP BY d.department_id; 

------------------------------
------------------------------
CREATE PROCEDURE deactivate_unpaid_account()
LANGUAGE SQL
AS $$
  UPDATE accounts SET account = false WHERE balance = 0
$$;
CALL deactivate_unpaid_account();
----

CREATE FUNCTION account_type_count(account_type text) RETURNS integer
LANGUAGE plpgsql
AS $$
DECLARE account_count int;
  BEGIN
  SELECT COUNT(*) into account_type from accounts WHERE account.account_type = $1;
  END;
$$;

-------------------------------
-- TRIGGER 
-------------------------------
CREATE TABLE products(
  id serial PRIMARY KEY,
  title VARCHAR(255) not null,
  base_price FLOAT8 NOT NULL,
  final_price FLOAT8
);

INSERT into products(title,base_price) values ('Apple',80);

-- TRIGGER
CREATE OR REPLACE TRIGGER add_tax_trigger
AFTER
INSERT ON Products
FOR EACH ROW
EXECUTE FUNCTION update_final_price();

CREATE OR REPLACE FUNCTION update_final_price()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
  BEGIN
    NEW.final_price := NEW.base_price * 1.05;
    RETURN NEW;
  END;
$$;


-----------------------------
-- INDEX 
-----------------------------
CREATE INDEX name_index ON employees(name);







SELECT * FROM products;

