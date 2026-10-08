USE LibraryDB;

-- PART B: SQL JOINS
-- Tables used: Books, Members, Borrow

-- INNER JOIN Q1: Display book names and member names for all borrowed books
SELECT b.book_name, m.member_name
FROM Borrow br
INNER JOIN Books b ON br.book_id = b.book_id
INNER JOIN Members m ON br.member_id = m.member_id;

SELECT b.book_name, m.member_name, br.borrow_date
FROM Borrow br
INNER JOIN Books b ON br.book_id = b.book_id
INNER JOIN Members m ON br.member_id = m.member_id;

SELECT b.book_name, b.author, m.member_name, m.city
FROM Borrow br
INNER JOIN Books b ON br.book_id = b.book_id
INNER JOIN Members m ON br.member_id = m.member_id;

SELECT b.book_name, m.member_name, m.city
FROM Borrow br
INNER JOIN Books b ON br.book_id = b.book_id
INNER JOIN Members m ON br.member_id = m.member_id
WHERE m.city = 'Chennai';

SELECT b.book_name, br.borrow_date
FROM Borrow br
INNER JOIN Books b ON br.book_id = b.book_id
INNER JOIN Members m ON br.member_id = m.member_id
WHERE m.member_name = 'Arun';

SELECT DISTINCT m.member_name
FROM Borrow br
INNER JOIN Books b ON br.book_id = b.book_id
INNER JOIN Members m ON br.member_id = m.member_id
WHERE b.category = 'Technology';

-- INNER JOIN Q7: Display book names and their corresponding borrowers
SELECT b.book_name, m.member_name AS borrower
FROM Borrow br
INNER JOIN Books b ON br.book_id = b.book_id
INNER JOIN Members m ON br.member_id = m.member_id;

SELECT br.*, b.book_name, m.member_name
FROM Borrow br
INNER JOIN Books b ON br.book_id = b.book_id
INNER JOIN Members m ON br.member_id = m.member_id
ORDER BY br.borrow_date ASC;

-- LEFT JOIN Q9: Display all books and the members who borrowed them
SELECT b.book_name, m.member_name
FROM Books b
LEFT JOIN Borrow br ON b.book_id = br.book_id
LEFT JOIN Members m ON br.member_id = m.member_id;

SELECT b.book_id, b.book_name, br.borrow_id
FROM Books b
LEFT JOIN Borrow br ON b.book_id = br.book_id;

-- LEFT JOIN Q11: Display all members and their borrowed books
SELECT m.member_name, b.book_name
FROM Members m
LEFT JOIN Borrow br ON m.member_id = br.member_id
LEFT JOIN Books b ON br.book_id = b.book_id;

SELECT m.member_id, m.member_name, br.borrow_id
FROM Members m
LEFT JOIN Borrow br ON m.member_id = br.member_id;

SELECT b.book_id, b.book_name
FROM Books b
LEFT JOIN Borrow br ON b.book_id = br.book_id
WHERE br.borrow_id IS NULL;

SELECT m.member_id, m.member_name
FROM Members m
LEFT JOIN Borrow br ON m.member_id = br.member_id
WHERE br.borrow_id IS NULL;

-- RIGHT JOIN Q15: Display all borrow records and matching book names using RIGHT JOIN
SELECT br.borrow_id, br.book_id, b.book_name, br.borrow_date
FROM Books b
RIGHT JOIN Borrow br ON b.book_id = br.book_id;

SELECT br.borrow_id, br.member_id, m.member_name, br.borrow_date
FROM Members m
RIGHT JOIN Borrow br ON m.member_id = br.member_id;

-- RIGHT JOIN Q17: Display all members and their borrow information using RIGHT JOIN
SELECT m.member_id, m.member_name, br.borrow_id, br.borrow_date
FROM Borrow br
RIGHT JOIN Members m ON br.member_id = m.member_id;

-- CROSS JOIN Q18: Display every possible combination of books and members
SELECT b.book_name, m.member_name
FROM Books b CROSS JOIN Members m;

SELECT COUNT(*) AS total_combinations
FROM Books CROSS JOIN Members;

