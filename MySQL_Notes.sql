USE sql_store;

SELECT *
FROM customers
-- WHERE city = 'Atlanta'
ORDER BY first_name;

-- All about the SELECT clause
SELECT first_name, last_name, points, points + 10 * 100 AS discount_factor
FROM customers;
SELECT state FROM customers;
SELECT DISTINCT state FROM customers;

-- All about the WHERE clause
SELECT * 
FROM customers
WHERE points > 3000;
-- Comparison operators:
-- > greater than, < less than, <= less than or equal to, >= greater than or equal to, <>,!= not equal to, = equal to

SELECT * 
FROM customers
WHERE state != 'VA';  -- use quotes for strings

SELECT * 
FROM customers
WHERE birth_date > '1990-01-01';  -- use quotes for date values
 
 -- The AND, OR and NOT operators
 -- Focus: How to combine multiple search conditions when filtering data
SELECT * 
FROM customers
WHERE birth_date > '1990-01-01' AND points > 1000; -- both conditions need to be met

SELECT * 
FROM customers
WHERE birth_date > '1990-01-01' OR points > 1000; -- Atleast one of the conditions need to be met

SELECT * 
FROM customers
WHERE birth_date > '1990-01-01' OR points > 1000 AND state = 'VA'; 
-- When combining many logical operators, you need to be aware of the order
-- The AND operator is always evaluated first then followed by OR
-- You can change order using parentheses or brackets
SELECT * 
FROM customers
WHERE (birth_date > '1990-01-01' OR points > 1000 ) AND state = 'VA'; 

-- NOT logical operator is used to negate a condition 
SELECT * 
FROM customers
WHERE NOT (birth_date > '1990-01-01' OR points > 1000);
-- This shows entries where people were not born after 1990 also points less than 1000
-- Maths trick: when you apply the NOT operator to > it becomes <=, OR becomes AND. So, we'll get:
-- birthdate <= 1990 AND points <= 1000

-- The IN operator
-- We want to get customers located in Virginia or Florida or Georgia 
SELECT *
FROM customers
WHERE state = 'VA' OR state = 'GA' OR state = 'FL';
-- We use OR operator to combine conditions not strings so we can't say WHERE state = 'VA' OR 'GA'
-- There is a shorter and cleaner way to get the same results
SELECT *
FROM customers
WHERE state IN ('VA', 'FL','GA'); -- This query is exactly equivalent/same as the one above 
-- order doesn't matter
SELECT *
FROM customers
WHERE state NOT IN ('VA', 'FL','GA'); -- NOT IN gives you the ones not in VA, FL & GA
-- Use IN operator when comparing an attribute with a list of values

-- The BETWEEN operator
-- We want to get the customers who have >1000 and < 3000 points
SELECT *
FROM Customers
WHERE points >= 1000 AND points <= 3000;
-- Whenever you're comparing an attribute with a range of values, you can use the BETWEEN Operator
SELECT *
FROM Customers
WHERE points BETWEEN 1000 AND 3000; -- Same as the above query

-- The LIKE operator
-- How to retrieve rows that match a specific string pattern
-- Looking for customers having last name start with B, followed by any number of characters
SELECT * 
FROM customers
WHERE last_name LIKE 'b%';
-- % indicates any no. of characters, also it can be lowercase or uppercase B

SELECT * 
FROM customers
WHERE last_name LIKE 'brush%';

-- The % sign doesn't have to be at the end, it could be anywhere
-- customers with a b in their name, %b% indicate any no. of characters before and after b
SELECT * 
FROM customers
WHERE last_name LIKE '%b%';

SELECT * 
FROM customers
WHERE last_name LIKE '%y'; -- Last name end with a y

SELECT * 
FROM customers
WHERE last_name LIKE '_____y'; -- 5 undercores hence 6 characters long last name
-- The underscore sign shows how many characters before y

SELECT * 
FROM customers
WHERE last_name LIKE 'b____y';
-- % represent any number of characters
-- _ represent a single character
-- There is a more powerful new operator than LIKE and allows us to search for any string patterns

-- The REGEXP operator
-- Regular Expression are extremely powerful when searching for a string
-- They allow us to search for more complex patterns
SELECT *
FROM customers
WHERE last_name LIKE '%field%';

