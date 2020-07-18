/*

Table my_numbers contains many numbers in column num including duplicated ones.
Can you write a SQL query to find the biggest number, which only appears once.

+---+
|num|
+---+
| 8 |
| 8 |
| 3 |
| 3 |
| 1 |
| 4 |
| 5 |
| 6 | 
For the sample data above, your query should return the following result:
+---+
|num|
+---+
| 6 |
Note:
If there is no such number, just output null.
 

*/

-- SQL Schema:

Create table my_numbers (num int)

Truncate table my_numbers
insert into my_numbers (num) values ('8')
insert into my_numbers (num) values ('8')
insert into my_numbers (num) values ('3')
insert into my_numbers (num) values ('3')
insert into my_numbers (num) values ('1')
insert into my_numbers (num) values ('4')
insert into my_numbers (num) values ('5')
insert into my_numbers (num) values ('6')

-- Solution:

SELECT
	MAX(num) AS num
FROM (
SELECT * FROM [dbo].[my_numbers]
GROUP BY(num)
HAVING COUNT(num) = 1) AS t