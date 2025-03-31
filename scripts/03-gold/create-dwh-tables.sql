-- dimension Tables

CREATE TABLE gold.dim_customers (
    customer_id INTEGER PRIMARY KEY,
    city TEXT,
    country TEXT,
    gender TEXT
);

CREATE TABLE gold.dim_products (
    product_id INTEGER PRIMARY KEY,
    category TEXT,
    sub_category TEXT,
    color TEXT,
    sizes TEXT,
    production_cost DOUBLE PRECISION
);

CREATE TABLE gold.dim_stores (
    store_id INTEGER PRIMARY KEY,
    country TEXT,
    city TEXT,
    store_name TEXT,
    number_of_employees INTEGER,
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION
);

CREATE TABLE gold.dim_employees (
    employee_id INTEGER PRIMARY KEY,
    store_id INTEGER REFERENCES gold.dim_stores(store_id),
    position TEXT
);

CREATE TABLE gold.dim_discounts (
    discount_id SERIAL PRIMARY KEY,
    start_date DATE,
    end_date DATE,
    discount DOUBLE PRECISION,
    category TEXT,
    sub_category TEXT
);

CREATE TABLE gold.dim_date (
    date_id SERIAL PRIMARY KEY,
    full_date DATE UNIQUE,
    year INTEGER,
    month INTEGER,
    day INTEGER,
    quarter INTEGER
);

-- Fact Table

CREATE TABLE gold.fact_transactions (
    invoice_id TEXT,
    line INTEGER,
    customer_id INTEGER REFERENCES gold.dim_customers(customer_id),
    product_id INTEGER REFERENCES gold.dim_products(product_id),
    store_id INTEGER REFERENCES gold.dim_stores(store_id),
    employee_id INTEGER REFERENCES gold.dim_employees(employee_id),
    discount_id INTEGER REFERENCES gold.dim_discounts(discount_id),
    size TEXT,
    color TEXT,
    unit_price DOUBLE PRECISION,
    quantity INTEGER,
    discount DOUBLE PRECISION,
    line_total DOUBLE PRECISION,
    currency TEXT,
    transaction_type TEXT,
    payment_method TEXT,
    invoice_total DOUBLE PRECISION,
    date_id INTEGER REFERENCES gold.dim_date(date_id),
    PRIMARY KEY (invoice_id, line)
);