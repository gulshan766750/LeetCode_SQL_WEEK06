-- 1378. Replace Employee ID With The Unique Identifier
select eu.unique_id , e.name
from Employees e
left join EmployeeUNI eu
on e.id = eu.id

-- 1068. Product Sales Analysis I
select product_name, s.year , s.price
from sales s 
join product p
on p.product_id = s.product_id


  -- 1581. Customer Who Visited but Did Not Make Any Transactions
select v.customer_id , count(v.visit_id) as count_no_trans
from visits v
left join transactions t
on  t.visit_id = v.visit_id
where t.transaction_id is null
group by v.customer_id

-- 197. Rising Temperature
SELECT w1.Id
FROM Weather w1
JOIN Weather w2
  ON DATEDIFF(w1.RecordDate, w2.RecordDate) = 1
WHERE w1.Temperature > w2.Temperature;

-- 1661. Average Time of Process per Machine
SELECT machine_id,
       ROUND(AVG(end_time - start_time), 3) AS processing_time
FROM (
    SELECT machine_id,
           process_id,
           MAX(CASE WHEN activity_type = 'start' THEN timestamp END) AS start_time,
           MAX(CASE WHEN activity_type = 'end' THEN timestamp END) AS end_time
    FROM Activity
    GROUP BY machine_id, process_id
) AS process_info
GROUP BY machine_id;

-- 577. Employee Bonus
SELECT e.name, b.bonus
FROM Employee e
LEFT JOIN Bonus b
  ON e.empId = b.empId
WHERE b.bonus < 1000 OR b.bonus IS NULL;

-- 1280. Students and Examinations
SELECT 
    s.student_id, 
    s.student_name, 
    sub.subject_name,
    COUNT(e.subject_name) AS attended_exams
FROM Students s
CROSS JOIN Subjects sub
LEFT JOIN Examinations e 
  ON s.student_id = e.student_id AND sub.subject_name = e.subject_name
GROUP BY s.student_id, s.student_name, sub.subject_name
ORDER BY s.student_id, sub.subject_name;

-- 570. Managers with at Least 5 Direct Reports
SELECT name
FROM Employee
WHERE id IN (
    SELECT managerId
    FROM Employee
    WHERE managerId IS NOT NULL
    GROUP BY managerId
    HAVING COUNT(*) >= 5
);

-- 1934. Confirmation Rate
SELECT 
    s.user_id,
    ROUND(
        IFNULL(SUM(c.action = 'confirmed') / COUNT(c.user_id), 0),
        2
    ) AS confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c 
  ON s.user_id = c.user_id
GROUP BY s.user_id;

