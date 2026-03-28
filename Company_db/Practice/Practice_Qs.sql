-- SQL Analyst Practice Questions (Synthetic Dataset)

/* This question bank is **strictly aligned to your schema, data volumes, ratios, skewed distributions, and dirty patterns**. 
Questions are grouped **topic‑wise**, ordered from easier to harder within each topic, and designed to simulate **real analyst work** (cleaning, analysis, edge cases). */

-- 🟢 BEGINNER LEVEL

-- 1️⃣ Query Data (SELECT) – 20 Questions

-- 1. Select all columns from the `employees` table.



-- 2. Display only `emp_id`, `name`, and `salary` from employees.



-- 3. Retrieve all departments located in Bangalore.



-- 4. Show distinct employee job levels.



-- 5. List all projects with status `Active`.



-- 6. Display all customers from India.



-- 7. Fetch all products belonging to a specific category.



-- 8. Show orders placed after 2022‑01‑0-1.



-- 9. Display employees hired in the year 2023.



-- 10. Retrieve projects with budget greater than 200,000.



-- 11. List all Platinum‑tier customers.



-- 12. Display products manufactured in Pune.



-- 13. Fetch orders where shipping_date is NULL.



-- 14. Show employees with performance_rating = 5.



-- 15. Retrieve customers who signed up before 2021.



-- 16. Display all orders with price greater than 10,000.



-- 17. Show all distinct customer countries.



-- 18. Retrieve departments with annual_budget above 10 million.



-- 19. Display projects started after employee hire date.



-- 20. Select top 100 rows from orders.




-- 2️⃣ DDL Commands – 20 Questions

-- 1. Create a backup table of `employees`.



-- 2. Add an `email` column to employees.



-- 3. Modify `salary` column to allow higher precision.



-- 4. Drop the `annual_budget` column from departments.



-- 5. Rename `projects.status` to `project_status`.



-- 6. Add a CHECK constraint on orders.price > 0.



-- 7. Create an index on employees.dept_id.



-- 8. Create a composite index on orders (customer_id, order_date).



-- 9. Add a NOT NULL constraint to products.product_name.



-- 10. Drop an index from orders table.



-- 11. Rename table customers to client_master.



-- 12. Truncate the projects table.



-- 13. Drop the products table safely.



-- 14. Create a foreign key between orders and products.



-- 15. Disable a constraint temporarily.



-- 16. Re‑enable a disabled constraint.



-- 17. Create a UNIQUE constraint on products.sku.



-- 18. Add a default value to customers.customer_tier.



-- 19. Create a temporary table structure like orders.



-- 20. Drop multiple columns in a single ALTER command.




-- 3️⃣ DML Commands – 20 Questions

-- 1. Insert a new department.



-- 2. Insert a new employee mapped to a department.



-- 3. Insert multiple products at once.



-- 4. Update salary for employees in a specific department.



-- 5. Increase salaries by 10% for Senior employees.



-- 6. Update job_level casing to proper case.



-- 7. Delete orders older than 2019.



-- 8. Insert a new customer with Gold tier.



-- 9. Update NULL salaries to department average.



-- 10. Update project status from Planned to Active.



-- 11. Delete customers with no orders.



-- 12. Insert projects using SELECT from employees.



-- 13. Update customer country values to trimmed uppercase.



-- 14. Soft‑delete employees using a flag column.



-- 15. Insert orders with calculated price.



-- 16. Update shipping_date = order_date + 5 days.



-- 17. Rollback a mistaken DELETE.



-- 18. Commit multiple DML statements.



-- 19. Merge new customers into customers table.



-- 20. Upsert product records.




-- 🟡 INTERMEDIATE LEVEL

-- 4️⃣ Filtering Data (WHERE) – 20 Questions

-- 1. Employees earning between 50k and 80k.



-- 2. Orders with price NULL.



-- 3. Customers from India or USA.



-- 4. Employees not assigned job_level.



-- 5. Projects with negative budget.



