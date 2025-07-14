-- 1757. Recyclable and Low Fat Products
# Write your MySQL query statement below
select product_id
from Products
where low_fats = 'Y'
and recyclable = 'Y'

-- 584. Find Customer Referee

select name
from Customer
where referee_id != 2
OR referee_id is null

-- 595. Big Countries
select name, population,area
from World
where area >=3000000
or population >= 25000000

-- 1148. Article Views I
select distinct author_id as id
from views
where author_id = viewer_id
order by author_id

-- 1683. Invalid Tweets
select tweet_id
from Tweets
where length(content) > 15
