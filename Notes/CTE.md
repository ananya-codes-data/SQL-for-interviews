# CTEs

## 🧠 The Real Problem (Why CTE feels hard)

You’re likely:

- Trying to write the final query directly
- Not breaking the problem into logical steps
- Not thinking of CTE as a temporary table

👉 Truth:
A CTE is just a way to say:

“Let me solve this problem step-by-step, like I would in Excel or Python.”

## 🔁 The Mindset Shift (Very Important)

Instead of:
❌ “How do I write this in one SQL query?”

Think:
✅ “What are the intermediate steps to reach the answer?”

## 🧩 CTE = Step-by-Step Thinking

### Template:

```sql
WITH step1 AS (
    -- first transformation
),
step2 AS (
    -- use step1
),
step3 AS (
    -- use step2
)
SELECT * FROM step3;
```

## 🧠 How to Think Logically (Framework)

Whenever you see a question, ask:

### 1. What is the FINAL OUTPUT?

- Columns?
- Aggregation?
- Filtering?

### 2. What do I need BEFORE that?

Break it into steps like:

- Step 1: Clean / filter data
- Step 2: Group / aggregate
- Step 3: Rank / compare
- Step 4: Final result

The dataset below can be used for solving all the examples and questions given in this file

## 📊 Dataset: E-Commerce + Employees + Events

[ER Diagram](erd_diagram.png)

### 👥 customers

| customer_id | name | city | email |
|-------------|------|------|-------|
| 1 | Ananya Sharma | Mumbai | <ananya@example.com> |
| 2 | Ravi Kumar | Delhi | <ravi@example.com> |
| 3 | Priya Nair | Mumbai | <priya@example.com> |
| 4 | Arjun Mehta | Bangalore | <arjun@example.com> |
| 5 | Sneha Iyer | Chennai | <sneha@example.com> |
| 6 | Karan Singh | Delhi | <karan@example.com> |
| 7 | Deepika Rao | Bangalore | <deepika@example.com> |
| 8 | Rahul Gupta | Mumbai | <rahul@example.com> |
| 9 | Meera Pillai | Chennai | <meera@example.com> |
| 10 | Vikram Joshi | Delhi | <vikram@example.com> |
| 11 | Pooja Verma | Bangalore | <pooja@example.com> |
| 12 | Amit Chatterjee | Kolkata | <amit@example.com> |
| 13 | Nisha Reddy | Kolkata | <nisha@example.com> |
| 14 | Suresh Patil | Pune | <suresh@example.com> |
| 15 | Lakshmi Menon | Pune | <lakshmi@example.com> |

### 🛍️ orders

| order_id | customer_id | city | amount | order_date |
|---|---|---|---|---|
| 101 | 1 | Mumbai | 3200.00 | 2023-01-15 |
| 102 | 2 | Delhi | 7500.00 | 2023-02-20 |
| 103 | 3 | Mumbai | 1500.00 | 2023-03-10 |
| 104 | 4 | Bangalore | 9800.00 | 2023-04-05 |
| 105 | 5 | Chennai | 4300.00 | 2022-11-22 |
| 106 | 6 | Delhi | 6200.00 | 2023-06-18 |
| 107 | 7 | Bangalore | 11500.00 | 2023-07-01 |
| 108 | 8 | Mumbai | 8900.00 | 2023-08-14 |
| 109 | 9 | Chennai | 2100.00 | 2022-09-30 |
| 110 | 10 | Delhi | 5400.00 | 2023-05-25 |
| 111 | 1 | Mumbai | 4100.00 | 2023-09-09 |
| 112 | 2 | Delhi | 3300.00 | 2023-10-03 |
| 113 | 4 | Bangalore | 7200.00 | 2023-11-11 |
| 114 | 7 | Bangalore | 6000.00 | 2023-12-01 |
| 115 | 12 | Kolkata | 2800.00 | 2023-03-22 |
| 116 | 13 | Kolkata | 9100.00 | 2023-07-19 |
| 117 | 14 | Pune | 1200.00 | 2023-08-08 |
| 118 | 15 | Pune | 5600.00 | 2023-09-15 |
| 119 | 11 | Bangalore | 3900.00 | 2023-10-28 |
| 120 | 6 | Delhi | 4800.00 | 2023-01-30 |