-- 6. Orders shipped before order_date.



-- 7. Products with unexpected size values.



-- 8. Employees hired in the future.



-- 9. Orders placed in the last 30 days.



-- 10. Customers whose name starts with 'A'.



-- 11. Products whose color contains 'black'.



-- 12. Employees with salary not between 30k and 120k.



-- 13. Orders with zero or negative price.



-- 14. Customers with NULL signup_date.



-- 15. Projects with status NOT IN standard values.



-- 16. Employees with performance_rating < 3.



-- 17. Orders between two dates.



-- 18. Products with duplicate SKU.



-- 19. Customers from Europe.



-- 20. Employees without department.




-- 5️⃣ SQL Joins (Basics) – 20 Questions

-- 1. Employees with their department names.



-- 2. Orders with customer names.



-- 3. Orders with product details.



-- 4. Projects with employee names.



-- 5. Employees working in Bangalore departments.



-- 6. Customers and their total orders.



-- 7. Products and total orders placed.



-- 8. Departments and employee count.



-- 9. Employees without projects.



-- 10. Customers without orders.



-- 11. Products never ordered.



-- 12. Orders with shipping delays.



-- 13. Employees and average project budget.



-- 14. Customers and most recent order.



-- 15. Products by manufacturing city.



-- 16. Orders placed by Gold customers.



-- 17. Employees with department budgets.



-- 18. Projects per department.



-- 19. Orders with missing customers.



-- 20. Employees hired after department creation (assume date).




-- 6️⃣ SQL Joins (Advanced) – 20 Questions

-- 1. Customers with orders in multiple countries (hypothetical).



-- 2. Employees sharing same salary.



-- 3. Departments with no employees.



-- 4. Products ordered by same customer multiple times.



-- 5. Employees working on more than 5 projects.



-- 6. Customers whose order value exceeds department average salary.



-- 7. Orders with products from same city as customer signup country.



-- 8. Projects with budget higher than employee average.



-- 9. Employees whose salary > department average.



-- 10. Customers ordering from multiple categories.



-- 11. Orders with maximum price per customer.



-- 12. Products with declining monthly orders.



-- 13. Employees working in departments outside headquarters.



-- 14. Orders contributing to top 10% revenue.



-- 15. Products contributing to 80% revenue (Pareto).



-- 16. Employees with same hire_date in same department.



-- 17. Customers who never ordered high‑value products.



-- 18. Projects overlapping date ranges.



-- 19. Departments where avg salary > avg project budget.



-- 20. Employees associated with inactive projects only.




-- 7️⃣ Set Operators – 20 Questions

-- 1. Countries appearing in customers and products manufacturing.



-- 2. Customers who are Gold OR Platinum.



-- 3. Employees in Bangalore OR Hyderabad.



-- 4. Customers with orders AND Gold tier.



-- 5. Products ordered in 2022 OR 2023.



-- 6. Employees with salary >80k UNION <30k.



-- 7. Customers who ordered electronics but not furniture.



-- 8. Employees in dept 1 EXCEPT dept 2.



-- 9. Products ordered AND discontinued.



-- 10. Customers ordering in Q1 AND Q4.



-- 11. Employees with projects OR high rating.



-- 12. Customers with orders UNION customers without signup date.



-- 13. Orders in India EXCEPT USA.



-- 14. Products ordered by Gold AND Platinum customers.



-- 15. Employees hired in 2022 UNION 2023.



-- 16. Customers with duplicate names.



-- 17. Orders with NULL OR negative price.



-- 18. Products in popular categories EXCEPT niche ones.



-- 19. Customers ordering only one category.



-- 20. Employees in multiple departments (hypothetical).




-- 8️⃣ SQL Functions (General) – 20 Questions

-- 1. Count total employees.



-- 2. Calculate average salary.



-- 3. Find max project budget.



-- 4. Round order prices.



-- 5. Calculate days between order and shipping.



-- 6. Convert names to uppercase.



