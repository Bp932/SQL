
USE sql_dbmsprac_db;
SELECT * FROM sql_dbmsprac_db.instructor;
INSERT INTO sql_dbmsprac_db.instructor values (102011,'Smith','Biology',66000);
DELETE FROM instructor where instructor.id=102011;
SELECT * FROM instructor where instructor.dept_name LIKE 'History';
SELECT * FROM instructor,teaches;
SELECT name,dept_name,course_id FROM instructor,teaches WHERE (dept_name AND course_id) IS NOT NULL;
SELECT * FROM instructor where name LIKE '%dar%';
SELECT * FROM instructor WHERE salary BETWEEN 90000 AND 100000;