SELECT *
FROM customers
WHERE last_name REGEXP 'field'; -- this is the same as the above expression
-- here we have additional characters that we don't have when using LIKE
-- ^ indicate Beginning of a string
-- $ indicate End of a string

SELECT *
FROM customers
WHERE last_name REGEXP 'field$';

SELECT *
FROM customers
WHERE last_name REGEXP '^brush';

-- Find customers with word Mac or field in their last name
SELECT *
FROM customers
WHERE last_name REGEXP 'field|mac';

-- Find customers with word Mac or field or rose in their last name
SELECT *
FROM customers
WHERE last_name REGEXP 'field|mac|rose';
-- vertical bar is for multiple search patterns

SELECT *
FROM customers
WHERE last_name REGEXP 'field$|mac|rose';

-- We want customers with an e in their last name, before the letter e we have to have either g or i
SELECT *
FROM customers
WHERE last_name REGEXP '[gim]e';
-- this covers all last names with ge, ie, me
-- We can add the square brackets after the e
SELECT *
FROM customers
WHERE last_name REGEXP 'e[lyp]';

-- We can have characters from a-h(range) before e
SELECT *
FROM customers
WHERE last_name REGEXP '[a-h]e';

-- The IS NULL operator
-- How to look for records that miss an attribute
SELECT *
FROM customers
WHERE phone IS NULL;
-- Customers with no phone number
SELECT *
FROM customers
WHERE phone IS NOT NULL;
-- Customers who do have a phone number


-- The ORDER BY clause 
-- This shows how to sort data in our SQL queries
-- Looking at the output, the customers are sorted by their ID. (Default sort column)
-- We can change this by using ORDER BY clause
-- The customer _id is the default because it was selected as the primary key (uniquely identify each customer)
SELECT *
FROM customers
ORDER BY  first_name; -- ASCending order is default
-- To change ASC to DESC
SELECT *
FROM customers
ORDER BY  first_name DESC;
-- Sorting data by multiple columns
SELECT *
FROM customers
ORDER BY  state, first_name;

SELECT *
FROM customers
ORDER BY  state DESC , first_name ASC;

-- One difference in MySQL is we can sort data by any column 
-- even ones not included in SELECT clause
SELECT first_name, last_name, state
FROM customers
ORDER BY state, first_name;

SELECT first_name, last_name, state
FROM customers
ORDER BY first_name ASC;

SELECT first_name, last_name
FROM customers
ORDER BY  birth_date;

USE sql_store;

-- Sorting data by an ALIAS
SELECT first_name, last_name, 10 AS points
FROM customers
ORDER BY  points, first_name;

SELECT first_name, last_name, 10 AS points
FROM customers
ORDER BY 1, 2; -- Avoid this, sorting by column positions produces unexpected results

-- The LIMIT Clause
SELECT * 
FROM customers
LIMIT 3;
-- Page 1: 1 - 3 
-- Page 2: 4 - 6
-- Page 3: 7 - 9
-- Query to retrieve customers on page 3
SELECT * 
FROM customers
LIMIT 6, 3; -- This query says skip 6 and select 3
-- The Limit clause always go at the end

-- The INNER JOIN clause
-- So far we've only selected items from one table, now we'll learn how to select in multiple tables
-- How to select orders from the orders table but instead of showing customer_ID we'll see customer name and surname
-- Combine columns in orders table with those in customers table
-- INNER JOIN is symmetrical
SELECT *
FROM orders
JOIN customers
    ON orders.customer_id = customers.customer_id;  -- We're using INNER JOIN but we write JOIN only cause INNER is optional

-- The query above shows the combination of the tables, we can simplify this by:
SELECT order_id, first_name, last_name
FROM orders
JOIN customers
    ON orders.customer_id = customers.customer_id;
-- You'' get an error if you put customer_id in SELECT because that will be ambigous due to both tables having the variable, 
-- so you must specify from which table
SELECT order_id, orders.customer_id, first_name, last_name
FROM orders
JOIN customers
    ON orders.customer_id = customers.customer_id;
-- Note that we have repeated the name orders in many places, we did the same to customers
-- We can fix that and make the code simpler by using an ALIAS
SELECT order_id, o.customer_id, first_name, last_name
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id;