SELECT m.member_name, b.book_name
FROM Members m
CROSS JOIN Books b
WHERE b.category = 'Technology';

-- JOIN + GROUP BY Q21: Count books each member has borrowed
SELECT m.member_id, m.member_name, COUNT(br.borrow_id) AS books_borrowed
FROM Members m
LEFT JOIN Borrow br ON m.member_id = br.member_id
GROUP BY m.member_id, m.member_name;

SELECT b.book_id, b.book_name, COUNT(DISTINCT br.member_id) AS member_count
FROM Books b
LEFT JOIN Borrow br ON b.book_id = br.book_id
GROUP BY b.book_id, b.book_name;

-- JOIN + GROUP BY Q23: Find the most borrowed book (returns ties)
WITH BorrowCounts AS (
    SELECT b.book_id, b.book_name, COUNT(br.borrow_id) AS borrow_count
    FROM Books b
    LEFT JOIN Borrow br ON b.book_id = br.book_id
    GROUP BY b.book_id, b.book_name
)
SELECT book_id, book_name, borrow_count
FROM BorrowCounts
WHERE borrow_count = (SELECT MAX(borrow_count) FROM BorrowCounts);

SELECT m.member_id, m.member_name, COUNT(br.borrow_id) AS books_borrowed
FROM Members m
JOIN Borrow br ON m.member_id = br.member_id
GROUP BY m.member_id, m.member_name
HAVING COUNT(br.borrow_id) > 2;

SELECT b.category, COUNT(br.borrow_id) AS borrow_count
FROM Books b
LEFT JOIN Borrow br ON b.book_id = br.book_id
GROUP BY b.category;

SELECT b.category, COUNT(br.borrow_id) AS total_borrowed
FROM Books b
LEFT JOIN Borrow br ON b.book_id = br.book_id
GROUP BY b.category;

-- PART C: SUBQUERIES

-- C1 Q1: Books priced above the overall average
SELECT * FROM Books WHERE price > (SELECT AVG(price) FROM Books);

SELECT * FROM Books WHERE price < (SELECT AVG(price) FROM Books);

SELECT * FROM Books WHERE price = (SELECT MAX(price) FROM Books);

SELECT * FROM Books WHERE price = (SELECT MIN(price) FROM Books);

SELECT * FROM Books
WHERE price = (SELECT price FROM Books WHERE book_id = 2);

SELECT * FROM Books
WHERE stock_quantity > (SELECT AVG(stock_quantity) FROM Books);

-- C2 Q7: Books in categories having more than one book
SELECT * FROM Books
WHERE category IN (
    SELECT category FROM Books GROUP BY category HAVING COUNT(*) > 1
);

SELECT * FROM Books
WHERE author IN (
    SELECT author FROM Books GROUP BY author HAVING COUNT(*) > 1
);

-- C2 Q9: Books in categories whose average price is greater than ₹500
SELECT * FROM Books
WHERE category IN (
    SELECT category FROM Books GROUP BY category HAVING AVG(price) > 500
);

SELECT * FROM Members
WHERE member_id IN (
    SELECT br.member_id
    FROM Borrow br JOIN Books b ON br.book_id = b.book_id
    WHERE b.category = 'Technology'
);

-- C3 Q11: Books never borrowed
SELECT * FROM Books
WHERE book_id NOT IN (SELECT book_id FROM Borrow);

SELECT * FROM Members
WHERE member_id NOT IN (SELECT member_id FROM Borrow);

SELECT DISTINCT author FROM Books
WHERE book_id NOT IN (SELECT book_id FROM Borrow);

-- C4 Q17: Books for which at least one borrow record exists
SELECT b.*
FROM Books b
WHERE EXISTS (SELECT 1 FROM Borrow br WHERE br.book_id = b.book_id);

-- C4 Q18: Members who have at least one borrow record
SELECT m.*
FROM Members m
WHERE EXISTS (SELECT 1 FROM Borrow br WHERE br.member_id = m.member_id);

SELECT b.*
FROM Books b
WHERE (SELECT COUNT(*) FROM Borrow br WHERE br.book_id = b.book_id) >= 2;

