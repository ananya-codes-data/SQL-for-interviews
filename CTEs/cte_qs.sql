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



-- 🧩 🟢 LEVEL 1 — Basic Funnel (Entry-Level)

-- These test if you understand **sequence + joins + MIN()**

-- Q1.

-- Find users who:
-- 👉 signed up and then made a purchase



-- Q2.

-- Find users who:
-- 👉 signed up → added to cart → purchased



-- Q3.

-- Find users who:
-- 👉 added to cart but never purchased



-- Q4.

-- Count number of users at each stage:
-- 👉 signup, add_to_cart, purchase



-- Q5.

-- Find users who:
-- 👉 purchased without signing up



-- 🧩 🟡 LEVEL 2 — Time-Based Funnel

-- Now we add **time constraints (very common)**



-- Q6.

-- Users who purchased within **3 days of signup**



-- Q7.

-- Users who added to cart within **1 day of signup**



-- Q8.

-- Users who:
-- 👉 signed up → purchased within 7 days → but never added to cart



-- Q9.

-- Users who completed:
-- 👉 signup → add_to_cart → purchase
-- 👉 ALL within 5 days



-- Q10.

-- Users whose **time between signup and purchase > average time**



-- 🧩 🟠 LEVEL 3 — Drop-off & Conversion

-- Now we test **analytics thinking**



-- Q11.

-- Find number of users who:

-- * signed up
-- * added to cart
-- * purchased

-- 👉 (single query output)



-- Q12.

-- Calculate conversion rate:
-- 👉 signup → purchase



-- Q13.

-- Calculate drop-off rate between:
-- 👉 add_to_cart → purchase



-- Q14.

-- Find % of users who:
-- 👉 signed up but never purchased



-- Q15.

-- Find stage with highest drop-off



-- 🧩 🔴 LEVEL 4 — Order + Sequence Complexity

-- Now things get tricky



-- Q16.

-- Users who:
-- 👉 purchased BEFORE adding to cart



-- Q17.

-- Users who:
-- 👉 added to cart multiple times before purchase



-- Q18.

-- Users who:
-- 👉 signed up → purchased → then added to cart (wrong order)



-- Q19.

-- Users who:
-- 👉 completed funnel in correct order BUT had extra events in between



-- Q20.

-- Users who:
-- 👉 completed funnel more than once



-- 🧩 🧨 LEVEL 5 — Advanced (Interview Killer)

-- These combine **CTE + window functions + logic**



-- Q21.

-- For each user:
-- 👉 find time taken between each step
-- (signup → cart → purchase)



-- Q22.

-- Find average time between:
-- 👉 signup and purchase across all users



-- Q23.

-- Find fastest users:
-- 👉 who completed full funnel in least time



-- Q24.

-- Find users who:
-- 👉 skipped add_to_cart but still purchased



-- Q25.

-- Find users whose:
-- 👉 purchase is closer to signup than to add_to_cart



-- 🧩 ☠️ LEVEL 6 — Real Product Analytics Questions

-- These are **actual company-style questions**



-- Q26.

-- For each day:
-- 👉 number of users entering each stage of funnel



-- Q27.

-- Cohort funnel:
-- 👉 users who signed up in Jan
-- → how many purchased within 7 days



-- Q28.

-- Find retention funnel:
-- 👉 users who signed up → came back next day → purchased



-- Q29.

-- Find % of users who:
-- 👉 drop off at each step (full breakdown)



-- Q30.

-- For each user:
-- 👉 identify the **first valid funnel completion**



-- 🧠 How to Approach ANY Funnel Question

-- Always break like this:

-- 1. Identify steps (signup, cart, purchase)
-- 2. Get FIRST occurrence (MIN)
-- 3. Join steps
-- 4. Apply order condition (t1 < t2 < t3)
-- 5. Add time constraints if needed


-- 🧠 How You Should Use This

-- Don't jump randomly ❌

-- Step-by-step method:

-- 1. Pick 1 question
-- 2. Write logic in English
-- 3. Break into steps
-- 4. Convert each step → CTE
-- 5. Then code