### 💻 products

| product_id | product_name | category | price |
|---|---|---|---|
| 1 | Laptop | Electronics | 55000.00 |
| 2 | Smartphone | Electronics | 22000.00 |
| 3 | Headphones | Electronics | 3500.00 |
| 4 | Desk Chair | Furniture | 12000.00 |
| 5 | Notebook Set | Stationery | 450.00 |
| 6 | Monitor | Electronics | 18000.00 |
| 7 | Mechanical Keyboard | Electronics | 4500.00 |
| 8 | Bookshelf | Furniture | 8000.00 |
| 9 | Coffee Mug | Kitchen | 350.00 |
| 10 | Standing Desk | Furniture | 25000.00 |

### 💳 order_items

| item_id | order_id | product_id | quantity | unit_price |
|---|---|---|---|---|
| 1 | 101 | 3 | 2 | 3500.00 |
| 2 | 101 | 9 | 5 | 350.00 |
| 3 | 102 | 1 | 1 | 55000.00 |
| 4 | 103 | 5 | 3 | 450.00 |
| 5 | 104 | 2 | 1 | 22000.00 |
| 6 | 104 | 6 | 1 | 18000.00 |
| 7 | 105 | 7 | 2 | 4500.00 |
| 8 | 106 | 4 | 1 | 12000.00 |
| 9 | 107 | 10 | 1 | 25000.00 |
| 10 | 108 | 1 | 1 | 55000.00 |
| 11 | 109 | 5 | 4 | 450.00 |
| 12 | 110 | 3 | 3 | 3500.00 |
| 13 | 111 | 9 | 2 | 350.00 |
| 14 | 112 | 8 | 1 | 8000.00 |
| 15 | 113 | 6 | 1 | 18000.00 |
| 16 | 114 | 7 | 1 | 4500.00 |
| 17 | 115 | 5 | 5 | 450.00 |
| 18 | 116 | 2 | 1 | 22000.00 |
| 19 | 117 | 9 | 3 | 350.00 |
| 20 | 118 | 4 | 1 | 12000.00 |

### 👥 employees

> `manager_id` is NULL for department heads (top of hierarchy). Used for the Recursive CTE pattern.

| id | name | department | salary | manager_id |
|---|---|---|---|---|
| 1 | Kavya Reddy | Engineering | 95000.00 | NULL |
| 2 | Aditya Nair | Engineering | 82000.00 | 1 |
| 3 | Sonal Mehta | Engineering | 74000.00 | 1 |
| 4 | Rohit Sharma | Engineering | 68000.00 | 2 |
| 5 | Divya Pillai | Marketing | 71000.00 | NULL |
| 6 | Aryan Kapoor | Marketing | 63000.00 | 5 |
| 7 | Tanvi Bose | Marketing | 58000.00 | 5 |
| 8 | Nikhil Jain | HR | 60000.00 | NULL |
| 9 | Preethi Rao | HR | 54000.00 | 8 |
| 10 | Siddharth Das | HR | 49000.00 | 8 |
| 11 | Manisha Gupta | Finance | 77000.00 | NULL |
| 12 | Yash Malhotra | Finance | 66000.00 | 11 |
| 13 | Ritu Verma | Finance | 61000.00 | 11 |
| 14 | Gaurav Saxena | Engineering | 55000.00 | 3 |
| 15 | Swati Kulkarni | Marketing | 52000.00 | 6 |

### 🌐 events

> Intentional edge cases for funnel practice:
>
> - user_id 3 → signup only (never purchased)
> - user_id 5 → add_to_cart happened **before** signup
> - user_id 6 → signup + cart, **no purchase**
> - user_id 8 → purchase **without** signup

