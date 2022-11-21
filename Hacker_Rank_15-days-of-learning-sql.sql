
USE `sql_unversity_details`;

-- Create ranking of hackers & partition the data wrt dates.
WITH X AS (
SELECT DENSE_RANK() over (PARTITION BY submission_date ORDER BY hacker_id) AS `Rank`,hacker_id,submission_date FROM Submissions
),
-- Count the number of times each unique hacker has submitted a new entry.
Y AS (
SELECT COUNT(`Rank`) as t_rank,hacker_id,submission_date FROM X GROUP BY hacker_id,submission_date
),
-- Find the maximum no of entries by any particular hacker during a particular day.
Z AS (
SELECT MAX(t_rank) AS h_rank,submission_date FROM Y GROUP BY submission_date
),
-- Filter all those hackers who have made maximum entries during a day.
W AS (
SELECT Y.hacker_id,Y.submission_date FROM Z
JOIN Y
ON Y.`t_rank`=Z.`h_rank`
GROUP BY Y.submission_date
ORDER BY Y.submission_date),
-- Merge results with hackers table to get people name.
FINAL_TABLE1 AS (
SELECT W.hacker_id,H.`name`,W.submission_date FROM W
JOIN Hackers AS H
ON W.hacker_id=H.hacker_id
),
-- ############################################################
-- Get list of unique hacker wrt dates.
D1 AS (
SELECT DISTINCT (hacker_id),submission_date FROM Submissions WHERE submission_date = '2016-03-01'
),
D2 AS (
SELECT DISTINCT (hacker_id),submission_date FROM Submissions WHERE submission_date = '2016-03-02' AND hacker_id IN (SELECT hacker_id FROM D1)
),
D3 AS (
SELECT DISTINCT (hacker_id),submission_date FROM Submissions WHERE submission_date = '2016-03-03' AND hacker_id IN (SELECT hacker_id FROM D2)
),
D4 AS (
SELECT DISTINCT (hacker_id),submission_date FROM Submissions WHERE submission_date = '2016-03-04' AND hacker_id IN (SELECT hacker_id FROM D3)
),
D5 AS (
SELECT DISTINCT (hacker_id),submission_date FROM Submissions WHERE submission_date = '2016-03-05' AND hacker_id IN (SELECT hacker_id FROM D4)
),
D6 AS (
SELECT DISTINCT (hacker_id),submission_date FROM Submissions WHERE submission_date = '2016-03-06' AND hacker_id IN (SELECT hacker_id FROM D5)
),
D7 AS (
SELECT DISTINCT (hacker_id),submission_date FROM Submissions WHERE submission_date = '2016-03-07' AND hacker_id IN (SELECT hacker_id FROM D6)
),
D8 AS (
SELECT DISTINCT (hacker_id),submission_date FROM Submissions WHERE submission_date = '2016-03-08' AND hacker_id IN (SELECT hacker_id FROM D7)
),
D9 AS (
SELECT DISTINCT (hacker_id),submission_date FROM Submissions WHERE submission_date = '2016-03-09' AND hacker_id IN (SELECT hacker_id FROM D8)
),
D10 AS (
SELECT DISTINCT (hacker_id),submission_date FROM Submissions WHERE submission_date = '2016-03-10' AND hacker_id IN (SELECT hacker_id FROM D9)
),
D11 AS (
SELECT DISTINCT (hacker_id),submission_date FROM Submissions WHERE submission_date = '2016-03-11' AND hacker_id IN (SELECT hacker_id FROM D10)
),
D12 AS (
SELECT DISTINCT (hacker_id),submission_date FROM Submissions WHERE submission_date = '2016-03-12' AND hacker_id IN (SELECT hacker_id FROM D11)
),
D13 AS (
SELECT DISTINCT (hacker_id),submission_date FROM Submissions WHERE submission_date = '2016-03-13' AND hacker_id IN (SELECT hacker_id FROM D12)
),
D14 AS (
SELECT DISTINCT (hacker_id),submission_date FROM Submissions WHERE submission_date = '2016-03-14' AND hacker_id IN (SELECT hacker_id FROM D13)
),
D15 AS (
SELECT DISTINCT (hacker_id),submission_date FROM Submissions WHERE submission_date = '2016-03-15' AND hacker_id IN (SELECT hacker_id FROM D14)
),
-- Count unique hackers from each day.
FINAL_TABLE2 AS (
SELECT COUNT(DISTINCT hacker_id),submission_date FROM D1
UNION
SELECT COUNT(DISTINCT hacker_id),submission_date FROM D2
UNION
SELECT COUNT(DISTINCT hacker_id),submission_date FROM D3
UNION
SELECT COUNT(DISTINCT hacker_id),submission_date FROM D4
UNION
SELECT COUNT(DISTINCT hacker_id),submission_date FROM D5
UNION
SELECT COUNT(DISTINCT hacker_id),submission_date FROM D6
UNION
SELECT COUNT(DISTINCT hacker_id),submission_date FROM D7
UNION
SELECT COUNT(DISTINCT hacker_id),submission_date FROM D8
UNION
SELECT COUNT(DISTINCT hacker_id),submission_date FROM D9
UNION
SELECT COUNT(DISTINCT hacker_id),submission_date FROM D10
UNION
SELECT COUNT(DISTINCT hacker_id),submission_date FROM D11
UNION
SELECT COUNT(DISTINCT hacker_id),submission_date FROM D12
UNION
SELECT COUNT(DISTINCT hacker_id),submission_date FROM D13
UNION
SELECT COUNT(DISTINCT hacker_id),submission_date FROM D14
UNION
SELECT COUNT(DISTINCT hacker_id),submission_date FROM D15)

-- Merge the two results to get the final view.
SELECT t2.submission_date,t2.`COUNT(DISTINCT hacker_id)` AS `Unique_hackers`,t1.hacker_id,t1.`name` FROM FINAL_TABLE2 AS t2
JOIN FINAL_TABLE1 AS t1
ON t2.submission_date=t1.submission_date
ORDER BY t2.submission_date;