-- JOINING ACROSS DATABASES
-- Sql_inventoy database has the table products. Now we want to join the order_items table in sql_store with the produts table in data base: sql_inventory
SELECT * 
FROM order_items oi
JOIN sql_inventory.products p 
ON oi.product_id = p.product_id;
-- We didn't prefix order_items with the name of the database because in the beginning we stated USE Sql_store but
-- If we change the database to e.g Sql_inventory then we will have to prefix order_items
-- In summary: You only have to prefix tables that are not in the current data base

-- SELF JOINS
-- Joining a table with itself

USE sql_hr;

SELECT *
FROM employees e
JOIN employees m
ON e.reports_to = m.reports_to;
-- But then we want the name of employee and manager

SELECT e.employee_id, e.first_name, m.first_name
FROM employees e
JOIN employees m
ON e.reports_to = m.reports_to;
-- This has helped us see who the employee reports to

SELECT e.employee_id, e.first_name, m.first_name AS manager
FROM employees e
JOIN employees m
ON e.reports_to = m.reports_to;
-- When joining a table with itself we have to use different aliases
-- And prefix each column with an alias

-- JOINING MULTIPLE TABLES
-- The orders table has statuses and customer_id. More info about these columns can be found in customers and order_statuses table
-- Join the order table with these 2 tables
USE sql_store;

SELECT * 
FROM orders o
JOIN customers c 
	ON o.customer_id = c.customer_id
JOIN order_statuses os
	ON o.status = os.order_status_id;
-- We can be asked to join 10 tables
-- The results show columns from all the tables
-- This result is complex and hard to extract info from, lets select few columns

SELECT o.order_id, o.order_date, c.first_name, c.last_name, os.name AS status
FROM orders o
JOIN customers c 
	ON o.customer_id = c.customer_id
JOIN order_statuses os
	ON o.status = os.order_status_id;
    

-- COMPOUND JOIN CONDITIONS
-- There are times where there isn't a unique column to uniquely identify records in a given table
-- For example in the order_items table we don't have a unique column
-- So in this table we use the combination of the values in each of the 2 columns to uniquely identify each order item
-- Opening the table in the design mode, we see that there are 2 primary keys - order_id and product_id, we call this a COMPOSITE PRIMARY KEY
-- Composite primary key contains more than one column
-- Why does this matter? When you have a table with a composite primary key, you need to learn how to join that table with other table
-- Order_item_notes table has a unique key- note_id, it contains the combination of order_id and product_id that uniquely identify order_item

-- Join order_item_notes table with order_items table:
SELECT *
FROM order_items oi
JOIN order_item_notes oin
	ON oi.order_id = oin.order_id
	AND oi.product_id = oin.product_id;

-- Implicit Join Syntax
SELECT *
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id;
    
-- There is another way to write the above query using Implicit Joint Syntax
 SELECT *
 FROM orders o, customers c
 WHERE o.customer_id = c.customer_id; -- We get 10 records

-- Suggestion is not to use this because if you forget to write the WHERE clause you'll get a CROSS JOINT
-- For EXAMPLE
 SELECT *
 FROM orders o, customers c;
-- We get 100 records because every record in the orders table is joined with every record in the customers table
-- This is called a CROSS JOINT
-- So it is better to use the EXPLICIT JOINT SYNTAX

-- OUTER JOINS
-- The above joins were all INNER JOINS, whenever we type JOIN it means INNER JOIN, INNER KEYWORD is OPTIONAL

-- Let's compare INNER AND OUTER JOIN
-- INNER JOIN

USE sql_store;
SELECT c.customer_id, c.first_name, o.order_id
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

-- There is something missing in our result, we only see customers who have an order in our system, customers 2, 5, 6, 7, 8 & 10
-- But looking at customers table we have other customers e.g 1,3 and so on where we currently don't have any orders for them
-- What if we want to see all the customers whether they have an order or not?
-- That's when we use an OUTER JOIN
-- The JOIN CONDITION - ON made us get the above results


-- In SQL we have 2 TYPES Of OUTER JOINS
-- We have LEFT JOINS AND RIGHT JOINS
-- The LEFT JOIN gives us all the items from the left table whether the condition is true or not
-- So we get all the customers and if they have an order, we'll see the order_id as well

