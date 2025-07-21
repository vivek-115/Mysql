CREATE DATABASE selfjoin_DB;
USE selfjoin_DB;

CREATE TABLE employee(
	employee_id INT PRIMARY KEY,
    first_name VARCHAR(50) ,
    last_name VARCHAR(50) ,
    job_title VARCHAR(50) ,
    salary DECIMAL(10,2) ,
    department VARCHAR(50) ,
    manager_id INT ,
    hire_date DATE 
    );
    
    
INSERT INTO employee VALUES
(1, 'James', 'Smith', 'CEO', 150000.00, 'Executive', NULL, '2010-01-15'),
(2, 'Sarah', 'Johnson', 'CTO', 140000.00, 'Technology', 1, '2011-03-10'),
(3, 'Michael', 'Williams', 'CFO', 140000.00, 'Finance', 1, '2012-07-22'),
(4, 'Jessica', 'Brown', 'HR Director', 110000.00, 'Human Resources', 1, '2013-05-18'),
(5, 'David', 'Miller', 'Senior Developer', 95000.00, 'Technology', 2, '2014-11-05'),
(6, 'Emily', 'Davis', 'Developer', 80000.00, 'Technology', 5, '2016-08-12'),
(7, 'Robert', 'Wilson', 'Junior Developer', 65000.00, 'Technology', 5, '2019-02-28'),
(8, 'Jennifer', 'Taylor', 'Accountant', 75000.00, 'Finance', 3, '2015-09-17'),
(9, 'Thomas', 'Anderson', 'Accountant', 72000.00, 'Finance', 3, '2017-06-24'),
(10, 'Lisa', 'Martinez', 'HR Specialist', 68000.00, 'Human Resources', 4, '2018-04-30');

SELECT * FROM employee;

SELECT *
FROM employee emp
LEFT JOIN employee mgr
ON emp.manager_id=mgr.employee_id;

SELECT department, count(*), group_concat(CONCAT(e.first_name,' ',e.last_name) ORDER BY e.employee_id separator ' , ') AS employees
FROM employee e
GROUP BY department;

-- EXAMPLE 5: Find employees who make less than their managers
-- Self join to compare employee salaries with their manager's salary
SELECT *
FROM employee e1 
JOIN employee e2
ON e1.manager_id=e2.employee_id
WHERE e1.salary>e2.salary;

-- EXAMPLE 6: Calculate average salary difference between employees and managers by department
-- This shows how to use aggregate functions with self joins
SELECT 
	e1.department,
    count(e1.employee_id),
	ROUND(avg(e1.salary),2) as avg_emp_salary,
    ROUND(avg(e2.salary),2) as avg_manager_salary,
    ROUND(AVG(e2.salary-e1.salary),2) AS avg_salary_difference
FROM employee e1 
JOIN employee e2
ON e1.manager_id=e2.employee_id
GROUP BY e1.department
ORDER BY  avg_salary_difference desc;


