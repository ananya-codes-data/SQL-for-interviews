# Window Functions

Most people don't struggle with the syntax of window functions—they struggle with recognizing when to use them.

The goal isn't just to memorize ROW_NUMBER() or RANK(), but to develop a way of thinking.

Here's the mental framework I recommend.

## Step 1: Ask one question first

Whenever you read a SQL problem, ask yourself:

> "Do I need to keep every row, or do I need to reduce the rows?"

**If the answer is "Reduce the rows"**

Use:

- `GROUP BY` usually reduces rows.
- A window function calculates across related rows while keeping the original rows.
- Aggregate functions (`SUM`, `AVG`, `COUNT`, `MAX`, `MIN`)

Example:

> Find total sales of each store.

```sql
SELECT 
    store_id,
    SUM(sales)
FROM orders
GROUP BY store_id;
```

The output has one row per store.

**If the answer is "Keep every row"**

Think:

> Window Function

Example:

> Show each employee's salary along with the average salary of their department.

```sql
SELECT 
    employee_name,
    department,
    salary,
    AVG(salary) OVER(PARTITION BY department)
FROM employees;
```

Notice every employee is still present.

## Step 2: Identify the type of question

Almost every window function question falls into one of these categories.

### 1. Ranking

Keywords:

- Top

- Highest

- Lowest

- First

- Second

- Rank

Functions:

- `ROW_NUMBER()`

- `RANK()`

- `DENSE_RANK()`

Example:

> Find the highest paid employee in every department.

Think:

> Rank employees inside each department.

```sql
ROW_NUMBER() OVER(
PARTITION BY department
ORDER BY salary DESC)
```

### 2. Running calculations

Keywords:

- Running total

- Cumulative

- Progressive

Functions:

```sql
SUM() OVER()
```

Example:

> Running sales till each day.

### 3. Previous or Next row

Keywords:

- Previous

- Next

- Difference

- Before

- After

Functions:

- `LAG()`

- `LEAD()`

Example:

> Difference between today's and yesterday's sales.

### 4. Compare with group

Keywords:

- Department average

- Company average

- Compare against category

Functions:

```sql
AVG() OVER(PARTITION BY ...)
```

Example:

> Employees earning more than department average.

### 5. Percentages

Keywords:

- Percentage

- Share

- Contribution

Example:

> Employee salary as percentage of department salary.

```sql
salary /
SUM(salary) OVER(PARTITION BY department)
```

### 6. First/Last value

Keywords:

- First purchase

- Latest order

- Earliest

Functions:

- `FIRST_VALUE()`

- `LAST_VALUE()`

- `NTH_VALUE()`

## Step 3: Learn to spot clues

| If the question says... | Think... |
| ----------------------- | -------- |
| For each department | `PARTITION BY` department |
| Highest/lowest | `ORDER BY` + ranking |
| Previous row | `LAG()` |
| Next row | `LEAD()` |
| Running total | `SUM() OVER(ORDER BY...)` |
| Compare with average | `AVG() OVER()` |
| Keep all rows | Window function |
| Collapse rows | `GROUP BY` |
| Group comparison | Aggregate `OVER(PARTITION BY...)` |
| Position/rank | `ROW_NUMBER`, `RANK`, `DENSE_RANK` |
| Filter a window result | CTE/subquery |

## Step 4: My five-question checklist

Whenever you solve a problem, ask:

1. **What should one output row represent?**

2. **Am I keeping all rows?**

- Yes → Window function.

- No → `GROUP BY`

3. **Should rows be divided into groups?**

- Yes → `PARTITION BY`

4. **Does the order matter?**

- Yes → `ORDER BY` inside `OVER()`

5. **What am I trying to calculate?**

- Rank?

- Running total?

- Previous row?

- Average?

- Percentage?

The answers usually point directly to the right function.

A challenge for you

Don't write SQL yet—just identify the approach.

For each question, tell me:

1. Will you use `GROUP BY` or a window function?

2. If it's a window function, which one?

3. What will go inside `PARTITION BY` and `ORDER BY`?

4. Find the second-highest salary in each department.

5. Show every employee with their department's average salary.

6. Calculate the running total of daily sales.

7. Find the difference between each day's sales and the previous day's sales.

8. Find the top 3 products by sales in each category.

---

# Patterns in Window Functions

