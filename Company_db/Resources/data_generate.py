import numpy as np
import pandas as pd
import random
from datetime import datetime, timedelta

random.seed(42)
np.random.seed(42)

# =========================
# CONFIG
# =========================
EMPLOYEES = 20_000
DEPARTMENTS = 50
PROJECTS = 80_000
CUSTOMERS = 50_000
ORDERS = 500_000
PRODUCTS = 5_000

BASE_DATE = datetime(2010, 1, 1)

# =========================
# DEPARTMENTS
# =========================
cities = ["Bangalore", "Hyderabad", "Pune", "Delhi", "Mumbai", "Chennai", "Noida", "Gurgaon"]
city_weights = [0.30, 0.20, 0.15, 0.15, 0.08, 0.07, 0.03, 0.02]

dept_ids = np.random.choice(range(1000, 9999), DEPARTMENTS, replace=False)

departments = pd.DataFrame({
    "dept_id": dept_ids,
    "dept_name": [f"Department_{i}" for i in range(DEPARTMENTS)],
    "location": np.random.choice(cities, p=city_weights, size=DEPARTMENTS),
    "annual_budget": np.random.randint(10_000_000, 100_000_000, DEPARTMENTS)
})

departments.to_csv("departments.csv", index=False)

# =========================
# EMPLOYEES
# =========================
salary_distribution = np.concatenate([
    np.random.randint(30_000, 50_000, int(EMPLOYEES * 0.40)),
    np.random.randint(50_000, 80_000, int(EMPLOYEES * 0.35)),
    np.random.randint(80_000, 120_000, int(EMPLOYEES * 0.20)),
    np.random.randint(120_000, 250_000, EMPLOYEES - int(EMPLOYEES * 0.95))
])
np.random.shuffle(salary_distribution)

employees = pd.DataFrame({
    "emp_id": np.random.choice(range(100000, 999999), EMPLOYEES, replace=False),
    "name": [f"Employee_{i}" for i in range(EMPLOYEES)],
    "dept_id": np.random.choice(dept_ids, EMPLOYEES),
    "salary": salary_distribution,
    "hire_date": BASE_DATE + pd.to_timedelta(np.random.randint(0, 5500, EMPLOYEES), unit="D"),
    "job_level": np.random.choice(["Junior", "Mid", "Senior", "Lead"], p=[0.35, 0.40, 0.20, 0.05], size=EMPLOYEES),
    "performance_rating": np.random.choice([1, 2, 3, 4, 5], p=[0.05, 0.15, 0.40, 0.25, 0.15], size=EMPLOYEES)
})

# NULL names
employees.loc[employees.sample(frac=0.02).index, "name"] = None

# NULL salaries
employees.loc[employees.sample(frac=0.01).index, "salary"] = None

# Salary outliers
employees.loc[employees.sample(frac=0.005).index, "salary"] = np.random.randint(1_000_000, 2_000_000)

# Future hire dates
employees.loc[employees.sample(frac=0.01).index, "hire_date"] = \
    datetime(2030, 1, 1) + pd.to_timedelta(np.random.randint(1, 365), unit="D")

# Job level casing issues
employees["job_level"] = employees["job_level"].replace({
    "Senior": "senior",
    "Lead": "LEAD"
}, regex=True)

employees.to_csv("employees.csv", index=False)

# =========================
# PROJECTS
# =========================
project_budgets = np.concatenate([
    np.random.randint(10_000, 50_000, int(PROJECTS * 0.50)),
    np.random.randint(50_000, 200_000, int(PROJECTS * 0.35)),
    np.random.randint(200_000, 1_200_000, PROJECTS - int(PROJECTS * 0.85))
])
np.random.shuffle(project_budgets)

projects = pd.DataFrame({
    "project_id": np.random.choice(range(1_000_000, 9_999_999), PROJECTS, replace=False),
    "emp_id": np.random.choice(employees["emp_id"], PROJECTS),
    "budget": project_budgets,
    "start_date": datetime(2018, 1, 1) + pd.to_timedelta(np.random.randint(0, 2500, PROJECTS), unit="D"),
    "status": np.random.choice(["Planned", "Active", "Completed"], p=[0.20, 0.50, 0.30], size=PROJECTS)
})

# NULL budgets
projects.loc[projects.sample(frac=0.01).index, "budget"] = None

# Negative budgets
neg_idx = projects.sample(frac=0.005).index
projects.loc[neg_idx, "budget"] = -1 * projects.loc[neg_idx, "budget"].abs()

# Unexpected status
projects.loc[projects.sample(frac=0.03).index, "status"] = "On-Hold"

projects.to_csv("projects.csv", index=False)

