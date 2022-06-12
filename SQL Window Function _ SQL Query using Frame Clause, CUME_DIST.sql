/*
source : https://www.youtube.com/watch?v=zAmJPdZu8Rg
author : bhavay.pant
sys_details : windows,mysql server
*/


Use sql_inventory;
Select * from product;
ALTER TABLE product CHANGE `ï»¿product_category` `product_category` VARCHAR(25); 

-- FIRST_VALUE
-- Write query to display the most expensive product under each category (corresponding to each record)
Select *, first_value(product_name) over (partition by product_category order by price) as most_exp_product from product;

-- LAST_VALUE
-- Write query to display the least expensive product under each category (corresponding to each record)
Select *, 
first_value(product_name) 
	over (partition by product_category order by price) as most_exp_product,
last_value(product_name) 
	over (partition by product_category order by price) as least_exp_product
from product;
/* The above query displays incorrect results as sql uses default frame.
Default Frame: range between unbonded preceding and current row. */

-- We Correct the above query using FRAMES.
Select *, 
first_value(product_name) 
	over (partition by product_category order by price desc) 
    as most_exp_product,
last_value(product_name) 
	over (partition by product_category order by price desc
    range between unbounded preceding and unbounded following) 
    as least_exp_product
from product;

-- In place of range we can use 'rows' as well. When we use rows, then we will face issues with entries with same values.
-- As rows considers row till that pointer, while range considered entire range of similar entires.
Select *, 
first_value(product_name) 
	over (partition by product_category order by price desc) 
    as most_exp_product,
last_value(product_name) 
	over (partition by product_category order by price desc
    range between unbounded preceding and current row) 
    as least_exp_product
    -- rows between unbounded preceding and current row) as least_exp_product
from product
where product_category='Phone';

Select *, 
first_value(product_name) 
	over (partition by product_category order by price desc) 
    as most_exp_product,
last_value(product_name) 
	over (partition by product_category order by price desc
    range between 2 preceding and 2 following) 
    as least_exp_product
from product;

-- We can also mention windows function as separate and use it multiple times within the same piece of code.
Select *, 
first_value(product_name) 
	over w as most_exp_product,
last_value(product_name) 
	over w as least_exp_product
from product
window w as (partition by product_category order by price desc
    range between unbounded preceding and unbounded following);

-- Nth values
-- Write a query to display second most expensive product under each category.
-- If we change the parameter inside nth_value to 5, then it will showcase null values from those partitions where the no of 
-- entries are less than 5.
Select *, 
first_value(product_name) 
	over w as most_exp_product,
last_value(product_name) 
	over w as least_exp_product,
nth_value(product_name,2)
	over w as second_most_exp_product
from product
window w as (partition by product_category order by price desc
    range between unbounded preceding and unbounded following);
    
-- NTile
-- Write a query to segregate all the expensive phones, mid-range phones and the cheaper phones.

With X as (Select *,ntile(3) over (order by price desc) as bucket from product
where product_category='Phone')
Select product_name,
	    (CASE
		WHEN X.bucket=1 THEN 'Expensive Phone'
        WHEN X.bucket=2 THEN 'Mid-Range Phone'
        WHEN X.bucket=3 THEN 'Cheaper Phone'
        END) AS phone_category
from X;


-- Query to fetch all products which are constituting the first 30% of the data in product table based on price.

With X as (
Select *, cume_dist() over (order by price desc) as cume_distribution,
round(cume_dist() over (order by price desc)*100,2) as cume_dist_percent from product)

Select product_name,concat(cume_dist_percent,'%') as cume_dist_percentage from X
where cume_dist_percent<=30;

-- Percent_Rank() : Provides a relative rank to each row in the form of percentage.
-- Query to identify how much percentage more expensive is "Galaxy Z Fold 3" when compared to all products.

With X as (Select *,
round(percent_rank() over (order by price)*100,2) as percentage_rank
from product)
Select product_name,percentage_rank from X
where product_name='Galaxy Z Fold 3';