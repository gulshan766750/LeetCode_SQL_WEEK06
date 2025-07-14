-- 1667. Fix Names in a Table
SELECT 
    user_id,
    CONCAT(UPPER(LEFT(name, 1)), LOWER(SUBSTRING(name, 2))) AS name
FROM Users
ORDER BY user_id;

-- 1527. Patients With a Condition
SELECT patient_id, patient_name, conditions
FROM Patients
WHERE
    conditions LIKE 'DIAB1%'         -- DIAB1 is the first code
    OR conditions LIKE '% DIAB1%'    -- DIAB1 is in the middle or end
;

-- 196. Delete Duplicate Emails
DELETE p1
FROM Person p1
JOIN Person p2
  ON p1.email = p2.email AND p1.id > p2.id;

-- 176. Second Highest Salary
SELECT 
    (SELECT DISTINCT salary 
     FROM Employee 
     ORDER BY salary DESC 
     LIMIT 1 OFFSET 1) AS SecondHighestSalary;

-- 1484. Group Sold Products By The Date
SELECT 
    sell_date,
    COUNT(DISTINCT product) AS num_sold,
    GROUP_CONCAT(DISTINCT product ORDER BY product SEPARATOR ',') AS products
FROM Activities
GROUP BY sell_date
ORDER BY sell_date;

-- 1327. List the Products Ordered in a Period
SELECT 
    p.product_name, 
    SUM(o.unit) AS unit
FROM Products p
JOIN Orders o 
    ON p.product_id = o.product_id
WHERE o.order_date BETWEEN '2020-02-01' AND '2020-02-29'
GROUP BY p.product_id
HAVING SUM(o.unit) >= 100;


-- 1517. Find Users With Valid E-Mails
SELECT *
FROM Users
WHERE mail REGEXP '^[a-zA-Z][a-zA-Z0-9._-]*@leetcode\\.com$'
  AND RIGHT(mail, 13) = BINARY '@leetcode.com';