## Pattern 1: Ranking within a group

### Scenario

You need to assign ranks to rows inside each category.

### Clues

- Top N

- Highest

- Lowest

- First

- Second

- Best performer

### Example

#### Table: employees

| emp_id | department | salary |
| ------ | ---------- | ------ |
| 1 | HR | 40000 |
| 2 | HR | 50000 |
| 3 | HR | 45000 |
| 4 | IT | 80000 |
| 5 | IT | 70000 |

Question:

> Find the highest-paid employee in every department.

Think:

- Divide by department

- Order by salary descending

- Rank them

Functions:

- `ROW_NUMBER()`

- `RANK()`

- `DENSE_RANK()`

## Pattern 2: Top N per group

### Scenario

- Not just first.

- Need top 3.

- Need top 5.

- Need top 10.

### Example

> Top 3 selling products in every category.

| Electronics |
| ---------- |
| Laptop |
| Phone |
| Tablet |

| Furniture |
| --------- |
| Chair |
| Table |
| Bed |

Think:

- Partition by category.

- Rank by sales.

- Filter rank <= 3.

## Pattern 3: Previous row comparison

### Scenario

Compare current row with previous row.

### Clues

- Yesterday

- Previous order

- Previous salary

- Last purchase

Example

| date | sales |
| ---- | ----- |
| 1 Jan | 100 |
| 2 Jan | 150 |
| 3 Jan | 130 |

Question

> Difference from previous day.

Function

`LAG()`

## Pattern 4: Next row comparison

### Scenario

Need future value.

### Clues

- Next order

- Next transaction

- Next event

Example

> Find the number of days until the customer's next purchase.

Function

`LEAD()`

## Pattern 5: Running Total

### Scenario

Need cumulative value.

### Clues

- Running

- Cumulative

- Till now

- Progressive

Example

| Date | Sales |
| ---- | ----- |
| 1 | 100 |
| 2 | 50 |
| 3 | 80 |

Output

| Date | Running Total |
| ---- | ----- |
| 1 | 100 |
| 2 | 150 |
| 3 | 230 |

Function

`SUM() OVER(ORDER BY date)`

## Pattern 6: Running Average

### Scenario

Average till current row.

Example

> Daily average sales till today.

Function

`AVG() OVER(ORDER BY date)`

## Pattern 7: Compare with group average

### Scenario

Need every row plus department average.

### Clues

- Above average

- Below average

- Compare with team

Example

> Employee salary vs department average.

Function

`AVG() OVER(PARTITION BY department)`

## Pattern 8: Percentage Contribution

### Scenario

Each row contributes to a total.

Example

Department salary

| Employee | Salary |
| ---- | ----- |
| A | 20k |
| B | 30k |
| C | 50k |

Need

```text
A = 20%
B = 30%
C = 50%
```

Function

`SUM() OVER(PARTITION BY department)`

## Pattern 9: First or Last Value

### Scenario

- Need first purchase.

- Need latest order.

- Need first login.

Functions

- `FIRST_VALUE()`

- `LAST_VALUE()`

Example

> First salary of every employee.

## Pattern 10: Find Duplicates

### Scenario

Need duplicate records.

Example

Same email appears multiple times.

Think

- Partition by email.

- Count rows.

`COUNT(*) OVER(PARTITION BY email)`

## Pattern 11: Gap Detection

### Scenario

- Need missing sequence.

- Need skipped IDs.

- Need days without sales.

Example

Orders
```text
1
2
3
6
7
```

Need to identify missing values.

Usually involves

- `LAG()`

- `LEAD()`

## Pattern 12: Consecutive Events (Streaks)

### Scenario

- Customer purchased 5 days continuously.

- Employee attended 10 days consecutively.

Example
```text
Login
------
1 Jan
2 Jan
3 Jan
6 Jan
7 Jan
```

Need streak.

Usually

- `ROW_NUMBER()`

- `LAG()`

## Pattern 13: Latest Record

### Scenario

Keep only latest record.

Example

Customer changes address.

Need latest address.

```text
Customer
Date
Address
```

Think

- Partition by customer.

- Order by date DESC.

- Row number = 1.

## Pattern 14: Remove Duplicates

Example

Keep only latest transaction.

Delete older ones.

Think

- Partition by unique key.

- Order by timestamp.

- Row number = 1.