-- 7. Trim country names.



-- 8. Extract year from hire_date.



-- 9. Replace NULL salary with 0.



-- 10. Concatenate product name and category.



-- 11. Calculate total revenue.



-- 12. Find minimum salary per department.



-- 13. Calculate employee tenure.



-- 14. Format dates.



-- 15. Convert salary to annual.



-- 16. Calculate discount buckets.



-- 17. Find length of customer names.



-- 18. Absolute value of negative budgets.



-- 19. Coalesce missing shipping dates.



-- 20. Cast price to integer.




-- 9️⃣ String Functions – 20 Questions

-- 1. Uppercase all employee names.



-- 2. Lowercase customer country.



-- 3. Trim whitespace from country.



-- 4. Replace 'Blk' with 'Black'.



-- 5. Extract first name from employee name.



-- 6. Find customers with duplicate names.



-- 7. Concatenate full product description.



-- 8. Find names starting with 'S'.



-- 9. Reverse customer names.



-- 10. Count characters in product_name.



-- 11. Remove special characters.



-- 12. Normalize casing in job_level.



-- 13. Extract domain from email.



-- 14. Replace multiple spaces.



-- 15. Mask customer names.



-- 16. Find longest product name.



-- 17. Find names containing numbers.



-- 18. Standardize city names.



-- 19. Split categories into tokens.



-- 20. Detect inconsistent color values.




-- 🔟 Numeric Functions – 20 Questions

-- 1. Round salaries.



-- 2. Ceiling of order prices.



-- 3. Floor project budgets.



-- 4. Absolute value of negative prices.



-- 5. Calculate salary increments.



-- 6. Percentage contribution of each order.



-- 7. Salary variance by department.



-- 8. Calculate tax on salary.



-- 9. Standard deviation of order prices.



-- 10. Median salary.



-- 11. Bucket salaries into ranges.



-- 12. Normalize order amounts.



-- 13. Find top 1% salaries.



-- 14. Log transformation of prices.



-- 15. Calculate growth rate.



-- 16. Discount simulation.



-- 17. Ratio of salary to project budget.



-- 18. Revenue per customer.



-- 19. Product profitability index.



-- 20. Z‑score for order prices.




-- 1️⃣1️⃣ Date & Time Functions – 20 Questions

-- 1. Orders per month.



-- 2. Employees hired per year.



-- 3. Average shipping delay.



-- 4. Customers signed up last quarter.



-- 5. Orders placed on weekends.



-- 6. Projects started per quarter.



-- 7. Employees with >5 years tenure.



-- 8. Orders in last 7 days.



-- 9. Customers inactive for 6 months.



-- 10. Year‑over‑year revenue.



-- 11. Orders per weekday.



-- 12. First order date per customer.



-- 13. Last login simulation.



-- 14. Rolling 30‑day revenue.



-- 15. Fiscal year revenue.



-- 16. Month‑end orders.



-- 17. Orders during festivals (date range).



-- 18. Leap year orders.



-- 19. Employees hired on same date.



-- 20. Project duration in days.




-- 1️⃣2️⃣ NULL Functions – 20 Questions

-- 1. Replace NULL salary.



-- 2. Count NULL salaries.



-- 3. Orders with missing dates.



-- 4. Customers without signup_date.



-- 5. Default tier assignment.



-- 6. Projects with missing budget.



-- 7. Replace NULL shipping_date.



-- 8. Detect incomplete records.



-- 9. Employees with all NULL optional fields.



-- 10. Orders with NULL or zero price.



-- 11. Customers with missing country.



-- 12. Products with missing color.



-- 13. Departments with missing location.



-- 14. NULL‑safe joins.



-- 15. Fill missing job_level.



-- 16. Identify critical NULLs.



-- 17. Remove NULL rows.



-- 18. Replace NULL with median.



-- 19. Count NULLs per column.



-- 20. Create NULL audit report.




-- 1️⃣3️⃣ CASE Statement – 20 Questions