SELECT c.customer_id, c.first_name, o.order_id
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

-- RIGHT JOIN, all the records from order table are returned whether the condition is true or not
SELECT c.customer_id, c.first_name, o.order_id
FROM customers c
RIGHT JOIN orders o
ON c.customer_id = o.customer_id
ORDER BY c.customer_id;
-- We get the same result as INNER JOIN because we're selecting all the records from the right table so we don't see all the customers we see all the orders

-- If we want to use the right join and still see the customers we can swap order of the tables
SELECT c.customer_id, c.first_name, o.order_id
FROM orders o
RIGHT JOIN customers c
ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

-- Often developers use the RIGHT OUTER or LEFT OUTER JOIN
-- THE OUTER KEYWORD is OPTIONAL just like the INNER KEYWORD

-- Outer Join Between Multiple Tables
-- Similar to INNER JOIN, we can use OUTER JOINS between MULTIPLE TABLES
-- Looking at the orders table we see that some of our orders have a shipper_id, these are orders that have been shipped
-- now let's join the orders table and the shipper's table to display the name of the shipper in the results
SELECT c.customer_id, c.first_name, o.order_id
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
JOIN shippers sh
ON o.shipper_id = sh.shipper_id
ORDER BY c.customer_id; -- We have OUTER JOIN and INNER JOIN
-- This gives us 5 records, but we have more orders, we have the same problem as before some of our orders do not have a shipper that is why they are not returned
-- The JOIN condition is not true for some of our orders
-- To solve this problem we use a LEFT JOIN

-- GROUP BY and AGGREGATE Functions
-- GROUP BY is a SQL statement that will allow us to aggregate data and apply functions to better uderstand how data is distributed per category 

-- AGGREGATE FUNCTIONS
-- SQL provides a variety of aggregate functions
-- Most common aggregate functions:

-- AVG() - returns average value
-- COUNT() - returns number of values
-- MAX() - returns max value
-- MIN() - returns min value
-- SUM() - returns the sum of all values
-- Aggregate functions happen only on the SELECT clause or HAVING clause
-- AVG() returns a floating point value with decimals, we can ROUND() to specify precisoon after the decimal
-- COUNT() simply returns the number of rows = COUNT(*)

USE sql_store;
SELECT MIN(points) FROM customers;
SELECT MAX(points) FROM customers;
SELECT COUNT(*) FROM customers;
SELECT ROUND(AVG(points),2) FROM customers;
SELECT SUM(points) FROM customers;

-- GROUP BY
-- Group by allows us to aggregate columns per some category
-- When performing a group by there are couple of things to consider:
-- Categorical Column - we need to choose a categorical column to perform a GROUP BY function on
-- Categorical columns are non-continous
-- They can still be numerous like (e.g class 1, class 2 etc)
-- After choosing categories we split the column to these categories or classes
 -- An aggregate function takes in multiples values and reduces them back dowm to a single value
 -- Aggregate function may sum/avg/min/max/count the categories or classes to show the total for each category

-- The general syntax 
-- SELECT category_col, AGG(data_col)
-- FROM table
-- GROUP BY category_col;

-- Select some category column or something we deem as a categorical
-- Then we choose to perform some aggregate function on data column
-- Then we group by that category column
-- The GROUP BY clause musr appear right after a FROM statement or WHERE statement
-- If we want before we Group by, we can filter things out using a WHERE statement 

-- SELECT category_col, AGG(data_col)
-- FROM table
-- WHERE category_col != 'A'
-- GROUP BY category_col;

-- In the SELECT statement, column must either have an aggregate function or be in the GROUP BY call.
-- E.g SELECT company,division, SUM(sales)
-- FROM finance_table
-- GROUP BY company, division
-- So columns that don't have an aggregate function in the SELECT statement MUST be included in the GROUP BY statement
-- WHERE statements should not refer to the aggregation result. HAVING statement explains how t do that

-- SELECT company,division, SUM(sales)
-- FROM finance_table
-- WEHERE division IN ('marketing', 'transport')
-- GROUP BY company, division;

