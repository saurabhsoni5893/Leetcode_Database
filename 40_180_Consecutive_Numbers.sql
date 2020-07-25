/*

Write a SQL query to find all numbers that appear at least three times consecutively.

+----+-----+
| Id | Num |
+----+-----+
| 1  |  1  |
| 2  |  1  |
| 3  |  1  |
| 4  |  2  |
| 5  |  1  |
| 6  |  2  |
| 7  |  2  |
+----+-----+
For example, given the above Logs table, 1 is the only number that appears consecutively for at least three times.

+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+

*/


-- SQL Schema:

Create table Logs (Id int, Num int)

Truncate table Logs
insert into Logs (Id, Num) values ('1', '1')
insert into Logs (Id, Num) values ('2', '1')
insert into Logs (Id, Num) values ('3', '1')
insert into Logs (Id, Num) values ('4', '2')
insert into Logs (Id, Num) values ('5', '1')
insert into Logs (Id, Num) values ('6', '2')
insert into Logs (Id, Num) values ('7', '2')


-- Solution 1:

select distinct Num as ConsecutiveNums from
(
	select Num, 
	lag(Num,1) over(order by id) as above,
	lead(Num,1) over(order by id) as below
	from Logs) a
where Num = above and Num = below;
	
	
-- Solution 2:

select distinct 
	l1.Num as ConsecutiveNums 
from
	Logs l1, 
	Logs l2, 
	Logs l3
where 
	l1.Id = l2.id - 1
	and l2.id = l3.id - 1
	and l1.num = l2.num
	and l2.Num = l3.num

	