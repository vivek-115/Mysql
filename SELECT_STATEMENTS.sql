CREATE DATABASE company;
use company;

DESC employees;

CREATE TABLE employees(
	employee_id int auto_increment primary key,
    first_name varchar(50),
    last_name varchar(50),
    department varchar(50),
    salary decimal(10.2),
    hire_date date);
    
INSERT INTO employees (first_name, last_name, department, salary, hire_date) VALUES
('John', 'Doe', 'HR', 60000.00, '2022-05-10'),
('Jane', 'Smith', 'IT', 75000.00, '2021-08-15'),
('Alice', 'Johnson', 'Finance', 82000.00, '2019-03-20'),
('Bob', 'Williams', 'IT', 72000.00, '2020-11-25'),
('Charlie', 'Brown', 'Marketing', 65000.00, '2023-01-05'); 

select first_name, last_name from employees;
select first_name as 'First Name', last_name as 'LAST NAME' from employees;

select * from employees where department='IT' order by salary ASC;
select * from employees where department='IT' order by salary DESC;

-- This will give the highest salary of person in the table working in I.T
select * from employees where department='IT' order by salary DESC limit 1;

select department from employees;
select distinct department from employees;

select first_name, last_name, salary*1.1 as 'SALARY AFTER RAISE' from employees;
select concat(first_name, ' ', last_name) as 'Full Name' from employees;
select YEAR(hire_date) from employees;
select ROUND(salary) from employees;
select YEAR(hire_date),ROUND(salary) from employees where salary>70000;

select avg(salary) from employees;
select * from employees where salary>70800.000;

select * from employees where salary>(select avg(salary) from employees);

select first_name, last_name from employees where department='IT'
UNION
select first_name, last_name from employees where department='HR';

-- Tell me how many employees are there in each department

select count(*),department from employees group by department;

select 2+2;
select now();
select now() as Time;
select length('Vivek');
select 5>3;