-- If you want to sort results based on the AGGREGATE, make sure to reference the entire function e.g SUM(sales) not just sales
-- SELECT company, SUM(sales)
-- FROM finance_table
-- GROUP BY company
-- ORDER BY SUM(sales)
-- LIMIT 5 

USE sql_store;
SELECT order_id, SUM(unit_price) FROM order_items
GROUP BY order_id
ORDER BY SUM(unit_price);

SELECT order_id FROM order_items
GROUP BY order_id;

SELECT DISTINCT order_id FROM order_items;

-- SELECT order_id, unit_price FROM order_items
-- GROUP BY unit_price; -- ERROR!!!!!!!!

-- When doing a GROUP BY on a DATE column with date and time stamp. You have to call a specialised GROUP function 
-- To CONVERT the Timestamp to a DATE

-- E.g SELECT DATE(payment_date), SUM(amount) FROM payment
-- GROUP BY DATE(payment_date)
-- ORDER BY SUM(amount) DESC
-- The DATE function is extracting just the DATE portion from the timestamp info.

-- HAVING CLAUSE
-- The HAVING clause allows us to filter after an aggregation has already taken place

-- SELECT company, SUM(sales)
-- FROM finance_table
-- WHERE company != 'Google'
-- GROUP BY company

-- We've already seen we can filter before executing the GROUP BY, but what if we want to filter based on SUM(sales)?
-- We can not use WHERE to filter based off of aggregate results because those happen after a WHERE is executed.
-- sum happens after GROUP BY, so can't use WHERE to filter cause aggregation happens after GROUP BY
-- So if after performing GROUP BY and sum we wanted to perform an additional filter based on the sum of sales we can use HAVING clause

-- SELECT company, SUM(sales)
-- FROM finance_table
-- WHERE company != 'Google'
-- GROUP BY company
-- HAVING SUM(sales) > 1000

-- HAVING allows us to use the aggregate result as a filter along with a GROUP BY 

-- ADVANCED SQL COMMANDS?
-- TIMESTAMPS & EXTRACT
-- These are more useful when creatingg our own tables and databases, rather than when quering a database
-- PostgreSQL can hold date and time info:
-- TIME - contains only time
-- DATE - contains only date
-- TIMESTAMP - contains date and time
-- TIMESTAMPTZ - contains date, time and timezone
-- Remember you can always remove historical info, but you can't add it
-- Let's explore functions and operations related to these specific data types:
-- TIMEZONE
-- NOW
-- TIMEOFDAY
-- CURRENT_TIME
-- CURRENT_DATE

-- FOR EXAMPLE:
-- SHOW ALL - Shows values of runtime values, SHOW ALL gives us the name of parameter, setting it is on and the decription
-- SHOW TIMEZONE - Gives us the current timezone the computer is working on:
SHOW TIMEZONE

-- IF you want to get the current TIMESTAMP
-- The NOW function gives us date, time and timezone
-- NOW gives info in the timestamp format
SELECT NOW()
-- IF we want the information as a string/text not timestamp we use:
SELECT TIMEOFDAY()
-- This returns back a text showing date, day and time zone

-- SELECT CURRENT_TIME gives us the current time and timezone data type
SELECT CURRENT_TIME
-- SELECT CURRENT_DATE gives us the date data type
SELECT CURRENT_DATE

-- Now we'll be focusing on time stamp functionality that is related to querying tables and databases
-- Let's explore extracting info from a time based data type using:
-- EXTRACT()
-- AGE()
-- TO_CHAR()

-- EXTRACT()
-- Allows us to 'extract' or obtain a sub-component of a date value
-- YEAR
-- MONTH
-- DAY 
-- WEEK
-- QUARTER
-- e.g EXTRACT(YEAR FROM date_col)

-- AGE()
-- Calculates and return the current age given a timestamp
-- Usage:
-- AGE(date_col)
-- Returns:
-- 13 years 1 mon 5 days 01:34:13.003423

-- TO_CHAR
-- General function to convert data types to text
-- Useful for timestamp formatting
-- Usage:
-- TO_CHAR(date_col, 'mm-dd-yyyy')

-- EXAMPLES on PgAdmin
-- SELECT EXTRACT(YEAR FROM payment_date)
-- AS pay_year
-- FROM Payment -- We can replace YEAR with MONTH, QUARTER, WEEK

