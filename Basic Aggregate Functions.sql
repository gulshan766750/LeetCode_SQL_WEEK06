-- 620. Not Boring Movies
SELECT *
FROM Cinema
WHERE MOD(id, 2) = 1
  AND description != 'boring'
ORDER BY rating DESC;

-- 1251. Average Selling Price
SELECT p.product_id,
       ROUND(IFNULL(SUM(u.units * p.price) / SUM(u.units), 0), 2) AS average_price
FROM Prices p
LEFT JOIN UnitsSold u
  ON p.product_id = u.product_id
 AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY p.product_id;

-- 1075. Project Employees I
SELECT p.project_id,
       ROUND(AVG(e.experience_years), 2) AS average_years
FROM Project p
JOIN Employee e
  ON p.employee_id = e.employee_id
GROUP BY p.project_id;


-- 1633. Percentage of Users Attended a Contest
SELECT 
    contest_id,
    ROUND(COUNT(DISTINCT user_id) * 100.0 / (SELECT COUNT(*) FROM Users), 2) AS percentage
FROM Register
GROUP BY contest_id
ORDER BY percentage DESC, contest_id ASC;

-- 1211. Queries Quality and Percentage
SELECT 
    query_name,
    ROUND(AVG(rating * 1.0 / position), 2) AS quality,
    ROUND(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS poor_query_percentage
FROM Queries
GROUP BY query_name;

-- 1193. Monthly Transactions I
SELECT 
    DATE_FORMAT(trans_date, '%Y-%m') AS month,
    country,
    COUNT(*) AS trans_count,
    SUM(state = 'approved') AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM Transactions
GROUP BY DATE_FORMAT(trans_date, '%Y-%m'), country;

-- 1174. Immediate Food Delivery II
SELECT 
    ROUND(SUM(order_date = customer_pref_delivery_date) * 100.0 / COUNT(*), 2) AS immediate_percentage
FROM Delivery
WHERE (customer_id, order_date) IN (
    SELECT customer_id, MIN(order_date)
    FROM Delivery
    GROUP BY customer_id
);

-- 550. Game Play Analysis IV
WITH FirstLogin AS (
  SELECT player_id, MIN(event_date) AS first_login
  FROM Activity
  GROUP BY player_id
),
NextDayLogin AS (
  SELECT DISTINCT a.player_id
  FROM Activity a
  JOIN FirstLogin f
    ON a.player_id = f.player_id
   AND a.event_date = DATE_ADD(f.first_login, INTERVAL 1 DAY)
)
SELECT 
  ROUND(COUNT(n.player_id) / COUNT(f.player_id), 2) AS fraction
FROM FirstLogin f
LEFT JOIN NextDayLogin n ON f.player_id = n.player_id;
