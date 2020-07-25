/*

Write a SQL query to get the nth highest salary from the Employee table.

+----+--------+
| Id | Salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
For example, given the above Employee table, the nth highest salary where n = 2 is 200. If there is no nth highest salary, then the query should return null.

+------------------------+
| getNthHighestSalary(2) |
+------------------------+
| 200                    |
+------------------------+

*/

-- SQL Schema:

create table Employee (
		id int,
		salary int)

insert into Employee values(1,100);
insert into Employee values(2,200);
insert into Employee values(3,300);


-- Solution 1:

CREATE FUNCTION getNthHighestSalary(@N INT) RETURNS INT AS
BEGIN
    RETURN (
        SELECT TOP 1 Salary FROM (
        SELECT TOP (@N) Salary 
        FROM EMPLOYEE
        ORDER BY Salary DESC)s
        ORDER BY s.Salary ASC
        );
END

select [dbo].[getNthHighestSalary](3) getNthHighestSalary


-- Solution 2:

CREATE FUNCTION getNthHighestSalary(@N INT) RETURNS INT AS
BEGIN
    RETURN (
        SELECT top 1 Salary FROM
		(SELECT Salary, DENSE_RANK() OVER (ORDER BY Salary DESC) AS RANK
		FROM Employee) Temp
		WHERE RANK = @N
		);
END

select [dbo].[getNthHighestSalary](2) getNthHighestSalary







