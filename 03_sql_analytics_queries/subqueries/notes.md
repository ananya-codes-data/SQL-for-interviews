# The 4-step thinking framework

## Step 1: Read the question and ignore SQL

Find employees who earn more than the average salary

## Step 2: Ask → what must be calculated first?

First -- average salary -- subquery
second -- compare with salary

## Step 3: Decide where the subquery goes

Ask:

Is it returning one value? -- WHERE salary > (subquery)

Is it returning multiple values? -- IN / EXISTS

Is it returning a table? -- FROM (subquery)

## Step 4: Combine helper + main query

Write the subquery first, then wrap the main query around it