-- PART D1: COMMON TABLE EXPRESSIONS (CTE)

-- D1 Q1: CTE for average book price; display books above average
WITH AveragePrice AS (
    SELECT AVG(price) AS avg_price FROM Books
)
SELECT b.* FROM Books b CROSS JOIN AveragePrice ap
WHERE b.price > ap.avg_price;

WITH CategoryAverage AS (
    SELECT category, AVG(price) AS avg_price
    FROM Books GROUP BY category
)
SELECT * FROM CategoryAverage;

WITH CategoryAverage AS (
    SELECT category, AVG(price) AS avg_price
    FROM Books GROUP BY category
)
SELECT b.* FROM Books b
JOIN CategoryAverage ca ON b.category = ca.category
WHERE b.price > ca.avg_price;

WITH CategoryStock AS (
    SELECT category, SUM(stock_quantity) AS total_stock
    FROM Books GROUP BY category
)
SELECT * FROM CategoryStock;

WITH CategoryStock AS (
    SELECT category, SUM(stock_quantity) AS total_stock
    FROM Books GROUP BY category
)
SELECT * FROM CategoryStock WHERE total_stock > 20;

WITH CategoryMaximum AS (
    SELECT category, MAX(price) AS max_price
    FROM Books GROUP BY category
)
SELECT b.*
FROM Books b JOIN CategoryMaximum cm
  ON b.category = cm.category AND b.price = cm.max_price;

-- D1 Q7: Number of books written by each author using a CTE
WITH AuthorCounts AS (
    SELECT author, COUNT(*) AS book_count
    FROM Books GROUP BY author
)
SELECT * FROM AuthorCounts;

WITH AuthorCounts AS (
    SELECT author, COUNT(*) AS book_count
    FROM Books GROUP BY author
)
SELECT * FROM AuthorCounts WHERE book_count > 1;

-- PART D2: WINDOW FUNCTIONS

-- D2 Q9: Rank books by price descending
SELECT book_id, book_name, price,
       RANK() OVER (ORDER BY price DESC) AS price_rank
FROM Books;

SELECT book_id, book_name, price,
       RANK() OVER (ORDER BY price ASC) AS price_rank
FROM Books;

-- D2 Q11: Assign unique row numbers based on price
SELECT book_id, book_name, price,
       ROW_NUMBER() OVER (ORDER BY price DESC, book_id) AS row_num
FROM Books;

SELECT book_id, book_name, category, price,
       RANK() OVER (PARTITION BY category ORDER BY price DESC) AS category_rank
FROM Books;

SELECT book_id, book_name, category, price,
       DENSE_RANK() OVER (PARTITION BY category ORDER BY price DESC) AS category_rank
FROM Books;

SELECT book_id, book_name, category, price,
       AVG(price) OVER (PARTITION BY category) AS category_average
FROM Books;

-- D2 Q15: Each book with highest price in its category
SELECT book_id, book_name, category, price,
       MAX(price) OVER (PARTITION BY category) AS category_highest_price
FROM Books;

SELECT book_id, book_name, category, price,
       MIN(price) OVER (PARTITION BY category) AS category_lowest_price
FROM Books;

-- D2 Q17: Difference between price and category average
SELECT book_id, book_name, category, price,
       price - AVG(price) OVER (PARTITION BY category) AS difference_from_average
FROM Books;

-- D2 Q18: Cumulative stock quantity
SELECT book_id, book_name, stock_quantity,
       SUM(stock_quantity) OVER (ORDER BY book_id) AS cumulative_stock
FROM Books;

SELECT book_id, book_name, category, stock_quantity,
       SUM(stock_quantity) OVER (
           PARTITION BY category ORDER BY book_id
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) AS category_cumulative_stock
FROM Books;

SELECT book_id, book_name, price,
       LAG(price) OVER (ORDER BY price, book_id) AS previous_price
FROM Books;

-- D2 Q21: Next book's price using LEAD()
SELECT book_id, book_name, price,
       LEAD(price) OVER (ORDER BY price, book_id) AS next_price
FROM Books;