| event_id | user_id | event | event_time |
|---|---|---|---|
| 1 | 1 | signup | 2023-01-01 10:00:00 |
| 2 | 1 | add_to_cart | 2023-01-02 12:00:00 |
| 3 | 1 | purchase | 2023-01-03 15:00:00 |
| 4 | 2 | signup | 2023-01-05 09:00:00 |
| 5 | 2 | purchase | 2023-01-06 11:00:00 |
| 6 | 3 | signup | 2023-01-07 08:30:00 |
| 7 | 4 | signup | 2023-01-10 14:00:00 |
| 8 | 4 | add_to_cart | 2023-01-11 16:00:00 |
| 9 | 4 | purchase | 2023-01-12 18:00:00 |
| 10 | 5 | add_to_cart | 2023-01-13 10:00:00 |
| 11 | 5 | signup | 2023-01-14 11:00:00 |
| 12 | 5 | purchase | 2023-01-15 12:00:00 |
| 13 | 6 | signup | 2023-01-16 09:00:00 |
| 14 | 6 | add_to_cart | 2023-01-17 10:00:00 |
| 15 | 7 | signup | 2023-01-18 07:00:00 |
| 16 | 7 | add_to_cart | 2023-01-19 08:00:00 |
| 17 | 7 | purchase | 2023-01-20 09:00:00 |
| 18 | 8 | purchase | 2023-01-21 10:00:00 |

### 👥 users

> Intentional duplicate emails for deduplication pattern practice (rows 3, 7, 10).

| id | name | email | created_at |
|---|---|---|---|
| 1 | Ananya Sharma | <ananya@example.com> | 2022-01-10 |
| 2 | Ravi Kumar | <ravi@example.com> | 2022-02-14 |
| 3 | Ananya Sharma | <ananya@example.com> | 2022-03-01 |
| 4 | Priya Nair | <priya@example.com> | 2022-04-05 |
| 5 | Karan Singh | <karan@example.com> | 2022-05-20 |
| 6 | Deepika Rao | <deepika@example.com> | 2022-06-15 |
| 7 | Karan Singh | <karan@example.com> | 2022-07-09 |
| 8 | Meera Pillai | <meera@example.com> | 2022-08-22 |
| 9 | Rahul Gupta | <rahul@example.com> | 2022-09-11 |
| 10 | Deepika Rao | <deepika@example.com> | 2022-10-03 |
| 11 | Vikram Joshi | <vikram@example.com> | 2022-11-30 |
| 12 | Sneha Iyer | <sneha@example.com> | 2022-12-18 |

## 🔥 Example (Let’s Train Your Brain)

### Problem:

> Find the **highest spending customer in each city**

## ❌ Wrong Approach (what you're probably doing)

Trying to write everything at once → confusion

## ✅ Correct Thinking

### Step 1: Total spending per customer

```sql
WITH customer_spending AS (
    SELECT 
        customer_id,
        city,
        SUM(amount) AS total_spent
    FROM orders
    GROUP BY customer_id, city
)
```

### Step 2: Rank customers within each city

```sql
, ranked_customers AS (
    SELECT *,
           RANK() OVER (PARTITION BY city ORDER BY total_spent DESC) AS rnk
    FROM customer_spending
)
```

### Step 3: Pick top customer

```sql
SELECT *
FROM ranked_customers
WHERE rnk = 1;
```

## 💡 Key Insight

Each CTE answers **one small question**:

- “What is total spending?”
- “Who ranks highest?”
- “Give me top ones”

👉 You’re not solving ONE problem
👉 You’re solving MANY SMALL problems

## 🧠 Practice Method (This will fix your issue FAST)

Do this for every question:

### Step 1: Don’t touch SQL yet ❌

Write in plain English:

Example:

- Get total per customer
- Rank them
- Filter top 1

### Step 2: Convert each line → one CTE

## 🏋️ Practice Exercise (Try this)

### Question:

> Find customers whose spending is above average

Try breaking it like:

