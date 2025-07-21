
-- Introduction to FULL JOIN
-- ====================================================================
-- FULL JOIN
-- - It returns all matching rows from both tables where the join condition is met
-- - It also returns all non-matching rows from the left table (with NULL values for columns from the right table)
-- - It also returns all non-matching rows from the right table (with NULL values for columns from the left table)
-- - It combines the results of both LEFT JOIN and RIGHT JOIN, including all records from both tables and matching records from both sides where available.
--
-- Note: MySQL does not natively support FULL JOIN, but we can emulate it using UNION of LEFT JOIN and RIGHT JOIN

-- Join Types Comparison:
-- - INNER JOIN (only returns matching rows between tables)
-- - LEFT JOIN (returns all rows from left table and matching from right)
-- - RIGHT JOIN (returns all rows from right table and matching from left)
-- - FULL JOIN (returns all rows from both tables)


CREATE DATABASE friendsdb;
USE friendsdb;

CREATE TABLE characters(
	character_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    occupation VARCHAR(100) NOT NULL
);

CREATE TABLE apartments(
	apartment_id INT PRIMARY KEY,
    building_address VARCHAR(100) NOT NULL,
    apartment_number VARCHAR(100) NOT NULL,
    monthly_rent DECIMAL(8,2) NOT NULL,
    current_tenant_id INT,
    FOREIGN KEY(current_tenant_id) REFERENCES characters(character_id)
);

INSERT INTO characters(character_id,first_name,last_name,occupation)
VALUES
(1,'Ross','Geller','Paleontologist'),
(2,'Rachel','Green','Fashion Executive'),  -- No address
(3,'Chandler','Bing','IT Procurement Manager'),
(4,'Monica','Geller','Chef'),
(5,'Joey','Tribbiani','Actor'),  -- No Address
(6, 'Phoebe', 'Buffay', 'Massage Therapist'),
(7, 'Gunther', 'Smith', 'Coffee Shop Manager'),  -- no address
(8, 'Janice', 'Hosenstein', 'Unknown');  -- no address

INSERT INTO apartments(apartment_id,building_address,apartment_number,monthly_rent,current_tenant_id)
VALUES
(101,'90 Bedfort Street','20',3500.00,3),  -- Chandler
(102,'90 Bedfort Street','19',3500.00,4),  --  Monica
(103,'5 Morton Street','14',2800.00,6),  -- Phoebe
(104,'17 Grove Street','3B',2200.00, NULL),
(105,'15 Yemen Road','Yemen',900.00, NULL),
(106,'495 Grove Street','7',2400.00, 1); -- Ross

-- All characters, including those without apartments
-- All apartments, includeding those without tenants
-- Matches where character have apartments

SELECT c.character_id, c.first_name, c.last_name, a.apartment_id,a.building_address, a.apartment_number, a.monthly_rent
FROM characters c
LEFT JOIN apartments a
ON c.character_id=a.current_tenant_id
UNION
SELECT c.character_id, c.first_name, c.last_name, a.apartment_id,a.building_address, a.apartment_number, a.monthly_rent
FROM characters c 
RIGHT JOIN apartments a 
ON c.character_id=a.current_tenant_id;

-- In MySQL with the help of UNION we can acheive FULL JOIN
-- In other RDBMS,like Postgress SQL they natively support FULL JOIN
 
 -- POSTGRESS SQL
/*
SELECT c.character_id, c.first_name, c.last_name, a.apartment_id,a.building_address, a.apartment_number, a.monthly_rent
FROM characters c 
FULL JOIN apartments a 
ON c.character_id=a.current_tenant_id;
*/ 






