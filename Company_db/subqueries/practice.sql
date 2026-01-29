-- 🧠 PART 1: 30 PRACTICE QUESTIONS (PATTERN-WISE)

-- 🔹 Pattern 1: Scalar Subqueries (5 questions)

-- 1. Find employees earning more than the average salary.


-- 2. Find employees earning less than the maximum salary.


-- 3. Find employees hired after the earliest hire date.


-- 4. Find orders with amount greater than the average order amount.


-- 5. Find customers whose total spending is above the average customer spending.



-- 🔹 Pattern 2: IN / NOT IN Subqueries (5 questions)

-- 6. Find employees working in departments located in Delhi.


-- 7. Find employees not assigned to any project.


-- 8. Find customers who placed orders in 2024.


-- 9. Find products that were never ordered.


-- 10. Find employees working in departments with more than 10 employees.



-- 🔹 Pattern 3: EXISTS / NOT EXISTS (5 questions)

-- 11. Find employees who have at least one project.


-- 12. Find customers who have never placed an order.


-- 13. Find departments that have employees earning above 80,000.


-- 14. Find orders that belong to customers from India.


-- 15. Find employees whose department has at least one project.



-- 🔹 Pattern 4: Correlated Subqueries (5 questions)

-- 16. Find employees earning more than their department’s average salary.


-- 17. Find employees who joined last in their department.


-- 18. Find employees earning the maximum salary in their department.


-- 19. Find orders with amount greater than customer’s average order amount.


-- 20. Find employees whose salary is higher than the average of employees hired after them.



--  🔹 Pattern 5: Subqueries in FROM / SELECT (5 questions)

-- 21. Find departments with average salary greater than 70,000.


-- 22. Show employees along with overall average salary.


-- 23. Find customers whose total order amount > 100,000.


-- 24. Find departments with highest total salary cost.


-- 25. Show each employee with number of projects they work on.



--  🔹 Pattern 6: Nested Subqueries (5 questions)

-- 26. Find employees working in departments located in cities where avg salary > 60,000.


-- 27. Find employees working on projects in departments located in India.


-- 28. Find customers from countries where average order value > 5,000.


-- 29. Find employees earning more than the company-wide average of top-paid departments.


-- 30. Find employees working in departments located in cities with highest total project budget.



/* 👉 Rule:
For each question:

* Write helper subquery separately
* Run it
* THEN combine */


-- 🧩 PART 2: PROGRESSIVE NESTED SUBQUERY PRACTICE (10 QUESTIONS)

-- 🟢 Level 1 — Easy Nesting (2 layers)

-- 1. Find employees working in departments located in cities where avg salary > 50,000.


-- 2. Find customers who placed orders in countries where total order amount > 1,000,000.



-- 🟡 Level 2 — Medium Nesting (3 layers)

-- 3. Find employees working in departments where average salary > company average salary.


-- 4. Find employees working on projects in departments located in cities where avg project budget > 100,000.



-- 🟠 Level 3 — Advanced Nesting (4 layers)

/* 5. Find employees earning more than the average salary of departments 
located in cities where avg project budget > 200,000. */


/* 6. Find customers whose total spending is higher than the average spending 
of customers from countries where total revenue is highest. */



--  🔴 Level 4 — Expert (Nested + Correlated)

/* 7. Find employees who earn more than their department’s average salary,
but only for departments located in cities where total project budget > company average. */


/* 8. Find employees who are the highest paid in departments located 
in countries where average salary is above global average. */



-- ⚫ Level 5 — Insane (Interview Killer)

/* 9. Find employees whose salary is higher than the average salary
 of top 3 highest-paying departments. */


/* 10. Find employees working in departments located in the city
 that has the highest total project budget,
and who earn more than the overall company average salary. */


/*  🧠 HOW YOU SHOULD PRACTICE THIS (IMPORTANT)

Do NOT jump to final SQL.

For each question:

1. Write the deepest subquery first
2. Run it alone
3. Move one level up
4. Only then write final query */