- Step 1: total per customer
- Step 2: overall average
- Step 3: filter customers > average

## 🧠 Pro Tip (Game changer)

If you're stuck:

👉 Ask yourself:

> “Can I solve this using Excel steps?”

If yes → convert each step into a CTE

## ⚠️ Common Mistakes

- Using CTE when not needed (overcomplicating)
- Not naming CTEs meaningfully
- Skipping intermediate steps
- Writing everything in one CTE

## 🧠 Think of CTEs as “Problem Patterns”

There are ~**7 major CTE patterns** used in real-world SQL.

I’ll explain each with:

- 🧩 When to use
- 🧠 How to think
- 💻 Example

## 🔹 1. Aggregation Pattern (Most Common)

### 🧩 Use when:

You need totals, averages, counts before doing something else.

### 🧠 Thinking:

> “First calculate summary → then use it”

## 💻 Example:

**Find customers who spent more than 5000**

```sql
WITH customer_totals AS (
    SELECT customer_id, SUM(amount) AS total_spent
    FROM orders
    GROUP BY customer_id
)
SELECT *
FROM customer_totals
WHERE total_spent > 5000;
```

## 🔹 2. Ranking Pattern

### 🧩 Use when:

Top N, highest, lowest, leaderboard

### 🧠 Thinking:

> “First compute → then rank → then filter”

## 💻 Example:

**Top 2 highest paid employees per department**

```sql
WITH ranked_emp AS (
    SELECT *,
           RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rnk
    FROM employees
)
SELECT *
FROM ranked_emp
WHERE rnk <= 2;
```

## 🔹 3. Filtering in Steps (Layered Filtering)

### 🧩 Use when:

Conditions are complex

### 🧠 Thinking:

> “Filter step by step instead of all at once”

## 💻 Example:

**Customers who ordered in 2023 AND spent > 1000**

```sql
WITH orders_2023 AS (
    SELECT *
    FROM orders
    WHERE YEAR(order_date) = 2023
),
high_spenders AS (
    SELECT customer_id, SUM(amount) AS total
    FROM orders_2023
    GROUP BY customer_id
)
SELECT *
FROM high_spenders
WHERE total > 1000;
```

## 🔹 4. Comparison Pattern (Self vs Overall)

### 🧩 Use when:

Compare row value vs average / max / min

### 🧠 Thinking:

> “Get overall metric → compare each row”

## 💻 Example:

**Employees earning above company average**

```sql
WITH avg_salary AS (
    SELECT AVG(salary) AS avg_sal FROM employees
)
SELECT e.*
FROM employees e, avg_salary a
WHERE e.salary > a.avg_sal;
```

## 🔹 5. Deduplication Pattern

### 🧩 Use when:

Remove duplicates

### 🧠 Thinking:

> “Rank duplicates → keep one”

## 💻 Example:

**Remove duplicate emails**

```sql
WITH ranked_emails AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY email ORDER BY id) AS rn
    FROM users
)
SELECT *
FROM ranked_emails
WHERE rn = 1;
```

## 🔹 6. Sequential / Funnel Pattern

### 🧩 Use when:

Steps in order (user journey, events)

### 🧠 Thinking:

> “Break journey into stages”

## 💻 Example:

**Users who signed up → then purchased**

```sql
WITH signup_users AS (
    SELECT user_id
    FROM events
    WHERE event = 'signup'
),
purchased_users AS (
    SELECT user_id
    FROM events
    WHERE event = 'purchase'
)
SELECT s.user_id
FROM signup_users s
JOIN purchased_users p
ON s.user_id = p.user_id;
```

## 🔹 7. Recursive CTE (Advanced)

### 🧩 Use when:

Hierarchy (tree, org chart)

### 🧠 Thinking:

> “Start from root → keep expanding”

## 💻 Example:

**Employee hierarchy**

```sql
WITH RECURSIVE emp_hierarchy AS (
    SELECT id, name, manager_id
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT e.id, e.name, e.manager_id
    FROM employees e
    JOIN emp_hierarchy eh
    ON e.manager_id = eh.id
)
SELECT * FROM emp_hierarchy;
```

