
-- FILE 08: إنشاء الجداول النهائية بالـ Data Types الصح


-- 8.1 customer_final
CREATE TABLE customer_final AS
SELECT
    COALESCE(NULLIF(TRIM(customer_key), ''), 'Unknown') AS customer_key,
    CASE WHEN name IS NULL OR TRIM(name) = '' OR UPPER(TRIM(name)) = 'NULL' THEN 'Unknown' 
	ELSE name END AS name,
    CASE WHEN contact_no IS NULL OR TRIM(contact_no)
	= '' OR UPPER(TRIM(contact_no)) = 'NULL' THEN 'Unknown' ELSE contact_no END AS contact_no,
    CASE WHEN nid IS NULL OR TRIM(nid) = '' OR UPPER(TRIM(nid)) = 'NULL' THEN 'Unknown' ELSE nid END AS nid
FROM customer_clean;
SELECT * FROM customer_final LIMIT 5;


-- 8.2 item_final
CREATE TABLE item_final AS
SELECT
    item_key,
    CASE WHEN item_name IS NULL OR TRIM(item_name) = '' OR UPPER(TRIM(item_name)) = 'NULL' THEN 'Unknown' ELSE item_name END AS item_name,
    CASE WHEN description IS NULL OR TRIM(description) = '' OR UPPER(TRIM(description)) = 'NULL' THEN 'Unknown' ELSE description END AS description,
    unit_price::NUMERIC(10,2),
    CASE WHEN man_country IS NULL OR TRIM(man_country) = '' OR UPPER(TRIM(man_country)) = 'NULL' THEN 'Unknown' ELSE man_country END AS man_country,
    CASE WHEN supplier IS NULL OR TRIM(supplier) = '' OR UPPER(TRIM(supplier)) = 'NULL' THEN 'Unknown' ELSE supplier END AS supplier,
    CASE WHEN unit IS NULL OR TRIM(unit) = '' OR UPPER(TRIM(unit)) = 'NULL' THEN 'Unknown' ELSE unit END AS unit,
    CASE WHEN main_category IS NULL OR TRIM(main_category) = '' OR UPPER(TRIM(main_category)) = 'NULL' THEN 'Unknown' ELSE main_category END AS main_category,
    CASE WHEN sub_category IS NULL OR TRIM(sub_category) = '' OR UPPER(TRIM(sub_category)) = 'NULL' THEN 'Unknown' ELSE sub_category END AS sub_category
FROM item_clean;

SELECT * FROM item_final LIMIT 5;


-- 8.3 store_final
CREATE TABLE store_final AS
SELECT
    store_key,
    CASE WHEN division IS NULL OR TRIM(division) = '' OR UPPER(TRIM(division)) = 'NULL' THEN 'Unknown' ELSE division END AS division,
    CASE WHEN district IS NULL OR TRIM(district) = '' OR UPPER(TRIM(district)) = 'NULL' THEN 'Unknown' ELSE district END AS district,
    CASE WHEN upazila IS NULL OR TRIM(upazila) = '' OR UPPER(TRIM(upazila)) = 'NULL' THEN 'Unknown' ELSE upazila END AS upazila
FROM store_clean;

SELECT * FROM store_final LIMIT 5;


-- 8.4 time_final
CREATE TABLE time_final AS
SELECT
    time_key                                             AS time_key,
    TO_TIMESTAMP(date, 'DD/MM/YYYY HH24:MI')::TIMESTAMP AS date,
    hour::SMALLINT                                       AS hour,
    day::SMALLINT                                        AS day,
    week                                                 AS week,
    month::SMALLINT                                      AS month,
    quarter                                              AS quarter,
    year::SMALLINT                                       AS year
FROM time_clean;

SELECT * FROM time_final LIMIT 5;


-- 8.5 trans_final
CREATE TABLE trans_final AS
SELECT
    payment_key,
    CASE WHEN trans_type IS NULL OR TRIM(trans_type) = '' OR UPPER(TRIM(trans_type)) = 'NULL' THEN 'Unknown' ELSE trans_type END AS trans_type,
    CASE WHEN bank_name IS NULL OR TRIM(bank_name) = '' OR UPPER(TRIM(bank_name)) = 'NULL' THEN 'Unknown' ELSE bank_name END AS bank_name
FROM trans_clean;

SELECT * FROM trans_final LIMIT 5;


-- 8.6 fact_table_final
CREATE TABLE fact_table_final AS
SELECT
    payment_key,
    customer_key,
    time_key,
    item_key,
    store_key,
    ROUND(quantity::NUMERIC)::SMALLINT AS quantity,
    CASE WHEN unit IS NULL OR TRIM(unit) = '' OR UPPER(TRIM(unit)) = 'NULL' THEN 'Unknown' ELSE unit END AS unit,
    unit_price::NUMERIC(10,2),
    total_price::NUMERIC(10,2)
FROM fact_table_clean;

SELECT * FROM fact_table_final LIMIT 5;

-- تحقق نهائي من عدد الصفوف
SELECT 
    'customer_final'   AS table_name, COUNT(*) AS rows FROM customer_final   UNION ALL
