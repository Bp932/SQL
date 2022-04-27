
USE sql_hr;
-- SELF OUTER JOINS.
SELECT e.employee_id,e.first_name,m.first_name AS manager 
	FROM employees e
    LEFT JOIN employees m
		ON e.reports_to = m.employee_id;

SELECT *
	FROM order_items oi
    JOIN order_item_notes oin
		USING (order_id,product_id);
        
USE sql_invoicing;
SELECT p.date,c.name AS 'Client',p.amount,pm.name AS payment_method
	FROM payments p
    JOIN clients c
		USING (client_id)
	JOIN payment_methods pm
		ON p.payment_method = pm.payment_method_id;
        
-- NATURAL JOINS
SELECT o.order_id,c.first_name
	FROM orders o
    NATURAL JOIN customers c;
-- The search engine will look out for data in both the tables and it will join based upon SAME COLUMN NAMES.
-- Natural joins are little dangerous to use, boz the search engine figure out or guesses the join.
-- So sometimes natural joins can produce unexpected results.

-- CROSS JOINS
-- We use cross joins to combine or join every record from the first table with every record from the second table.
SELECT c.first_name,p.name
	FROM customers c
    CROSS JOIN products p
    ORDER BY c.first_name; 

-- Implicit Syntax of Cross Join
SELECT 
	c.first_name AS Customer,
    p.name AS product
    FROM customers c,products p
    ORDER BY c.first_name;

SELECT *
	FROM shippers s
    CROSS JOIN products p
    ORDER BY s.shipper_id,p.product_id;

-- UNION Operation to get results out of two queries.
-- UNION Operator helps in combining rows from multiple tables.

SELECT order_id , order_date, 'Active' AS status 
	FROM orders
	WHERE order_date >= '2019-01-01'
UNION
SELECT order_id , order_date, 'Archived' AS status 
	FROM orders
	WHERE order_date < '2019-01-01';
-- While using UNION operator we have to make sure that the number of columns returned from both the queries must be equal.

SELECT customer_id,
	first_name,
    points,
    'GOLD' AS Type
	FROM customers
    WHERE points >3000
UNION
SELECT customer_id,
	first_name,
    points,
    'SILVER' AS Type
	FROM customers
    WHERE points BETWEEN 2000 AND 3000
UNION
SELECT customer_id,
	first_name,
    points,
    'BRONZE' AS Type
	FROM customers
    WHERE points< 2000
	ORDER BY first_name;
    