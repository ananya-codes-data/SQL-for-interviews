# The 4-step thinking framework

## Step 1: Read the question and ignore SQL

> Find employees who earn more than the average salary

## Step 2: Ask → what must be calculated first?

First -- average salary -- subquery
second -- compare with salary

## Step 3: Decide where the subquery goes

Ask:

* Is it returning **one value**? → `WHERE salary > (subquery)`

* Is it returning **multiple values**? → `IN / EXISTS`

* Is it returning a **table**? → `FROM (subquery)`

## Step 4: Combine helper + main query

Write the subquery first, then wrap the main query around it

## Let’s walk through examples slowly

## Example 1: Single-value subquery (easiest)

**Question:**
Find employees earning more than the average salary.

### Step 1: Read the qs

* First find average salary
* Then compare each employee’s salary with it

### Step 2: Helper answer

```sql
SELECT AVG(salary)
FROM employees;
```

### Step 3: Where does it go?

* One value → `WHERE`

### Step 4: Final query

```sql
SELECT *
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);
```

💡 Think:

> “Show me employees where salary is greater than **that number**.”

## Example 2: Multi-row subquery (IN)

**Question:**
Find employees who work in departments located in 'Delhi'.

### Step 1

* First get department IDs in Delhi
* Then get employees from those departments

### Step 2: subquery

```sql
SELECT department_id
FROM departments
WHERE location = 'Delhi';
```

### Step 3: Returns many values → `IN`

### Step 4: Ultimate query

```sql
SELECT *
FROM employees
WHERE department_id IN (
    SELECT department_id
    FROM departments
    WHERE location = 'Delhi'
);
```

🧠 Mental model:

> “Give me employees whose department_id is **inside this list**.”

## Example 3: Correlated subquery (this is where logic breaks for most people)

**Question:**
Find employees who earn more than the average salary of their own department.

### Step 1: English

* For each employee:

  * Find **average salary of their department**
  * Compare employee salary with that average

⚠️ Notice:
The subquery depends on the **current employee row**.

### Step 2: Write helper with dependency

```sql
SELECT AVG(e2.salary)
FROM employees e2
WHERE e2.department_id = e1.department_id
```

### Step 3: Final query

```sql
SELECT *
FROM employees e1
WHERE salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e1.department_id
);
```

🧠 Think like:

> “For THIS employee, calculate THEIR department’s average.”

## How to recognise which subquery you need

### 🔹 If question says

* **“more than average”** → scalar subquery
* **“belongs to / exists in”** → `IN`
* **“for each row” / “their own”** → correlated subquery
* **“top / highest / max per group”** → subquery or window function

## Common mistakes you’re probably making

❌ Confusing which clause to use to form subquery
❌ Not running the subquery alone
❌ Confusing `=` with `IN`
❌ Panicking when table alias appears
❌ Confusing how many layers of subqueries should be there inside the main query

## Training method (this WILL make you good)

For every subquery question, do this **on paper or notes**:

1. Write:

   > “First I need to find __________”
2. Write that SQL
3. Run ONLY that query
4. Then write:

   > “Now using that result, I will __________”
5. Combine

Do **not skip step 3**.

## 🔹 SUBQUERY PATTERN PLAYBOOK

## **Pattern 1: Scalar Subquery (returns ONE value)**

### 🧠 When you’ll see it

* more than / less than / equal to
* average, max, min
* “overall”

### Mental trigger

> “I need ONE number first.”

### Example

**Question:**
Find employees earning more than the average salary.

```sql
SELECT *
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);
```

💡 Tip:
If your subquery returns **one row, one column**, this is your pattern.

## **Pattern 2: IN Subquery (returns MULTIPLE values)**

### 🧠 When you’ll see it

* belongs to
* part of
* in these categories
* list of IDs

### Mental trigger

> “I need a LIST first.”

### Example

**Question:**
Find employees working in departments located in Mumbai.

