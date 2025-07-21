-- CROSS JOIN
-- Cartesian Products of two tables
-- It combines each row from first table and every row from the second table; 
-- resulting in all possible combinations of rows

CREATE DATABASE cross_joinDB;
USE cross_joinDB;

CREATE TABLE products(
	product_id INT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL
);

CREATE TABLE colors(
	color_id INT PRIMARY KEY,
    color_name VARCHAR(50) NOT NULL
);

INSERT INTO products(product_id,product_name)
VALUES
(1,'T-Shirt'),
(2,'Jeans'),
(3,'Sweater'),
(4,'Jacket');

SELECT * FROM products;

INSERT INTO colors(color_id,color_name)
VALUES
(1,'Red'),
(2,'Blue'),
(3,'Green'),
(4,'Black'),
(5,'White');

SELECT * FROM colors;

SELECT p.product_name, c.color_name
FROM products p 
CROSS JOIN colors c;

CREATE TABLE sizes(
	size_id INT PRIMARY KEY,
    size_name VARCHAR(50) NOT NULL
    );

INSERT INTO sizes(size_id,size_name)
VALUES
(1,'S'),
(2,'M'),
(3,'L'),
(4,'XL');



SELECT p.product_name, c.color_name, s.size_name,CONCAT(p.product_name,' - ',c.color_name,' - ',s.size_name) AS full_description
FROM products p 
CROSS JOIN colors c 
CROSS JOIN sizes s;


SELECT p.product_name, c.color_name, s.size_name
FROM products p 
CROSS JOIN colors c 
CROSS JOIN sizes s
WHERE p.product_name='T-Shirt';  -- Query Optimizer

-- Cross Join is Expensive, so use Filters, Limits etc





