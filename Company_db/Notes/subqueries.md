# Subqueries

## The 4-step thinking framework

### Step 1: Read the question and ignore SQL

> Find employees who earn more than the average salary

### Step 2: Ask → what must be calculated first?

First -- average salary -- subquery

second -- compare with salary

### Step 3: Decide where the subquery goes

Ask:

* Is it returning **one value**? → `WHERE salary > (subquery)`

* Is it returning **multiple values**? → `IN / EXISTS`

* Is it returning a **table**? → `FROM (subquery)`

### Step 4: Combine helper + main query

Write the subquery first, then wrap the main query around it

### Let’s walk through examples slowly

### Example 1: Single-value subquery (easiest)

**Question:**
Find employees earning more than the average salary.

#### Step 1: Read the qs

* First find average salary
* Then compare each employee’s salary with it

#### Step 2: Helper answer

```sql
SELECT AVG(salary)
FROM employees;
```

#### Step 3: Where does it go?

* One value → `WHERE`

#### Step 4: Final query

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

### Example 2: Multi-row subquery (IN)

**Question:**
Find employees who work in departments located in 'Delhi'.

#### Step 1

* First get department IDs in Delhi
* Then get employees from those departments

#### Step 2: subquery

```sql
SELECT department_id
FROM departments
WHERE location = 'Delhi';
```

#### Step 3: Returns many values → `IN`

#### Step 4: Ultimate query

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

### Example 3: Correlated subquery (this is where logic breaks for most people)

**Question:**
Find employees who earn more than the average salary of their own department.

#### Step 1: English

* For each employee:

  * Find **average salary of their department**
  * Compare employee salary with that average

⚠️ Notice:
The subquery depends on the **current employee row**.

#### Step 2: Write helper with dependency

```sql
SELECT AVG(e2.salary)
FROM employees e2
WHERE e2.department_id = e1.department_id
```

#### Step 3: Final query

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

### How to recognise which subquery you need

#### 🔹 If question says

* **“more than average”** → scalar subquery
* **“belongs to / exists in”** → `IN`
* **“for each row” / “their own”** → correlated subquery
* **“top / highest / max per group”** → subquery or window function

### Common mistakes you’re probably making

❌ Confusing which clause to use to form subquery
❌ Not running the subquery alone
❌ Confusing `=` with `IN`
❌ Panicking when table alias appears
❌ Confusing how many layers of subqueries should be there inside the main query

### Training method (this WILL make you good)

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

## 🧩 NESTED SUBQUERIES — STEP BY STEP TRAINING

## 🟢 Level 1: Single nested subquery (2 layers)

### Question

Find employees who work in departments located in cities where the average salary is above 60,000.

## Step-by-step thinking:

### Step 1: What’s the deepest info?

We need:

> Cities where avg salary > 60000

So first query:

```sql
SELECT d.location
FROM employees e
JOIN departments d 
  ON e.department_id = d.department_id
GROUP BY d.location
HAVING AVG(e.salary) > 60000;
```

This gives:
👉 list of locations

### Step 2: Use that result to get departments

```sql
SELECT department_id
FROM departments
WHERE location IN (
    -- locations with high avg salary
)
```

### Step 3: Use that to get employees

## Final nested query:

```sql
SELECT *
FROM employees
WHERE department_id IN (
    SELECT department_id
    FROM departments
    WHERE location IN (
        SELECT d.location
        FROM employees e
        JOIN departments d 
          ON e.department_id = d.department_id
        GROUP BY d.location
        HAVING AVG(e.salary) > 60000
    )
);
```

🧠 Layering:

1. location list
2. department list
3. employee list

### Question:

👉 Find employees who work in departments located in **Delhi**.

## Step 1: Translate to English

* Find departments in Delhi
* Find employees in those departments

---

## Step 2: Find departments in Delhi (inner query)

```sql
SELECT dept_id
FROM departments
WHERE location = 'Delhi';
```

---

## Step 3: Use that result to find employees (outer query)

```sql
SELECT *
FROM employees
WHERE dept_id IN (
    SELECT dept_id
    FROM departments
    WHERE location = 'Delhi'
);
```

🧠 Think:

> “Show employees whose dept_id is inside this list.”

## 🟡 Level 2: 3-layer dependency (logical nesting)

### Question:

Find employees working on projects in departments located in cities where **total project budget > 1,000,000**.

