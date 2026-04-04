-- 🗄️ DATASET (Use this for ALL questions)

-- We’ll simulate a --small e-commerce system--



-- 🧩 1. Customers


CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);


INSERT INTO customers VALUES
(1, 'Alice', 'Mumbai'),
(2, 'Bob', 'Delhi'),
(3, 'Charlie', 'Mumbai'),
(4, 'David', 'Bangalore'),
(5, 'Eva', 'Delhi');



-- 🧩 2. Orders

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    amount INT
);


INSERT INTO orders VALUES
(101, 1, '2023-01-10', 2000),
(102, 1, '2023-02-15', 3000),
(103, 2, '2023-01-12', 7000),
(104, 3, '2023-03-05', 1500),
(105, 4, '2023-03-20', 9000),
(106, 5, '2023-04-01', 4000),
(107, 2, '2023-04-15', 2000),
(108, 3, '2023-05-01', 3500),
(109, 1, '2023-05-10', 2500);



-- 🧩 3. Products

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50),
    price INT
);


INSERT INTO products VALUES
(1, 'Laptop', 'Electronics', 50000),
(2, 'Phone', 'Electronics', 20000),
(3, 'Shirt', 'Clothing', 2000),
(4, 'Shoes', 'Clothing', 3000);



-- 🧩 4. Order_Items

CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT
);


INSERT INTO order_items VALUES
(101, 1, 1),
(102, 2, 1),
(103, 1, 1),
(104, 3, 2),
(105, 1, 1),
(106, 4, 1),
(107, 2, 2),
(108, 3, 1),
(109, 4, 2);



-- 🧩 5. Employees

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary INT
);


INSERT INTO employees VALUES
(1, 'John', 'HR', 50000),
(2, 'Jane', 'IT', 80000),
(3, 'Mark', 'IT', 75000),
(4, 'Sara', 'HR', 60000),
(5, 'Paul', 'Finance', 90000);



-- 🧩 6. Events (for funnel)

CREATE TABLE events (
    user_id INT,
    event VARCHAR(50),
    event_time DATE
);


INSERT INTO events VALUES
(1, 'signup', '2023-01-01'),
(1, 'purchase', '2023-01-03'),
(2, 'signup', '2023-01-05'),
(2, 'add_to_cart', '2023-01-06'),
(2, 'purchase', '2023-01-10'),
(3, 'signup', '2023-01-07');



-- ✅ QUESTION MAPPING (What YOU can solve)


-- 🟢 START NOW (Based on your level)

-- These require:

-- Aggregation
-- Basic joins (light)
-- Simple logic

👉 DO THESE FIRST:

--✔️ Q1–Q5 (Aggregation)
--✔️ Q6 (Top 5 customers)
--✔️ Q11 (Top cities)
--✔️ Q16 (Above avg salary)
--✔️ Q19 (Dept avg > company avg)
--✔️ Q24 (Signup + purchase)



-- 🟡 NEXT LEVEL (Stretch zone)

-- These require:

-- Joins + GROUP BY
-- Slight CTE chaining

-- 👉 Try after above:

--✔️ Q7 (Top per department)
--✔️ Q12 (Top customer per city)
--✔️ Q18 (City-wise comparison)
--✔️ Q25 (Funnel)
--✔️ Q28 (Revenue contribution)



-- 🔴 HARD (Window functions heavy)

-- These will build your weak area (VERY IMPORTANT)

-- 👉 Do these slowly:

--⚠️ Q8 (Lowest per category)
--⚠️ Q9 (2nd highest salary)
--⚠️ Q10 (Rank range)
--⚠️ Q13 (Top product per category)
--⚠️ Q21–Q23 (Dedup)
--⚠️ Q30 (Month-over-month growth)


-- ☠️ VERY HARD (Interview level)

-- 👉 Attempt LAST:

--🔥 Q26 (Purchase within 7 days)
--🔥 Q27 (Consecutive login)
--🔥 Q29 (Latest vs avg)
--🔥 Q30 (Trend analysis)


-- 🧠 How to Use This (IMPORTANT)

-- Step-by-step:

-- 1. Pick a ✔️ question
-- 2. Write logic in English
-- 3. Break into steps
-- 4. Convert → CTE
-- 5. Then code