## Pattern 15: Nth Highest

### Scenario

- Second highest salary.

- Third highest sale.

- Fifth largest order.

Think

- Ranking.

- Filter

```text
rank = 2
```

or

```text
dense_rank = 5
```

## Pattern 16: Window Count

Need count without collapsing rows.

Example

Orders

| Customer | Order |
| ---- | ----- |
| A | 1 |
| A | 2 |
| A | 3 |
| B | 4 |

Need

```text
Customer Orders

A -> 3
A -> 3
A -> 3
B -> 1
```

Use

`COUNT(*) OVER(PARTITION BY customer)`

## Pattern 17: Maximum or Minimum in Group

> Need every employee along with highest salary in their department.

```sql
MAX(salary)
OVER(PARTITION BY department)
```

## Pattern 18: Difference from Maximum

Example

> Employee salary difference from highest salary.

```sql
MAX(salary)
OVER(PARTITION BY department)
```

Then

```text
max_salary - salary
```

## Pattern 19: Percentile and Quartiles

Example

- Top 10% students.

- Median employee.

Functions

- `NTILE()`

- `PERCENT_RANK()`

- `CUME_DIST()`

## Pattern 20: Bucketing

Need divide customers into 4 equal groups.

`NTILE(4)`

Example

- Gold

- Silver

- Bronze

- Premium

## Pattern 21: Change Detection

Need to know when value changed.

Example

> Employee salary history

```text
50000
50000
60000
60000
65000
```

Need rows where salary changed.

Think

`LAG(salary)`

Compare.

---

## Pattern 22: First Time Something Happened

Example

- Customer's first purchase.

- Employee's first promotion.

Think

`ROW_NUMBER()`

Filter

`row_number = 1`

## Pattern 23: Sessionization

Example

- Website clicks

- If inactivity >30 minutes

- Start new session.

Uses

- `LAG()`

- Time difference

- Running `SUM()`

Very common in analytics.

## Pattern 24: Running Balance

Example

Bank transactions

```text
+500
-100
+300
```

Need

```text
500
400
700
```

Use cumulative `SUM()`

## Pattern-recognition cheat sheet

| If the question says... | Think... | Function(s) |
| ----------------------- | -------- | ----------- |
| Top, highest, first | Ranking | `ROW_NUMBER()`, `RANK()`, `DENSE_RANK()` |
| Top N in each category | Ranking + filter | `ROW_NUMBER()`, `RANK()` |
| Previous or yesterday | Previous row | `LAG()` |
| Next or upcoming | Next row | `LEAD()` |
| Running, cumulative | Running total | `SUM() OVER()` |
| Average of department | Group comparison | `AVG() OVER()` |
| Highest salary in department | Group aggregate | `MAX() OVER()` |
| Number of orders per customer | Count without collapsing | `COUNT() OVER()` |
| Percentage contribution | Total within group | `SUM() OVER()` |
| First/last purchase | Ordered value | `FIRST_VALUE()`, `LAST_VALUE()` |
| Split into quartiles | Bucketing | `NTILE()` |
| Ranking by percentage | Relative standing | `PERCENT_RANK()`, `CUME_DIST()` |
| Detect changes | Compare adjacent rows | `LAG()`, `LEAD()` |
| Latest record | Most recent row | `ROW_NUMBER()` |

# One pattern at a time, with increasing complexity

## Level 1 – Understand `OVER()`

Suppose we have an `employees` table.

| emp_id | name | dept | salary |
| --- | --- | --- | --- |
| 1 | Alice | HR | 40000 |
| 2 | Bob | HR | 50000 |
| 3 | Charlie | HR | 45000 |
| 4 | David | IT | 70000 |
| 5 | Emma | IT | 80000 |

**Question 1**

> Show every employee along with the company's average salary.

**Step 1: What is the question asking?**

Do we want one row?

No.

We want every employee.

So **NOT** `GROUP BY`

**Step 2**

Need average salary.

```sql
AVG(salary) OVER ()
```

Output

| Employee | Salary | Company Avg |
| --- | --- | --- |
| Alice | 40000 | 57000 |
| Bob | 50000 | 57000 |
| Charlie | 45000 | 57000 |
| David | 70000 | 57000 |
| Emma | 80000 | 57000 |

## Level 2 – `PARTITION BY`

Question