## Thinking chain:

### Step 1: Find cities with high project budget

```sql
SELECT d.location
FROM projects p
JOIN employees e ON p.employee_id = e.employee_id
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.location
HAVING SUM(p.project_budget) > 1000000;
```

👉 cities list

### Step 2: Find departments in those cities

```sql
SELECT department_id
FROM departments
WHERE location IN (cities)
```

### Step 3: Find employees in those departments

## Final nested query:

```sql
SELECT *
FROM employees
WHERE department_id IN (
    SELECT department_id
    FROM departments
    WHERE location IN (
        SELECT d.location
        FROM projects p
        JOIN employees e ON p.employee_id = e.employee_id
        JOIN departments d ON e.department_id = d.department_id
        GROUP BY d.location
        HAVING SUM(p.project_budget) > 1000000
    )
);
```

🧠 Layers:
project → location → department → employee

### Question:

Find employees who work in departments located in **cities in India**.

## Step 1: English breakdown

* Find cities in India
* Find departments in those cities
* Find employees in those departments

## Step 2: Start from deepest logic

### 1️⃣ Cities in India

```sql
SELECT city
FROM locations
WHERE country = 'India';
```

### 2️⃣ Departments in those cities

```sql
SELECT dept_id
FROM departments
WHERE location IN (
    SELECT city
    FROM locations
    WHERE country = 'India'
);
```

### 3️⃣ Employees in those departments

```sql
SELECT *
FROM employees
WHERE dept_id IN (
    SELECT dept_id
    FROM departments
    WHERE location IN (
        SELECT city
        FROM locations
        WHERE country = 'India'
    )
);
```

🧠 Mental chain:

```
India → cities → departments → employees
```

## 🟠 Level 3: Nested + correlated logic

### Question:

Find employees whose salary is higher than the average salary of departments located in cities where the average project budget is high.

## Thinking:

### Step 1: Cities with high avg project budget

```sql
SELECT d.location
FROM projects p
JOIN employees e ON p.employee_id = e.employee_id
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.location
HAVING AVG(p.project_budget) > 500000;
```

### Step 2: Departments in those cities

```sql
SELECT department_id
FROM departments
WHERE location IN (cities)
```

### Step 3: Average salary of those departments

```sql
SELECT AVG(salary)
FROM employees
WHERE department_id IN (dept list)
```

### Step 4: Compare employee salary

## Final query:

```sql
SELECT *
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department_id IN (
        SELECT department_id
        FROM departments
        WHERE location IN (
            SELECT d.location
            FROM projects p
            JOIN employees e ON p.employee_id = e.employee_id
            JOIN departments d ON e.department_id = d.department_id
            GROUP BY d.location
            HAVING AVG(p.project_budget) > 500000
        )
    )
);
```

🧠 Mental model:

> projects → cities → departments → avg salary → compare employee

## 🔴 Level 4: Correlated nested subqueries (hard mode)

### Question:

Find employees who earn more than their department’s average salary,
but only for departments located in cities where **total project budget is highest**.

## Step-by-step:

### Step 1: Find city with highest total project budget

```sql
SELECT d.location
FROM projects p
JOIN employees e ON p.employee_id = e.employee_id
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.location
ORDER BY SUM(p.project_budget) DESC
LIMIT 1;
```

### Step 2: Departments in that city

```sql
SELECT department_id
FROM departments
WHERE location = (top city)
```

### Step 3: Employees in those departments who earn more than dept avg (correlated)

## Final query:

```sql
SELECT *
FROM employees e1
WHERE department_id IN (
    SELECT department_id
    FROM departments
    WHERE location = (
        SELECT d.location
        FROM projects p
        JOIN employees e ON p.employee_id = e.employee_id
        JOIN departments d ON e.department_id = d.department_id
        GROUP BY d.location
        ORDER BY SUM(p.project_budget) DESC
        LIMIT 1
    )
)
AND salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e1.department_id
);
```

🧠 Layers:

* best city
* departments in best city
* employees in those departments
* correlated avg salary
* compare

## 🧠 How to mentally build nested subqueries

Always ask in this order:

1. **What is the final output?**
2. **What info is needed just before that?**
3. **What info is needed before that?**
4. Keep drilling until base data

You’re basically doing **reverse engineering**.

## 🔁 Practice rule (very powerful)

Write like this in notes:

