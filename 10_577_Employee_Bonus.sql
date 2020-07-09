/*

Select all employee's name and bonus whose bonus is < 1000.

Table:Employee

+-------+--------+-----------+--------+
| empId |  name  | supervisor| salary |
+-------+--------+-----------+--------+
|   1   | John   |  3        | 1000   |
|   2   | Dan    |  3        | 2000   |
|   3   | Brad   |  null     | 4000   |
|   4   | Thomas |  3        | 4000   |
+-------+--------+-----------+--------+
empId is the primary key column for this table.
Table: Bonus

+-------+-------+
| empId | bonus |
+-------+-------+
| 2     | 500   |
| 4     | 2000  |
+-------+-------+
empId is the primary key column for this table.
Example ouput:

+-------+-------+
| name  | bonus |
+-------+-------+
| John  | null  |
| Dan   | 500   |
| Brad  | null  |
+-------+-------+

*/

-- SQL Schema:

 if NOT EXISTS (select * from sysobjects where name='cars' and xtype='U')
	Create table Employee (
		EmpId int, 
		Name varchar(255), 
		Supervisor int, 
		Salary int)
	
	Create table Bonus (
		EmpId int, 
		Bonus int)


Truncate table Employee

insert into Employee (EmpId, Name, Salary) values ('3', 'Brad', '4000')
insert into Employee (EmpId, Name, Supervisor, Salary) values ('1', 'John', '3', '1000')
insert into Employee (EmpId, Name, Supervisor, Salary) values ('2', 'Dan', '3', '2000')
insert into Employee (EmpId, Name, Supervisor, Salary) values ('4', 'Thomas', '3', '4000')

Truncate table Bonus

insert into Bonus (EmpId, Bonus) values ('2', '500')
insert into Bonus (EmpId, Bonus) values ('4', '2000')

-- Solutions:

SELECT Name, Bonus
FROM Employee e LEFT OUTER JOIN Bonus b
ON e.EmpId = b.EmpId 
WHERE ISNULL(Bonus,0) < 1000