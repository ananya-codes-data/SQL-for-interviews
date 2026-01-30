-- 📚 SQL PRACTICE QUESTIONS — TOPIC-WISE

/* 1. Data Understanding & Profiling
2. Data Cleaning & Validation
3. Basic Filtering & Aggregations
4. Joins (1-to-many, many-to-many logic)
5. Subqueries (scalar, IN, EXISTS)
6. Correlated Subqueries
7. Nested Subqueries (progressive)
8. Window Functions
9. Business Metrics & KPIs
10. Performance / Optimization Thinking */

-- 🔹 TOPIC 1: DATA UNDERSTANDING & PROFILING

-- Goal

/* Understand distributions
 Detect dirt
 Validate assumptions
 Build intuition about the data */

-- 🟢 Level 1.1 — Table Size & Shape

-- 1. How many rows are there in each table?


-- 2. Which table is the largest and which is the smallest?


-- 3. How many distinct:
-- departments


-- locations


-- product categories


-- countries



-- 🟢 Level 1.2 — NULL & Dirt Detection

-- Employees

-- 4. How many employees have:
-- NULL names


-- NULL salaries


-- 5. What percentage of employees have future hire dates?


/* 6. How many distinct job_level values exist?
   (Hint: casing issues) */


-- Projects

-- 7. How many projects have:
-- NULL budget


-- Negative budget


/* 8. List all distinct project statuses.
   (Spot the unexpected value) */


-- Customers

-- 9. How many customers have NULL signup dates?


-- 10. List distinct country values before cleaning.


/* 11. Identify potential duplicate customers based on:
Same name ignoring case & spaces */


-- Orders

-- 12. How many orders have:
-- NULL price


--Zero or negative price


-- 13. How many orders were shipped before they were ordered?


-- 14. How many orders have NULL order_date?


-- Products

-- 15. List distinct values of:
-- color


-- size


-- 16. How many duplicate SKUs exist?


-- 🟡 Level 1.3 — Distribution Awareness

-- Employees

-- 17. What is the salary distribution?

-- min


-- max


-- avg


-- 18. How many employees earn more than 1,000,000?


-- 19. Salary stats per department.


-- Projects

-- 20. Budget distribution:

-- min


-- max


-- avg


-- 21. Which department has the highest total project budget?


-- Orders

-- 22. Price distribution:

-- min


-- max


-- avg


-- 23. Top 5 products by order count.


-- 24. Top 5 products by total revenue.



-- 🔵 Level 1.4 — Relationship Validation

-- 25. Are there employees with no projects?


-- 26. Are there customers with no orders?


-- 27. Which departments have no employees?


-- 28. Which products were never ordered?



-- 🔴 Level 1.5 — Business Sanity Checks

-- 29. Do any departments exceed their annual_budget when summing employee salaries?


-- 30. Do some customers generate extreme revenue outliers?


-- 31. Which manufacturing cities contribute the most revenue?




/* First: detect dirt precisely
 Then: standardize / fix
 Then: validate fixes
 Finally: prepare clean analytical views */

-- 🧹 TOPIC 2: DATA CLEANING & STANDARDIZATION (SQL)

-- 🔹 PHASE 1: IDENTIFY & MEASURE DIRT (Before Fixing)

-- Rule: Never clean what you haven’t measured

-- 🟢 2.1 Employees – Cleaning Readiness

-- 1. Count employees where name IS NULL.


-- 2. Count employees where salary IS NULL.


-- 3. Find employees with salary > 1,000,000 (outliers).


-- 4. Find employees whose hire_date is in the future.


-- 5. List all distinct job_level values (case-sensitive).



-- Goal: quantify how bad the data is

-- 🟢 2.2 Projects – Cleaning Readiness

-- 6. Count projects with budget IS NULL.


-- 7. Count projects with negative budget.


-- 8. List all distinct status values.



-- 🟢 2.3 Customers – Cleaning Readiness

-- 9. Count customers with signup_date IS NULL.


-- 10. List distinct country values with raw formatting.


-- 11. Identify potential duplicate customers using:

