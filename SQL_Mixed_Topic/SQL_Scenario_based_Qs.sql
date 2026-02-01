-- EMPLOYEE TABLE CREATION
CREATE TABLE IF NOT EXISTS employees (
	employee_id INT PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	department VARCHAR(50),
	salary DECIMAL(10,2)
);

DROP TABLE employees;

-- EMPLOYEE DETAILS FOR INSERTION FROM CHATGPT
INSERT INTO employees (employee_id, first_name, last_name, department, salary) 
VALUES
(1, 'Amit', 'Sharma', 'HR', 45000.00),
(2, 'Neha', 'Verma', 'Finance', 55000.00),
(3, 'Rahul', 'Mehta', 'IT', 70000.00),
(4, 'Priya', 'Singh', 'Marketing', 48000.00),
(5, 'Karan', 'Patel', 'IT', 72000.00),
(6, 'Anjali', 'Iyer', 'HR', 46000.00),
(7, 'Rohit', 'Gupta', 'Finance', 60000.00),
(8, 'Sneha', 'Kapoor', 'Marketing', 50000.00),
(9, 'Vikas', 'Malhotra', 'IT', 75000.00),
(10, 'Pooja', 'Nair', 'HR', 47000.00),
(11, 'Arjun', 'Reddy', 'Finance', 58000.00),
(12, 'Kavita', 'Joshi', 'Marketing', 52000.00),
(13, 'Suresh', 'Kumar', 'IT', 68000.00),
(14, 'Meena', 'Das', 'HR', 44000.00),
(15, 'Nikhil', 'Bansal', 'Finance', 61000.00),
(16, 'Ritu', 'Chopra', 'Marketing', 53000.00),
(17, 'Manish', 'Agarwal', 'IT', 77000.00),
(18, 'Swati', 'Mishra', 'HR', 49000.00),
(19, 'Deepak', 'Saxena', 'Finance', 62000.00),
(20, 'Ayesha', 'Khan', 'Marketing', 54000.00),
(21, 'Sanjay', 'Thakur', 'IT', 80000.00),
(22, 'Komal', 'Arora', 'HR', 45500.00),
(23, 'Abhishek', 'Pandey', 'Finance', 59000.00),
(24, 'Divya', 'Rana', 'Marketing', 51000.00),
(25, 'Harsh', 'Jain', 'IT', 74000.00),
(26, 'Nisha', 'Bhat', 'HR', 46500.00),
(27, 'Rajesh', 'Yadav', 'Finance', 63000.00),
(28, 'Ishita', 'Ghosh', 'Marketing', 55000.00),
(29, 'Alok', 'Srivastava', 'IT', 82000.00),
(30, 'Pallavi', 'Kulkarni', 'HR', 47500.00),
(31, 'Varun', 'Khanna', 'Finance', 64000.00),
(32, 'Tanya', 'Sengupta', 'Marketing', 56000.00),
(33, 'Mohit', 'Singhal', 'IT', 76000.00),
(34, 'Rekha', 'Menon', 'HR', 48500.00),
(35, 'Ashish', 'Choudhary', 'Finance', 65000.00),
(36, 'Rina', 'Paul', 'Marketing', 57000.00),
(37, 'Siddharth', 'Roy', 'IT', 79000.00),
(38, 'Lakshmi', 'Rao', 'HR', 49500.00),
(39, 'Kunal', 'Mathur', 'Finance', 66000.00),
(40, 'Shalini', 'Dutta', 'Marketing', 58000.00),
(41, 'Prakash', 'Naik', 'IT', 83000.00),
(42, 'Sonali', 'Deshpande', 'HR', 50500.00),
(43, 'Ankit', 'Tiwari', 'Finance', 67000.00),
(44, 'Madhuri', 'Bose', 'Marketing', 59000.00),
(45, 'Ramesh', 'Pillai', 'IT', 81000.00),
(46, 'Jyoti', 'Kohli', 'HR', 51500.00),
(47, 'Vivek', 'Sinha', 'Finance', 68000.00),
(48, 'Ankita', 'Mukherjee', 'Marketing', 60000.00),
(49, 'Naveen', 'Shetty', 'IT', 85000.00),
(50, 'Bhavna', 'Tripathi', 'HR', 52500.00);

-- FOR CHECKING
SELECT *
FROM employees;

-- 1. SELECT & WHERE
SELECT
	first_name,
	last_name,
	salary
FROM employees
WHERE
	department = 'Finance';

-- NEW EMPLOYEE TABLE CREATION
CREATE TABLE IF NOT EXISTS employees (
	employee_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	department VARCHAR(50),
	salary DECIMAL(10,2)
);