# =========================
# PRODUCTS
# =========================
categories = [
    "Electronics", "Clothing", "Furniture", "Books", "Sports",
    "Toys", "Kitchen", "Beauty", "Office", "Gaming",
    "Automotive", "Medical"
]

category_weights = [0.20, 0.15, 0.10, 0.08, 0.10, 0.07, 0.08, 0.05, 0.07, 0.05, 0.03, 0.02]

product_ids = np.random.choice(range(10000, 99999), PRODUCTS, replace=False)

products = pd.DataFrame({
    "product_id": product_ids,
    "product_name": [f"Product_{i}" for i in range(PRODUCTS)],
    "product_category": np.random.choice(categories, p=category_weights, size=PRODUCTS),
    "manufacturing_city": np.random.choice(cities, p=city_weights, size=PRODUCTS),
    "size": np.random.choice(["XS", "S", "M", "L", "XL"], size=PRODUCTS),
    "color": np.random.choice(["Black", "White", "Red", "Blue", "Green", "Yellow"], size=PRODUCTS),
    "sku": np.random.randint(10000000, 99999999, PRODUCTS)
})

# Dirty colors
dirty_idx = products.sample(frac=0.05).index
products.loc[dirty_idx, "color"] = np.random.choice(
    ["Blk", "black", "BLACK", "blu", "?"], size=len(dirty_idx)
)

# Invalid sizes
bad_size_idx = products.sample(frac=0.02).index
products.loc[bad_size_idx, "size"] = np.random.choice(
    ["XXL", "?"], size=len(bad_size_idx)
)

# Duplicate SKUs
dup_idx = products.sample(frac=0.005).index
products.loc[dup_idx, "sku"] = products.loc[dup_idx, "sku"].values

products.to_csv("products.csv", index=False)

# =========================
# CUSTOMERS
# =========================
countries = ["India", "USA", "Germany", "UK", "France", "Canada", "Australia"]
country_weights = [0.40, 0.30, 0.08, 0.07, 0.05, 0.05, 0.05]

customers = pd.DataFrame({
    "customer_id": np.random.choice(range(1_000_000, 9_999_999), CUSTOMERS, replace=False),
    "customer_name": [f"Customer_{i}" for i in range(CUSTOMERS)],
    "country": np.random.choice(countries, p=country_weights, size=CUSTOMERS),
    "signup_date": datetime(2014, 1, 1) + pd.to_timedelta(np.random.randint(0, 4000, CUSTOMERS), unit="D"),
    "customer_tier": np.random.choice(["Bronze", "Silver", "Gold", "Platinum"], p=[0.45, 0.30, 0.20, 0.05], size=CUSTOMERS)
})

# Country casing & whitespace issues
customers["country"] = customers["country"].apply(
    lambda x: f" {x.lower()} " if random.random() < 0.1 else x
)

# NULL signup dates
customers.loc[customers.sample(frac=0.01).index, "signup_date"] = None

# Duplicate-ish names
dup_idx = customers.sample(frac=0.02).index
customers.loc[dup_idx, "customer_name"] = customers.loc[dup_idx, "customer_name"].str.lower()

customers.to_csv("customers.csv", index=False)

# =========================
# ORDERS
# =========================
active_products = product_ids[:-5]  # 5 products with no orders

order_prices = np.concatenate([
    np.random.exponential(scale=30, size=int(ORDERS * 0.70)),
    np.random.exponential(scale=200, size=int(ORDERS * 0.25)),
    np.random.exponential(scale=1000, size=ORDERS - int(ORDERS * 0.95))
])
order_prices = np.round(order_prices, 2)

orders = pd.DataFrame({
    "order_id": np.random.choice(range(10_000_000, 99_999_999), ORDERS, replace=False),
    "product_id": np.random.choice(active_products, ORDERS),
    "customer_id": np.random.choice(customers["customer_id"], ORDERS),
    "price": order_prices,
    "order_date": datetime(2019, 1, 1) + pd.to_timedelta(np.random.randint(0, 2200, ORDERS), unit="D")
})

orders["shipping_date"] = orders["order_date"] + pd.to_timedelta(
    np.random.randint(1, 10, ORDERS), unit="D"
)

# NULL prices
orders.loc[orders.sample(frac=0.01).index, "price"] = None

# Zero / negative prices
orders.loc[orders.sample(frac=0.005).index, "price"] = np.random.choice([0, -10, -50])

# Shipping before order
bad_ship = orders.sample(frac=0.02).index
orders.loc[bad_ship, "shipping_date"] = orders.loc[bad_ship, "order_date"] - pd.to_timedelta(
    np.random.randint(1, 5, len(bad_ship)), unit="D"
)

# NULL order dates
orders.loc[orders.sample(frac=0.005).index, "order_date"] = None

orders.to_csv("orders.csv", index=False)

print("[OK] All CSV files generated successfully.")