> Show every employee along with their department's average salary.

Now think.

Average of what?

Department.

So partition.

```sql
AVG(salary)
OVER(PARTITION BY dept)
```

Output

| Employee | Dept | Salary | Dept Avg |
| --- | --- | --- | --- |
| Alice | HR | 40000 | 45000 |
| Bob | HR | 50000 | 45000 |
| Charlie | HR | 45000 | 45000 |
| David | IT | 70000 | 75000 |
| Emma | IT | 80000 | 75000 |

Notice:

HR employees only "see" HR.

IT employees only "see" IT.

## Level 3 – Ranking

Question

> Highest paid employee in each department.

Think.

Average?

No.

Maximum?

No.

Need position.

So ranking.

```sql
ROW_NUMBER()
OVER(
PARTITION BY dept
ORDER BY salary DESC
)
```

Result

HR

| Employee | Salary | Row Number |
| -------- | ------ | ---------- |
| Bob | 50000 | 1 |
| Charlie | 45000 | 2 |
| Alice | 40000 | 3 |

IT

| Employee | Salary | Row Number |
| -------- | ------ | ---------- |
| Emma | 80000 | 1 |
| David | 70000 | 2 |

## Level 4 – Filtering after ranking

Question

> Return only the highest-paid employee.

First calculate

`ROW_NUMBER()`

Then filter.

```sql
WITH ranked AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY dept
ORDER BY salary DESC
) rn
FROM employees
)

SELECT *
FROM ranked
WHERE rn=1;
```

Notice

You cannot directly write

```sql
WHERE ROW_NUMBER()...
```

because `WHERE` executes before window functions.

## Level 5 – Running Total

Table

| Date | Sales |
| ---- | ----- |
| Jan1 | 100 |
| Jan2 | 50 |
| Jan3 | 70 |
| Jan4 | 80 |

Question

Running total.

Think.

Current row needs previous rows.

Need order.

```sql
SUM(sales)
OVER(
ORDER BY date
)
```

Result

| Date | Running Total |
| ---- | ----- |
| Jan1 | 100 |
| Jan2 | 150 |
| Jan3 | 220 |
| Jan4 | 300 |

## Level 6 – Previous Row

Question

> Difference between today's sales and yesterday's.

Need previous row.

```sql
LAG(sales)
OVER(
ORDER BY date
)
```

Output

| Date | Sales | Yesterday |
| ---- | ----- | ----- |
| Jan1 | 100 | NULL |
| Jan2 | 50 | 100 |
| Jan3 | 70 | 50 |
| Jan4 | 80 | 70 |

Now calculate

```sql
sales -
LAG(sales)
OVER(ORDER BY date)
```

## Level 7 – Two Window Functions Together

Question

Show

- Department average

- Department maximum

```sql
SELECT
employee,
salary,

AVG(salary)
OVER(PARTITION BY dept),

MAX(salary)
OVER(PARTITION BY dept)

FROM employees;
```

Multiple window functions can coexist.

## Level 8 – Nested Thinking

Question

> Employees earning above department average.

Think.

- Need average.

- Need comparison.

First

```sql
AVG()
OVER(PARTITION BY dept)
```

Now compare.

```sql
WITH cte AS
(
SELECT *,
AVG(salary)
OVER(PARTITION BY dept)
AS dept_avg

FROM employees
)

SELECT *
FROM cte
WHERE salary>dept_avg;
```

Notice

The window function is inside.

Filtering happens outside.

## Level 9 – Top 2 Employees

Question

> Return top 2 employees from each department.

First

Rank.

`ROW_NUMBER()`

Then

Filter

```text
WHERE rn<=2
```

## Level 10 – Multiple Partitions

Suppose

| Region | Dept | Employee | Salary |
| ------ | ---- | -------- | ------ |
| East | HR | A | 50 |
| East | HR | B | 40 |
| East | IT | C | 90 |
| West | HR | D | 55 |

Question

> Highest salary within each region and department.

Partition becomes

```sql
PARTITION BY region, dept
```

Now each partition is

```text
East HR

East IT

West HR
```

## Level 11 – Multiple Ordering

Question

> Rank by salary.
>
> If salary ties,
>
> Use age.

```sql
ORDER BY
salary DESC,
age ASC
```

Now ties are broken.

## Level 12 – A Real Interview Question

Tables

