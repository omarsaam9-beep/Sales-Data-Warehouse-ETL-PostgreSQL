
-- FILE 04: تنظيف البيانات في جداول الـ Clean


-- 4.1 customer_clean

UPDATE customer_clean
SET
    customer_key = TRIM(customer_key),
    name         = INITCAP(TRIM(REGEXP_REPLACE(name, '\s+', ' ', 'g'))),
    contact_no   = NULLIF(TRIM(contact_no), ''),
    nid          = NULLIF(TRIM(nid), '');


-- 4.2 fact_table_clean
UPDATE fact_table_clean
SET
    payment_key  = TRIM(payment_key),
    customer_key = TRIM(customer_key),
    time_key     = TRIM(time_key),
    item_key     = TRIM(item_key),
    store_key    = TRIM(store_key),
    unit         = LOWER(TRIM(unit)),
    quantity     = NULLIF(TRIM(quantity), ''),
    unit_price   = NULLIF(TRIM(unit_price), ''),
    total_price  = NULLIF(TRIM(total_price), '');


-- 4.3 item_clean
UPDATE item_clean
SET
    item_key    = TRIM(item_key),
    item_name   = INITCAP(TRIM(item_name)),
    description = TRIM(description),
    unit_price  = NULLIF(TRIM(unit_price), ''),
    man_country = INITCAP(TRIM(man_country)),
    supplier    = INITCAP(TRIM(supplier)),
    unit        = LOWER(TRIM(unit));


-- 4.4 store_clean
UPDATE store_clean
SET
    store_key = TRIM(store_key),
    division  = INITCAP(TRIM(division)),
    district  = INITCAP(TRIM(district)),
    upazila   = INITCAP(TRIM(upazila));


-- 4.5 time_clean
UPDATE time_clean
SET
    time_key = TRIM(time_key),
    date     = TRIM(date),
    hour     = NULLIF(TRIM(hour), ''),
    day      = NULLIF(TRIM(day), ''),
    week     = TRIM(week),
    month    = NULLIF(TRIM(month), ''),
    quarter  = TRIM(quarter),
    year     = NULLIF(TRIM(year), '');


-- 4.6 trans_clean
UPDATE trans_clean
SET
    payment_key = TRIM(payment_key),
    trans_type  = LOWER(TRIM(trans_type)),
    bank_name   = NULLIF(TRIM(bank_name), 'None');
