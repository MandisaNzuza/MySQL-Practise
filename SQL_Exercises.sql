-- EXERCISE 1
-- Return all the products
-- name 
-- unit price
-- new price (unit price * 1.1)

SELECT name, unit_price, unit_price * 1.1 AS new_price
FROM products;

-- EXERCISE 2
-- Get the orders placed this year
SELECT * FROM orders
WHERE order_date > '2018-12-31';

-- Correct answer
SELECT * FROM orders
WHERE order_dae >= '2019-01-01';

-- EXERCISE 3
-- From the order items table, get the items
-- for order #6
-- where the total price is greater than 30 

SELECT * FROM order_items
WHERE order_id = 6 AND quantity*unit_price > 30;  -- YAY!!!!!! CORRECT

-- EXERCISE 3
-- Return products with
-- quantity in stock equal 49, 38, 72
SELECT *
FROM products
WHERE quantity_in_stock IN ( 49, 38, 72);
-- YAY!! CORRECT

-- EXERCISE 4
-- Return customers born
-- between 1/1/1990 AND 1/1/2000
SELECT *
FROM customers
WHERE birth_date BETWEEN 1990-01-01 AND 2000-01-01;
-- CORRECT ANSWER:
SELECT *
FROM customers
WHERE birth_date BETWEEN '1990-01-01'  AND '2000-01-01';

-- EXERCISE 5
-- Get the customers whose 
-- addresses contain TRAIL OR AVENUE

SELECT *
FROM customers
WHERE address LIKE '%trail%' OR '%avenue%';
-- CORRECT ANSWER
SELECT *
FROM customers
WHERE address LIKE '%trail%' OR 
	  address LIKE '%avenue%';
      
-- Phone numbers end with 9    
SELECT *
FROM customers
WHERE phone LIKE '%9'; -- YAY!! CORRECT

-- Phone numbers NOT ending with 9  
SELECT *
FROM customers
WHERE phone NOT LIKE '%9';

-- EXERCISE 6 
-- Get the customers whose
-- first names are ELKA or AMBUR
SELECT * 
FROM customers
WHERE first_name REGEXP 'Elka|Ambur'; -- CORRECT!!

-- last names end with EY or ON
SELECT * 
FROM customers
WHERE last_name REGEXP 'ey$|on$'; -- CORRECT!!

-- last names start with MY or contains SE
SELECT * 
FROM customers
WHERE last_name REGEXP '^my|se'; -- CORRECT!!

-- last names contain B followed by R or U
SELECT * 
FROM customers
WHERE last_name REGEXP 'b[ru]'; -- CORRECT!!
-- OTHER WAY:
SELECT * 
FROM customers
WHERE last_name REGEXP 'br|bu';

-- EXERCISE 7
-- Get the orders that are not shipped 
SELECT *
FROM orders
WHERE shipped_date IS NULL; -- CORRECT!!

-- Another Correct answer:
SELECT *
FROM orders
WHERE shipper_id IS NULL; 

-- EXERCISE 8
SELECT order_id, product_id, quantity*unit_price AS total_price
FROM order_items
WHERE order_id = 2
ORDER BY total_price DESC;

-- RIGHT ANSWER
SELECT *, quantity*unit_price AS total_price
FROM order_items
WHERE order_id = 2
ORDER BY total_price DESC;

-- EXERCISE 9
-- Get the top 3 loyal customers, customers with a lot of points
SELECT * 
FROM customers
ORDER BY points DESC
LIMIT 3; -- YAY!!! CORRECT , I'M PROUD OF THIS ONE

-- EXERCISE 10
-- Write a query to join order_items table with the products table
-- For each order return both order_id and product name, followed by quantity  and the unit price from order_items table
-- Use an ALIAS to simplify the code
SELECT order_id, name, quantity, order_items.unit_price
FROM order_items 
JOIN products 
     ON products.product_id = order_items.product_id;
     
SELECT order_id, oi.product_id, quantity, oi.unit_price
FROM order_items oi 
JOIN products p
     ON p.product_id = oi.product_id;

SELECT name
FROM order_items 
JOIN products ON order_items.product_id = products.product_id;

-- EXERCISE 11
-- USE sql_invoicing database
-- JOIN payments table with the clients table and payments method table
-- Produce a reports that shows the payments with more detail such as name of client and payment method

USE sql_invoicing;

SELECT p.date, p.invoice_id, p.amount, p.client_id, c.name, pm.name AS payment_method
FROM payments p
JOIN clients c 
	ON p.client_id = c.client_id
JOIN payment_methods pm
	ON p.payment_method = pm.payment_method_id;

-- COMPOUND JOIN CONDITIONS
-- There are times where there isn't a unique column to uniquely identify records in a given table
-- For example in the order_items table we don't have a unique column
-- So in this table we use the combination of the values in each of the 2 columns to uniquely identify each order item

-- Write a query that produces the given result, we have 3 columns product_id, name and quantity from the order_items table
-- We join the product table with order_items table so we can see how many times each product is ordered
-- Write an OUTER JOIN to produce the result

SELECT p.product_id, p.name, oi.quantity
FROM products p
LEFT JOIN order_items oi
ON p.product_id = oi.product_id;











