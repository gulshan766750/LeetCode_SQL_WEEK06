-- 1978. Employees Whose Manager Left the Company
SELECT employee_id
FROM Employees e
WHERE salary < 30000
  AND manager_id IS NOT NULL
  AND manager_id NOT IN (SELECT employee_id FROM Employees)
ORDER BY employee_id;

-- 626. Exchange Seats
SELECT 
    CASE 
        WHEN id % 2 = 1 AND id + 1 <= (SELECT COUNT(*) FROM Seat) THEN id + 1
        WHEN id % 2 = 0 THEN id - 1
        ELSE id
    END AS id,
    student
FROM Seat
ORDER BY id;

-- 1341. Movie Rating
(
  SELECT u.name AS results
  FROM MovieRating mr
  JOIN Users u ON mr.user_id = u.user_id
  GROUP BY mr.user_id
  ORDER BY COUNT(*) DESC, u.name ASC
  LIMIT 1
)
UNION ALL
(
  SELECT m.title AS results
  FROM MovieRating mr
  JOIN Movies m ON mr.movie_id = m.movie_id
  WHERE mr.created_at BETWEEN '2020-02-01' AND '2020-02-29'
  GROUP BY mr.movie_id
  ORDER BY AVG(mr.rating) DESC, m.title ASC
  LIMIT 1
);

-- 1321. Restaurant Growth
WITH daily_amount AS (
    SELECT visited_on, SUM(amount) AS amount
    FROM Customer
    GROUP BY visited_on
),
seven_day_window AS (
    SELECT 
        d1.visited_on,
        SUM(d2.amount) AS amount,
        ROUND(SUM(d2.amount) / 7, 2) AS average_amount
    FROM daily_amount d1
    JOIN daily_amount d2
      ON d2.visited_on BETWEEN DATE_SUB(d1.visited_on, INTERVAL 6 DAY) AND d1.visited_on
    GROUP BY d1.visited_on
    HAVING COUNT(*) = 7
)
SELECT *
FROM seven_day_window
ORDER BY visited_on;

-- 602. Friend Requests II: Who Has the Most Friends
SELECT id, COUNT(*) AS num
FROM (
    SELECT requester_id AS id FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS id FROM RequestAccepted
) AS all_friends
GROUP BY id
ORDER BY num DESC
LIMIT 1;

-- 585. Investments in 2016
SELECT 
    ROUND(SUM(tiv_2016), 2) AS tiv_2016
FROM Insurance
WHERE tiv_2015 IN (
    SELECT tiv_2015
    FROM Insurance
    GROUP BY tiv_2015
    HAVING COUNT(*) > 1
)
AND (lat, lon) IN (
    SELECT lat, lon
    FROM Insurance
    GROUP BY lat, lon
    HAVING COUNT(*) = 1
);


-- 185. Department Top Three Salaries
SELECT 
    d.name AS Department,
    e.name AS Employee,
    e.salary AS Salary
FROM (
    SELECT 
        e.*,
        DENSE_RANK() OVER (PARTITION BY departmentId ORDER BY salary DESC) AS salary_rank
    FROM Employee e
) e
JOIN Department d ON e.departmentId = d.id
WHERE e.salary_rank <= 3;


