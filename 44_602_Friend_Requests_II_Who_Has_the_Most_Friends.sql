/*

In social network like Facebook or Twitter, people send friend requests and accept others' requests as well.

Table request_accepted

+--------------+-------------+------------+
| requester_id | accepter_id | accept_date|
|--------------|-------------|------------|
| 1            | 2           | 2016_06-03 |
| 1            | 3           | 2016-06-08 |
| 2            | 3           | 2016-06-08 |
| 3            | 4           | 2016-06-09 |
+--------------+-------------+------------+
This table holds the data of friend acceptance, while requester_id and accepter_id both are the id of a person.
 

Write a query to find the the people who has most friends and the most friends number under the following rules:

It is guaranteed there is only 1 people having the most friends.
The friend request could only been accepted once, which mean there is no multiple records with the same requester_id and accepter_id value.
For the sample data above, the result is:

Result table:
+------+------+
| id   | num  |
|------|------|
| 3    | 3    |
+------+------+
The person with id '3' is a friend of people '1', '2' and '4', so he has 3 friends in total, which is the most number than any others.
Follow-up:
In the real world, multiple people could have the same most number of friends, can you find all these people in this case?

*/


-- SQL Schema:

Create table If Not Exists request_accepted ( requester_id INT NOT NULL, accepter_id INT NULL, accept_date DATE NULL)
Truncate table request_accepted
insert into request_accepted (requester_id, accepter_id, accept_date) values ('1', '2', '2016/06/03')
insert into request_accepted (requester_id, accepter_id, accept_date) values ('1', '3', '2016/06/08')
insert into request_accepted (requester_id, accepter_id, accept_date) values ('2', '3', '2016/06/08')
insert into request_accepted (requester_id, accepter_id, accept_date) values ('3', '4', '2016/06/09')


-- Solution 1:

with user_stats (user_id, friends, rank)
as
(
	select requester_id, 
		   count(distinct accepter_id),
           DENSE_RANK() over (order by count(distinct accepter_id) desc)
	from
	(
		select requester_id, accepter_id 
		from request_accepted
		union all
		select accepter_id, requester_id
		from request_accepted
	) pairs
	group by requester_id
)

SELECT user_id [id], friends [num]
FROM user_stats
WHERE rank = 1


-- Solution 2:

SELECT TOP 1
ISNULL(requester_id, accepter_id) AS id, request_count+accept_count AS num 

FROM
(SELECT requester_id, COUNT(*) AS request_count
 FROM request_accepted
 GROUP BY requester_id) request
FULL OUTER JOIN
(SELECT accepter_id, COUNT(*) AS accept_count
 FROM request_accepted
 GROUP BY accepter_id) accept
ON request.requester_id = accept.accepter_id

ORDER BY num DESC