SELECT 'item_final',                             COUNT(*) FROM item_final     UNION ALL
SELECT 'store_final',                            COUNT(*) FROM store_final    UNION ALL
SELECT 'time_final',                             COUNT(*) FROM time_final     UNION ALL
SELECT 'trans_final',                            COUNT(*) FROM trans_final    UNION ALL
SELECT 'fact_table_final',                       COUNT(*) FROM fact_table_final;




-- customer_final
SELECT customer_key, COUNT(*) AS count FROM customer_final GROUP BY customer_key ORDER BY count DESC;
SELECT name,         COUNT(*) AS count FROM customer_final GROUP BY name         ORDER BY count DESC;
SELECT contact_no,   COUNT(*) AS count FROM customer_final GROUP BY contact_no   ORDER BY count DESC;
SELECT nid,          COUNT(*) AS count FROM customer_final GROUP BY nid          ORDER BY count DESC;


-- item_final
SELECT item_key,      COUNT(*) AS count FROM item_final GROUP BY item_key      ORDER BY count DESC;
SELECT item_name,     COUNT(*) AS count FROM item_final GROUP BY item_name     ORDER BY count DESC;
SELECT description,   COUNT(*) AS count FROM item_final GROUP BY description   ORDER BY count DESC;
SELECT man_country,   COUNT(*) AS count FROM item_final GROUP BY man_country   ORDER BY count DESC;
SELECT supplier,      COUNT(*) AS count FROM item_final GROUP BY supplier      ORDER BY count DESC;
SELECT unit,          COUNT(*) AS count FROM item_final GROUP BY unit          ORDER BY count DESC;
SELECT main_category, COUNT(*) AS count FROM item_final GROUP BY main_category ORDER BY count DESC;
SELECT sub_category,  COUNT(*) AS count FROM item_final GROUP BY sub_category  ORDER BY count DESC;




-- store_final
SELECT store_key, COUNT(*) AS count FROM store_final GROUP BY store_key ORDER BY count DESC;
SELECT division,  COUNT(*) AS count FROM store_final GROUP BY division  ORDER BY count DESC;
SELECT district,  COUNT(*) AS count FROM store_final GROUP BY district  ORDER BY count DESC;
SELECT upazila,   COUNT(*) AS count FROM store_final GROUP BY upazila   ORDER BY count DESC;


-- --------------------
-- time_final
-- --------------------
SELECT time_key, COUNT(*) AS count FROM time_final GROUP BY time_key ORDER BY count DESC;
SELECT week,     COUNT(*) AS count FROM time_final GROUP BY week     ORDER BY count DESC;
SELECT quarter,  COUNT(*) AS count FROM time_final GROUP BY quarter  ORDER BY count DESC;
SELECT hour,     COUNT(*) AS count FROM time_final GROUP BY hour     ORDER BY count DESC;
SELECT day,      COUNT(*) AS count FROM time_final GROUP BY day      ORDER BY count DESC;
SELECT month,    COUNT(*) AS count FROM time_final GROUP BY month    ORDER BY count DESC;
SELECT year,     COUNT(*) AS count FROM time_final GROUP BY year     ORDER BY count DESC;


-- --------------------
-- trans_final
-- --------------------
SELECT payment_key, COUNT(*) AS count FROM trans_final GROUP BY payment_key ORDER BY count DESC;
SELECT trans_type,  COUNT(*) AS count FROM trans_final GROUP BY trans_type  ORDER BY count DESC;
SELECT bank_name,   COUNT(*) AS count FROM trans_final GROUP BY bank_name   ORDER BY count DESC;


-- A. Beverage → Beverage
UPDATE item_final SET main_category = 'Beverage' WHERE main_category LIKE 'A. Beverage%';

-- Beverage Water → Beverage
UPDATE item_final SET main_category = 'Beverage' WHERE main_category = 'Beverage Water';

-- كل Coffee sub → Coffee
UPDATE item_final SET main_category = 'Coffee' 
WHERE main_category LIKE 'Coffee%' 
  AND main_category != 'Coffee';




SELECT 
    MIN(date) AS oldest_date,
    MAX(date) AS newest_date
FROM time_final;

-- ✅ ضيف الكود ده بعد تصحيحات الـ main_category
UPDATE fact_table_final SET unit = 'ct'      WHERE unit = 'ct.';
UPDATE fact_table_final SET unit = 'oz'      WHERE unit = 'oz.';
UPDATE fact_table_final SET unit = 'pack'    WHERE unit = 'pk';
UPDATE fact_table_final SET unit = 'bottles' WHERE unit = 'botlltes';



UPDATE item_final SET unit = 'ct'      WHERE unit = 'ct.';
UPDATE item_final SET unit = 'oz'      WHERE unit = 'oz.';
UPDATE item_final SET unit = 'pack'    WHERE unit = 'pk';
UPDATE item_final SET unit = 'bottles' WHERE unit = 'botlltes';


SELECT year, COUNT(*) AS count
FROM time_final
GROUP BY year
ORDER BY year;