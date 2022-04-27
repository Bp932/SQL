
-- Provides you information about the whole schema. How many different Databases, DataTables, DataColumns, DataType, etc.
SELECT * FROM information_schema.columns;
SHOW databases;
-- Use is used to create a global access for the database
USE sql_store;
-- Show all tables within the table database
SHOW TABLES;
SELECT TABLE_NAME FROM information_schema.tables WHERE table_schema = 'sql_store';

SELECT * FROM customers 
-- WHERE customer_id = 1
ORDER BY first_name;

SELECT 
	first_name,
    last_name,
    points,
    points+10 AS discount_factor, -- use alas. You can use double qoutes if you want to have a space rather than under-score. 
    (points+10) * 100 AS 'discount fac'
FROM customers;

-- How to update a value within a table wrt a specific instance.
UPDATE sql_store.customers SET `state` = 'VA' WHERE (`customer_id` = '1');

SELECT DISTINCT state FROM customers; -- if you want to see unique values.

SELECT * FROM customers WHERE points > 3000;
SELECT * FROM customers WHERE state = 'VA';
SELECT * FROM customers WHERE state = 'va'; -- where operator is non case sensitive.
SELECT * FROM customers WHERE state <> 'VA'; -- <> or != both act as not equal operators.
SELECT * FROM customers WHERE state != 'VA';
SELECT * FROM customers WHERE birth_date > '1991-01-01';

-- To get the datatype of each column(field) within a specific table
SELECT COLUMN_NAME,data_type from information_schema.COLUMNS WHERE table_schema = 'sql_store' AND TABLE_NAME = 'customers';

-- Get all customers who's birthday is after 1990 and who's points are more than 1000.
SELECT * FROM customers WHERE (birth_date > '1990-01-01' OR points > 1000) AND state = 'va';
SELECT * FROM customers WHERE NOT (birth_date > '1990-01-01' OR points > 1000);
SELECT * FROM customers WHERE birth_date <= '1990-01-01' AND points < 1000;

-- Select entries from order_items table where order_id equals '6' and total order amount is greater than 30.
SELECT * FROM order_items WHERE order_id = 6 AND quantity*unit_price > 30;

-- IN operator is used to match values in a list.
SELECT * FROM customers WHERE state = 'va' OR state = 'ga' OR state = 'fl';
SELECT * FROM customers WHERE state NOT IN ('va','ga','fl');

SELECT c.name,t.name FROM sys.columns c JOIN sys.tables t ON c.object_id=t.object_id
WHERE c.name LIKE '%Products%';

-- Find Products with quantity in stock equal to 49,38,72.
-- How to get the table which has the column name or attribute Products.
SELECT * FROM information_schema.columns where column_name like '%Product%';
SELECT DISTINCT table_schema,table_name FROM information_schema.columns;
SELECT * FROM information_schema.columns;
-- Like Operator is use to where we don't need to match case sensitive.
-- Equal to operator can't be used in above situation.

SELECT * FROM sql_store.products WHERE quantity_in_stock IN (49,38,72);

SELECT * FROM customers WHERE points BETWEEN 1000 AND 3000;

-- Find those people who's last name starts with B.
SELECT * FROM customers WHERE last_name LIKE 'b%';
SELECT * FROM customers WHERE last_name NOT LIKE 'b%';

-- Find those people who's last name end with y and have exactly 6 characters in their last name.
SELECT * FROM customers WHERE last_name LIKE 'b____y';

SELECT * FROM customers WHERE last_name LIKE '%field%';
SELECT * FROM customers WHERE last_name REGEXP 'field$';
SELECT * FROM customers WHERE last_name REGEXP '^field|mac|rose';
SELECT * FROM customers WHERE last_name REGEXP 'field$|mac|rose';
SELECT * FROM customers WHERE last_name REGEXP '[gim]e';
SELECT * FROM customers WHERE last_name REGEXP '[a-h]e';

-- ^ : to represent the beginning of a string (carrot sign).
-- $ : to represent the end of a string. Last name must end with field. 
-- | : to represent multiple search options - OR situation. Last name must have field or mac. (pipe sign)

-- ^ beginning (carrot)
-- $ end
-- | logical OR (pipe) multiple search patterns
-- [] to match any search type listed in the bracket
-- [-] represent a range

SELECT * FROM customers 
WHERE first_name REGEXP 'elka|ambur';

SELECT * FROM customers
WHERE last_name REGEXP 'ey$|on$';

SELECT * FROM customers
WHERE last_name REGEXP '^my|se';

SELECT * FROM customers
WHERE last_name REGEXP 'b[ru]';