## 🔥 BONUS Pattern (Very Important)

## 🔹 8. Multi-Step Transformation (Real Interview Pattern)

### 🧩 Use when:

Complex problems

### 🧠 Thinking:

> “Break problem into pipeline”

## 💻 Example:

**Top city by revenue**

```sql
WITH city_revenue AS (
    SELECT city, SUM(amount) AS revenue
    FROM orders
    GROUP BY city
),
ranked_city AS (
    SELECT *,
           RANK() OVER (ORDER BY revenue DESC) AS rnk
    FROM city_revenue
)
SELECT *
FROM ranked_city
WHERE rnk = 1;
```

## 🧠 How to Practice (IMPORTANT)

Don’t memorize queries ❌
Recognize patterns ✅

### When you see a question:

Ask:

- Is this aggregation?
- Is this ranking?
- Is this comparison?
- Is this step-by-step filtering?

Let's take **one pattern at a time** and gradually make it more complex so your brain learns how to *build CTE chains*.

We’ll focus on **progressive difficulty**.

## 🧩 PATTERN 1: Aggregation → Filtering → Ranking (Progressive Build)

### 🟢 LEVEL 1 — Simple Aggregation

#### Problem:

Find total spending per customer

#### 🧠 Thinking:

- I just need totals → one step

```sql
WITH customer_totals AS (
    SELECT customer_id, SUM(amount) AS total_spent
    FROM orders
    GROUP BY customer_id
)
SELECT * FROM customer_totals;
```

### 🟡 LEVEL 2 — Add Filtering

#### Problem:

Customers who spent more than 5000

#### 🧠 Thinking:

- Step 1: total per customer
- Step 2: filter

```sql
WITH customer_totals AS (
    SELECT customer_id, SUM(amount) AS total_spent
    FROM orders
    GROUP BY customer_id
)
SELECT *
FROM customer_totals
WHERE total_spent > 5000;
```

### 🟠 LEVEL 3 — Add Ranking

#### Problem:

Top 3 customers by spending

#### 🧠 Thinking:

- Step 1: totals
- Step 2: rank
- Step 3: filter rank

```sql
WITH customer_totals AS (
    SELECT customer_id, SUM(amount) AS total_spent
    FROM orders
    GROUP BY customer_id
),
ranked_customers AS (
    SELECT *,
           RANK() OVER (ORDER BY total_spent DESC) AS rnk
    FROM customer_totals
)
SELECT *
FROM ranked_customers
WHERE rnk <= 3;
```

### 🔴 LEVEL 4 — Add Partitioning (Real Interview Level)

#### Problem:

Top 2 customers per city

#### 🧠 Thinking:

- Step 1: totals per customer per city
- Step 2: rank within each city
- Step 3: filter

```sql
WITH customer_totals AS (
    SELECT customer_id, city, SUM(amount) AS total_spent
    FROM orders
    GROUP BY customer_id, city
),
ranked_customers AS (
    SELECT *,
           RANK() OVER (PARTITION BY city ORDER BY total_spent DESC) AS rnk
    FROM customer_totals
)
SELECT *
FROM ranked_customers
WHERE rnk <= 2;
```

### 🧨 LEVEL 5 — Add Another Layer (Advanced Thinking)

#### Problem:

Find cities where **top customer spends more than 10000**

#### 🧠 Thinking:

- Step 1: totals
- Step 2: rank per city
- Step 3: get top customer
- Step 4: filter cities

```sql
WITH customer_totals AS (
    SELECT customer_id, city, SUM(amount) AS total_spent
    FROM orders
    GROUP BY customer_id, city
),
ranked_customers AS (
    SELECT *,
           RANK() OVER (PARTITION BY city ORDER BY total_spent DESC) AS rnk
    FROM customer_totals
),
top_customers AS (
    SELECT *
    FROM ranked_customers
    WHERE rnk = 1
)
SELECT *
FROM top_customers
WHERE total_spent > 10000;
```

