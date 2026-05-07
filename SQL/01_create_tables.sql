
-- FILE 01: إنشاء الجداول الأصلية
 
CREATE TABLE customer (
    customer_key  TEXT,
    name          TEXT,
    contact_no    TEXT,
    nid           TEXT
);

CREATE TABLE fact_table (
    payment_key   TEXT,
    customer_key  TEXT,
    time_key      TEXT,
    item_key      TEXT,
    store_key     TEXT,
    quantity      TEXT,
    unit          TEXT,
    unit_price    TEXT,
    total_price   TEXT
);

CREATE TABLE item (
    item_key     TEXT,
    item_name    TEXT,
    description  TEXT,
    unit_price   TEXT,
    man_country  TEXT,
    supplier     TEXT,
    unit         TEXT
);

CREATE TABLE store (
    store_key  TEXT,
    division   TEXT,
    district   TEXT,
    upazila    TEXT
);

CREATE TABLE time (
    time_key  TEXT,
    date      TEXT,
    hour      TEXT,
    day       TEXT,
    week      TEXT,
    month     TEXT,
    quarter   TEXT,
    year      TEXT
);

CREATE TABLE trans (
    payment_key  TEXT,
    trans_type   TEXT,
    bank_name    TEXT
);