-- trimmed name


-- case-insensitive match



-- 🟢 2.4 Orders – Cleaning Readiness

-- 12. Count orders with price IS NULL.


-- 13. Count orders with price <= 0.


-- 14. Count orders where shipping_date < order_date.


-- 15. Count orders where order_date IS NULL.



-- 🟢 2.5 Products – Cleaning Readiness

-- 16. List distinct color values.


-- 17. List distinct size values.


-- 18. Count duplicate sku values.



-- 🔹 PHASE 2: STANDARDIZATION (Fixing Values)

-- Here we don’t delete data — we normalize it.

-- 🟡 2.6 Text Standardization

/* 19. Standardize job_level to proper case
    (Junior, Mid, Senior, etc.). */

-- 20. Standardize customers.country:

-- trim spaces


-- convert to uppercase


-- 21. Standardize products.color to lowercase.



-- 🟡 2.7 Value Corrections (Logic-based)

-- 22. Replace negative project budgets with NULL.


-- 23. Replace price ≤ 0 with NULL in orders.


-- 24. Set shipping_date = NULL where it is before order_date.



-- 🟡 2.8 Handling NULLs (Business Decisions)

/* 25. Replace NULL employee salary with:
department average salary */


/* 26. Replace NULL project budget with:
average budget of same project status */


/* 27. Replace NULL signup_date with:
customer’s first order_date */



-- 🔹 PHASE 3: DE-DUPLICATION LOGIC

-- This is very interview-relevant.

-- 🟠 2.9 Customers Deduplication

-- 28. Identify duplicate customer groups using:

-- normalized customer_name


-- same country


-- 29. Assign a canonical customer_id per duplicate group.



-- 🟠 2.10 Products SKU Validation

-- 30. Identify duplicate SKUs with different product names.


-- 31. Decide which SKU record should be retained (earliest product_id).



-- 🔹 PHASE 4: DATA QUALITY CHECKS (After Cleaning)

-- Always validate after fixing.

-- 🔵 2.11 Post-cleaning Validation

-- 32. Confirm no negative prices remain.


-- 33. Confirm no future hire dates exist.


-- 34. Confirm standardized country count is reduced.


-- 35. Confirm no invalid product sizes remain.



-- 🔹 PHASE 5: CLEAN ANALYTICAL VIEWS (REAL-WORLD PRACTICE)

-- Analysts often don’t update raw tables — they create views.

-- 🔴 2.12 Create Clean Views

-- 36. Create clean_employees view:

-- standardized job_level


-- cleaned salary


-- valid hire_date only


-- 37. Create clean_orders view:

-- valid price


-- valid order_date


-- corrected shipping_date


-- 38. Create clean_customers view:

-- trimmed name


-- standardized country


-- 39. Create clean_products view:

-- normalized color


-- valid sizes only



/* After Topic 2, you will be able to:

 Explain data quality issues confidently
 Justify cleaning decisions (huge interview win)
 Build trusted datasets for analytics
 Write cleaner subqueries later (much easier!) */

-- 📊 TOPIC 3: BASIC FILTERING & AGGREGATIONS

-- Use clean views if you created them; otherwise note assumptions in queries.

-- 🔹 PHASE 1: BASIC FILTERING (WHERE mastery)

-- 🟢 Level 3.1 — Simple Filters

-- 1. List all employees hired after 2020.


-- 2. List employees whose salary is between 50,000 and 100,000.


-- 3. Find employees with performance_rating = 5.


-- 4. List projects with status 'active'.


-- 5. Find orders placed in 2023.


-- 6. Find products manufactured in Bangalore.


-- 7. Find customers from India.


-- 8. List employees whose job_level is Senior.



-- 🟢 Level 3.2 — Filtering with NULL logic

-- 9. Find employees with missing salary.


-- 10. Find projects with unknown budget.


-- 11. Find orders with missing shipping_date.


-- 12. Find customers with missing signup_date.


--💡 Interview note: IS NULL vs = NULL.

-- 🟡 Level 3.3 — Compound Conditions