-- To get how old the TIMESTAMP is we use:
-- SELECT AGE(payment_date)
-- FROM payment

-- CREATING TABLES
-- We'll look at choosing 
-- Data Types
-- Primary and foreign keys
-- Contraints
-- CREATE
-- INSERT
-- UPDATE
-- DELETE, ALTER, DROP

-- Boolean : True or false
-- Character : char, varchar, and text
-- Numeric : integer and floating-point number
-- Temporal : date, time, timestamp, and interval

-- UUID : Universally Unique Identifiers
-- Array : Stores an arrray of strings, numbers, etc.
-- JSON 
-- Hstore key-value pair
-- Special types susch as network address and geometric data

-- e.g. Imagine we want to store a phone number, should it be stored as numeric?
-- If so which type of numeric?
-- We take a look at the online documentation for options
-- The doc showed us maybe BIGINT data type is the one making sense.
-- But then we just want to record numbers, why bother with numerics at all?
-- We don't perform arithmetic with numbers, so it probably makes more sense as a VANCHAR data type instead.
-- It is usually recommended to store phone numbers as a text data type
-- When it comes to numeric leading zeros can cause problems. 07 and 7 can be treated the same
-- Or you can store additional libraries to store phone numbers
-- When creating a database and table, take your time to plan for long term storage.
-- You can always remove historical info but you can't go back in time to add in info.

-- PRIMARY AND FOREIGN KEYS
-- A primary key is a column or a group of columns used to identify a row unqiuely in a table.
-- non-null 
-- Primary keys are also important because they allow us to easily discern what columns should be used for joining tables together
-- Serial data type - automatically creating these unique integers as we eneter more data into the table

-- Foreign key is a field or group of fields in a table that uniquely identifies a row in another table
-- FK is defined in a table that references the PK of the other table
-- The table that contains the FK is called the referencing table or child table
-- The table to which the FK references is called referenced table or parent table
-- A table can have multiple FKs depending on its relationship with other tables

-- Foreign key and primary key typically make good columns choices for joining togetehr 2 or more tables.
-- When creating tables and defining columns we can use constraints to define columns as a PK,
-- or attaching a foreign key relationship to another table

-- CONTRAINTS
-- Constraints are the rules enforced on data columns on table
-- These are used to prevent invalid data from being entered into the database
-- This ensures the accuracy and reliability of the data in the database
-- Contraints can be divided into 2
-- Column constraints:
-- Contraints the data in a column adhere to certain conditions
-- Table contraints
-- applied to the entire table rather than an individual column
-- Most common Column Constraints:
-- NOT NULL - ensures that a column cannot have NULL value
-- UNIQUE contraint
-- Ensures that all values in a column are different
-- PRIMARY KEY contraint
-- uniquely identifies each row/record in a database table
-- FOREIGN KEY
-- contrains data based on columns in other tables
-- CHECK contraint
-- Ensures that all values in a column satisfy certain conditions
-- Exclusion constraint
-- Ensures that if any two rows are compared on the specified column or expression using the specified operator not all these comparisons will return

-- Most common Table Constraints
-- CHECK (condition) contraint
-- to check a condition when inserting or updating data
-- REFERENCES contraint
-- to contrain the value stored in the column that must exist in a column in another table
-- UNIQUE (column-list) contraint
-- forces the values tored in the columns listed inside the parentheses to be unique
-- PRIMARY KEY (column-list)
-- allows you to define the PK that consists of multiple tables

-- WE ARE READY TO USE SQL SYNTAX TO CREATE TABLES!!

-- CREATE TABLES
-- Full general syntax:
-- CREATE TABLE table_name(column_name DATA TYPE column_constraint, 
-- column_name DATA TYPE column_constraint, table_constraint table_constraint)
-- INHERITS existing_table_name;

-- For now we'll do a Common simple example:
-- CREATE TABLE table_name(column_name DATA TYPE column_constraint, 
-- column_name DATA TYPE column_constraint, table_constraint table_constraint);

-- SERIAL records unique numbers for us as we insert data into a table and when we remove a record a serial will show that that record was removed
-- CREATE TABLE players (player_id SERIAL PRIMARY KEY,
-- age SMALLINT NOT NULL);

