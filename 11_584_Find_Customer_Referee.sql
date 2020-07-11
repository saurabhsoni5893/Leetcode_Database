/*

Given a table customer holding customers information and the referee.

+------+------+-----------+
| id   | name | referee_id|
+------+------+-----------+
|    1 | Will |      NULL |
|    2 | Jane |      NULL |
|    3 | Alex |         2 |
|    4 | Bill |      NULL |
|    5 | Zack |         1 |
|    6 | Mark |         2 |
+------+------+-----------+
Write a query to return the list of customers NOT referred by the person with id '2'.

For the sample data above, the result is:

+------+
| name |
+------+
| Will |
| Jane |
| Bill |
| Zack |
+------+

*/

-- SQL Schema:

if NOT EXISTS (select * from sysobjects where name='cars' and xtype='U')
	CREATE TABLE customer (
		id INT,
		name VARCHAR(25),
		referee_id INT);

Truncate table customer
insert into customer (id, name) values ('1', 'Will')
insert into customer (id, name) values ('2', 'Jane')
insert into customer (id, name, referee_id) values ('3', 'Alex', '2')
insert into customer (id, name) values ('4', 'Bill')
insert into customer (id, name, referee_id) values ('5', 'Zack', '1')
insert into customer (id, name, referee_id) values ('6', 'Mark', '2')

-- Solutions:

SELECT NAME FROM CUSTOMER 
WHERE REFEREE_ID != 2 OR REFEREE_ID IS NULL