-- 1. Salary bands.



-- 2. Employee performance labels.



-- 3. Project size category.



-- 4. Customer tier priority.



-- 5. Order value category.



-- 6. Shipping delay flag.



-- 7. Salary hike eligibility.



-- 8. Budget risk flag.



-- 9. Customer churn flag.



-- 10. Product popularity bucket.



-- 11. Employee seniority.



-- 12. Revenue contribution bucket.



-- 13. Discount eligibility.



-- 14. Country region mapping.



-- 15. Data quality flag.



-- 16. High‑risk orders.



-- 17. Project status normalization.



-- 18. Order season classification.



-- 19. Customer lifetime value bucket.



-- 20. Employee attrition risk.




-- 1️⃣4️⃣ Aggregate Functions – 20 Questions

-- 1. Total employees per department.



-- 2. Average salary per department.



-- 3. Total revenue per customer.



-- 4. Max order per product.



-- 5. Min project budget.



-- 6. Count customers per country.



-- 7. Revenue per month.



-- 8. Orders per customer.



-- 9. Avg project budget per employee.



-- 10. Salary distribution.



-- 11. Top 5 departments by salary.



-- 12. Median order price.



-- 13. Revenue by category.



-- 14. Employee count by job_level.



-- 15. Orders by shipping status.



-- 16. Products per category.



-- 17. Customers per tier.



-- 18. Average tenure.



-- 19. Project count per status.



-- 20. Revenue concentration.




-- 1️⃣5️⃣ Window Functions (Basics) – 20 Questions

-- 🧩 PART 1: Understanding OVER() (No Partition, No Order)
/* 1. Add ROW_NUMBER() to the employees table without ORDER BY.
→ What order do you observe? */



/* 2. Add COUNT(*) OVER() to employees.
→ What value is repeated across all rows? */



/* 3. Add AVG(salary) OVER() to each employee.
→ How is it different from GROUP BY? */



-- 4. Add SUM(salary) OVER() and compare with total salary using aggregation.



-- 5. Add MAX(salary) OVER() and observe how it behaves row-wise.




-- 🧩 PART 2: Adding ORDER BY (Row Sequencing Behavior)

/* 6. Apply ROW_NUMBER() OVER(ORDER BY salary DESC) to employees.
→ Who gets rank 1? */



/* 7. Change ordering to ORDER BY salary ASC.
→ What changes? */



/* 8. Apply ROW_NUMBER() on orders using ORDER BY order_date.
→ Does row number reflect time sequence? */



/* 9. Add SUM(price) OVER(ORDER BY order_date)
→ What type of result do you see? */



/* 10. Remove ORDER BY from above query.
→ What changes in output? */




-- 🧩 PART 3: PARTITION BY (Group-wise Behavior)

/* 11. Apply ROW_NUMBER() OVER(PARTITION BY dept_id)
→ What happens inside each department? */



/* 12. Add ORDER BY salary DESC within partition.
→ Who becomes rank 1 per department? */



/* 13. Apply COUNT(*) OVER(PARTITION BY dept_id)
→ What does it represent? */



/* 14. Compare:

COUNT(*) OVER(PARTITION BY dept_id)
vs GROUP BY dept_id
→ Key difference? */



/* 15. Apply AVG(salary) OVER(PARTITION BY dept_id)
→ What does each row now show? */


-- 🧩 PART 4: Partition + Order Together

/* 16. Apply:
ROW_NUMBER() OVER(PARTITION BY dept_id ORDER BY hire_date)

→ What story does this tell? */




/* 17. Apply:
SUM(salary) OVER(PARTITION BY dept_id ORDER BY hire_date)

→ Is this cumulative within department? */




/* 18. Change ORDER BY to salary instead of hire_date.
→ How does result change? */



-- 🧩 PART 5: Frame Awareness (Intro Only)

/* 19. Apply:
SUM(price) OVER(ORDER BY order_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)

→ Compare with default behavior. */