-- INSERT COMMAND
-- INSERT allows us to add in rows to a table.
-- GENERAL SYNTAX:
-- INSERT INTO table (column1, column2, ...)
-- VALUES 
-- (value1, value2, ...),
-- (value1, value2, ...),...;

-- SYNTAX for inserting values from another table:
-- INSERT INTO table (column1, column2,...)
-- SELECT column1, column2,...
-- FROM another_table
-- WHERE condition;
-- To do this:
-- Keep in mind, the inserted row values must match up for the table, including constarints
-- SERIAL columns do not need to be provided a value


-- UPDATING DATA
-- The update keyword allows for the changing of values of the columns in a table
-- GENERAL SYNTAX:
-- UPDATE table
-- SET column1 = value1,
-- column2 = value2, ...
-- WHERE condition;

-- For example
-- UPDATE account
-- SET last_login = CURRENT_TIMESTAMP
-- WHERE last_login IS NULL;

-- You can also reset everything without the WHERE condition
-- UPDATE account
-- SET last_login = CURRENT_TIMESTAMP
-- This overwrite all last_login entries

-- Set based on another column
-- UPDATE account 
-- SET last_login = created_on

-- Can use another tables's values (UPDATE join)
-- UPDATE TableA
-- SET original_col = TableB.new_col
-- FROM tableB
-- WHERE TableA.id = TableB.id

-- Return affected rows
-- UPDATE account
-- SET last_login = created_on
-- RETURNING account_id, last_login

-- DELETE COMMAND
-- We can use the DELETE clause to remove rows from a table
-- For example:
-- DELETE FROM table
-- WHERE row_id =1

-- We can delete rows based on their presence in other tables
-- For example
-- DELETE FROM tableA
-- USING tableB
-- WHERE tableA.id = TableB.id
-- So we're deleteing rows where they match TableB

-- We can DELETE all rows from a table
-- For example:
-- DELETE FROM table

-- Similar to UPDATE command, we can also add in a RETURNING call to eturn rows that were removed
-- It will return the rows deleted

-- ALTER COMMAND
-- allows for changes to an existing table structure such as:
-- Adding, dropping or renaming columns
-- Changing a column's data type
-- Set DEFAULT values for a column
-- Add CHECK constraints
-- Rename table

-- General Syntax
-- ALTER TABLE table_name action

-- ADDING columns
-- ALTER TABLE table_name
-- ADD COLUMN new_col Data TYPE

-- Removing columns
-- ALTER TABLE table_name
-- DROP COLUMN col_name

-- Renaming columns
-- ALTER TABLE table_name
-- RENAME TO new_name

-- ALTER CONSTRAINTS
-- ALTER TABLE table_name
-- ALTER COLUMN col_name
-- SET DEFAULT value

-- ALTER TABLE table_name
-- ALTER COLUMN col_name
-- DROP DEFAULT

-- ALTER TABLE table_name
-- ALTER COLUMN col_name
-- SET NOT NULL

-- ALTER TABLE table_name
-- ALTER COLUMN col_name
-- DROP NOT NULL

-- ALTER TABLE table_name
-- ALTER COLUMN col_name
-- ADD CONSTRAINT constraint_name

-- DROP COMMAND
-- DROP allows for the complete removal of a column in a table
-- In PostgreSQL this will also automatically remove all of its indexes and constraints involving the column
-- However, it will not remove columns used in views, triggers or stored procedures without the additional CASCADE Clause
--  it will not remove columns used on other things that are dependent
-- If you do want to remove such columns, we can use CASCADE clause

-- GENERAL SYNTAX
-- ALTER TABLE table_name
-- DROP COLUMN col_name

-- Remove all dependencies
-- ALTER TABLE table_name
-- DROP COLUMN col_name CASCADE

-- Check for existence of the column to avoid error
-- ALTER TABLE table_name
-- DROP COLUMN IF EXISTS col_name

-- Drop multiple columns
-- ALTER TABLE table_name
-- DROP COLUMN col_one,
-- DROP COLUMN col_two

-- CHECK CONSTRAINT
-- The CHECK constraints allows us to create more customized constraints that adhere to a certain condition
-- Such as making sure all inserted integer values fall below a certain threshold.

