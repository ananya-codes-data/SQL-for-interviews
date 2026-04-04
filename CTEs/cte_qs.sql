--30 pattern-based questions (structured learning)
--10 progressive problems (easy → insane, interview-level)


-- 🧩 PART 1: 30 CTE PRACTICE QUESTIONS (Pattern-wise)

-- 🔹 PATTERN 1: Aggregation → Filtering (Q1–Q5)

--Q1. Find total sales per customer
--Q2. Find customers whose total spending > 10,000
--Q3. Find products whose total sales < average product sales
--Q4. Find cities with total revenue > 50,000
--Q5. Find customers who placed more orders than the average number of orders


-- 🔹 PATTERN 2: Ranking (Q6–Q10)

--Q6. Top 5 highest spending customers
--Q7. Top 3 highest paid employees per department
--Q8. Lowest 2 selling products per category
--Q9. Find the 2nd highest salary in the company
--Q10. Find employees whose salary rank is between 3 and 5 in their department


-- 🔹 PATTERN 3: Aggregation + Ranking (Q11–Q15)

--Q11. Top 3 cities by total revenue
--Q12. Top customer per city
--Q13. Top product per category based on sales
--Q14. Find departments with highest average salary
--Q15. Find top 2 months with highest total sales


-- 🔹 PATTERN 4: Comparison (Row vs Overall) (Q16–Q20)

--Q16. Employees earning above company average
--Q17. Products priced above category average
--Q18. Customers whose spending > average spending of their city
--Q19. Departments where avg salary > overall avg salary
--Q20. Orders where amount > average order amount of that customer


-- 🔹 PATTERN 5: Deduplication (Q21–Q23)

--Q21. Remove duplicate customers based on email (keep latest)
--Q22. Find duplicate transactions
--Q23. Keep only first order per customer


-- 🔹 PATTERN 6: Funnel / Sequential (Q24–Q27)

--Q24. Users who signed up and logged in
--Q25. Users who signed up → added to cart → purchased
--Q26. Users who purchased within 7 days of signup
--Q27. Users who logged in on consecutive days


-- 🔹 PATTERN 7: Multi-Step Transformation (Q28–Q30)

--Q28. Find cities where top customer contributes > 50% of total revenue
--Q29. Find customers whose latest order amount is higher than their average order amount
--Q30. Find products whose sales are increasing month-over-month




-- 🚀 PART 2: Progressive Practice Sheet (Real Interview Style)


-- 🟢 LEVEL 1 (Easy)

-- Q1.

-- Find total spending per customer and return only those above 5000



-- Q2.

-- Find top 3 products by total sales



-- 🟡 LEVEL 2 (Easy → Medium)

-- Q3.

-- Find customers whose spending is above average



-- Q4.

-- Find highest paid employee in each department



-- 🟠 LEVEL 3 (Medium)

-- Q5.

-- Find customers who made more orders than the average customer



-- Q6.

-- Find the second highest salary in each department



-- 🔴 LEVEL 4 (Medium → Hard)

-- Q7.

-- Find top 2 customers per city based on spending



-- Q8.

-- Find departments where average salary is higher than company average AND rank them



-- 🧨 LEVEL 5 (Hard)

-- Q9.

-- Find users who:

-- signed up
-- purchased within 3 days
-- and spent more than average user spending

-- 👉 Requires:

-- funnel + time logic + aggregation + comparison



-- ☠️ LEVEL 6 (Insane / Interview Killer)

-- Q10.

-- Find, for each city:

-- total revenue
-- top customer revenue
-- percentage contribution of top customer

-- Return only cities where:
-- 👉 top customer contributes > 40%



-- 🧠 How You Should Use This

-- Don't jump randomly ❌



-- Step-by-step method:

-- 1. Pick 1 question
-- 2. Write logic in English
-- 3. Break into steps
-- 4. Convert each step → CTE
-- 5. Then code