Orders

| customer | date | amount |
| -------- | ---- | ------ |
| A | 1 Jan | 100 |
| A | 5 Jan | 200 |
| A | 10 Jan | 150 |
| B | 3 Jan | 50 |
| B | 9 Jan | 90 |

Question

> Find each customer's second purchase.

Think.

- Each customer separately.

- Need order.

- Need ranking.

Partition

```text
customer
```

Order

```text
date
```

Filter

```text
rn=2
```

## Level 13 – Harder Question

> Find customers whose latest purchase is greater than their average purchase.

Steps

1. Average purchase per customer.

2. Latest purchase.

3. Compare.

Need

```sql
AVG()

ROW_NUMBER()
```

inside one CTE.

Then filter outside.

## Level 14 – Even Harder

Orders

| Customer | Date | Amount |
| -------- | ---- | ------ |
| A | 1 | 100 |
| A | 2 | 120 |
| A | 3 | 80 |
| A | 4 | 150 |

Question

> For every order,
> Show
>
> - Current order
> - Previous order
> - Running total
> - Customer average

One query.

You'll need

```sql
LAG()

SUM()

AVG()
```

All together.

## Level 15 – Interview-Level Challenge

Imagine this table:

| Customer | Date | Amount |
| -------- | ---- | ------ |
| A | Jan1 | 100 |
| A | Jan5 | 200 |
| A | Jan10 | 50 |
| A | Jan12 | 250 |
| B | Jan2 | 500 |
| B | Jan8 | 600 |

**Question:**

Find customers whose latest purchase is greater than the average of all their previous purchases.

To solve this, you need to think in stages:

1. Rank purchases by date (latest = `ROW_NUMBER()` = 1 when ordered descending).

2. Calculate the average of previous purchases (this requires excluding the latest row).

3. Compare the latest purchase to that average.

4. Return only customers where the latest purchase is greater.

This kind of problem combines ranking, aggregation, and filtering, and is very common in SQL interviews.

# Window-function patterns

Assume:

```text
employees(emp_id, employee_name, department, salary)
```

## Pattern 1 — Company average

Question: Show every employee with the company average salary.

```sql
SELECT
    employee_name,
    salary,
    AVG(salary) OVER () AS company_avg
FROM employees;
```

**Thinking:** Keep every employee, so no `GROUP BY`.

## Pattern 2 — Department average

```sql
SELECT
    employee_name,
    department,
    salary,
    AVG(salary) OVER (
        PARTITION BY department
    ) AS dept_avg
FROM employees;
```

**Thinking:** Every employee remains, but the average is calculated separately inside each department.

## Pattern 3 — Department maximum

```sql
SELECT
    employee_name,
    department,
    salary,
    MAX(salary) OVER (
        PARTITION BY department
    ) AS dept_max
FROM employees;
```

## Pattern 4 — Department employee count

```sql
SELECT
    employee_name,
    department,
    COUNT(*) OVER (
        PARTITION BY department
    ) AS dept_employee_count
FROM employees;
```

## 5. Ranking patterns

### `ROW_NUMBER()`

```sql
SELECT
    employee_name,
    department,
    salary,
    ROW_NUMBER() OVER (
        PARTITION BY department
        ORDER BY salary DESC
    ) AS rn
FROM employees;
```

Every row gets a unique number.

### `RANK()`

```sql
RANK() OVER (
    PARTITION BY department
    ORDER BY salary DESC
)
```

Ties share a rank and gaps can appear:

| salary   | rank |
| -------- | ---- |
| 80000    | 1    |
| 80000    | 1    |
| 70000    | 3    |

### `DENSE_RANK()`

```sql
DENSE_RANK() OVER (
    PARTITION BY department
    ORDER BY salary DESC
)
```

Ties share a rank but there are no gaps:

| salary   | dense_rank |
| -------- | ---------- |
| 80000    |      1     |
| 80000    |      1     |
| 70000    |      2     |

### Decision rule

- Unique row position → `ROW_NUMBER()`
- Ranking with gaps → `RANK()`
- Ranking without gaps → `DENSE_RANK()`

## 6. Top N per group

Question: Top 3 employees by salary in every department.

```sql
WITH ranked AS (
    SELECT
        employee_name,
        department,
        salary,
        ROW_NUMBER() OVER (
            PARTITION BY department
            ORDER BY salary DESC
        ) AS rn
    FROM employees
)
SELECT *
FROM ranked
WHERE rn <= 3;
```

