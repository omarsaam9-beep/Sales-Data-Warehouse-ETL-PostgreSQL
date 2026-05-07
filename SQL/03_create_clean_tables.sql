
-- FILE 03: إنشاء جداول الـ Clean (للتعديل عليها بأمان)

CREATE TABLE customer_clean   AS SELECT * FROM customer;
CREATE TABLE fact_table_clean AS SELECT * FROM fact_table;
CREATE TABLE item_clean       AS SELECT * FROM item;
CREATE TABLE store_clean      AS SELECT * FROM store;
CREATE TABLE time_clean       AS SELECT * FROM time;
CREATE TABLE trans_clean      AS SELECT * FROM trans;