WITH PriceSequence AS (
    SELECT book_id, book_name, price,
           LAG(price) OVER (ORDER BY price, book_id) AS previous_price
    FROM Books
)
SELECT book_id, book_name, price, previous_price,
       price - previous_price AS price_difference
FROM PriceSequence;

-- PART D3: CASE

-- D3 Q23: Classify books as Expensive or Affordable
SELECT book_name, price,
       CASE WHEN price > 600 THEN 'Expensive' ELSE 'Affordable' END AS price_class
FROM Books;

SELECT book_name, price,
       CASE
           WHEN price < 400 THEN 'Low'
           WHEN price <= 700 THEN 'Medium'
           ELSE 'High'
       END AS price_category
FROM Books;

SELECT book_name, stock_quantity,
       CASE
           WHEN stock_quantity = 0 THEN 'Out of Stock'
           WHEN stock_quantity BETWEEN 1 AND 5 THEN 'Low Stock'
           ELSE 'Available'
       END AS stock_status
FROM Books;

SELECT book_name, price,
       CASE
           WHEN price < 400 THEN 'Low'
           WHEN price <= 700 THEN 'Medium'
           ELSE 'High'
       END AS price_category
FROM Books;

SELECT book_name, stock_quantity,
       CASE
           WHEN stock_quantity = 0 THEN 'Out of Stock'
           WHEN stock_quantity BETWEEN 1 AND 5 THEN 'Low Stock'
           ELSE 'Available'
       END AS stock_status
FROM Books;

SELECT
    CASE
        WHEN price < 400 THEN 'Low'
        WHEN price <= 700 THEN 'Medium'
        ELSE 'High'
    END AS price_category,
    COUNT(*) AS book_count
FROM Books
GROUP BY price_category;

SELECT book_name, price,
       CASE WHEN price > 700 THEN 100 ELSE 0 END AS discount,
       price - CASE WHEN price > 700 THEN 100 ELSE 0 END AS final_price
FROM Books;

-- PART D4: VIEWS

-- D4 Q30: Create Technology_Books view
CREATE OR REPLACE VIEW Technology_Books AS
SELECT * FROM Books WHERE category = 'Technology';

SELECT * FROM Technology_Books;

CREATE OR REPLACE VIEW Expensive_Books AS
SELECT * FROM Books WHERE price > 600;

CREATE OR REPLACE VIEW Available_Books AS
SELECT * FROM Books WHERE stock_quantity > 0;

CREATE OR REPLACE VIEW Library_Borrow_Details AS
SELECT b.book_name, b.author, m.member_name, m.city, br.borrow_date
FROM Borrow br
JOIN Books b ON br.book_id = b.book_id
JOIN Members m ON br.member_id = m.member_id;

SELECT * FROM Library_Borrow_Details;

CREATE OR REPLACE VIEW Category_Average_Price AS
SELECT category, AVG(price) AS average_price
FROM Books GROUP BY category;

CREATE OR REPLACE VIEW Members_Who_Borrowed AS
SELECT DISTINCT m.member_id, m.member_name, m.city
FROM Members m JOIN Borrow br ON m.member_id = br.member_id;

DESCRIBE Technology_Books;

CREATE OR REPLACE VIEW Technology_Books AS
SELECT book_id, book_name, author, category, price, stock_quantity
FROM Books WHERE category = 'Technology';

DROP VIEW IF EXISTS Available_Books;

-- PART D5: STORED PROCEDURES

-- D5 Q41: Create GetAllBooks procedure
DELIMITER //
CREATE PROCEDURE GetAllBooks()
BEGIN
    SELECT * FROM Books;
END //
DELIMITER ;

CALL GetAllBooks();

DELIMITER //
CREATE PROCEDURE GetAllMembers()
BEGIN
    SELECT * FROM Members;
END //
DELIMITER ;

CALL GetAllMembers();

DELIMITER //
CREATE PROCEDURE GetBooksByCategory(IN p_category VARCHAR(80))
BEGIN
    SELECT * FROM Books WHERE category = p_category;
END //
DELIMITER ;

CALL GetBooksByCategory('Technology');