/* 20. Apply:
AVG(price) OVER(ORDER BY order_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)

→ What rows are included in calculation? */




-- 1️⃣6️⃣ Window Aggregate (20 Questions)

-- (Running totals, moving averages, cumulative metrics)

-- 1. Calculate running total of order revenue ordered by order_date.



-- 2. Compute cumulative revenue per customer.



-- 3. Find running average of order price per customer.



-- 4. Calculate cumulative count of orders per product.



-- 5. Compute moving average (last 3 orders) per customer.



-- 6. Calculate running sum of project budgets per employee.



-- 7. Find cumulative salary expense per department ordered by hire_date.



-- 8. Compute rolling 7-day revenue.



-- 9. Calculate running total of orders per country.



-- 10. Find cumulative distinct customers over time (tricky).



-- 11. Compute moving average salary per department (last 5 hires).



-- 12. Calculate cumulative max order price per customer.



-- 13. Compute running min salary per department.



-- 14. Calculate rolling 30-day average order value.



-- 15. Find cumulative revenue contribution % per product.



-- 16. Compute running total of completed projects per employee.



-- 17. Calculate moving sum of last 10 orders globally.



-- 18. Find department-wise cumulative hiring trend.



-- 19. Compute running variance of order price per customer.



-- 20. Calculate cumulative revenue and compare with total revenue (running %).




-- 1️⃣7️⃣ Window Ranking (20 Questions)

-- (Ranking, Top-N, percentile logic)

-- 1. Rank employees by salary (highest first).



-- 2. Dense rank employees within each department.



-- 3. Find top 3 highest-paid employees per department.



-- 4. Rank customers by total revenue.



-- 5. Find top 10 customers overall.



-- 6. Rank products by total orders.



-- 7. Identify lowest-performing employees (bottom 5 per department).



-- 8. Assign percentile rank to customers based on revenue.



-- 9. Find top 5% customers (high-value segment).



-- 10. Rank projects by budget within each employee.



-- 11. Identify second highest salary per department.



-- 12. Rank orders by price per customer.



-- 13. Find top-selling product per category.



-- 14. Assign quartiles to salaries.



-- 15. Rank departments by total salary expense.



-- 16. Identify top 2 products per manufacturing city.



-- 17. Rank employees by performance_rating (tie-aware).



-- 18. Find customers in top decile revenue bucket.



-- 19. Rank orders within each day by price.



-- 20. Compare RANK vs DENSE_RANK vs ROW_NUMBER on same dataset.




-- 1️⃣8️⃣ Window Value Functions (20 Questions)

-- (LAG, LEAD, FIRST_VALUE, LAST_VALUE)

-- 1. Show previous order price using LAG.



-- 2. Show next order price using LEAD.



-- 3. Calculate difference between current and previous order price.



-- 4. Find day-to-day revenue change.



-- 5. Identify customers whose order value increased compared to last order.



-- 6. Get first order date per customer using FIRST_VALUE.



-- 7. Get latest order price per customer using LAST_VALUE.



-- 8. Calculate salary difference between employees hired consecutively.



-- 9. Detect orders where price dropped compared to previous order.



-- 10. Find gap in days between consecutive orders per customer.



-- 11. Identify project budget increase/decrease trend per employee.



-- 12. Compare current salary vs department average using window + value.



-- 13. Find first project assigned to each employee.



-- 14. Get last completed project per employee.



-- 15. Identify customers with irregular ordering gaps.



-- 16. Compute difference between current and next order (lead-based).



-- 17. Detect salary jumps greater than 50% compared to previous hire.



-- 18. Identify consecutive duplicate order prices.



-- 19. Track change in customer tier over time (if historical simulated).



-- 20. Flag orders where shipping delay increased compared to previous order.




-- 🔴 ADVANCED LEVEL

-- 1️⃣9️⃣ Subqueries – 20 Questions

-- 1. Employees earning above avg salary.



-- 2. Departments with highest avg salary.



-- 3. Customers with orders above avg order.