```sql
SELECT *
FROM employees
WHERE department_id IN (
    SELECT department_id
    FROM departments
    WHERE location = 'Mumbai'
);
```

## **Pattern 3: NOT IN Subquery (exclusion)**

### 🧠 When you’ll see it

* not assigned
* never did
* without

### Mental trigger

> “Exclude this list.”

```sql
SELECT *
FROM employees
WHERE employee_id NOT IN (
    SELECT employee_id
    FROM projects
);
```

⚠️ Interview tip:
If `NULL` exists → prefer `NOT EXISTS`.

## **Pattern 4: EXISTS Subquery (yes/no check)**

### 🧠 When you’ll see it

* if at least one exists
* presence matters, not values

### Mental trigger

> “I only care if a match exists.”

```sql
SELECT *
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM projects p
    WHERE p.employee_id = e.employee_id
);
```

🧠 Think:

> “If ANY row matches, keep the employee.”

## **Pattern 5: Correlated Subquery (per-row logic)**

### 🧠 When you’ll see it

* for each employee
* their own
* same department

### Mental trigger

> “This must be calculated AGAIN for every row.”

### Example

**Question:**
Employees earning more than their department average.

```sql
SELECT *
FROM employees e1
WHERE salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e1.department_id
);
```

💡 Rule:
Outer query column inside subquery = correlated.

## **Pattern 6: Subquery in SELECT clause**

### 🧠 When you’ll see it

* show extra calculated value
* comparison column

### Mental trigger

> “Show helper info per row.”

```sql
SELECT 
    employee_name,
    salary,
    (SELECT AVG(salary) FROM employees) AS avg_salary
FROM employees;
```

⚠️ Used sparingly (can be slow).

## **Pattern 7: Subquery in FROM clause (derived table)**

### 🧠 When you’ll see it

* complex aggregation first
* then filter on result

### Mental trigger

> “Create a temporary table first.”

```sql
SELECT department_id, avg_salary
FROM (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
) dept_avg
WHERE avg_salary > 60000;
```

🧠 Think:

> “Calculate → then filter.”

## **Pattern 8: Max / Top per Group**

### 🧠 When you’ll see it

* highest per department
* top scorer per team

### Mental trigger

> “Compare against the best in the same group.”

```sql
SELECT *
FROM employees e1
WHERE salary = (
    SELECT MAX(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e1.department_id
);
```

## **Pattern 9: Nested Subqueries (subquery inside subquery)**

### 🧠 When you’ll see it

* multi-level conditions
* complex filters

### Mental trigger

> “Answer → used to answer → final answer.”

```sql
SELECT *
FROM employees
WHERE department_id IN (
    SELECT department_id
    FROM departments
    WHERE location IN (
        SELECT location
        FROM locations
        WHERE country = 'India'
    )
);
```

## **Pattern 10: Comparison with ANY / ALL**

### 🧠 When you’ll see it

* higher than all
* greater than any

### Mental trigger

> “Compare against multiple values logically.”

```sql
-- Earns more than ALL department averages
SELECT *
FROM employees
WHERE salary > ALL (
    SELECT AVG(salary)
    FROM employees
    GROUP BY department_id
);
```

## **Pattern 11: UPDATE / DELETE with Subqueries**

### 🧠 When you’ll see it

* modify based on condition
* cleanup tasks

```sql
DELETE FROM employees
WHERE department_id IN (
    SELECT department_id
    FROM departments
    WHERE is_active = 'N'
);
```

## **Pattern 12: Subquery vs JOIN (interview gold)**

### Subquery version

```sql
SELECT *
FROM employees
WHERE department_id IN (
    SELECT department_id
    FROM departments
    WHERE location = 'Delhi'
);
```

### JOIN version

```sql
SELECT e.*
FROM employees e
JOIN departments d
  ON e.department_id = d.department_id
WHERE d.location = 'Delhi';
```

🧠 Rule:

* Filtering → JOIN
* Per-row comparison → Subquery
