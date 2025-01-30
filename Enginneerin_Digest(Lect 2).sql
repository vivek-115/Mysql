CREATE DATABASE test; 
USE test;

CREATE TABLE employees(
	employee_id int primary key auto_increment,
	first_name varchar(50) NOT NULL ,
    last_name varchar(50) NOT NULL,
    hire_date date default (CURRENT_DATE()),
    email varchar(100) unique,
    phone_number varchar(100) unique,
    salary decimal(10,2) check (salary>0.0),
    employment_status enum('active','on leave','terminated') default 'active',
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp
); 

insert into employees(
first_name,
last_name,
email,
phone_number,
salary,
hire_date,
emergency_contact,
department_id)
values ('Michael','Chang','michael.chang@gmail.com','+91 34567886',71000,'2005-06-10','Chang Family: +12-1-432-9876',1);

SELECT * from employees;
SELECT * from department;

Alter table employees
add column description text;

Alter table employees 
drop column description;


alter table employees
add column emergency_contact varchar(100) not null check (emergency_contact REGEXP '^[A-Za-z ]+: [0-9+-]+$'); 

Desc employees;
alter table employees
add column emergency_contact varchar(100);

alter table employees 
add check (emergency_contact REGEXP '^[A-Za-z ]+: [0-9+-]+$');

alter table employees
modify column department_id int not null;

alter table employees
add column department_id int;

alter table employees
drop column department_id;

alter table employees
add column department_id int;

alter table employees
add foreign key(department_id) references department(department_id);

CREATE TABLE department(
	department_id int primary key auto_increment,
    department_name varchar(100) not null,
    location varchar(100),
    Created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp
    );
    
    Insert into department(
    department_name,
    location)
    values('Accounts','Delhi');
    



