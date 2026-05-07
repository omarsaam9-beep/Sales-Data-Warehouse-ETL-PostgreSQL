
-- FILE 02: إنشاء جداول الـ Backup (نسخة احتياطية من الأصلية)

CREATE TABLE customer_backup   AS SELECT * FROM customer;
CREATE TABLE fact_table_backup AS SELECT * FROM fact_table;
CREATE TABLE item_backup       AS SELECT * FROM item;
CREATE TABLE store_backup      AS SELECT * FROM store;
CREATE TABLE time_backup       AS SELECT * FROM time;
CREATE TABLE trans_backup      AS SELECT * FROM trans;
