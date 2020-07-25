/*

The Employee table holds all employees. Every employee has an Id, a salary, and there is also a column for the department Id.

+----+-------+--------+--------------+
| Id | Name  | Salary | DepartmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 70000  | 1            |
| 2  | Jim   | 90000  | 1            |
| 3  | Henry | 80000  | 2            |
| 4  | Sam   | 60000  | 2            |
| 5  | Max   | 90000  | 1            |
+----+-------+--------+--------------+
The Department table holds all departments of the company.

+----+----------+
| Id | Name     |
+----+----------+
| 1  | IT       |
| 2  | Sales    |
+----+----------+
Write a SQL query to find employees who have the highest salary in each of the departments. For the above tables, your SQL query should return the following rows (order of rows does not matter).

+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Max      | 90000  |
| IT         | Jim      | 90000  |
| Sales      | Henry    | 80000  |
+------------+----------+--------+
Explanation:

Max and Jim both have the highest salary in the IT department and Henry has the highest salary in the Sales department.

*/

-- SQL Schema:

Create table If Not Exists Employee (Id int, Name varchar(255), Salary int, DepartmentId int)
Create table If Not Exists Department (Id int, Name varchar(255))

Truncate table Employee
insert into Employee (Id, Name, Salary, DepartmentId) values ('1', 'Joe', '70000', '1')
insert into Employee (Id, Name, Salary, DepartmentId) values ('2', 'Jim', '90000', '1')
insert into Employee (Id, Name, Salary, DepartmentId) values ('3', 'Henry', '80000', '2')
insert into Employee (Id, Name, Salary, DepartmentId) values ('4', 'Sam', '60000', '2')
insert into Employee (Id, Name, Salary, DepartmentId) values ('5', 'Max', '90000', '1')

Truncate table Department
insert into Department (Id, Name) values ('1', 'IT')
insert into Department (Id, Name) values ('2', 'Sales')


-- Solution 1:

with cte as (
select Name, Salary, DepartmentID from (
select name, salary, DepartmentID, rank() over(Partition by DepartmentId order by Salary desc) as r
from Employee) a
where r = 1)

select d.Name as Department, c.Name as Employee, c.salary as Salary
from cte c join Department d
on c.DepartmentID = d.id


-- Solution 2:

with cte as
(
select d.Name as Department, 
	   e.Name as Employee, 
	   e.salary as Salary,
	   dense_rank() over (partition by DepartmentId order by Salary desc) as r
from Employee e inner join Department d
on e.DepartmentId = d.Id)

select Department, Employee, Salary
from cte
where r = 1


-- Solution 3:

select 
	d.name as department,
	a.name as employee,
	salary
from (select 
	name,
	salary,
	departmentid,
	dense_rank() over(partition by departmentid order by salary desc) as rnk
     from employee  
     ) a
join department d on d.id=a.departmentid
where rnk=1