**Steps:** partition → sort → number → filter.

## 7. Highest-paid employee per department

```sql
WITH ranked AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY department
            ORDER BY salary DESC
        ) AS rn
    FROM employees
)
SELECT *
FROM ranked
WHERE rn = 1;
```

A CTE is needed because window functions are not available to the same query's `WHERE` clause.

## 8. Second-highest salary per department

```sql
WITH ranked AS (
    SELECT
        *,
        DENSE_RANK() OVER (
            PARTITION BY department
            ORDER BY salary DESC
        ) AS rnk
    FROM employees
)
SELECT *
FROM ranked
WHERE rnk = 2;
```

`DENSE_RANK()` is useful when "second highest" means second distinct salary.

## 9. `LAG()` — previous row

Assume:

```text
sales(sale_date, sales_amount)
```

Question: Show today's sales and the previous day's sales.

```sql
SELECT
    sale_date,
    sales_amount,
    LAG(sales_amount) OVER (
        ORDER BY sale_date
    ) AS previous_sales
FROM sales;
```

Difference:

```sql
SELECT
    sale_date,
    sales_amount,
    sales_amount
      - LAG(sales_amount) OVER (
            ORDER BY sale_date
        ) AS sales_difference
FROM sales;
```

## 10. `LEAD()` — next row

Question: Show each customer's order and their next order date.

```sql
SELECT
    customer_id,
    order_date,
    LEAD(order_date) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS next_order_date
FROM orders;
```

Thinking:

- Same customer → `PARTITION BY customer_id`
- Chronological order → `ORDER BY order_date`
- Future row → `LEAD()`

## 11. Running total

```sql
SELECT
    sale_date,
    sales_amount,
    SUM(sales_amount) OVER (
        ORDER BY sale_date
    ) AS running_sales
FROM sales;
```

Example:

```text
date    sales    running
Jan 1     100       100
Jan 2      50       150
Jan 3      80       230
```

Per customer:

```sql
SELECT
    customer_id,
    order_date,
    amount,
    SUM(amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS customer_running_total
FROM orders;
```

## 12. Running average

```sql
SELECT
    sale_date,
    sales_amount,
    AVG(sales_amount) OVER (
        ORDER BY sale_date
    ) AS running_average
FROM sales;
```

## 13. Percentage contribution

Question:

> What percentage of department salary does each employee earn?

```sql
SELECT
    employee_name,
    department,
    salary,
    ROUND(
        100.0 * salary
        / SUM(salary) OVER (PARTITION BY department),
        2
    ) AS salary_percentage
FROM employees;
```

The denominator is the department total while the employee rows remain.

## 14. Above-department-average

```sql
WITH x AS (
    SELECT
        *,
        AVG(salary) OVER (
            PARTITION BY department
        ) AS dept_avg
    FROM employees
)
SELECT *
FROM x
WHERE salary > dept_avg;
```

Pattern:

> Window calculation → CTE → filter.

## 15. Difference from department maximum

```sql
SELECT
    employee_name,
    department,
    salary,
    MAX(salary) OVER (
        PARTITION BY department
    ) - salary AS gap_from_top
FROM employees;
```

## 16. Latest record per customer

```sql
WITH ranked AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY order_date DESC
        ) AS rn
    FROM orders
)
SELECT *
FROM ranked
WHERE rn = 1;
```

This is one of the most important real-world patterns.

## 17. First purchase per customer

```sql
WITH ranked AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY order_date
        ) AS rn
    FROM orders
)
SELECT *
FROM ranked
WHERE rn = 1;
```

## 18. Second purchase per customer

```sql
WITH ranked AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY order_date
        ) AS rn
    FROM orders
)
SELECT *
FROM ranked
WHERE rn = 2;
```

## 19. Remove duplicates while keeping the newest record

```sql
WITH ranked AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY updated_at DESC
        ) AS rn
    FROM customer_records
)
SELECT *
FROM ranked
WHERE rn = 1;
```

For deletion, use the same ranking idea carefully inside a transaction.

## 20. Detect salary changes

```sql
SELECT
    employee_id,
    effective_date,
    salary,
    LAG(salary) OVER (
        PARTITION BY employee_id
        ORDER BY effective_date
    ) AS previous_salary
FROM salary_history;
```