DELIMITER //
CREATE PROCEDURE GetBooksByAuthor(IN p_author VARCHAR(100))
BEGIN
    SELECT * FROM Books WHERE author = p_author;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE GetBooksAbovePrice(IN p_price DECIMAL(10,2))
BEGIN
    SELECT * FROM Books WHERE price > p_price ORDER BY price DESC;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE GetMemberBorrowDetails(IN p_member_id INT)
BEGIN
    SELECT m.member_id, m.member_name, b.book_name, br.borrow_date, br.return_date
    FROM Members m
    LEFT JOIN Borrow br ON m.member_id = br.member_id
    LEFT JOIN Books b ON br.book_id = b.book_id
    WHERE m.member_id = p_member_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE GetCategoryBooks(
    IN p_category VARCHAR(80),
    IN p_price_limit DECIMAL(10,2)
)
BEGIN
    SELECT * FROM Books
    WHERE category = p_category AND price <= p_price_limit
    ORDER BY price DESC;
END //
DELIMITER ;

-- PART E: INTEGRATED SQL PROBLEMS

-- E Q1: Members who borrowed books priced above the average book price
SELECT DISTINCT m.member_id, m.member_name
FROM Members m
JOIN Borrow br ON m.member_id = br.member_id
JOIN Books b ON br.book_id = b.book_id
WHERE b.price > (SELECT AVG(price) FROM Books);

WITH CategoryMaximum AS (
    SELECT category, MAX(price) AS max_price FROM Books GROUP BY category
)
SELECT b.category, b.book_name, b.author, b.price
FROM Books b JOIN CategoryMaximum cm
  ON b.category = cm.category AND b.price = cm.max_price;

SELECT category, AVG(price) AS category_average
FROM Books GROUP BY category
HAVING AVG(price) > (SELECT AVG(price) FROM Books);

SELECT m.member_id, m.member_name, COUNT(br.borrow_id) AS borrow_count
FROM Members m JOIN Borrow br ON m.member_id = br.member_id
GROUP BY m.member_id, m.member_name
HAVING COUNT(br.borrow_id) > 1;

SELECT b.* FROM Books b
WHERE b.price > 500
  AND NOT EXISTS (SELECT 1 FROM Borrow br WHERE br.book_id = b.book_id);

WITH RankedBooks AS (
    SELECT b.*, ROW_NUMBER() OVER (ORDER BY price DESC, book_id) AS rn
    FROM Books b
)
SELECT * FROM RankedBooks WHERE rn <= 3;

-- E Q7: Each category with book count, average price and total stock
SELECT category, COUNT(*) AS total_books, AVG(price) AS average_price,
       SUM(stock_quantity) AS total_stock
FROM Books GROUP BY category;

SELECT book_name, category, price,
       AVG(price) OVER (PARTITION BY category) AS category_average,
       price - AVG(price) OVER (PARTITION BY category) AS difference_from_average
FROM Books;

-- E Q9: Each member with number of books borrowed
SELECT m.member_id, m.member_name, COUNT(br.borrow_id) AS books_borrowed
FROM Members m LEFT JOIN Borrow br ON m.member_id = br.member_id
GROUP BY m.member_id, m.member_name;

WITH MemberCounts AS (
    SELECT m.member_id, m.member_name, COUNT(br.borrow_id) AS borrow_count
    FROM Members m LEFT JOIN Borrow br ON m.member_id = br.member_id
    GROUP BY m.member_id, m.member_name
)
SELECT * FROM MemberCounts
WHERE borrow_count > (SELECT AVG(borrow_count) FROM MemberCounts);

-- E Q11: Highest-priced book borrowed by each member
WITH BorrowedPrices AS (
    SELECT m.member_id, m.member_name, b.book_name, b.price,
           RANK() OVER (PARTITION BY m.member_id ORDER BY b.price DESC) AS price_rank
    FROM Members m
    JOIN Borrow br ON m.member_id = br.member_id
    JOIN Books b ON br.book_id = b.book_id
)
SELECT member_id, member_name, book_name, price
FROM BorrowedPrices WHERE price_rank = 1;

