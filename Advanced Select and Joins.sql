-- 1731. The Number of Employees Which Report to Each Employee
SELECT 
    e.employee_id,
    e.name,
    COUNT(r.employee_id) AS reports_count,
    ROUND(AVG(r.age)) AS average_age
FROM Employees e
JOIN Employees r
  ON e.employee_id = r.reports_to
GROUP BY e.employee_id, e.name
ORDER BY e.employee_id;

-- 1789. Primary Department for Each Employee
SELECT employee_id, department_id
FROM Employee
WHERE primary_flag = 'Y'

UNION

SELECT employee_id, department_id
FROM Employee
GROUP BY employee_id
HAVING COUNT(*) = 1;

-- 610. Triangle Judgement
SELECT *,
       CASE 
           WHEN x + y > z AND x + z > y AND y + z > x THEN 'Yes'
           ELSE 'No'
       END AS triangle
FROM Triangle;

-- 180. Consecutive Numbers
SELECT DISTINCT l1.num AS ConsecutiveNums
FROM Logs l1
JOIN Logs l2 ON l1.id = l2.id - 1
JOIN Logs l3 ON l1.id = l3.id - 2
WHERE l1.num = l2.num AND l2.num = l3.num;

-- 1164. Product Price at a Given Date
SELECT p.product_id,
       COALESCE(
           (SELECT new_price 
            FROM Products 
            WHERE product_id = p.product_id 
              AND change_date <= '2019-08-16' 
            ORDER BY change_date DESC 
            LIMIT 1),
           10
       ) AS price
FROM (SELECT DISTINCT product_id FROM Products) p;

-- 1204. Last Person to Fit in the Bus
WITH OrderedQueue AS (
    SELECT *, 
           SUM(weight) OVER (ORDER BY turn) AS cum_weight
    FROM Queue
),
FitPeople AS (
    SELECT *
    FROM OrderedQueue
    WHERE cum_weight <= 1000
)
SELECT person_name
FROM FitPeople
ORDER BY turn DESC
LIMIT 1;

-- 1907. Count Salary Categories
SELECT 'Low Salary' AS category, 
       COUNT(*) AS accounts_count
FROM Accounts
WHERE income < 20000

UNION ALL

SELECT 'Average Salary' AS category, 
       COUNT(*) AS accounts_count
FROM Accounts
WHERE income BETWEEN 20000 AND 50000

UNION ALL

SELECT 'High Salary' AS category, 
       COUNT(*) AS accounts_count
FROM Accounts
WHERE income > 50000;
