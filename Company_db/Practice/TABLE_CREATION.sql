CREATE TABLE departments (
	dept_id INT PRIMARY KEY,
	dept_name VARCHAR(50) NOT NULL,
	location VARCHAR(50) DEFAULT NULL,
	annual_budget BIGINT DEFAULT NULL
);

CREATE TABLE employees (
	emp_id INT PRIMARY KEY,
	name VARCHAR(50) DEFAULT NULL,
	dept_id INT NOT NULL,
	salary NUMERIC(12,2) DEFAULT NULL,
	hire_date DATE NOT NULL,
	job_level VARCHAR(50) DEFAULT NULL,
	performance_rating INT CHECK (performance_rating BETWEEN 1 AND 5) DEFAULT NULL,
	FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

CREATE TABLE projects (
	project_id BIGINT PRIMARY KEY,
	emp_id INT NOT NULL,
	budget NUMERIC(12,2) DEFAULT NULL,
	start_date DATE DEFAULT NULL,
	status VARCHAR(50) DEFAULT NULL,
	FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

CREATE TABLE products (
	product_id INT PRIMARY KEY,
	product_name VARCHAR(50) NOT NULL,
	product_category VARCHAR(50) DEFAULT NULL,
	manufacturing_city VARCHAR(50) DEFAULT NULL,
	size VARCHAR(5) NOT NULL,
	color VARCHAR(25) DEFAULT NULL,
	sku BIGINT DEFAULT NULL
);

CREATE TABLE customers (
	customer_id BIGINT PRIMARY KEY,
	customer_name VARCHAR(50) DEFAULT NULL,
	country VARCHAR(25) DEFAULT NULL,
	signup_date DATE DEFAULT NULL,
	customer_tier VARCHAR(25) CHECK (customer_tier IN ('Bronze', 'Silver', 'Gold', 'Platinum'))
);

CREATE TABLE orders (
	order_id BIGINT PRIMARY KEY,
	product_id INT NOT NULL,
	customer_id BIGINT NOT NULL,
	price NUMERIC DEFAULT NULL,
	order_date DATE DEFAULT NULL,
	shipping_date DATE DEFAULT NULL,
	FOREIGN KEY (product_id) REFERENCES products(product_id),
	FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
