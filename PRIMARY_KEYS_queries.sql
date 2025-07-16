CREATE DATABASE db13;
USE db13;

-- PRIMARY KEY
-- A column or a set of column which uniquely identifies each row in a column
-- In Relational DataBase's it is the most basic and important thing

-- Characteristics
-- 1. It should be unique
-- 2. The Field cannot be null
-- 3. The Value should be stable i.e It should not be that way, thaat we are changing/Updating the primary key again and again

CREATE TABLE students(
	student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100)
    );

-- Primary Keys - Key Benefits:
-- They uniquely identify each record in a table
-- They ensure no duplicate records exist
-- They provide a reference point for relationships between tables (Primary key is the Only reference point fot the connection bweteen the 2 tables)
-- They optimize database performance for record retrieval (Primary Key ensures Faster reterival of the data)

INSERT INTO students VALUES
(1,'John','Smith', 'john@example.com'),
(2,'Maria','Garcia', 'maria@example.com'),
(3,'Ahmed','Khan', 'ahmed@example.com');

SELECT * FROM students;

-- We Cannot insert the data again with the same PRIMARY KEY. It will give an error
-- Error Code: 1062. Duplicate entry '1' for key 'students.PRIMARY'
INSERT INTO students VALUES
(1,'John','Smith', 'john@example.com');

-- Generally whenever we make a column as a primary key we don't manually insert the values;
-- we keep that on a AUTO_INCREMENT(which means the values keeps on increasing automatically)

-- Creating a table with AUTO_INCREMENT
CREATE TABLE products(
	product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    description TEXT
    );

INSERT INTO products(product_name,price,description) VALUES
('Laptop',1299.99,'High-Performance Laptop'),
('Smartphone',799.99,'Latest model Smartphone'),
('HeadPhones',199.99,'Noise-Cancelling headphones');

SELECT * FROM products;

-- Creating a table with a primary key defined separately
CREATE TABLE orders(
	order_id INT ,
    customer_id INT,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (order_id)
);

-- Create table without primary key
CREATE TABLE suppliers(
	supplier_id INT,
    supplier_name VARCHAR(100) NOT NULL,
    contact_person VARCHAR(100)
);    
DESC suppliers;    

-- Adding a primary key to an existing table
ALTER TABLE suppliers
ADD PRIMARY KEY(supplier_id);    

-- Composite Primary Key
-- We can combine multiple columns to make primary key called as Composite Primary Key;    

CREATE TABLE enrollments(
	student_id INT,
    course_id INT,
    enrollment_date DATE NOT NULL,
    grade VARCHAR(2),
    PRIMARY KEY(student_id, course_id)
    );

INSERT INTO enrollments VALUES
(1,101,'2023-01-15', 'A'),
(1,102,'2023-01-15','B+'), -- Same student, different course - OK
(2,101,'2023-01-16','A-'), -- Different student, same course - OK
(3,103,'2023-01-17','B-');

SELECT * FROM enrollments;

-- This will fail - duplicate composite key (student_id + course_id) 	
INSERT INTO enrollments VALUES
(1,101,'2023-02-16','C');
-- Error: Duplicate entry '1-101' for key 'PRIMARY'

-- Primary Key Best Practices:
-- 1. Always include a primary key in every table
-- 2. Use auto-increment unless you have a specific reason not to
-- 3. Keep primary keys simple - use INT or BIGINT for numeric IDs