## 🧩 PATTERN 2: Comparison (Row vs Overall) → Multi-Step

### 🟢 LEVEL 1 — Basic Comparison

#### Problem:

Employees earning above average

```sql
WITH avg_salary AS (
    SELECT AVG(salary) AS avg_sal FROM employees
)
SELECT *
FROM employees e, avg_salary a
WHERE e.salary > a.avg_sal;
```

### 🟡 LEVEL 2 — Add Aggregation

#### Problem:

Departments where avg salary > company avg

#### 🧠 Thinking:

- Step 1: company avg
- Step 2: department avg
- Step 3: compare

```sql
WITH company_avg AS (
    SELECT AVG(salary) AS avg_sal FROM employees
),
dept_avg AS (
    SELECT department, AVG(salary) AS dept_avg_sal
    FROM employees
    GROUP BY department
)
SELECT *
FROM dept_avg d, company_avg c
WHERE d.dept_avg_sal > c.avg_sal;
```

### 🔴 LEVEL 3 — Add Filtering + Ranking

#### Problem:

Top departments whose avg salary > company avg

```sql
WITH company_avg AS (
    SELECT AVG(salary) AS avg_sal FROM employees
),
dept_avg AS (
    SELECT department, AVG(salary) AS dept_avg_sal
    FROM employees
    GROUP BY department
),
filtered AS (
    SELECT *
    FROM dept_avg d, company_avg c
    WHERE d.dept_avg_sal > c.avg_sal
),
ranked AS (
    SELECT *,
           RANK() OVER (ORDER BY dept_avg_sal DESC) AS rnk
    FROM filtered
)
SELECT *
FROM ranked
WHERE rnk <= 3;
```

## 🧩 PATTERN 3: Event / Funnel (VERY IMPORTANT FOR DATA ANALYST)

### 🟢 LEVEL 1 — Simple Step Match

#### Problem:

Users who signed up and purchased

```sql
WITH signup AS (
    SELECT user_id FROM events WHERE event = 'signup'
),
purchase AS (
    SELECT user_id FROM events WHERE event = 'purchase'
)
SELECT s.user_id
FROM signup s
JOIN purchase p ON s.user_id = p.user_id;
```

### 🟡 LEVEL 2 — Add Time Logic

#### Problem:

Users who purchased AFTER signup

```sql
WITH signup AS (
    SELECT user_id, MIN(event_time) AS signup_time
    FROM events
    WHERE event = 'signup'
    GROUP BY user_id
),
purchase AS (
    SELECT user_id, MIN(event_time) AS purchase_time
    FROM events
    WHERE event = 'purchase'
    GROUP BY user_id
)
SELECT s.user_id
FROM signup s
JOIN purchase p 
ON s.user_id = p.user_id
WHERE p.purchase_time > s.signup_time;
```

### 🔴 LEVEL 3 — Full Funnel

#### Problem:

Users who completed:
signup → add_to_cart → purchase

```sql
WITH signup AS (
    SELECT user_id, MIN(event_time) AS t1
    FROM events WHERE event = 'signup'
    GROUP BY user_id
),
cart AS (
    SELECT user_id, MIN(event_time) AS t2
    FROM events WHERE event = 'add_to_cart'
    GROUP BY user_id
),
purchase AS (
    SELECT user_id, MIN(event_time) AS t3
    FROM events WHERE event = 'purchase'
    GROUP BY user_id
)
SELECT s.user_id
FROM signup s
JOIN cart c ON s.user_id = c.user_id
JOIN purchase p ON s.user_id = p.user_id
WHERE t1 < t2 AND t2 < t3;
```

## 🧠 WHAT YOU SHOULD NOTICE

As complexity increases:

- You add **more CTEs**
- Each CTE = **one logical step**
- Final query = just combining steps

## 🚨 Golden Rule

👉 If your CTE has too much logic → break it
👉 If you're confused → you're skipping steps
