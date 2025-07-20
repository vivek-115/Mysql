CREATE DATABASE dbunion;
USE dbunion;

-- Union / Union All
-- Allows us to combine result sets from multiple SELECT queries into a single result set

CREATE TABLE headquater_employees(
	employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    hire_date DATE,
    department VARCHAR(50),
    salary DECIMAL(10,2)
);

CREATE TABLE branch_employees(
	employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    hire_date DATE,
    department VARCHAR(50),
    salary DECIMAL(10,2)
);

CREATE TABLE customers(
	customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    signup_date DATE,
    status VARCHAR(20)
);
DESC customers;

INSERT INTO headquater_employees
VALUES
(101,'John','Smith','john.smith@company.com','2018-03-15','IT',75000.00),
(102,'Marry','Johnson','marry.johnson@company.com','2019-06-22','HR',65000.00),
(103,'Robert','Williams','robert.williams@company.com','2017-11-08','Finance',82000.00),
(104,'Susan','Brown','susan.brown@company.com','2020-01-30','Marketing',68000.00),
(105,'Michael','Davis','michael.davis@company.com','2018-09-12','IT',78000.00);

INSERT INTO branch_employees
VALUES
(201,'James','Williams','james.williams@company.com','2019-04-18','Sales',62000.00),
(202,'Patricia','Moore','patricia.moore@company.com','2020-07-25','Marketing',59000.00),
(203,'Linda','Taylor','linda.taylor@company.com','2018-08-15','HR',61000.00),
(204,'Robert','Williams','robert.williams@company.com','2017-11-08','Finance',82000.00),  --  Same as of the headquater_employees Table
(205,'Elizabeth','Anderson','elizabeth.anderson@company.com','2019-12-03','Sales',64000.00);

INSERT INTO customers
VALUES
(1001,'David','Miller','david.miller@gmail.com','2019-02-14','Active'),
(1002,'Sarah','Wilson','sarah.wilson@gmail.com','2020-05-20','Active'),
(1003,'Michael','Davis','michael.davis@gmail.com','2018-11-30','Inactive'),
(1004,'Jennifer','Garcia','jennifer.garcia@gmail.com','2021-01-05','Active'),
(1005,'Robert','Martinez','robert.martinez@gmail.com','2019-08-22','Active');

SELECT * FROM headquater_employees
UNION
SELECT * FROM branch_employees;

SELECT first_name, last_name, email FROM headquater_employees   -- 
UNION
SELECT first_name, last_name, email FROM branch_employees;

-- UNION ALL
SELECT first_name, last_name, email FROM headquater_employees
UNION ALL
SELECT first_name, last_name, email FROM branch_employees;

-- Basic UNION Examples
-- ====================================================================
-- Example 1: UNION vs UNION ALL
-- Get a list of all employees from both locations (without duplicates)

SELECT first_name, last_name, email
FROM headquater_employees
UNION
SELECT first_name, last_name,email
FROM branch_employees;

-- Get a list of all employees from both locations (including duplicates)
SELECT first_name, last_name, email
FROM headquater_employees
UNION ALL
SELECT first_name, last_name,email
FROM branch_employees;

-- Example 2: Combining full tables
SELECT * FROM headquater_employees
UNION ALL
SELECT * FROM branch_employees;

-- Advanced UNION Examples
-- ====================================================================
-- Example 3: Adding a descriptor column
-- Combine employee and customer contact information with a type indicator
SELECT first_name, last_name, email, 'Employee' AS contact_type
FROM headquater_employees
UNION
SELECT first_name, last_name, email,'Customer' AS contact_type1
FROM customers;

-- Example 4: Ordering results after UNION
-- Get all employees sorted by last name
SELECT first_name, last_name, email 
FROM headquater_employees
UNION ALL
SELECT first_name, last_name, email
FROM branch_employees
ORDER BY last_name;

-- Example 5: Filtering before UNION
-- Get employees with salary over 70000
SELECT first_name, last_name, email, salary
FROM headquater_employees WHERE salary>70000
UNION 
SELECT first_name, last_name, email, salary
FROM branch_employees WHERE salary>70000
ORDER BY salary DESC;

-- Handling Different Column Structures
-- ====================================================================
-- Example 6: Handling different table structures with NULL values
SELECT first_name, last_name, email,department, 'NULL' AS status
FROM 
headquater_employees
UNION
SELECT first_name, last_name, email,NULL,status
FROM customers;

-- Practical Use Cases
-- ====================================================================
-- Example 7: Finding all unique departments across locations
SELECT department 
FROM headquater_employees
UNION 
SELECT department
FROM branch_employees;

-- Example 8: Finding common departments (advanced)
-- Departments that exist in both headquarters and branch offices
SELECT department, count(*) FROM 
(SELECT DISTINCT department FROM headquater_employees
UNION ALL
SELECT DISTINCT department FROM branch_employees) AS c
GROUP BY department 
HAVING COUNT(*)=2;


    