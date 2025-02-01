create database bookstore;
use bookstore;

CREATE TABLE books(
	book_id int primary key,
    title varchar(50),
    author varchar(50),
    price Decimal(10,2),
    publication_date Date,
    category varchar(30),
    in_stock int);
    
INSERT INTO books VALUES
(1, 'The MySQL Guide', 'John Smith', 29.99, '2023-01-15', 'Technology', 50),
(2, 'Data Science Basics', 'Sarah Johnson', 34.99, '2023-03-20', 'Technology', 30),
(3, 'Mystery at Midnight', 'Michael Brown', 19.99, '2023-02-10', 'Mystery', 100),
(4, 'Cooking Essentials', 'Lisa Anderson', 24.99, '2023-04-05', 'Cooking', 75);  

INSERT INTO books VALUES
(5, 'Cook Book', null, 24.99, '2023-04-05', 'Cooking', 75);

INSERT INTO books VALUES
(6, 'Mini Cook Book', 'Gohn Smith', 24.99, '2023-04-05', 'Cooking', 75);

SELECT * from books;  
SELECT * from books where category='technology';
SELECT * from books where price<30.00;
SELECT * from books where publication_date>='2023-03-01';
select * from books where category='Technology' and price < 30.00;
select * from books where (category='Technology' or category='Mystery') and price<25.00;
select * from books where category!='Technology';

select * from books where author is null
select * from books where author is not null;

select * from books;
select * from books where title like '%SQL%';
select * from books where title like '%the%';

select * from books where title like 'the%';

select * from books where title like binary '%SQL%'; 
select * from books where author like '_ohn%';

select * from books where price between 20 and 30;
select * from books where category in('Science','Mystery','Technology');
select * from books where price between 20 and 40.00 and publication_date>='2023-01-01';
select * from books where price>(select avg(price) from books);

 -- Find all books published in 2023 that cost less than the average book price
 select * from books where publication_date>='2023-01-01' and price<(select avg(price) from books);
 
 -- Approach 2
 SELECT book_id,title, price, publication_date
FROM books
WHERE YEAR(publication_date) = 2023
AND price < (SELECT AVG(price) FROM books);

 -- List all technology books with "data" in the title that have more than 50 copies in stock
select * from books where category='Technology' and title like '%data%' and (in_stock>50);

SELECT title, category, in_stock
FROM books
WHERE category = 'Technology'
AND title LIKE '%data%'
AND in_stock > 50;

-- Find books that are either in the Technology category with price > $30 or in the Mystery category with price < $20
select * from books where category='Technology' and price>30.00 or (category='Mystery' and price<20.00);
 
 SELECT *
FROM books
WHERE (category = 'Technology' AND price > 30.00)
OR (category = 'Mystery' AND price < 20.00);

-- List all books where the author's name contains either 'son' or 'th' and were published after March 2023

select * from books where (author like '%son%' or author like '%th%') and publication_date>'2023-03-31';