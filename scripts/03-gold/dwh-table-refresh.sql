-- laoding dim_customers

-- print("gold.dim_customers")
BEGIN;
INSERT INTO gold.dim_customers (customer_id, city, country, gender)
SELECT "Customer_ID", "City", "Country", "Gender"
FROM stage.t_gfs_customers
ON CONFLICT (customer_id) 
DO UPDATE SET 
    city = EXCLUDED.city,
    country = EXCLUDED.country,
    gender = EXCLUDED.gender;


--dim_product

INSERT INTO gold.dim_products (product_id, category, sub_category, color, sizes, production_cost)
SELECT "Product_ID", "Category", "Sub_Category", "Color", "Sizes", "Production_Cost"
FROM stage.t_gfs_products
ON CONFLICT (product_id) 
DO UPDATE SET 
    category = EXCLUDED.category,
    sub_category = EXCLUDED.sub_category,
    color = EXCLUDED.color,
    sizes = EXCLUDED.sizes,
    production_cost = EXCLUDED.production_cost;

--dim stores

INSERT INTO gold.dim_stores (store_id, country, city, store_name, number_of_employees, latitude, longitude)
SELECT "Store_ID", "Country", "City", "Store_Name", "Number_of_Employees", "Latitude", "Longitude"
FROM stage.t_gfs_stores
ON CONFLICT (store_id) 
DO UPDATE SET 
    country = EXCLUDED.country,
    city = EXCLUDED.city,
    store_name = EXCLUDED.store_name,
    number_of_employees = EXCLUDED.number_of_employees,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

-- dim employee
INSERT INTO gold.dim_employees (employee_id, store_id, position)
SELECT "Employee_ID", "Store_ID", "Position"
FROM stage.t_gfs_employees
ON CONFLICT (employee_id) 
DO UPDATE SET 
    store_id = EXCLUDED.store_id,
    position = EXCLUDED.position;


-- dim discount

INSERT INTO gold.dim_discounts (discount_id, start_date, end_date, discount, category, sub_category)
SELECT DISTINCT ON ("Start", "End", COALESCE("Category", ''), COALESCE("Sub_Category", '')) 
    abs(mod(('x' || md5(
        CAST("Start" AS TEXT) || CAST("End" AS TEXT) || 
        COALESCE("Category", '') || COALESCE("Sub_Category", '')
    ))::bit(64)::bigint, 2147483647)) AS discount_id,
    "Start", "End", "Discont", "Category", "Sub_Category"
FROM stage.t_gfs_discounts
WHERE "Start" IS NOT NULL AND "End" IS NOT NULL  
ON CONFLICT (discount_id) 
DO UPDATE SET 
    start_date = EXCLUDED.start_date,
    end_date = EXCLUDED.end_date,
    discount = EXCLUDED.discount,
    category = EXCLUDED.category,
    sub_category = EXCLUDED.sub_category;

-- dim date
INSERT INTO gold.dim_date (full_date, year, month, day, quarter)
SELECT DISTINCT 
    "Date", 
    EXTRACT(YEAR FROM "Date"), 
    EXTRACT(MONTH FROM "Date"), 
    EXTRACT(DAY FROM "Date"), 
    EXTRACT(QUARTER FROM "Date")
FROM stage.t_gfs_transactions
ON CONFLICT (full_date) 
DO NOTHING;

-- fct transactions

INSERT INTO gold.fact_transactions (
    invoice_id, 
	line, 
	customer_id, 
	product_id, 
	store_id, 
	employee_id, 
	discount_id,
    size, 
	color, 
	unit_price, 
	quantity, 
	discount, 
	line_total, 
	currency, 
    transaction_type, 
	payment_method, 
	invoice_total, 
	date_id
)
SELECT DISTINCT ON (t."Invoice_ID", t."Line")  -- Ensure unique rows
    t."Invoice_ID", 
	t."Line", 
	t."Customer_ID", 
	p.product_id, 
	t."Store_ID", 
    t."Employee_ID", 
	dsc.discount_id, 
	t."Size", 
	t."Color", 
    t."Unit_Price", 
	t."Quantity", 
	t."Discount", 
	t."Line_Total", 
    t."Currency", 
	t."Transaction_Type", 
	t."Payment_Method", 
    t."Invoice_Total", 
	dt.date_id
FROM stage.t_gfs_transactions t
LEFT JOIN gold.dim_date dt 
    ON dt.full_date = t."Date"
LEFT JOIN gold.dim_products p 
    ON t."Product_ID" = p.product_id
LEFT JOIN gold.dim_discounts dsc 
    ON p.category = dsc.category  
    AND p.sub_category = dsc.sub_category 
    AND t."Discount" = dsc.discount
ON CONFLICT (invoice_id, line) 
DO UPDATE SET 
    customer_id = EXCLUDED.customer_id,
    product_id = EXCLUDED.product_id,
    store_id = EXCLUDED.store_id,
    employee_id = EXCLUDED.employee_id,
    discount_id = EXCLUDED.discount_id,
    size = EXCLUDED.size,
    color = EXCLUDED.color,
    unit_price = EXCLUDED.unit_price,
    quantity = EXCLUDED.quantity,
    discount = EXCLUDED.discount,
    line_total = EXCLUDED.line_total,
    currency = EXCLUDED.currency,
    transaction_type = EXCLUDED.transaction_type,
    payment_method = EXCLUDED.payment_method,
    invoice_total = EXCLUDED.invoice_total,
    date_id = EXCLUDED.date_id;

drop table stage.t_gfs_customers;
drop table stage.t_gfs_discounts;
drop table stage.t_gfs_employees;
drop table stage.t_gfs_products;
drop table stage.t_gfs_stores;
drop table stage.t_gfs_transactions;

commit;


