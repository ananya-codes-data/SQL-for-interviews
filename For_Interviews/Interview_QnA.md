# ✅ *Core SQL Interview Questions With Answers* 🖥️

1. What is SQL

- SQL stands for Structured Query Language
- You use it to read and manage data in relational databases
- Used in MySQL, PostgreSQL, SQL Server, Oracle

2. What is an RDBMS

- Relational Database Management System
- Stores data in tables with rows and columns
- Uses keys to link tables
- Example. Customer table linked to Orders table using customer_id

3. What is a table

- Structured storage for data
- Rows are records
- Columns are attributes
- Example. One row equals one customer

4. What is a primary key

- Uniquely identifies each row
- Cannot be NULL
- No duplicate values
- Example. user_id in users table

5. What is a foreign key

- Links one table to another
- Refers to a primary key in another table
- Allows duplicate values
- Example. user_id in orders table

6. Difference between primary key and foreign key

- Primary key ensures uniqueness
- Foreign key ensures relationship
- One table can have one primary key
- One table can have multiple foreign keys

7. What is NULL

- Represents missing or unknown value
- Not equal to zero or empty string
- Use IS NULL or IS NOT NULL to check

8. What are constraints

- Rules applied on columns
- Maintain data quality
- Common constraints
– NOT NULL
– UNIQUE
– PRIMARY KEY
– FOREIGN KEY
– CHECK

9. What are data types

- Define type of data stored
- Common types
– INT for numbers
– VARCHAR for text
– DATE for dates
– FLOAT or DECIMAL for decimals

10. Interview tip you must remember

- Always explain with a small example
- Speak logic before syntax
- Keep answers short and direct

11. What is SELECT

- Retrieves specific data from tables
- Choose columns with * for all
- Example: SELECT name, age FROM users;

12. What does WHERE do

- Filters rows based on conditions
- Applied after FROM clause
- Example: SELECT * FROM users WHERE age > 25 [1]

13. What is ORDER BY

- Sorts result set by column(s)
- ASC (default) or DESC
- Example: SELECT * FROM users ORDER BY age DESC;

14. What is GROUP BY

- Groups rows with same values
- Used with aggregate functions like COUNT, SUM
- Example: SELECT department, COUNT(*) FROM employees GROUP BY department [2]

15. Difference between WHERE and HAVING

- WHERE filters rows before grouping
- HAVING filters groups after GROUP BY
- WHERE can't use aggregates; HAVING can

16. What is a JOIN

- Combines rows from two or more tables
- Based on related columns
- INNER JOIN returns matching rows only

17. Types of JOINs

- INNER JOIN: matching rows
- LEFT JOIN: all from left + matches from right
- RIGHT JOIN: all from right + matches from left
- FULL OUTER JOIN: all from both

18. What are aggregate functions

- Perform calculations on groups
- COUNT, SUM, AVG, MIN, MAX
- Example: SELECT AVG(salary) FROM employees

19. What is a subquery

- Query inside another query
- Used in SELECT, WHERE, FROM
- Example: SELECT * FROM users WHERE age > (SELECT AVG(age) FROM users)

20. Interview tip you must remember

- Explain query execution order: FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY
- Use simple examples with 2-3 rows
- Practice on sample datasets like employees/orders

21. What is COUNT function

- Counts number of rows or non-NULL values
- COUNT(*) counts all rows including NULLs
- Example: SELECT COUNT(*) FROM orders WHERE status = 'shipped';

22. What is SUM function

- Adds up numeric values in column
- Ignores NULL values
- Example: SELECT SUM(amount) FROM orders;

23. What is AVG function

- Calculates average of numeric column
- Ignores NULL values
- Example: SELECT AVG(salary) FROM employees WHERE department = 'IT';

24. What is MIN and MAX

- Finds smallest/largest value
- Works on numbers, dates, strings
- Example: SELECT MIN(order_date), MAX(order_date) FROM orders;

25. What are window functions

- Perform calculations across row sets
- ROW_NUMBER(), RANK(), DENSE_RANK()
- Example: ROW_NUMBER() OVER (ORDER BY salary DESC);

26. What does DISTINCT do

- Removes duplicate rows from result
- Use in SELECT or with COUNT
- Example: SELECT DISTINCT department FROM employees;

27. What is LIMIT

- Restricts number of rows returned
- TOP in SQL Server, ROWNUM in Oracle
- Example: SELECT * FROM employees ORDER BY salary DESC LIMIT 5;

28. What is OFFSET

- Skips specified number of rows
- Used with LIMIT for pagination
- Example: SELECT * FROM employees LIMIT 10 OFFSET 20;

29. What are indexes

- Speed up data retrieval
- Like book index for fast lookup
- CREATE INDEX idx_name ON table(column);

30. Interview tip you must remember

- Always mention execution order impact on performance
- Practice explaining JOIN visuals (Venn diagrams)
- Know when to use WHERE vs HAVING vs window functions
