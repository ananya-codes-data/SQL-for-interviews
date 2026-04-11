# Case Based Qs

## 𝗜𝗻𝘁𝗲𝗿𝘃𝗶𝗲𝘄𝗲𝗿: You have 2 minutes to solve this SQL query

From the employees table, retrieve the employee name, department, and their salary rank within the department (highest salary rank 1).

𝗠𝗲: Challenge accepted!

```sql
SELECT 
    name, 
    department, 
    salary,
    DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS salary_rank
FROM employees;
```

I applied `DENSE_RANK()` window function partitioned by department and ordered by descending salary to assign ranks within each department. Unlike ROW_NUMBER(), DENSE_RANK() handles ties by assigning the same rank without gaps. This is ideal for leaderboards or performance analytics.

𝗧𝗶𝗽 𝗳𝗼𝗿 𝗦𝗤𝗟 𝗝𝗼𝗯 𝗦𝗲𝗲𝗸𝗲𝗿𝘀:  
Master window function differences (ROW_NUMBER vs RANK vs DENSE_RANK)—they're interview staples for deduping, paging, and top-N queries!