-- 13. Find employees hired after 2019 and earning more than 80,000.


-- 14. Find projects that are active and have budget greater than 100,000.


-- 15. Find orders with price > 10,000 and shipped after 5 days.


-- 16. Find products that are Black and size L.


-- 17. Find customers from India or USA.



-- 🔹 PHASE 2: BASIC AGGREGATIONS

-- 🟢 Level 3.4 — Single Aggregates

-- 18. Find total number of employees.


-- 19. Find average employee salary.


-- 20. Find maximum project budget.


-- 21. Find total revenue from orders.


-- 22. Find earliest and latest hire_date.



-- 🟡 Level 3.5 — GROUP BY Fundamentals

-- 23. Count employees per department.


-- 24. Average salary per department.


-- 25. Total project budget per employee.


-- 26. Total revenue per customer.


-- 27. Order count per product.


-- 28. Revenue per product category.


-- 29. Customer count per country.



-- 🟠 Level 3.6 — GROUP BY + WHERE vs HAVING (IMPORTANT)

-- 30. Departments with more than 200 employees.


-- 31. Departments where average salary > 70,000.


-- 32. Products with total revenue > 1,000,000.


-- 33. Customers with more than 10 orders.



/* 🧠 Rule reminder:

 WHERE → filters rows before grouping
 HAVING → filters groups after aggregation */


-- 🔹 PHASE 3: AGGREGATIONS WITH BUSINESS LOGIC

-- 🔵 Level 3.7 — Time-based Aggregations

-- 34. Monthly employee hiring count.


-- 35. Monthly revenue trend.


-- 36. Year-wise order count.


-- 37. Average order value per month.



-- 🔵 Level 3.8 — Multi-column Grouping

-- 38. Employee count by department & job_level.


-- 39. Revenue by country & customer_tier.


-- 40. Orders by product_category & manufacturing_city.



-- 🔹 PHASE 4: DATA QUALITY–AWARE AGGREGATIONS

-- 🔴 Level 3.9 — Dirty Data Traps

-- 41. Average salary excluding outliers (>1M).


-- 42. Revenue excluding NULL or negative prices.


-- 43. Project budget totals excluding negative budgets.


-- 44. Customer revenue ignoring orders with NULL order_date.



-- 🔴 Level 3.10 — Sanity Check Aggregations

-- 45. Departments where total salary > annual_budget.


-- 46. Products where avg order price is suspiciously low.


-- 47. Customers with unusually high revenue compared to average.



-- 🧠 HOW TO PRACTICE THIS PROPERLY

/* For each question:

1. Decide → WHERE or HAVING
2. Decide grouping columns
3. Decide dirty-data exclusions
4. Run & sanity-check numbers */


/* WHAT YOU’LL UNLOCK AFTER THIS TOPIC

 Stop mixing WHERE and HAVING
 Understand how dirt affects aggregates
 Be ready for subqueries & window functions
 Think in metrics, not just SQL syntax */

-- 🔗 TOPIC 4: JOINS

-- (1-to-many, many-to-many, real-world traps)

-- 🧠 FIRST: MENTAL MODEL (read once, remember forever)

/* 1️⃣ One-to-Many (1:M)

 One row on left
 Many rows on right
 Example:

   departments → employees
   customers → orders
   employees → projects

2️⃣ Many-to-Many (M:M)

 Many rows on both sides
 Always needs a bridge table
 In your schema:

   employees ↔ projects (projects acts as bridge)
   customers ↔ products (orders acts as bridge) */


-- 🔹 PHASE 1: INNER JOIN (only matching rows)

-- 🟢 Level 4.1 — Basic INNER JOIN

-- 1. List all employees with their department name.


-- 2. List all projects with employee names.


-- 3. List all orders with customer names.


-- 4. List all orders with product names.


-- 5. List employees with department name and location.



-- 🟢 Level 4.2 — INNER JOIN + Filtering

-- 6. Employees working in departments located in Bangalore.


-- 7. Projects handled by employees earning more than 80,000.


-- 8. Orders placed by customers from India.


-- 9. Orders for products in category Electronics.


