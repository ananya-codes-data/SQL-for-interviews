# *SQL Scenario based Interview Questions with Answers*

## *Question 1: Calculate conversion rate for a sales funnel*

Tables: events (user_id, event_name, event_date)

Events: signup → product_view → purchase

Requirement: Count users at each stage, compute conversion from signup to purchase

```sql
WITH stages AS (
  SELECT user_id,
    MAX(CASE WHEN event_name = 'signup' THEN 1 ELSE 0 END) AS signup,
    MAX(CASE WHEN event_name = 'product_view' THEN 1 ELSE 0 END) AS view,
    MAX(CASE WHEN event_name = 'purchase' THEN 1 ELSE 0 END) AS purchase
  FROM events
  GROUP BY user_id
)

SELECT 
  SUM(signup) AS signups,
  SUM(purchase) AS purchases,
  ROUND(100.0 * SUM(purchase) / SUM(signup), 2) AS conversion_rate
FROM stages;
```

## *Question 2: Build a monthly retention cohort*

Tables: users (user_id, signup_date), logins (user_id, login_date)

Requirement: Cohort by signup month, show retained users by login month

```sql
WITH cohort AS (
  SELECT user_id, DATE_TRUNC('month', signup_date) AS cohort_month
  FROM users
),
activity AS (
  SELECT l.user_id, DATE_TRUNC('month', l.login_date) AS activity_month
  FROM logins l
)

SELECT 
  c.cohort_month,
  a.activity_month,
  COUNT(DISTINCT a.user_id) AS active_users
FROM cohort c
JOIN activity a ON c.user_id = a.user_id
GROUP BY c.cohort_month, a.activity_month
ORDER BY c.cohort_month, a.activity_month;
```

## *Question 3: Calculate monthly churn rate*

Tables: subscriptions (user_id, start_date, end_date)

Requirement: Churned users per month, churn rate = churned / active users

```sql
WITH active_users AS (
  SELECT DATE_TRUNC('month', start_date) AS month, COUNT(DISTINCT user_id) AS active_users
  FROM subscriptions
  GROUP BY DATE_TRUNC('month', start_date)
),
churned_users AS (
  SELECT DATE_TRUNC('month', end_date) AS month, COUNT(DISTINCT user_id) AS churned_users
  FROM subscriptions
  WHERE end_date IS NOT NULL
  GROUP BY DATE_TRUNC('month', end_date)
)
SELECT 
  a.month,
  a.active_users,
  COALESCE(c.churned_users, 0) AS churned_users,
  ROUND(100.0 * COALESCE(c.churned_users, 0) / a.active_users, 2) AS churn_rate
FROM active_users a
LEFT JOIN churned_users c ON a.month = c.month
ORDER BY a.month;
```

## *Question 4: Calculate Daily Active Users*

Table: user_activity (user_id, activity_date)

Requirement: DAU per day

```sql
SELECT activity_date, COUNT(DISTINCT user_id) AS dau
FROM user_activity
GROUP BY activity_date
ORDER BY activity_date;
```

## *Question 5: Revenue by marketing channel*

Tables: orders (order_id, user_id, amount, order_date), users (user_id, channel)

Requirement: Total revenue per channel, monthly breakdown

```sql
SELECT 
  DATE_TRUNC('month', o.order_date) AS month,
  u.channel,
  SUM(o.amount) AS revenue
FROM orders o
JOIN users u ON o.user_id = u.user_id
GROUP BY DATE_TRUNC('month', o.order_date), u.channel
ORDER BY month, revenue DESC;
```

## *Question 6: Identify returning customers*

Table: orders (order_id, customer_id, order_date)

Requirement: Customers with more than one order

```sql
SELECT customer_id
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) > 1;
```

## *Question 7: Top product by revenue per month*

Table: sales (product_id, amount, sale_date)

```sql
WITH monthly_sales AS (
  SELECT 
    DATE_TRUNC('month', sale_date) AS month,
    product_id,
    SUM(amount) AS revenue
  FROM sales
  GROUP BY DATE_TRUNC('month', sale_date), product_id
),
ranked AS (
  SELECT *, RANK() OVER (PARTITION BY month ORDER BY revenue DESC) AS rnk
  FROM monthly_sales
)

SELECT month, product_id, revenue
FROM ranked
WHERE rnk = 1;
```

## *Question 8*

You have a table `orders` with duplicate entries:  

```text
-- Sample data
id | customer_id | product | order_date
1  | 101         | Laptop  | 2026-01-15
2  | 101         | Laptop  | 2026-01-15
3  | 102         | Phone   | 2026-01-16
4  | 101         | Tablet  | 2026-01-17
5  | 102         | Phone   | 2026-01-16
```

Remove duplicates while keeping the row with the *smallest `id`* for each `customer_id` + `product` combination.

*Expected Output:*  

```text
id | customer_id | product | order_date
1  | 101         | Laptop  | 2026-01-15
3  | 102         | Phone   | 2026-01-16
4  | 101         | Tablet  | 2026-01-17
```

*SQL Code:*  

```sql
WITH RankedOrders AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY customer_id, product 
               ORDER BY id ASC
           ) as rn
    FROM orders
)
DELETE FROM orders 
WHERE id IN (
    SELECT id FROM RankedOrders 
    WHERE rn > 1
);
```

*Explanation:*  
– `PARTITION BY customer_id, product` groups duplicates  
– `ORDER BY id ASC` keeps smallest ID (first occurrence)  
– `ROW_NUMBER() = 1` survives, others get deleted  
– Works in PostgreSQL/SQL Server

## *Question 9*

