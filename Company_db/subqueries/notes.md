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