```
Final goal: Employees
Needs: Departments
Needs: Cities
Needs: Project budget
```

Then convert each line into SQL.

## 🟠 LEVEL 5 — Nested with Aggregation Logic

### Question:

Find employees who earn **more than the average salary of employees working in India**.

## Step 1: English logic

* Find employees in India
* Find their average salary
* Compare everyone’s salary to that number

## Step 2: Build from inside out

### 1️⃣ Employees in India

```sql
SELECT e.salary
FROM employees e
WHERE e.dept_id IN (
    SELECT d.dept_id
    FROM departments d
    WHERE d.location IN (
        SELECT city
        FROM locations
        WHERE country = 'India'
    )
);
```

### 2️⃣ Average salary of those employees

```sql
SELECT AVG(salary)
FROM employees
WHERE dept_id IN (
    SELECT dept_id
    FROM departments
    WHERE location IN (
        SELECT city
        FROM locations
        WHERE country = 'India'
    )
);
```

### 3️⃣ Final query

```sql
SELECT *
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE dept_id IN (
        SELECT dept_id
        FROM departments
        WHERE location IN (
            SELECT city
            FROM locations
            WHERE country = 'India'
        )
    )
);
```

🧠 Think:

```
India employees → average salary → compare
```

---

## 🔴 LEVEL 6 — Nested + Correlated (Brain Stretch)

### Question:

Find employees who earn more than the **average salary of employees in the same country**.

## Step 1: English logic

For each employee:

* Find their country
* Find avg salary of employees in that country
* Compare salary

## Step 2: Identify correlation

Employee’s country depends on **their department → location → country**

## Step 3: SQL

```sql
SELECT *
FROM employees e1
WHERE salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.dept_id IN (
        SELECT d.dept_id
        FROM departments d
        WHERE d.location IN (
            SELECT l.city
            FROM locations l
            WHERE l.country = (
                SELECT l2.country
                FROM departments d2
                JOIN locations l2 ON d2.location = l2.city
                WHERE d2.dept_id = e1.dept_id
            )
        )
    )
);
```

🧠 Mindset:

```
For THIS employee →
find THEIR country →
find avg salary in THAT country →
compare
```

## 🧠 HOW TO THINK WHEN NESTING DEEPLY

## Always work INSIDE → OUTSIDE

### Ask repeatedly:

> “What must I know before I can answer this?”

Write the chain like:

```
Answer A depends on B
B depends on C
C depends on D
```

Then SQL mirrors that structure.

## ⚡ LEVEL 7 — Interview-Level Deep Nesting (Final Boss)

### Question:

Find employees who earn more than the **highest department average salary** among departments located in **India**.

## Step 1: English logic chain

1. Find departments in India
2. Compute average salary per department
3. Find highest among those averages
4. Compare employees salary

## Step 2: SQL step-by-step

### 1️⃣ Departments in India

```sql
SELECT dept_id
FROM departments
WHERE location IN (
    SELECT city
    FROM locations
    WHERE country = 'India'
);
```

### 2️⃣ Avg salary per dept (India only)

```sql
SELECT AVG(salary)
FROM employees
WHERE dept_id IN ( ... )
GROUP BY dept_id;
```

### 3️⃣ Highest avg salary

```sql
SELECT MAX(avg_sal)
FROM (
    SELECT AVG(salary) AS avg_sal
    FROM employees
    WHERE dept_id IN (
        SELECT dept_id
        FROM departments
        WHERE location IN (
            SELECT city
            FROM locations
            WHERE country = 'India'
        )
    )
    GROUP BY dept_id
) t;
```

### 4️⃣ Final Query

```sql
SELECT *
FROM employees
WHERE salary > (
    SELECT MAX(avg_sal)
    FROM (
        SELECT AVG(salary) AS avg_sal
        FROM employees
        WHERE dept_id IN (
            SELECT dept_id
            FROM departments
            WHERE location IN (
                SELECT city
                FROM locations
                WHERE country = 'India'
            )
        )
        GROUP BY dept_id
    ) t
);
```

🧠 Brain translation:

```
India → departments → avg salary → highest avg → compare employee salary
```

## 🎯 Practice Drill for You (try mentally)

### Q1

Find employees who work in departments where **the average salary > company average salary**.

### Q2

Find departments that have **no employees earning less than the company average**.

### Q3

Find employees who earn more than **all employees in departments located in Mumbai**.
