-- 1. table creation
CREATE TABLE countries (
	country_id VARCHAR(2) DEFAULT NULL,
	country_name VARCHAR(50) DEFAULT NULL,
	region_id DECIMAL(10,0) DEFAULT NULL
);

DROP TABLE countries;

-- 2. table creation if not exists
CREATE TABLE IF NOT EXISTS countries (
	country_id VARCHAR(2) DEFAULT NULL,
	country_name VARCHAR(50) DEFAULT NULL,
	region_id DECIMAL(10,0) DEFAULT NULL
);

-- 3. copy table structure
CREATE TABLE IF NOT EXISTS dup_countries
(LIKE countries);

DROP TABLE dup_countries;

-- 4. copy table structure and data
CREATE TABLE IF NOT EXISTS dup_countries AS
SELECT *
FROM countries;

-- 5. table creation with constraint
CREATE TABLE IF NOT EXISTS countries (
	country_id VARCHAR(2) NOT NULL,
	country_name VARCHAR(50) NOT NULL,
	region_id DECIMAL(10,0) NOT NULL
);

-- 6. table creation with many more constraints
CREATE TABLE IF NOT EXISTS jobs (
	job_id VARCHAR(10) NOT NULL,
	job_title VARCHAR(50) NOT NULL,
	min_salary NUMERIC(6,2),
	max_salary NUMERIC(6,2) CHECK(max_salary <= 25000)
);

DROP TABLE jobs;

-- 7. table creation with many contraints
CREATE TABLE IF NOT EXISTS countries (
	country_id VARCHAR(2),
	country_name VARCHAR(50) CHECK(country_name IN('Italy', 'India', 'China')),
	region_id DECIMAL(10,0)
);

-- 8. table creation with check contraints
CREATE TABLE job_history (
	employee_id DECIMAL(6,0) NOT NULL,
	start_date DATE NOT NULL,
	end_date VARCHAR(10) NOT NULL CHECK(end_date LIKE '__/__/____'),
	job_id VARCHAR(10) NOT NULL,
	department_id DECIMAL(4,0) NOT NULL
);
-- LIKE only works on character data and not on DATE

-- 9.
CREATE TABLE IF NOT EXISTS countries (
	country_id VARCHAR(2) NOT NULL,
	country_name VARCHAR(50) NOT NULL,
	region_id DECIMAL(10,0) NOT NULL,
	UNIQUE(country_id)
);

-- 10. table creation with defaults
CREATE TABLE IF NOT EXISTS jobs (
	job_id VARCHAR(10) PRIMARY KEY,
	job_title VARCHAR(50) NOT NULL DEFAULT ' ',
	min_salary NUMERIC(6,2) DEFAULT 8000,
	max_salary NUMERIC(6,2) DEFAULT NULL
);

-- 11. table creation and primary key
CREATE TABLE IF NOT EXISTS countries (
	country_id VARCHAR(2) PRIMARY KEY,
	country_name VARCHAR(50) NOT NULL,
	region_id DECIMAL(10,0) NOT NULL
);

-- 12. table creation and auto incremented value
CREATE TABLE IF NOT EXISTS countries(
	country_id VARCHAR(2) PRIMARY KEY,
	country_name VARCHAR(50) NOT NULL,
	region_id DECIMAL(10,0) NOT NULL
);

-- 13. 
CREATE TABLE IF NOT EXISTS countries (
	country_id VARCHAR(2) NOT NULL,
	country_name VARCHAR(50) DEFAULT NULL,
	region_id DECIMAL(10,0) NOT NULL,
	PRIMARY KEY(country_id, region_id)
);

-- 14.
CREATE TABLE IF NOT EXISTS job_history (
	employee_id DECIMAL(6,0) PRIMARY KEY,
	start_date DATE NOT NULL,
	end_date DATE NOT NULL,
	job_id VARCHAR(10) NOT NULL,
	department_id DECIMAL(4,0) DEFAULT NULL,
	FOREIGN KEY (job_id) REFERENCES jobs(job_id)
);

-- 15.
CREATE TABLE IF NOT EXISTS employees (
	employee_id DECIMAL(6,0) PRIMARY KEY,
	first_name VARCHAR(50) DEFAULT NULL,
	last_name VARCHAR(50) NOT NULL,
	email VARCHAR(75) NOT NULL,
	phone_number VARCHAR(10) DEFAULT NULL,
	hire_date DATE NOT NULL,
	job_id VARCHAR(10) NOT NULL,
	salary NUMERIC(8,2) DEFAULT NULL,
	commission_pct DECIMAL(2,2) DEFAULT NULL,
	manager_id DECIMAL(6,0) DEFAULT NULL,
	department_id DECIMAL(4,0) DEFAULT NULL,
	FOREIGN KEY (department_id, manager_id) REFERENCES departments(department_id, manager_id)
);