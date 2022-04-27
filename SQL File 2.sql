
USE sql_store;

SELECT * FROM customers WHERE phone IS NULL;

SELECT * FROM customers WHERE phone IS NOT NULL;

Select * from information_schema.columns where column_name like '%ship%';

SELECT * 
FROM orders 
WHERE shipped_date IS NULL;

-- Sorting or Sequencing Data.
SELECT * FROM customers ORDER BY first_name ASC;
SELECT * FROM customers ORDER BY first_name DESC;

SELECT * FROM customers ORDER BY state,first_name;
SELECT * FROM customers ORDER BY state DESC,first_name ASC;

SELECT first_name,last_name FROM customers ORDER BY 1,2;

SELECT * FROM order_items WHERE order_id = 2 ORDER BY quantity*unit_price DESC;

-- skip first 7 and show last 3
SELECT * FROM customers LIMIT 7,3;
-- Show only top 3 
SELECT * FROM customers LIMIT 3;

-- Find the top 3 order ids in terms of total amount.
SELECT * FROM order_items ORDER BY quantity*unit_price DESC LIMIT 3;
-- Top 3 most loyal customers based upon points.
SELECT * FROM customers ORDER BY points DESC LIMIT 3;

-- Order
-- 1. SELECT 2. FROM 3. WHERE 4. ORDER BY 5. LIMIT.

SELECT order_id,o.customer_id,first_name,last_name 
	FROM orders o 
	INNER JOIN customers c 
	ON o.customer_id=c.customer_id;

-- when you need to select a column which has similar name as keyword use `` to access it.
SELECT order_id,`name`,quantity 
	FROM order_items oi 
	INNER JOIN products p 
	ON oi.product_id=p.product_id;

-- from the order item table show the top 3 orders which were most expensive buys. 
-- Also show the name of the product that was purchased in that respective order.

SELECT oi.order_id,p.name,oi.quantity*oi.unit_price AS 'Total Order Amount',
oi.unit_price AS 'Unit Price at Tym of Purchase',p.unit_price AS 'Current Price' 
	FROM order_items oi
    INNER JOIN products p
    ON oi.product_id=p.product_id
	ORDER BY oi.quantity*oi.unit_price DESC
	LIMIT 3;

-- The Limit clause must always come in the end.

SELECT order_id,c.first_name,c.last_name,order_date,status,shipped_date,shipper_id 
	FROM orders o
    INNER JOIN customers c
    USING (customer_id);

-- Joining 2 tables from different databases    
SELECT *
	FROM order_items oi
    JOIN sql_inventory.products p
    ON oi.product_id=p.product_id;

-- How to use Self Join
SELECT e.employee_id,e.first_name,e.last_name,e.job_title,m.first_name AS 'Reports To'
	FROM sql_hr.employees e
    JOIN sql_hr.employees m
    ON e.reports_to=m.employee_id;
    
-- How to join more than two tables

SELECT o.order_id,o.order_date,c.first_name,c.last_name,os.name AS 'Order Status'
	FROM orders o
    JOIN customers c
		ON o.customer_id=c.customer_id
	JOIN order_statuses os
		ON o.status=os.order_status_id;
        
SELECT p.payment_id,p.date,c.name,p.amount,pm.name AS 'Payment Method'
	FROM sql_invoicing.payments p
    JOIN sql_invoicing.clients c
		ON p.client_id=c.client_id
	JOIN sql_invoicing.payment_methods pm
		ON p.payment_method=pm.payment_method_id;
        
-- How to use compound JOIN

SELECT *
	FROM order_items oi
    JOIN order_item_notes oin
		ON oi.order_id=oin.order_Id
        AND oi.product_id=oin.product_id;
        
-- How to your implicit Join operation
SELECT order_id,order_date,c.first_name,c.last_name,os.name AS 'Order Status'
	FROM orders o,customers c,order_statuses os
    WHERE o.customer_id=c.customer_id AND o.status=os.order_status_id;

-- How to use Outer Joins
SELECT o.order_id,c.customer_id,c.first_name
	FROM customers c
    LEFT JOIN orders o
		ON c.customer_id=o.customer_id
	ORDER BY c.customer_id;
-- Outer Joins are of two kinds- LEFT JOIN /RIGHT JOIN.
-- When we use a LEFT JOIN all the instances of LEFT table are displayed whether the condition is true or not.
-- When we use a RIGHT JOIN all the instances of RIGHT table are displayed whether the condition is true or not.
-- Outer and Inner Keywords are optional not necessary.

SELECT o.order_id,c.customer_id,c.first_name
	FROM orders o
    RIGHT JOIN customers c
		USING (customer_id)
	ORDER BY c.customer_id;

SELECT p.product_id,p.name,oi.quantity
	FROM order_items oi
    RIGHT JOIN products p
		USING (product_id)
	ORDER BY oi.quantity;

-- Outer Joins between multiple tables

SELECT c.first_name,c.last_name,o.order_id,o.order_date,sh.name AS 'Shipper Name'
	FROM customers c
    LEFT JOIN orders o
		USING (customer_id)
	LEFT JOIN shippers sh
		ON sh.shipper_id=o.order_id
	ORDER BY c.customer_id;
    Select * from customers;
    Select * from orders;
    Select * from shippers;

-- **NOTE : ALWAYS USE LEFT OUTER JOINS WHEN YOU ARE USING MULTIPLE TABLES. THIS AVOIDS CONFUSION.

Select * from orders;
Select * from customers;
Select * from shippers;
Select * from order_statuses;

SELECT o.order_date,o.order_id,c.first_name,sh.name AS 'shipper',os.name AS 'status'
	FROM orders o
    JOIN customers c
		USING (customer_id)
	LEFT JOIN shippers sh
		USING (shipper_id)
	JOIN order_statuses os
		ON o.status=os.order_status_id
	ORDER BY sh.name;