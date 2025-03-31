Table dim_customers {
  customer_id integer [primary key]
  city text
  country text
  gender text
}

Table dim_date {
    date_id integer [primary key]
    full_date date
    year integer
    month integer
    day integer
    quarter integer
}

Table dim_discount {
    discount_id integer [primary key]
    start_date date
    end_date date
    discount double
    category text
    sub_category text
}

Table dim_employees {
  employee_id integer [primary key]
  store_id integer
  position text
}

Table dim_product {
    product_id integer [primary key]
    category text
    sub_category text
    color text
    sizes text
    production_cost double
}

Table dim_stores {
    store_id integer [primary key]
    country text
    city text
    store_name text
    number_of_employees integer
    latitude double
    longitude double
}

Table fact_transactions {
    invoice_id text
    line integer
    customer_id integer [ref: - dim_customers.customer_id]
    product_id integer [ref: - dim_product.product_id]
    store_id integer [ref: - dim_stores.store_id]
    employee_id integer [ref: - dim_employees.employee_id]
    discount_id integer [ref: - dim_discount.discount_id]
    size text
    color text
    unit_price double
    quantity integer
    discount double
    line_total double
    currency text
    transaction_type text
    payment_method text
    invoice_total double
    date_id integer [ref: - dim_date.date_id]
}