SELECT category, COUNT(*) AS book_count, AVG(price) AS average_price
FROM Books GROUP BY category
HAVING COUNT(*) >= 2 AND AVG(price) > 500;

WITH CategoryRanks AS (
    SELECT b.*, ROW_NUMBER() OVER (
        PARTITION BY category ORDER BY price DESC, book_id
    ) AS rn
    FROM Books b
)
SELECT * FROM CategoryRanks WHERE rn <= 2;

SELECT * FROM (
    SELECT b.*,
           AVG(price) OVER (PARTITION BY category) AS category_average
    FROM Books b
) AS x
WHERE price > category_average AND stock_quantity > 5;

-- E Q15: Create view with book name, category, price, stock and borrow count
CREATE OR REPLACE VIEW Book_Borrow_Summary AS
SELECT b.book_id, b.book_name, b.category, b.price, b.stock_quantity,
       COUNT(br.borrow_id) AS borrow_count
FROM Books b LEFT JOIN Borrow br ON b.book_id = br.book_id
GROUP BY b.book_id, b.book_name, b.category, b.price, b.stock_quantity;

DELIMITER //
CREATE PROCEDURE GetCategoryBooksByPrice(IN p_category VARCHAR(80))
BEGIN
    SELECT * FROM Books
    WHERE category = p_category
    ORDER BY price DESC;
END //
DELIMITER ;

-- E Q17: Procedure accepts minimum and maximum price
DELIMITER //
CREATE PROCEDURE GetBooksByPriceRange(
    IN p_min_price DECIMAL(10,2),
    IN p_max_price DECIMAL(10,2)
)
BEGIN
    SELECT * FROM Books
    WHERE price BETWEEN p_min_price AND p_max_price
    ORDER BY price;
END //
DELIMITER ;

-- E Q18: CTE counts borrowed books per category; display categories with more than 2 borrows
WITH CategoryBorrowCounts AS (
    SELECT b.category, COUNT(br.borrow_id) AS borrow_count
    FROM Books b LEFT JOIN Borrow br ON b.book_id = br.book_id
    GROUP BY b.category
)
SELECT * FROM CategoryBorrowCounts WHERE borrow_count > 2;

SELECT
    CASE
        WHEN price < 400 THEN 'Low'
        WHEN price <= 700 THEN 'Medium'
        ELSE 'High'
    END AS price_range,
    COUNT(*) AS book_count
FROM Books GROUP BY price_range;

WITH BookRanks AS (
    SELECT b.*, RANK() OVER (
        PARTITION BY category ORDER BY price DESC
    ) AS category_rank
    FROM Books b
)
SELECT * FROM BookRanks WHERE category_rank = 1;

-- PART F: CHALLENGE QUESTIONS

-- F Q1: Find second-highest priced book without LIMIT
SELECT * FROM Books
WHERE price = (
    SELECT MAX(price) FROM Books
    WHERE price < (SELECT MAX(price) FROM Books)
);

SELECT * FROM Books
WHERE price = (
    SELECT MAX(price)
    FROM Books
    WHERE price < (SELECT MAX(price) FROM Books)
);

WITH PriceRanks AS (
    SELECT b.*, DENSE_RANK() OVER (ORDER BY price DESC) AS price_rank
    FROM Books b
)
SELECT * FROM PriceRanks WHERE price_rank = 3;

SELECT DISTINCT category FROM Books
WHERE price = (SELECT MAX(price) FROM Books);

WITH AuthorCounts AS (
    SELECT author, COUNT(*) AS book_count FROM Books GROUP BY author
)
SELECT * FROM AuthorCounts
WHERE book_count = (SELECT MAX(book_count) FROM AuthorCounts);

WITH MemberCounts AS (
    SELECT m.member_id, m.member_name, COUNT(br.borrow_id) AS borrow_count
    FROM Members m LEFT JOIN Borrow br ON m.member_id = br.member_id
    GROUP BY m.member_id, m.member_name
)
SELECT * FROM MemberCounts
WHERE borrow_count = (SELECT MAX(borrow_count) FROM MemberCounts);

