
-- USAGE WITH MULTIPLE COLUMNS
-- CUSTOM SORTING ORDER
-- NULL VALUE HANDLING
-- ADVANCED SORTING TECHNIQUES
-- PERFORMANCE CONSIDERATIONS
-- BEST PRACTICES

-- FOR SORTING WE USE 'ORDER BY'

CREATE DATABASE db12;
USE db12;
CREATE TABLE products(
	products_id INT PRIMARY KEY,
    product_name varchar(100),
    category varchar(50),
    price DECIMAL(10,2),
    stock_quantity INT,
    last_updated TIMESTAMP);

INSERT INTO products VALUES
(1, 'Laptop Pro', 'Electronics', 1299.99, 50, '2024-01-15 10:00:00'),
(2, 'Desk Chair', 'Furniture', 199.99, 30, '2024-01-16 11:30:00'),
(3, 'Coffee Maker', 'Appliances', 79.99, 100, '2024-01-14 09:15:00'),
(4, 'Gaming Mouse', 'Electronics', 59.99, 200, '2024-01-17 14:20:00'),
(5, 'Bookshelf', 'Furniture', 149.99, 25, '2024-01-13 16:45:00');

SELECT * FROM products;
SELECT * FROM products ORDER BY price ASC;

-- HOW TO SORT ON THE BASIS OF MULTIPLE COLUMNS
SELECT * FROM products ORDER BY category desc, price desc;


-- factors which decide the order of displaying the results if we are not using the 'ORDER BY' cluase;
-- if the underline storage engine is different then the results can be different depending on the storage engine
-- agar aapne koi query phele chaliyeh thee toh uska data cache mein store ho gaya ho ga
-- toh Mysql socha hai todha data cache se le ata hun aur todha disk se le ata hun
-- toh estarah se data inconsitent dikh sakta hai 

-- SORTING BY USING COLUMN POSITIONS
-- NOT RECOMMENDED
-- BEACUSE IF IN FUTURE SOMEONE CHANGES THE TABLE STRUCTURE USING ALTER/UPDATE/DELETE,  THEN THE ORDER BY WON'T WORK PROPERLY
SELECT * FROM products ORDER BY 4;  

-- SORTING BY USING WHERE CLAUSE
SELECT * FROM products where category='Electronics' ORDER BY price;

-- for case sensitive sorting
SELECT * FROM products ORDER BY binary category;

-- sorting with functions
SELECT product_name, length(product_name) from products;
SELECT * FROM products ORDER BY length(product_name);

-- will sort as per the year
SELECT * FROM products ORDER BY year(last_updated);

-- will sort as per the day
SELECT * FROM products ORDER BY day(last_updated) ASC;

SELECT * FROM products ORDER BY last_updated;

-- ORDER BY AND LIMIT
SELECT * FROM products ORDER BY stock_quantity DESC limit 1;

-- CUSTOM SORTING

-- What if i want my results such that the Electronics items should come first
-- CUSTOM SOTING USING 'FIELD()' function
SELECT * FROM products ORDER BY field(category, 'Electronics','Appliances','Furniture'), price DESC ;

-- CUSTOM SORTING USING CASE
-- This is for more complex logic

-- in this case we are using a condition instead of a column for sorting and hence sql will create two buckets
-- one for all the items which have a stock_quantity of less than 50 and other for all the quantities which are greater than 50

-- Drawback as i have to think a alot
-- not readable
SELECT *,stock_quantity<=50 and price>=200 FROM products ORDER BY (stock_quantity<=50 and price>=200) DESC;

SELECT *,CASE
		WHEN stock_quantity<=50 and price>=200 THEN 1
        WHEN stock_quantity<50  THEN 2
        ELSE 3
END as priority FROM products
ORDER BY
	CASE
		WHEN stock_quantity<=50 and price>=200 THEN 1
        WHEN stock_quantity<50  THEN 2
        ELSE 3
END;


-- can also be written as below using alias
SELECT *,CASE
		WHEN stock_quantity<=50 and price>=200 THEN 1
        WHEN stock_quantity<50  THEN 2
        ELSE 3
END as priority FROM products
ORDER BY priority;


-- Handling NULL values
INSERT INTO products VALUES
(6, 'Desk Lamp', 'Furniture', NULL, 45, '2024-01-18 13:25:00'),
(7, 'Keyboard', 'Electronics', 89.99, NULL, '2024-01-19 15:10:00');

SELECT * FROM products;

-- by default null will come first when we sort it by using 'ORDER BY' clause
SELECT * FROM products ORDER BY price;

-- we can use custom sorting using the conditions so that buckets can be formed
SELECT *,price is null as priority FROM products ORDER BY price is null;

-- Sorting with Calculated Columns;
SELECT *, price*stock_quantity FROM products ORDER BY price*stock_quantity; 
SELECT *, price*stock_quantity as total_value FROM products ORDER BY total_value; 

-- to increase the performance of sorting we can do Indexing against that column;

-- IF YOU WANT to understand the game plan of Mysql or if you want to understand how does that particular query
-- works then we can use 'Explain' keyword

-- since category and price columns are not indexed therefore we are using FileSort which means
-- it has seen all the records one-by-one

-- whyy FileSort?
-- Because in oldern days some Files were kept and Mysql used to use those files for sorting and till now the naming has not been changes 
-- and hence it is called FileSort
EXPLAIN SELECT * FROM products ORDER BY category, price;

-- this sorting will be faster  as primary keys are always Indexed and the type is 'Index' 
EXPLAIN SELECT * FROM products ORDER BY products_id;