Filter changed rows:

```sql
WITH x AS (
    SELECT
        *,
        LAG(salary) OVER (
            PARTITION BY employee_id
            ORDER BY effective_date
        ) AS previous_salary
    FROM salary_history
)
SELECT *
FROM x
WHERE salary <> previous_salary;
```

The first row has `NULL` as its previous value.

## 21. Percentage change

```sql
WITH x AS (
    SELECT
        *,
        LAG(sales_amount) OVER (
            ORDER BY sale_date
        ) AS previous_sales
    FROM sales
)
SELECT
    sale_date,
    sales_amount,
    previous_sales,
    ROUND(
        100.0 * (sales_amount - previous_sales)
        / NULLIF(previous_sales, 0),
        2
    ) AS pct_change
FROM x;
```

`NULLIF()` protects against division by zero.

## 22. `NTILE()`

Question: Divide customers into four groups by spending.

```sql
SELECT
    customer_id,
    total_spending,
    NTILE(4) OVER (
        ORDER BY total_spending DESC
    ) AS spending_quartile
FROM customer_spending;
```

## 23. Multiple window functions together

```sql
SELECT
    customer_id,
    order_date,
    amount,

    AVG(amount) OVER (
        PARTITION BY customer_id
    ) AS customer_avg,

    SUM(amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS running_total,

    LAG(amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS previous_amount

FROM orders;
```

One query can contain several independent windows.

## 24. Latest purchase > previous purchase

```sql
WITH x AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY order_date DESC
        ) AS rn,
        LAG(amount) OVER (
            PARTITION BY customer_id
            ORDER BY order_date
        ) AS previous_amount
    FROM orders
)
SELECT *
FROM x
WHERE rn = 1
  AND amount > previous_amount;
```

Thinking:

1. Find previous purchase.
2. Identify latest purchase.
3. Compare.
4. Filter.

## 25. Latest purchase > average of previous purchases

```sql
WITH x AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY order_date DESC
        ) AS rn,
        AVG(amount) OVER (
            PARTITION BY customer_id
            ORDER BY order_date
            ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING
        ) AS previous_avg
    FROM orders
)
SELECT
    customer_id,
    order_date,
    amount,
    previous_avg
FROM x
WHERE rn = 1
  AND amount > previous_avg;
```

The window frame:

```sql
ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING
```

means all rows before the current row.

This is an advanced pattern.

## 26. Rolling 3-row average

```sql
SELECT
    sale_date,
    sales_amount,
    AVG(sales_amount) OVER (
        ORDER BY sale_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS rolling_3_avg
FROM sales;
```

Difference:

- Running average → beginning through current row.
- Rolling 3-row average → only current + previous 2 rows.

## 27. Customer order count without GROUP BY

```sql
SELECT
    order_id,
    customer_id,
    order_date,
    COUNT(*) OVER (
        PARTITION BY customer_id
    ) AS customer_order_count
FROM orders;
```

## 28. Multi-level partition

Question:

> Highest salary in each region + department.

```sql
MAX(salary) OVER (
    PARTITION BY region, department
)
```

A partition can contain multiple columns.

## 29. Ranking with tie breakers

```sql
ROW_NUMBER() OVER (
    PARTITION BY department
    ORDER BY salary DESC, age ASC
)
```

Salary is the primary sort; age breaks ties.

## 30. Gap detection with `LAG()`

```sql
WITH x AS (
    SELECT
        order_id,
        LAG(order_id) OVER (
            ORDER BY order_id
        ) AS previous_id
    FROM orders
)
SELECT *
FROM x
WHERE order_id - previous_id > 1;
```

This identifies a gap larger than one.

## 31. Consecutive events — gaps and islands

For consecutive login days:

```sql
SELECT
    customer_id,
    login_date,
    login_date
      - ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY login_date
        )::int AS grp
FROM logins;
```

Rows in the same consecutive streak get the same grouping key.

This is the beginning of the **Gaps and Islands** pattern.

## 32. JOIN + window function

Question:

> Highest-spending customer in every city.

