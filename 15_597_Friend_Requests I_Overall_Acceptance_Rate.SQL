/*

In social network like Facebook or Twitter, people send friend requests and accept others’ requests as well. Now given two tables as below:
 
Table: friend_request
| sender_id | send_to_id |request_date|
|-----------|------------|------------|
| 1         | 2          | 2016_06-01 |
| 1         | 3          | 2016_06-01 |
| 1         | 4          | 2016_06-01 |
| 2         | 3          | 2016_06-02 |
| 3         | 4          | 2016-06-09 |
 
Table: request_accepted
| requester_id | accepter_id |accept_date |
|--------------|-------------|------------|
| 1            | 2           | 2016_06-03 |
| 1            | 3           | 2016-06-08 |
| 2            | 3           | 2016-06-08 |
| 3            | 4           | 2016-06-09 |
| 3            | 4           | 2016-06-10 |
 
Write a query to find the overall acceptance rate of requests rounded to 2 decimals, which is the number of acceptance divide the number of requests.
 
For the sample data above, your query should return the following result.
 
|accept_rate|
|-----------|
|       0.80|
 
Note:
The accepted requests are not necessarily from the table friend_request. In this case, you just need to simply count the total accepted requests (no matter whether they are in the original requests), and divide it by the number of requests to get the acceptance rate.
It is possible that a sender sends multiple requests to the same receiver, and a request could be accepted more than once. In this case, the ‘duplicated’ requests or acceptances are only counted once.
If there is no requests at all, you should return 0.00 as the accept_rate.
 
Explanation: There are 4 unique accepted requests, and there are 5 requests in total. So the rate is 0.80.
 
Follow-up:
Can you write a query to return the accept rate but for every month?
How about the cumulative accept rate for every day?

*/

-- SQL Schema:

Create table friend_request ( 
	sender_id INT NOT NULL, 
	send_to_id INT NULL, 
	request_date DATE NULL)

Create table request_accepted ( 
	requester_id INT NOT NULL, 
	accepter_id INT NULL, 
	accept_date DATE NULL)

Truncate table friend_request
insert into friend_request (sender_id, send_to_id, request_date) values ('1', '2', '2016/06/01')
insert into friend_request (sender_id, send_to_id, request_date) values ('1', '3', '2016/06/01')
insert into friend_request (sender_id, send_to_id, request_date) values ('1', '4', '2016/06/01')
insert into friend_request (sender_id, send_to_id, request_date) values ('2', '3', '2016/06/02')
insert into friend_request (sender_id, send_to_id, request_date) values ('3', '4', '2016/06/09')

Truncate table request_accepted
insert into request_accepted (requester_id, accepter_id, accept_date) values ('1', '2', '2016/06/03')
insert into request_accepted (requester_id, accepter_id, accept_date) values ('1', '3', '2016/06/08')
insert into request_accepted (requester_id, accepter_id, accept_date) values ('2', '3', '2016/06/08')
insert into request_accepted (requester_id, accepter_id, accept_date) values ('3', '4', '2016/06/09')
insert into request_accepted (requester_id, accepter_id, accept_date) values ('3', '4', '2016/06/10')

-- Solutions 1:

SELECT CASE WHEN B=0 THEN 0
ELSE
ROUND(CAST(a as float)/cast(b as float),3)
END AS ACCEPT_RATE FROM
(select count(distinct concat(requester_id, accepter_id))a from [dbo].[request_accepted]) t1,
(select count(distinct concat(sender_id, send_to_id))b from [dbo].[friend_request]) t2

-- Solutions 2:

WITH CTE_1 (sender_id, num_sent, num_accepted) AS (
	
	SELECT sender_id, CASE
						WHEN COUNT(DISTINCT send_to_id) IS NULL THEN 0
						ELSE COUNT(DISTINCT send_to_id) END, COUNT(DISTINCT accepter_id)
	FROM friend_request fr
	LEFT OUTER JOIN request_accepted ra on ra.requester_id = fr.sender_id
	GROUP BY sender_id
)

SELECT CASE WHEN SUM(num_sent) = 0 THEN 0
			WHEN ROUND(SUM(CAST(num_accepted AS DECIMAL(5,2)))/SUM(num_sent),2) IS NULL THEN 0.00
			ELSE ROUND(SUM(CAST(num_accepted AS DECIMAL(5,2)))/SUM(num_sent),2) END AS accept_rate
FROM CTE_1