-- DATASET
INSERT INTO employees (first_name, last_name, department, salary) VALUES
('Amit', 'Sharma', 'HR', 45000.00),
('Neha', 'Verma', 'Finance', 55000.00),
('Rahul', 'Mehta', 'IT', 70000.00),
('Priya', 'Singh', 'Marketing', 48000.00),
('Karan', 'Patel', 'IT', 72000.00),
('Anjali', 'Iyer', 'HR', 46000.00),
('Rohit', 'Gupta', 'Finance', 60000.00),
('Sneha', 'Kapoor', 'Marketing', 50000.00),
('Vikas', 'Malhotra', 'IT', 75000.00),
('Pooja', 'Nair', 'HR', 47000.00),
('Arjun', 'Reddy', 'Finance', 58000.00),
('Kavita', 'Joshi', 'Marketing', 52000.00),
('Suresh', 'Kumar', 'IT', 68000.00),
('Meena', 'Das', 'HR', 44000.00),
('Nikhil', 'Bansal', 'Finance', 61000.00),
('Ritu', 'Chopra', 'Marketing', 53000.00),
('Manish', 'Agarwal', 'IT', 77000.00),
('Swati', 'Mishra', 'HR', 49000.00),
('Deepak', 'Saxena', 'Finance', 62000.00),
('Ayesha', 'Khan', 'Marketing', 54000.00),
('Sanjay', 'Thakur', 'IT', 80000.00),
('Komal', 'Arora', 'HR', 45500.00),
('Abhishek', 'Pandey', 'Finance', 59000.00),
('Divya', 'Rana', 'Marketing', 51000.00),
('Harsh', 'Jain', 'IT', 74000.00),
('Nisha', 'Bhat', 'HR', 46500.00),
('Rajesh', 'Yadav', 'Finance', 63000.00),
('Ishita', 'Ghosh', 'Marketing', 55000.00),
('Alok', 'Srivastava', 'IT', 82000.00),
('Pallavi', 'Kulkarni', 'HR', 47500.00),
('Varun', 'Khanna', 'Finance', 64000.00),
('Tanya', 'Sengupta', 'Marketing', 56000.00),
('Mohit', 'Singhal', 'IT', 76000.00),
('Rekha', 'Menon', 'HR', 48500.00),
('Ashish', 'Choudhary', 'Finance', 65000.00),
('Rina', 'Paul', 'Marketing', 57000.00),
('Siddharth', 'Roy', 'IT', 79000.00),
('Lakshmi', 'Rao', 'HR', 49500.00),
('Kunal', 'Mathur', 'Finance', 66000.00),
('Shalini', 'Dutta', 'Marketing', 58000.00),
('Prakash', 'Naik', 'IT', 83000.00),
('Sonali', 'Deshpande', 'HR', 50500.00),
('Ankit', 'Tiwari', 'Finance', 67000.00),
('Madhuri', 'Bose', 'Marketing', 59000.00),
('Ramesh', 'Pillai', 'IT', 81000.00),
('Jyoti', 'Kohli', 'HR', 51500.00),
('Vivek', 'Sinha', 'Finance', 68000.00),
('Ankita', 'Mukherjee', 'Marketing', 60000.00),
('Naveen', 'Shetty', 'IT', 85000.00),
('Bhavna', 'Tripathi', 'HR', 52500.00);

-- CHECK
SELECT *
FROM employees;

-- 2. inserting new employee
INSERT INTO employees (first_name, last_name, department, salary)
VALUES 
('John', 'Doe', 'HR', 50000);

SELECT *
FROM employees;

DROP TABLE employees;

-- 3. updating salary of IT employees
UPDATE employees
SET
	salary = salary * 1.10
WHERE
	department = 'IT';

SELECT *
FROM employees
WHERE
	department = 'IT';

-- 4. deleting employees of HR department
SELECT *
FROM employees
WHERE
	department = 'HR';

DELETE
FROM employees
WHERE 
	department = 'HR';

-- 5. table creation
CREATE TABLE IF NOT EXISTS products (
	product_id INT PRIMARY KEY,
	product_name VARCHAR(100),
	price DECIMAL(10,2)
);

-- 6. retrieving employees with salaries between 30000 and 60000
SELECT
*
FROM employees
WHERE
	salary BETWEEN 30000 AND 60000;

-- 7. retrieving employees whose salary is not 40000
SELECT
*
FROM employees
WHERE
	salary != 40000;

-- 8. employees with letter a
SELECT
*
FROM employees
WHERE
	first_name LIKE '%a%';

-- 9. check for employees in sales department
-- using EXISTS operator


-- 10. table creation
CREATE TABLE IF NOT EXISTS employee_status (
	employee_id INT PRIMARY KEY,
	first_name VARCHAR(50),
	is_active BOOLEAN -- TRUE if active, FALSE if inactive
);

-- 11. top 5 highest paid
SELECT
*
FROM employees
ORDER BY
	salary DESC
LIMIT 5;

-- 12. calculating total salary for each department
SELECT
	department,
	SUM(salary) AS total_salary
FROM employees
GROUP BY
	department;

-- 13. departments with salary more than 100000
SELECT
	department,
	SUM(salary) AS total_salary
FROM employees
GROUP BY
	department
HAVING
	SUM(salary) > 100000;

-- 14. combining two tables without duplicates
SELECT
*
FROM employees_2023
UNION
SELECT
*
FROM employees_2024;

-- 15. combining two tables keeping duplicates
SELECT
*
FROM employees_2023
UNION ALL
SELECT
*
FROM employees_2024;

-- 16. list of employees from Finance OR IT department
SELECT
*
FROM employees
WHERE
	department IN ('Finance', 'IT');

SELECT
*
FROM employees
WHERE
	department = 'Finance'
	OR
	department = 'IT';

-- 17. calculating average salary across all employees
SELECT
	ROUND(
		AVG(salary),
		0
	) AS avg_salary
FROM employees;

-- 18. employees don't belong to HR department
SELECT
*
FROM employees
WHERE
	department != 'HR';

-- 19. 
SELECT 
	first_name
FROM employees
ORDER BY
	first_name ASC
LIMIT 3;

-- 20.