```sql
WITH customer_sales AS (
    SELECT
        c.customer_id,
        c.customer_name,
        c.city,
        SUM(o.amount) AS total_spending
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY
        c.customer_id,
        c.customer_name,
        c.city
),
ranked AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY city
            ORDER BY total_spending DESC
        ) AS rn
    FROM customer_sales
)
SELECT *
FROM ranked
WHERE rn = 1;
```

Important pattern:

> JOIN → GROUP BY → window function → filter.

## 33. Monthly top seller

```sql
WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', order_date) AS month,
        product_id,
        SUM(amount) AS revenue
    FROM orders
    GROUP BY
        DATE_TRUNC('month', order_date),
        product_id
),
ranked AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY month
            ORDER BY revenue DESC
        ) AS rn
    FROM monthly_sales
)
SELECT *
FROM ranked
WHERE rn = 1;
```

Important principle:

> Aggregate first, rank second.

## 34. Month-over-month revenue growth

```sql
WITH monthly AS (
    SELECT
        DATE_TRUNC('month', order_date) AS month,
        SUM(amount) AS revenue
    FROM orders
    GROUP BY DATE_TRUNC('month', order_date)
),
x AS (
    SELECT
        *,
        LAG(revenue) OVER (
            ORDER BY month
        ) AS previous_revenue
    FROM monthly
)
SELECT
    month,
    revenue,
    previous_revenue,
    ROUND(
        100.0 * (revenue - previous_revenue)
        / NULLIF(previous_revenue, 0),
        2
    ) AS growth_pct
FROM x
ORDER BY month;
```

Pattern:

> GROUP BY → LAG → calculation.

## Pattern-recognition cheat sheet

| Question wording | Likely function/pattern |
| ---------------- | --- |
| Highest employee per department | `ROW_NUMBER/RANK/DENSE_RANK` |
| Top 3 per category | Ranking + CTE |
| Second-highest salary | Ranking |
| Previous purchase | `LAG()` |
| Next purchase | `LEAD()` |
| Running total | `SUM() OVER(ORDER BY...)` |
| Running average | `AVG() OVER(ORDER BY...)` |
| Department average beside every employee | `AVG() OVER(PARTITION BY...)` |
| Percentage of department total | `SUM() OVER(PARTITION BY...)` |
| Latest record | `ROW_NUMBER() ... ORDER BY date DESC` |
| First record | `ROW_NUMBER() ... ORDER BY date` |
| Remove duplicates | `ROW_NUMBER()` |
| Detect changes | `LAG()` |
| Days until next event | `LEAD()` |
| Divide into quartiles | `NTILE()` |
| Relative rank | `PERCENT_RANK()` / `CUME_DIST()` |
| Rolling average | Window frame |
| Missing sequence | `LAG()` |
| Consecutive events | `ROW_NUMBER()` + gaps/islands |
| Monthly top product | `GROUP BY` → ranking |
| Monthly growth | `GROUP BY` → `LAG()` |

# Learning Progression

## Foundation

Practice:

- `OVER()`
- `PARTITION BY`
- `ORDER BY`
- `ROW_NUMBER()`
- `RANK()`
- `DENSE_RANK()`
- Aggregate windows

Goal:

> Decide whether a question needs a window function.

## Row relationships

Practice:

- `LAG()`
- `LEAD()`
- Running totals
- Running averages
- Percent contribution
- `NTILE()`

Goal:

> Understand relationships between current and other rows.

## Filtering and multiple windows

Practice:

- CTE + window
- Multiple window functions
- Above/below average
- Latest records
- First/second/third records

Goal:

> Solve multi-step questions.

## Real analytics

Practice:

- JOIN + window
- Aggregate + window
- Monthly ranking
- Growth
- Gaps
- Consecutive events

Goal:

> Combine SQL concepts.

## Advanced

Practice:

- Window frames
- Rolling calculations
- Nested CTEs
- Multiple partitions
- Tie handling
- Complex comparisons

Goal:

> Translate business questions into multiple SQL steps.

## Interview level

Practice questions:

1. Latest purchase greater than previous purchase.
2. Latest purchase greater than average of previous purchases.
3. Top 3 customers in every city.
4. Top product in every month.
5. Month-over-month growth.
6. Employees above department average.
7. Second-highest salary with ties handled correctly.
8. Longest customer purchase streak.
9. Customers whose spending is consistently increasing.
10. Complete retail-sales analysis using joins, CTEs, aggregates and multiple windows.
