
Use sql_dbmsprac_db;
#1.
Select * from instructor order by salary;
#2.
Select course_id,semester,year from teaches where (semester like 'Fall' or semester like 'Spring') order by year;
#3.
Select t.course_id,t.semester,t.year,t2.semester,t2.year from teaches t
join teaches t2 
ON t.course_id=t2.course_id
where t.semester like 'Fall' and t.year=2017 and t2.semester like 'Spring' and t2.year=2018;
# second approach
(select course_id from teaches where semester = 'Fall' and year= 2017) union (select course_id
from teaches where semester = 'Spring' and year= 2018);

#4.
Select course_id,semester,year from teaches where (semester like 'Fall' and year=2017) and (semester not like 'Spring' and year!=2018) order by year;
#5.
INSERT INTO sql_dbmsprac_db.instructor values (10212,'Tom','Biology',null);
INSERT INTO sql_dbmsprac_db.instructor values (10211,'Smith','Biology',66000);
#6.
Select * from instructor where salary is null;
#7.
Select avg(salary) from instructor where dept_name like 'Comp.Sci.';
#8.
Select count(distinct id) from teaches where (semester like 'Spring' and year=2018);
#10.
Select avg(salary) as avg_Sal,dept_name from instructor group by instructor.dept_name;

#11.
select dept_name, avg_salary
from (select dept_name, avg(salary) from instructor group by dept_name) as dept_avg(dept_name, avg_salary)
where avg_salary > 42000;

#12.
Select name from instructor where (name!='Einstein' and name not like 'Mozart');

#13.
Select Salary,name from instructor where Salary>(
Select min(Salary) from instructor where dept_name='Biology');
#14.
Select Salary,name from instructor where Salary>(
Select max(Salary) from instructor where dept_name='Biology');

#16.
select dept_name, sum_salary
from (select dept_name, sum(salary) from instructor group by dept_name) as dept_sum(dept_name, sum_salary)
where sum_salary > (select avg(Salary) from instructor);

#17.
Select name,id from instructor;
Select * from teaches;

#18.
Select i.name,t.course_id from instructor i
left outer join teaches t
on i.id=t.id;
# alternative way
select ID,name
from instructor natural left outer join teaches
where course_id is null;