-- 10. Employees with performance_rating = 5 and active projects.



-- 🔹 PHASE 2: LEFT JOIN (keep everything on the left)

-- 🟡 Level 4.3 — LEFT JOIN Fundamentals

-- 11. List all employees and their projects (including employees with no projects).


-- 12. List all customers and their orders (including customers with no orders).


-- 13. List all products and their orders (including products never ordered).


-- 14. List all departments and their employees.


-- 🧠 LEFT JOIN = “I care about left table even if no match”


-- 🟡 Level 4.4 — LEFT JOIN + NULL Detection (classic interview)

-- 15. Find employees with no projects.


-- 16. Find customers with no orders.


-- 17. Find products that were never ordered.


-- 18. Find departments with no employees.



-- 🔹 PHASE 3: MANY-TO-MANY LOGIC (critical)

-- 🟠 Level 4.5 — Understanding the Bridge Table

/* 19. List all employees and the products they indirectly worked on
    (employees → projects → orders → products — think carefully) */

/* 20. List customers and departments whose employees worked on products they bought
    (customers → orders → products → ??? — this one is tricky by design) */



-- 🟠 Level 4.6 — Aggregation Across Joins

-- 21. Total project budget per department.


/* 22. Total revenue per department
    (employee → project → order logic assumption). */


-- 23. Revenue per customer by product category.


/* 24. Average employee salary per product category
    (non-obvious join path). */



-- 🔹 PHASE 4: JOIN TRAPS (VERY IMPORTANT)

-- 🔴 Level 4.7 — Duplicate Explosion

/* 25. Join employees → projects → orders.
    Explain why row count explodes. */

-- 26. Fix Q.25 using:
-- correct join order


-- grouping



-- 🔴 Level 4.8 — INNER vs LEFT JOIN Mistakes

/* 27. Why does this query drop employees?

SELECT e.emp_id, p.project_id
FROM employees e
LEFT JOIN projects p ON e.emp_id = p.emp_id
WHERE p.status = 'active'; */


-- 28. Fix the query so employees without projects are retained.



-- 🔴 Level 4.9 — Dirty Data + JOIN

-- 29. Revenue per country excluding:

-- NULL prices


-- invalid order dates


-- 30. Product sales by color after normalizing color values.



-- 🔹 PHASE 5: REAL-WORLD JOIN SCENARIOS

-- ⚫ Level 4.10 — Analyst-Level Thinking

-- 31. Departments whose employees generate highest revenue.


-- 32. Customers who buy products manufactured in the same country as their location.


-- 33. Products that are popular among Gold & Platinum customers.


-- 34. Employees working on projects that involve high-revenue products.


-- 35. Departments exceeding their annual_budget when combining salary + project cost.



/* 🧠 GOLDEN RULES FOR JOINS (Memorise)

1. Always ask: What is my grain?
2. Identify the bridge table
3. Count rows before and after join
4. Be suspicious of sudden row explosions
5. LEFT JOIN + WHERE on right table = hidden INNER JOIN */


-- 5️⃣ SUBQUERIES (Scalar, IN, EXISTS)

-- 🟢 Scalar Subqueries (return single value)

-- 1. Find employees earning more than the average salary.


-- 2. Find employees hired after the latest hire date in the Sales department.


-- 3. Find products priced higher than the overall average product price.


-- 4. List departments whose budget is greater than the average department budget.


-- 5. Find orders placed after the earliest customer signup date.



-- 🟡 IN Subqueries (multi-row results)

-- 6. Find employees working in departments located in 'New York'.


-- 7. Find products ordered by customers from 'India'.


-- 8. Find employees who are assigned to any project with budget > 1M.


-- 9. Find customers who have placed orders in 2023.


-- 10. Find departments that have at least one employee with a performance rating of 5.



-- 🔵 EXISTS Subqueries (relationship existence)

-- 11. Find customers who have placed at least one order.


-- 12. Find customers who have never placed an order.


-- 13. Find employees who are assigned to any active project.


-- 14. Find products that have been ordered at least once.


-- 15. Find departments that currently have employees.