-- GENERAL SYNTAX:
-- CREATE TABLE example(
-- ex_id SERIAL PRIMARY KEY,
-- age SMALLINT CHECK (age>21),
-- parent_age SMALLINT CHECK (parent_age>age);
-- We can set conditions based on other columns e.g parent_age>age


-- CREATE TABLE account(
 --user_id SERIAL PRIMARY KEY,
 --username VARCHAR(50)UNIQUE NOT NULL,
	password VARCHAR(50) NOT NULL,
	email VARCHAR(250) UNIQUE NOT NULL,
	created_on TIMESTAMP NOT NULL,
	last_login TIMESTAMP
)

-- CREATE TABLE AND LINK TO ANOTHER THROUGH FOREIGN KEY

CREATE TABLE job(
job_id SERIAL PRIMARY KEY,
	job_name VARCHAR (200) UNIQUE NOT NULL
)

CREATE TABLE account_job(
user_id INTEGER REFERENCES account(user_id),
	job_id INTEGER REFERENCES job(job_id),
	hire_date TIMESTAMP
)

INSERT INTO account(username, password, email, created_on)
VALUES
('Jose','password','jose@mail.com',CURRENT_TIMESTAMP)

SELECT * FROM account;

INSERT INTO job (job_name)
VALUES
('President');

INSERT INTO job (job_name)
VALUES
('Astronaut');


SELECT * FROM job

-- ASSIGN ACCOUNT TO A JOB

INSERT INTO account_job (user_id,job_id,hire_date)
VALUES
(1,1,CURRENT_TIMESTAMP)

SELECT * FROM account_job

-- Let's try for someone whose user_id doesn't exist
INSERT INTO account_job (user_id,job_id,hire_date)
VALUES
(10,10,CURRENT_TIMESTAMP)

-- We get an error because this violets the foreign key contraints
-- user_id 10 is not present in table account
-- We have to make sure that when we insert something with FK constraint that it exist in other tables


SELECT * FROM account

UPDATE account
SET last_login = CURRENT_TIMESTAMP

UPDATE account
SET last_login = created_on

-- These examples are just for syntax reasons

UPDATE account_job
SET hire_date = account. created_on 
FROM account
WHERE account_job.user_id = account.user_id

SELECT * FROM account_job

UPDATE account
SET last_login = CURRENT_TIMESTAMP
RETURNING email, created_on, last_login;

INSERT INTO job(job_name)
VALUES ('cowboy')

DELETE FROM job
WHERE job_name = 'cowboy'
RETURNING job_id, job_name

CREATE TABLE information(
info_id SERIAL PRIMARY KEY,
	title VARCHAR(500) NOT NULL,
	person VARCHAR(50) NOT NULL UNIQUE
)

-- Lets rename this table
ALTER TABLE information
RENAME TO new_info

SELECT * FROM new_info

-- Renaming the column
ALTER TABLE new_info
RENAME COLUMN person TO people

-- How to insert data into the table
INSERT INTO new_info(title)
VALUES 
('some new title')
-- We get an error, so we can either add a value for people or remove the NOT NULL costraints
--ALTER constraints that already exist on certain columns

ALTER TABLE new_info
ALTER COLUMN people DROP NOT NULL
-- If you want to DROP a constraint we use DROP, or SET if you want to SET a constraint

INSERT INTO new_info(title)
VALUES 
('some new title')

SELECT * FROM new_info

ALTER TABLE new_info
DROP COLUMN people

ALTER TABLE new_info
DROP COLUMN IF EXISTS people

CREATE TABLE employees(
emp_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50)NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	birthdate DATE CHECK (birthdate> '1990-01-01'),
	hire_date DATE CHECK (hire_date>birthdate),
	salary INTEGER CHECK (salary>0)
)

INSERT INTO employees(
first_name, last_name,birthdate,hire_date,salary)
VALUES ('jose', 'Portilla', '1990-11-03','2010-01-01',100)

INSERT INTO employees(
first_name, last_name,birthdate,hire_date,salary)
VALUES ('Sammy', 'Smith', '1990-11-03','2010-01-01',200)

SELECT * FROM employees

-- The SERIAL kept count of the failed attempts so started primary key at 2 and 4
-- This lets us know whether rows were removed or insert commands failed)




