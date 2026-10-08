-- PART A1: DDL - DATABASE AND TABLE CREATION

-- Q1: Create database LibraryDB
CREATE DATABASE IF NOT EXISTS LibraryDB;

USE LibraryDB;

CREATE TABLE IF NOT EXISTS Books (
    book_id INT PRIMARY KEY,
    book_name VARCHAR(150) NOT NULL,
    author VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS Members (
    member_id INT PRIMARY KEY,
    member_name VARCHAR(100) NOT NULL,
    city VARCHAR(80),
    phone VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS Borrow (
    borrow_id INT PRIMARY KEY,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    borrow_date DATE
);

ALTER TABLE Books ADD COLUMN IF NOT EXISTS category VARCHAR(80);

ALTER TABLE Books ADD COLUMN IF NOT EXISTS quantity INT DEFAULT 0;

ALTER TABLE Members ADD COLUMN IF NOT EXISTS email VARCHAR(120);

ALTER TABLE Borrow ADD COLUMN IF NOT EXISTS return_date DATE NULL;

ALTER TABLE Books MODIFY COLUMN price DECIMAL(10,2) NOT NULL;

ALTER TABLE Books RENAME COLUMN quantity TO stock_quantity;

DESCRIBE Books;

DESCRIBE Members;

DESCRIBE Borrow;

-- PART A2: DML - INSERT

-- Q15: Insert at least 10 books with different names, authors, categories, prices and stock
INSERT INTO Books (book_id, book_name, author, price, category, stock_quantity) VALUES
(101, 'Learning SQL', 'A. Sharma', 450.00, 'Technology', 12),
(102, 'Python Basics', 'B. Kumar', 550.00, 'Technology', 18),
(103, 'Artificial Intelligence', 'C. Devi', 850.00, 'Technology', 8),
(104, 'Data Science Guide', 'A. Sharma', 720.00, 'Technology', 10),
(105, 'Database Systems', 'D. Raj', 600.00, 'Education', 15),
(106, 'Modern Literature', 'E. Priya', 320.00, 'Literature', 6),
(107, 'Teaching Methods', 'F. Anand', 280.00, 'Education', 22),
(108, 'Web Development', 'B. Kumar', 680.00, 'Technology', 9),
(109, 'History of India', 'G. Meena', 390.00, 'History', 14),
(110, 'Computer Networks', 'C. Devi', 760.00, 'Technology', 7);

INSERT INTO Members (member_id, member_name, city, phone, email) VALUES
(201, 'Arun', 'Chennai', '9000000001', 'arun@example.com'),
(202, 'Bala', 'Madurai', '9000000002', 'bala@example.com'),
(203, 'Charu', 'Chennai', '9000000003', 'charu@example.com'),
(204, 'Divya', 'Coimbatore', '9000000004', 'divya@example.com'),
(205, 'Ezhil', 'Trichy', '9000000005', 'ezhil@example.com'),
(206, 'Farah', 'Chennai', '9000000006', 'farah@example.com'),
(207, 'Gokul', 'Salem', '9000000007', 'gokul@example.com'),
(208, 'Hema', 'Vellore', '9000000008', 'hema@example.com');

INSERT INTO Borrow (borrow_id, book_id, member_id, borrow_date, return_date) VALUES
(301, 101, 201, '2026-01-05', '2026-01-15'),
(302, 102, 202, '2026-01-06', '2026-01-16'),
(303, 103, 203, '2026-01-07', NULL),
(304, 104, 201, '2026-01-08', NULL),
(305, 101, 204, '2026-01-09', '2026-01-19'),
(306, 105, 205, '2026-01-10', NULL),
(307, 108, 206, '2026-01-11', NULL),
(308, 103, 202, '2026-01-12', '2026-01-22'),
(309, 109, 207, '2026-01-13', NULL),
(310, 110, 203, '2026-01-14', NULL);

INSERT INTO Books (book_id, book_name, author, price, category, stock_quantity)
VALUES (111, 'Cloud Computing', 'H. Kumar', 790.00, 'Technology', 11);

INSERT INTO Members (member_id, member_name, city, phone, email)
VALUES (209, 'Ila', 'Chennai', '9000000009', 'ila@example.com');

INSERT INTO Borrow (borrow_id, book_id, member_id, borrow_date, return_date)
VALUES (311, 111, 209, '2026-01-20', NULL);

-- PART A2: UPDATE

-- Q21: Update price of book_id = 103
UPDATE Books SET price = 875.00 WHERE book_id = 103;

UPDATE Books SET price = price * 1.10 WHERE category = 'Technology';

UPDATE Books SET stock_quantity = stock_quantity + 5;

UPDATE Members SET city = 'Chennai' WHERE member_id = 202;

UPDATE Members SET email = 'bala.kumar@example.com' WHERE member_id = 202;

UPDATE Books SET category = 'Education' WHERE book_id = 109;

UPDATE Borrow SET return_date = '2026-02-01' WHERE borrow_id = 303;

-- PART A2: DELETE

-- Q28: Delete book with book_id = 106
DELETE FROM Borrow WHERE book_id = 106;
DELETE FROM Books WHERE book_id = 106;

DELETE FROM Members
WHERE member_id = 208
  AND member_id NOT IN (SELECT member_id FROM Borrow);

DELETE FROM Borrow WHERE borrow_id = 310;

DELETE FROM Borrow
WHERE book_id IN (SELECT book_id FROM Books WHERE stock_quantity = 0);
DELETE FROM Books WHERE stock_quantity = 0;

-- PART A3: DQL - SELECT QUERIES

-- Q32: Display all records from Books
SELECT * FROM Books;

SELECT book_name, author FROM Books;

SELECT book_name, category, price FROM Books;

SELECT * FROM Books WHERE price > 500;

SELECT * FROM Books WHERE price < 500;

SELECT * FROM Books WHERE price BETWEEN 300 AND 800;

SELECT * FROM Books WHERE category = 'Technology';

SELECT * FROM Books WHERE author = 'A. Sharma';

SELECT * FROM Books WHERE book_name LIKE 'S%';

SELECT * FROM Books WHERE book_name LIKE '%SQL%';

SELECT * FROM Books WHERE category IN ('Technology', 'Education');

SELECT * FROM Books WHERE price <> 500;

SELECT * FROM Books WHERE stock_quantity > 10;

SELECT * FROM Books WHERE stock_quantity BETWEEN 5 AND 15;

-- PART A4: DCL - DATA CONTROL LANGUAGE

-- Q1: Create user library_user on localhost
CREATE USER IF NOT EXISTS 'library_user'@'localhost' IDENTIFIED BY 'ChangeThisPassword123!';

GRANT SELECT ON LibraryDB.Books TO 'library_user'@'localhost';

GRANT INSERT ON LibraryDB.Books TO 'library_user'@'localhost';

GRANT UPDATE ON LibraryDB.Books TO 'library_user'@'localhost';

SHOW GRANTS FOR 'library_user'@'localhost';

REVOKE INSERT ON LibraryDB.Books FROM 'library_user'@'localhost';

REVOKE UPDATE ON LibraryDB.Books FROM 'library_user'@'localhost';

GRANT SELECT ON LibraryDB.* TO 'library_user'@'localhost';

REVOKE SELECT ON LibraryDB.Books FROM 'library_user'@'localhost';

SHOW GRANTS FOR 'library_user'@'localhost';

-- PART A5: SORTING AND LIMIT

-- Q46: Sort books by price ascending
SELECT * FROM Books ORDER BY price ASC;

SELECT * FROM Books ORDER BY price DESC;

SELECT * FROM Books ORDER BY book_name ASC;

SELECT * FROM Books ORDER BY category ASC, price ASC;

SELECT * FROM Books ORDER BY price DESC LIMIT 3;

SELECT * FROM Books ORDER BY price ASC LIMIT 3;

SELECT * FROM Books ORDER BY stock_quantity DESC LIMIT 5;

SELECT * FROM Members ORDER BY member_name ASC LIMIT 5;

SELECT * FROM Borrow ORDER BY borrow_date DESC, borrow_id DESC LIMIT 5;

-- PART A6: AGGREGATE FUNCTIONS

-- Q55: Count total books
SELECT COUNT(*) AS total_books FROM Books;

SELECT COUNT(*) AS total_members FROM Members;

SELECT COUNT(*) AS total_borrow_records FROM Borrow;

SELECT SUM(stock_quantity) AS total_stock_quantity FROM Books;

SELECT SUM(price) AS total_book_price FROM Books;

SELECT AVG(price) AS average_book_price FROM Books;

SELECT MAX(price) AS highest_price FROM Books;

SELECT MIN(price) AS lowest_price FROM Books;

SELECT MAX(price) - MIN(price) AS price_difference FROM Books;

SELECT AVG(stock_quantity) AS average_stock_quantity FROM Books;

-- PART A7: GROUP BY

-- Q65: Count books in each category
SELECT category, COUNT(*) AS book_count
FROM Books GROUP BY category;

SELECT category, AVG(price) AS average_price
FROM Books GROUP BY category;

SELECT category, MAX(price) AS highest_price
FROM Books GROUP BY category;

SELECT category, MIN(price) AS lowest_price
FROM Books GROUP BY category;

SELECT category, SUM(stock_quantity) AS total_stock
FROM Books GROUP BY category;

SELECT category, SUM(price * stock_quantity) AS inventory_value
FROM Books GROUP BY category;

SELECT category, COUNT(*) AS book_count
FROM Books GROUP BY category
HAVING COUNT(*) > 2;

SELECT category, AVG(price) AS average_price
FROM Books GROUP BY category
HAVING AVG(price) > 500;

SELECT author, COUNT(*) AS book_count
FROM Books GROUP BY author;

SELECT author, AVG(price) AS average_price
FROM Books GROUP BY author;

-- PART A8: HAVING

-- Q75: Display categories containing more than 2 books
SELECT category, COUNT(*) AS book_count
FROM Books GROUP BY category
HAVING COUNT(*) > 2;

SELECT category, AVG(price) AS average_price
FROM Books GROUP BY category
HAVING AVG(price) > 500;

SELECT author, COUNT(*) AS book_count
FROM Books GROUP BY author
HAVING COUNT(*) > 1;

SELECT category, SUM(stock_quantity) AS total_stock
FROM Books GROUP BY category
HAVING SUM(stock_quantity) > 20;

SELECT author, AVG(price) AS average_price
FROM Books GROUP BY author
HAVING AVG(price) > 600;