-- 🔴 Mixed Difficulty

-- 16. Find employees whose salary is greater than the average salary of employees hired in the same year.


-- 17. Find products ordered by Gold or Platinum customers.


-- 18. Find customers who placed orders but never received shipping on time.


-- 19. Find employees who belong to departments with below-average employee count.


-- 20. Find departments where all employees earn more than 50,000.



-- 6️⃣ CORRELATED SUBQUERIES

-- 🟢 Warm-up

-- 1. Find employees earning more than the average salary of their department.


-- 2. Find the highest-paid employee in each department.


-- 3. Find customers who placed more orders than the average orders per customer.


-- 4. Find products priced higher than the average price of their category.



-- 🟡 Medium

-- 5. Find employees hired earliest in their department.


-- 6. Find customers who placed their first order within 30 days of signup.


-- 7. Find products that are the most frequently ordered in their category.


-- 8. Find departments whose total salary expense is above the company average.



-- 🔴 Advanced / Interview Level

-- 9. Find employees whose salary is in the top 10% of their department.


-- 10. Find customers who have the highest total spend in their country.


-- 11. Find products whose average selling price is higher than the category average.


-- 12. Find employees who earn more than all employees hired after them in the same department.


-- 13. Find departments where the lowest salary is greater than the company-wide average salary.


-- 14. Find customers who placed every order after signup within 7 days.


-- 15. Find employees whose salary is higher than the median salary of their department.



-- 7️⃣ NESTED SUBQUERIES (PROGRESSIVE 🔥)

-- (Subquery inside subquery — logic depth increases)

-- 🟢 Easy Nesting (2 levels)

-- 1. Find employees earning more than the average salary of departments located in 'New York'.


-- 2. Find products ordered by customers who signed up before 2020.


-- 3. Find departments with employees earning more than the company average.



-- 🟡 Medium (3 levels)

-- 4. Find employees working in departments where the average salary is higher than the overall average salary.


-- 5. Find customers who ordered products whose category has above-average revenue.


--6. Find products ordered by customers who belong to countries with above-average customer count.



-- 🔴 Hard (4–5 levels)

/* 7. Find employees who earn more than the average salary of employees
hired in departments with below-average budgets. */


-- 8. Find customers who placed orders only for products manufactured in cities with above-average sales.


-- 9. Find departments whose employees generate more revenue than the company average per department.


-- 10. Find products that contribute more than 10% of their category’s total revenue.



-- 8️⃣ WINDOW FUNCTIONS (ANALYST GOLD ✨)

-- 1. Rank employees by salary within each department.


-- 2. Find top 3 highest-paid employees per department.


-- 3. Compute running total of orders per customer.


-- 4. Find month-over-month revenue growth.


-- 5. Assign quartiles to employees based on salary.


-- 6. Find customers whose last order was their most expensive.


-- 7. Find salary difference between employee and department average.


-- 8. Find employees with increasing salary trend (if historical).


-- 9. Identify duplicate customers using window functions.


-- 10. Find customers whose order frequency is declining.



-- 9️⃣ BUSINESS METRICS & KPIs

-- 1. Monthly revenue trend.


-- 2. Average order value (AOV).


-- 3. Customer lifetime value (CLV).


-- 4. Repeat purchase rate.


-- 5. Customer churn proxy (no orders in last X months).


-- 6. Revenue by product category.


-- 7. Top 10% customers by revenue.


-- 8. Average project budget per department.


-- 9. Cost-to-revenue ratio per department.


-- 10. Customer tier conversion rates.



-- 🔟 PERFORMANCE / OPTIMIZATION THINKING

-- 1. Rewrite correlated subqueries using JOINs.


-- 2. When is EXISTS better than IN?


-- 3. How would indexes help this query?


-- 4. Which column would you index first and why?


-- 5. Identify slow patterns in a given query.


-- 6. Explain query execution order.


-- 7. How would you optimize a nested subquery?


-- 8. How would you denormalize for reporting?


-- 9. How would you design a summary table?


-- 10. How would you scale this dataset to 100M rows?