-- F Q7: Find the most frequently borrowed book
WITH BookCounts AS (
    SELECT b.book_id, b.book_name, COUNT(br.borrow_id) AS borrow_count
    FROM Books b LEFT JOIN Borrow br ON b.book_id = br.book_id
    GROUP BY b.book_id, b.book_name
)
SELECT * FROM BookCounts
WHERE borrow_count = (SELECT MAX(borrow_count) FROM BookCounts);

SELECT b.* FROM Books b
WHERE NOT EXISTS (SELECT 1 FROM Borrow br WHERE br.book_id = b.book_id);

-- F Q9: Find categories where every book costs more than ₹300
SELECT category
FROM Books
GROUP BY category
HAVING MIN(price) > 300;

SELECT DISTINCT category FROM Books WHERE price > 800;

-- F Q11: Price greater than average but lower than maximum price
SELECT * FROM Books
WHERE price > (SELECT AVG(price) FROM Books)
  AND price < (SELECT MAX(price) FROM Books);

WITH CategoryRanks AS (
    SELECT b.*, DENSE_RANK() OVER (
        PARTITION BY category ORDER BY price DESC
    ) AS price_rank
    FROM Books b
)
SELECT * FROM CategoryRanks WHERE price_rank <= 2;

SELECT m.member_id, m.member_name, COUNT(DISTINCT b.category) AS category_count
FROM Members m
JOIN Borrow br ON m.member_id = br.member_id
JOIN Books b ON br.book_id = b.book_id
GROUP BY m.member_id, m.member_name
HAVING COUNT(DISTINCT b.category) > 1;

WITH CategoryInventory AS (
    SELECT category, SUM(price * stock_quantity) AS inventory_value
    FROM Books GROUP BY category
)
SELECT * FROM CategoryInventory
WHERE inventory_value = (SELECT MAX(inventory_value) FROM CategoryInventory);

-- F Q15: Calculate total library inventory value (price * stock_quantity)
SELECT SUM(price * stock_quantity) AS total_inventory_value FROM Books;

SELECT category, SUM(price * stock_quantity) AS inventory_value
FROM Books GROUP BY category;

-- F Q17: Rank categories based on total inventory value
WITH CategoryInventory AS (
    SELECT category, SUM(price * stock_quantity) AS inventory_value
    FROM Books GROUP BY category
)
SELECT category, inventory_value,
       RANK() OVER (ORDER BY inventory_value DESC) AS inventory_rank
FROM CategoryInventory;

-- F Q18: Find member who borrowed the most expensive book
WITH BorrowedBookRanks AS (
    SELECT m.member_id, m.member_name, b.book_name, b.price,
           RANK() OVER (ORDER BY b.price DESC) AS price_rank
    FROM Borrow br
    JOIN Members m ON br.member_id = m.member_id
    JOIN Books b ON br.book_id = b.book_id
)
SELECT * FROM BorrowedBookRanks WHERE price_rank = 1;

WITH MemberCounts AS (
    SELECT m.member_id, m.member_name, COUNT(br.borrow_id) AS borrow_count
    FROM Members m LEFT JOIN Borrow br ON m.member_id = br.member_id
    GROUP BY m.member_id, m.member_name
)
SELECT member_id, member_name, borrow_count,
       RANK() OVER (ORDER BY borrow_count DESC) AS borrow_rank
FROM MemberCounts;

SELECT
    b.book_name,
    b.author,
    b.category,
    b.price,
    b.stock_quantity AS stock,
    m.member_name,
    br.borrow_date,
    CASE
        WHEN br.borrow_id IS NULL THEN 'Not Borrowed'
        WHEN br.return_date IS NULL THEN 'Borrowed / Not Returned'
        ELSE 'Returned'
    END AS borrow_status,
    CASE
        WHEN b.price < 400 THEN 'Low'
        WHEN b.price <= 700 THEN 'Medium'
        ELSE 'High'
    END AS price_classification,
    RANK() OVER (PARTITION BY b.category ORDER BY b.price DESC) AS category_price_rank
FROM Books b
LEFT JOIN Borrow br ON b.book_id = br.book_id
LEFT JOIN Members m ON br.member_id = m.member_id
ORDER BY b.category, category_price_rank, b.book_name;
