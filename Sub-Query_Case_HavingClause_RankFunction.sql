
Use `sql_dbmsprac_db`;

Select * from teaches;
Select * from instructor;

-- 1. Find the sum of salary of all the departments.
Select dept_name,sum(salary) as total_dept_salary 
from instructor 
group by dept_name
having (total_dept_salary>cast((Select avg(salary) from instructor) AS float4));

-- 1. Find the sum of salary wrt each individual departments.
WITH total_salary_per_dept AS(
	SELECT dept_name,SUM(salary) AS total_dept_salary
	FROM instructor
	GROUP BY dept_name),

-- 2. Find the average of salary of all the departments combined.
avg_total_combined_salary AS(
	SELECT ROUND(AVG(salary)) as avg_sal FROM instructor)

-- 3. Find those departments which have total salary greater than the avg salary of combined departments.
Select * from total_salary_per_dept tspd,avg_total_combined_salary atcs
where tspd.total_dept_salary<atcs.avg_sal;


SELECT id,name,
	(CASE
		WHEN salary>90000 THEN
        'Highest Salary Slab'
        WHEN (salary<=90000 AND salary>50000) THEN
        'Middle Salary Slab'
        WHEN (salary<=50000) THEN
        'Lower Salary Slab'
        ELSE 'no salary slab'
	END) as PaymentText 
FROM instructor;

Select * from instructor;

SELECT ROUND(AVG(salary)) AS avg_sal FROM instructor;
SELECT RAND()*(15-10)+10;
SELECT CONCAT(name,' ',dept_name) FROM instructor;
SELECT REPLACE(job_title,' ','') FROM sql_hr.employees;
SELECT INSERT('Bhavay Pant',12,1,'Pandey');
SELECT INSERT('SQL Tutorial!', 13, 1,' is fun!');

SELECT * FROM instructor;

SELECT *,FIRST_VALUE(name) OVER (PARTITION BY dept_name ORDER BY salary DESC) AS Higher_Paid_Prof FROM instructor;

SELECT dept_name,name,salary,RANK() OVER(PARTITION BY dept_name ORDER BY salary DESC) AS Highest_Paid_Prof FROM instructor;

WITH X AS (SELECT *,
	RANK() OVER (ORDER BY salary DESC) AS ranks,
	DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_ranks,
	ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_no
	FROM instructor
	WHERE salary IS NOT NULL)
    
SELECT name,dept_name,salary FROM X
WHERE ranks=(Select MAX(ranks) as max_rank FROM X);

Select *,NTILE(3) OVER (ORDER BY salary) as Ntile_seq
FROM instructor ORDER BY salary; 


