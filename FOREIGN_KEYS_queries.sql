
-- To Establish a relationship bewteen tables we use a Foreign key

-- A Foreign Key is a column or set of columns in one table that refers to the primary key in another table
-- It creates a link between the two tables, establishing a parent-child relationship
-- Parent --> Contains the primary key that is referred
-- Child --> contains the Foreign Key that references the primary key of the parent table

-- Purpose of Foreign Key?
-- 1. Referential Integrity(RelationShip between the table remains consistent)
-- 2. Data Validation
-- 3. Structured Relationship (A Clear and logical relationship that mirrors real world relationship)

-- For Exammple
-- A "customer" table with customer Id's as the primary key
-- An 'Order' table with a foreign key that refers to the customer Id

-- Referential integerity
-- You can't add an order for a customer that doesn't exits;
-- You can't delete a customer who has existing orders(Unless you specify what should happen to those orders)

-- 3.Types of RelationShip
-- One-to-One (1:1): Ecah Record in Table A relates to exactly one record in Table B
-- One-to-Many(1:N): Each record in Table A relates to multiple records in Table B;
-- Many-to-Many(N:N): Multiple records in Table A relates to multiple records in Table B

create database db100;
use db100;
CREATE TABLE department(
	department_id INT NOT NULL,
    department_name VARCHAR(50),
    location VARCHAR(100),
    PRIMARY KEY(department_id)
);    
DESC department;
SELECT * FROM department;

CREATE TABLE employee(
	employee_id INT NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    hire_date DATE,
    salary DECIMAL(10,2),
    department_id INT ,
    PRIMARY KEY(employee_id),
    foreign key(department_id) references department(department_id)
);    
DESC employee;
SELECT * FROM employee;

INSERT INTO department VALUES
    (1, 'Human Resources', 'Floor 1'),
    (2, 'Marketing', 'Floor 2'),
    (3, 'Engineering', 'Floor 3'),
    (4, 'Finance', 'Floor 1');

INSERT INTO employee VALUES
    (101, 'John', 'Smith', 'john.smith@company.com', '2018-06-20', 55000.00, 1),
    (102, 'Sarah', 'Johnson', 'sarah.johnson@company.com', '2019-03-15', 62000.00, 2),
    (103, 'Michael', 'Williams', 'michael.williams@company.com', '2020-01-10', 75000.00, 3),
    (104, 'Emily', 'Brown', 'emily.brown@company.com', '2019-11-05', 68000.00, 3),
    (105, 'David', 'Jones', 'david.jones@company.com', '2021-02-28', 58000.00, 4),
    (106, 'Jessica', 'Davis', 'jessica.davis@company.com', '2020-07-16', 61000.00, 2),
    (107, 'Robert', 'Miller', 'robert.miller@company.com', '2018-09-12', 72000.00, 3);
 
-- - DEMONSTRATING FOREIGN KEY CONSTRAINT
-- ====================================

-- Attempt to insert an employee with non-existent department_id (this will fail) --> this is only called as Referential integerity
INSERT INTO employee values
(109,'Thomas','Wilson', 'thomas.wilson@company.com', '2015-05-02',50000.00,60);
-- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails

-- Insert an employee with NULL department_id (allowed if the foreign key allows NULL)  -> This is called Optional relationship
INSERT INTO employee VALUES
(145,'John','Smith','john.smith@company.com','2018-06-20', 55000.00,NULL);

CREATE TABLE projects(
	project_id INT NOT NULL,
    project_name VARCHAR(100) NOT NULL,
    start_date DATE,
    end_date DATE,
    manager_id INT,
    PRIMARY KEY(project_id)
); 

-- Add a foreign key constraint after table creation
ALTER TABLE projects
ADD FOREIGN KEY(manager_id) references employee(employee_id);   

-- gives excat table structure; if you want to recreate the table
SHOW CREATE TABLE projects;  
'projects', 'CREATE TABLE `projects` (\n  `project_id` int NOT NULL,\n  `project_name` varchar(100) NOT NULL,\n  `start_date` date DEFAULT NULL,\n  `end_date` date DEFAULT NULL,\n  `manager_id` int DEFAULT NULL,\n  PRIMARY KEY (`project_id`),\n  KEY `manager_id` (`manager_id`)\n) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci'

ALTER TABLE projects
DROP FOREIGN KEY projects_ibfk_1;



-- Create a table for employee skills with a foreign key to employees
CREATE TABLE employee_skills(
	skill_id INT NOT NULL,
    skill_name varchar(50) NOT NULL,
    proficiency_level ENUM('Beginner', 'Intermediate', 'Advanced', 'Expert') NOT NULL,
    employee_id INT NOT NULL,
    PRIMARY KEY(skill_id),
    FOREIGN KEY(employee_id) references employee(employee_id)
    );
    
INSERT INTO employee_skills(skill_id,employee_id,skill_name,proficiency_level) VALUES
(1, 103, 'Python', 'Expert'),
    (2, 103, 'SQL', 'Advanced'),
    (3, 104, 'Java', 'Intermediate'),
    (4, 107, 'C++', 'Advanced'),
    (5, 107, 'SQL', 'Expert'),
    (6, 102, 'Graphic Design', 'Advanced');
    
SELECT * FROM employee_skills;
    