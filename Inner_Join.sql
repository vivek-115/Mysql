-- Inner Join / Join
-- An inner Join returns only the rows where there is a match in both the tables based on the specified join condition
-- if there is not match then that particular row is excluded from the result set

CREATE DATABASE dbjoin;
USE dbjoin;

CREATE TABLE authors(
	author_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_year INT
    );

DESC authors;

INSERT INTO authors
VALUES
(1,'Jane','Austen',1775),
(2,'George','Orwell',1903),
(3,'Ernest','Hemingway',1899),
(4,'Agatha','Christie',1890),
(5,'J.K','Rowling',1965);

SELECT * FROM authors;
    
CREATE TABLE books(
	book_id INT PRIMARY KEY,
    title VARCHAR(100),
    author_id INT,
    publication_year INT,
    price DECIMAL(10,2)
    );
ALTER TABLE books
MODIFY author_id INT NOT NULL;

ALTER TABLE books
ADD FOREIGN KEY(author_id) REFERENCES authors(author_id);
    
DESC books;

INSERT INTO books(book_id,title,author_id,publication_year,price)
VALUES
(101, 'Pride and Prejudice', 1, 1813, 12.99),
(102, '1984', 2, 1949, 14.50),
(103, 'Animal Farm', 2, 1945, 11.75),
(104, 'The Old Man and the Sea', 3, 1952, 10.99),
(105, 'Murder on the Orient Express', 4, 1934, 13.25),
(106, 'Death on the Nile', 4, 1937, 12.50),
(107, 'Emma', 1, 1815, 11.99),
(108, 'For Whom the Bell Tolls', 3, 1940, 15.75);

SELECT * FROM books;

-- INNER JOIN

-- Basic INNER JOIN syntax:
/*
SELECT columns
FROM table1
JOIN_TYPE table2
ON table1.column = table2.column;
*/

SELECT * 
FROM authors
JOIN books 
on authors.author_id=books.author_id;

-- Retrieve books with their author's information with conditions and ordering
SELECT * 
FROM authors a
JOIN books b
on a.author_id=b.author_id
WHERE b.publication_year>1940
ORDER BY birth_year DESC;

-- Count how many books each author has written
SELECT a.first_name, a.last_name, count(b.book_id)
FROM authors a
JOIN books b
ON a.author_id=b.author_id
GROUP BY a.author_id;

-- Create categories table for many-to-many relationship example
CREATE TABLE categories(
	category_id INT PRIMARY KEY,
    category_name VARCHAR(50)
    );
    
INSERT INTO categories(category_id,category_name)
VALUES
    (1, 'Fiction'),
    (2, 'Classic'),
    (3, 'Romance'),
    (4, 'Political'),
    (5, 'Mystery'),
    (6, 'Adventure');
    
SELECT * FROM categories;

-- Create junction table for book-category many-to-many relationship
CREATE TABLE book_categories(
	book_id INT,
    category_id INT,
    foreign key(book_id) references books(book_id),
    foreign key(category_id) references categories(category_id),
    primary key(book_id,category_id)
);
desc book_categories;
SHOW CREATE TABLE book_categories;

INSERT INTO book_categories (book_id, category_id)
VALUES 
    (101, 1), (101, 2), (101, 3), -- Pride and Prejudice: Fiction, Classic, Romance
    (102, 1), (102, 2), (102, 4), -- 1984: Fiction, Classic, Political
    (103, 1), (103, 2), (103, 4), -- Animal Farm: Fiction, Classic, Political
    (104, 1), (104, 2), (104, 6), -- The Old Man and the Sea: Fiction, Classic, Adventure
    (105, 1), (105, 5), -- Murder on the Orient Express: Fiction, Mystery
    (106, 1), (106, 5), -- Death on the Nile: Fiction, Mystery
    (107, 1), (107, 2), (107, 3), -- Emma: Fiction, Classic, Romance
    (108, 1), (108, 2), (108, 6); -- For Whom the Bell Tolls: Fiction, Classic, Adventure

SELECT * FROM book_categories;

-- Get books with their authors and categories using GROUP_CONCAT
-- a.first_name, a.last_name, b.title, group_concat(bc.
SELECT a.first_name, a.last_name, b.title, group_concat(c.category_name)
FROM authors a
JOIN books b
on a.author_id=b.author_id
JOIN
book_categories bc
on b.book_id=bc.book_id
JOIN 
categories c
on bc.category_id=c.category_id
group by(b.book_id);

-- Example with join condition in AND clause

-- Return books published before 1950 by authors born before 1900
SELECT *
FROM authors a
JOIN books b
ON a.author_id=b.author_id
AND publication_year<1950
AND a.birth_year<1900;  -- Fast and Efficient as we have filtered at the time of Joining


-- Equivalent example with join condition in WHERE clause
SELECT *
FROM authors a
JOIN books b
on a.author_id=b.author_id
WHERE publication_year<1950 and a.birth_year<1900;  -- After joining we have filtered based on the publication_year
													-- Therefore less efficient

-- Example with date functions - books published more than 70 years ago
SELECT * 
FROM authors a
JOIN books b
ON a.author_id=b.author_id
WHERE YEAR(curdate())-b.publication_year>70;  -- The publication_year 


-- Inner join excludes the rows with null values in the Join Columns
-- If you want to include the NULL values then you need to use Left Join or Right Join

-- Performance
		-- It is slow so need to use LIMIT, indexing
        -- Do not use SELECT *