```text
*📊 Dataset: employees*
id| name|department|salary|manager_id
1 | Aditi |  HR | 30000 | 5
2 | Rahul | IT | 50000 | 6
3 | Neha | IT | 60000 | 6
4 | Aman | Sales | 40000 | 7
5 | Kiran | HR | 70000 | NULL
6 | Mohit | IT | 80000 | NULL
7 | Suresh | Sales | 65000 | NULL
8 | Pooja | HR | 30000 | 5
```

1. *Find average salary per department*

```sql
SELECT 
    department, 
    AVG(salary) AS avg_salary 
FROM employees 
GROUP BY department;
```

2. *Find employees earning above department average*

```sql
SELECT 
    name, 
    department, 
    salary 
FROM employees e 
WHERE salary > ( 
    SELECT AVG(salary) 
    FROM employees 
    WHERE department = e.department 
);
```

3. *Find highest salary in each department*

```sql
SELECT 
    department, 
    MAX(salary) AS max_salary 
FROM employees 
GROUP BY department;
```

4. *Find employees who earn more than their manager*

```sql
SELECT e.name 
FROM employees e 
JOIN employees m 
ON e.manager_id = m.id 
WHERE e.salary > m.salary;
```

5. *Count employees in each department*

```sql
SELECT 
    department, 
    COUNT(*) AS total_employees 
FROM employees 
GROUP BY department;
```

6. *Find departments with more than 2 employees*

```sql
SELECT 
    department, 
    COUNT(*) AS total 
FROM employees 
GROUP BY department 
HAVING COUNT(*) > 2;
```

7. *Find second highest salary*

```sql
SELECT 
    MAX(salary) 
FROM employees 
WHERE salary < 
    (SELECT 
        MAX(salary) 
    FROM employees);
```

8. *Find employees without managers*

```sql
SELECT name 
FROM employees 
WHERE manager_id IS NULL;
```

9. *Rank employees by salary*

```sql
SELECT 
    name, 
    salary, 
    RANK() OVER (ORDER BY salary DESC) AS rank 
FROM employees;
```

10. *Find duplicate salaries*

```sql
SELECT salary, 
    COUNT(*) 
FROM employees 
GROUP BY salary 
HAVING COUNT(*) > 1;
```

11. *Top 2 highest salaries*

```sql
SELECT DISTINCT salary 
FROM employees 
ORDER BY salary DESC 
LIMIT 2;
```

## *Question 10*

📊 Dataset: products

```text
| id | product_name | category     | price | stock_qty | supplier_id |
|----|--------------|--------------|-------|-----------|-------------|
| 1  | Laptop       | Electronics  | 75000 | 15        | 101         |
| 2  | Mouse        | Electronics  | 1500  | 50        | 102         |
| 3  | Chair        | Furniture    | 8000  | 25        | 103         |
| 4  | Keyboard     | Electronics  | 2500  | 30        | 102         |
| 5  | Desk         | Furniture    | 15000 | 10        | 103         |
| 6  | Monitor      | Electronics  | 25000 | 20        | 101         |
| 7  | Table        | Furniture    | 5000  | 40        | 104         |
| 8  | Webcam       | Electronics  | 3000  | 35        | 102         |
```

1. *Find the average price per product category*

```sql
SELECT category, AVG(price) AS avg_price 
FROM products 
GROUP BY category;
```

Expected: Electronics ~27k, Furniture ~9.3k

2. *Find products more expensive than their category average*

```sql
SELECT product_name, category, price 
FROM products p 
WHERE price > (
    SELECT AVG(price) 
    FROM products 
    WHERE category = p.category
);
```

Expected: Laptop, Monitor, Desk

3. *Find the highest priced product in each category*

```sql
SELECT category, MAX(price) AS max_price 
FROM products 
GROUP BY category;
```

Expected: Electronics 75000, Furniture 15000

4. *Find products with stock quantity less than 20*

```sql
SELECT product_name, stock_qty 
FROM products 
WHERE stock_qty < 20;
```

Expected: Laptop, Desk

5. *Count total products per supplier*

```sql
SELECT supplier_id, COUNT(*) AS product_count 
FROM products 
GROUP BY supplier_id;
```

Expected: 101:2, 102:3, 103:2, 104:1

6. *Find categories with more than 2 products*

```sql
SELECT category, COUNT(*) AS total_products 
FROM products 
GROUP BY category 
HAVING COUNT(*) > 2;
```

Expected: Electronics (5 products)

7. *Find the second highest price overall*

```sql
SELECT MAX(price) 
FROM products 
WHERE price < (SELECT MAX(price) FROM products);
```

Expected: 25000

8. *Find the most expensive Electronics product*

```sql
SELECT product_name, price 
FROM products 
WHERE category = 'Electronics' 
AND price = (SELECT MAX(price) FROM products WHERE category = 'Electronics');
```

Expected: Laptop, 75000

9. *Rank products by price within each category*

```sql
SELECT product_name, category, price, 
       RANK() OVER (PARTITION BY category ORDER BY price DESC) AS rank 
FROM products;
```

Expected: Laptop rank 1, Monitor rank 2, etc.

10. *Find suppliers with more than 3 products*

```sql
SELECT supplier_id, COUNT(*) 
FROM products 
GROUP BY supplier_id 
HAVING COUNT(*) > 3;
```

Expected: supplier_id 102 (Mouse, Keyboard, Webcam)

11. *Find top 3 most expensive products*

```sql
SELECT DISTINCT price 
FROM products 
ORDER BY price DESC 
LIMIT 3;
```

Expected: 75000, 25000, 15000