-- 4. Products with max revenue.



-- 5. Employees with more projects than avg.



-- 6. Orders larger than customer avg.



-- 7. Customers with no orders.



-- 8. Employees in top‑paying departments.



-- 9. Products ordered by top customers.



-- 10. Orders contributing to top 10% revenue.



-- 11. Projects with budget > department avg.



-- 12. Customers with highest lifetime value.



-- 13. Employees hired after department avg date.



-- 14. Products never ordered.



-- 15. Orders with price > product avg.



-- 16. Customers ordering premium products.



-- 17. Departments with lowest attrition.



-- 18. Projects longer than avg duration.



-- 19. Employees with highest performance.



-- 20. Countries generating max revenue.




-- 2️⃣0️⃣ Common Table Expressions (CTEs) – 20 Questions

-- 1. Clean salary data.



-- 2. Normalize country names.



-- 3. Rank customers by revenue.



-- 4. Identify churned customers.



-- 5. Monthly revenue trend.



-- 6. Employee salary bands.



-- 7. Project size breakdown.



-- 8. Order quality checks.



-- 9. Duplicate customer detection.



-- 10. Product popularity.



-- 11. Department KPIs.



-- 12. Rolling averages.



-- 13. Top customers per country.



-- 14. Data quality report.



-- 15. Employee performance summary.



-- 16. Revenue Pareto.



-- 17. Project risk analysis.



-- 18. Order delay analysis.



-- 19. Salary outlier detection.



-- 20. Customer lifetime value.




-- 2️⃣1️⃣ Views – 20 Questions

-- 1. Create employee_summary view.



-- 2. Customer_revenue view.



-- 3. Product_sales view.



-- 4. Department_cost view.



-- 5. Cleaned_customers view.



-- 6. High_value_orders view.



-- 7. Salary_band view.



-- 8. Project_status view.



-- 9. Order_delay view.



-- 10. Customer_churn view.



-- 11. Employee_attrition view.



-- 12. Revenue_trend view.



-- 13. Product_popularity view.



-- 14. Data_quality view.



-- 15. Top_customers view.



-- 16. Project_risk view.



-- 17. Employee_performance view.



-- 18. Monthly_orders view.



-- 19. Country_revenue view.



-- 20. Department_dashboard view.




-- 2️⃣2️⃣ CTAS – 20 Questions

-- 1. Create cleaned_employees table.



-- 2. High_value_customers table.



-- 3. Monthly_revenue table.



-- 4. Salary_outliers table.



-- 5. Order_anomalies table.



-- 6. Customer_lifetime_value table.



-- 7. Product_performance table.



-- 8. Department_summary table.



-- 9. Project_risk table.



-- 10. Cleaned_products table.



-- 11. Cleaned_orders table.



-- 12. Active_customers table.



-- 13. Top_products table.



-- 14. Revenue_contributors table.



-- 15. Employee_metrics table.



-- 16. Country_metrics table.



-- 17. Project_metrics table.



-- 18. Order_metrics table.



-- 19. Salary_distribution table.



-- 20. Customer_segmentation table.




-- 2️⃣3️⃣ Temp Tables – 20 Questions

-- 1. Temp table for daily revenue.



-- 2. Temp employee salary bands.



-- 3. Temp order delay analysis.



-- 4. Temp duplicate customers.



-- 5. Temp project budget buckets.



-- 6. Temp customer churn.



-- 7. Temp product popularity.



-- 8. Temp monthly orders.



-- 9. Temp salary hike simulation.



-- 10. Temp revenue forecast.



-- 11. Temp order quality checks.



-- 12. Temp cleaned countries.



-- 13. Temp high‑risk projects.



-- 14. Temp employee ranking.



-- 15. Temp top customers.



-- 16. Temp category revenue.



-- 17. Temp inactive customers.



-- 18. Temp product duplicates.



-- 19. Temp shipping SLA breaches.



-- 20. Temp KPI dashboard staging.



