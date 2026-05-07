


-- 6.1 customer_clean
SELECT * 
FROM customer_clean;

SELECT
    COUNT(*)                       AS total_rows,
    COUNT(*) - COUNT(customer_key) AS customer_key_nulls,
    COUNT(*) - COUNT(name)         AS name_nulls,
    COUNT(*) - COUNT(contact_no)   AS contact_no_nulls,
    COUNT(*) - COUNT(nid)          AS nid_nulls
FROM customer_clean;

UPDATE customer_clean 
SET nid = 'Unknown' 
WHERE nid IS NULL;

UPDATE customer_clean 
SET name = 'Unknown' 
WHERE name IS NULL;

UPDATE customer_clean 
SET contact_no = 'Unknown' 
WHERE contact_no IS NULL;


-- 6.2 fact_table_clean


SELECT *
FROM fact_table_clean;

SELECT
    COUNT(*)                       AS total_rows,
    COUNT(*) - COUNT(payment_key)  AS payment_key_nulls,
    COUNT(*) - COUNT(customer_key) AS customer_key_nulls,
    COUNT(*) - COUNT(time_key)     AS time_key_nulls,
    COUNT(*) - COUNT(item_key)     AS item_key_nulls,
    COUNT(*) - COUNT(store_key)    AS store_key_nulls,
    COUNT(*) - COUNT(quantity)     AS quantity_nulls,
    COUNT(*) - COUNT(unit_price)   AS unit_price_nulls,
    COUNT(*) - COUNT(total_price)  AS total_price_nulls
FROM fact_table_clean;

SELECT 
    ROUND(MIN(quantity::numeric))    AS min_quantity,
    ROUND(MAX(quantity::numeric))    AS max_quantity,
    ROUND(AVG(quantity::numeric))    AS avg_quantity, 
    ROUND(MIN(unit_price::numeric))  AS min_unit_price,
    ROUND(MAX(unit_price::numeric))  AS max_unit_price,
    ROUND(AVG(unit_price::numeric))  AS avg_unit_price,
    ROUND(MIN(total_price::numeric)) AS min_total_price,
    ROUND(MAX(total_price::numeric)) AS max_total_price,
    ROUND(AVG(total_price::numeric)) AS avg_total_price
FROM fact_table_clean;

--معالجة أوتلاير quantity بالـ item_key
WITH iqr_calc AS (
    SELECT
        item_key,
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY quantity::numeric) -
        1.5 * (PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY quantity::numeric) -
               PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY quantity::numeric)) AS lower_bound,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY quantity::numeric) +
        1.5 * (PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY quantity::numeric) -
               PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY quantity::numeric)) AS upper_bound
    FROM fact_table_clean
    WHERE quantity IS NOT NULL
    GROUP BY item_key
)
UPDATE fact_table_clean
SET quantity = NULL
FROM iqr_calc
WHERE fact_table_clean.item_key = iqr_calc.item_key
  AND (fact_table_clean.quantity::numeric < iqr_calc.lower_bound
    OR fact_table_clean.quantity::numeric > iqr_calc.upper_bound);

UPDATE fact_table_clean
SET quantity = avg_qty::TEXT
FROM (
    SELECT item_key, ROUND(AVG(quantity::numeric), 2) AS avg_qty
    FROM fact_table_clean
    WHERE quantity IS NOT NULL
    GROUP BY item_key
) AS clean_avg
WHERE fact_table_clean.item_key = clean_avg.item_key
  AND fact_table_clean.quantity IS NULL;


-- 2️⃣ معالجة أوتلاير unit_price بالـ item_key
WITH iqr_calc AS (
    SELECT
        item_key,
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY unit_price::numeric) -
        1.5 * (PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY unit_price::numeric) -
               PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY unit_price::numeric)) AS lower_bound,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY unit_price::numeric) +
        1.5 * (PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY unit_price::numeric) -
               PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY unit_price::numeric)) AS upper_bound
    FROM fact_table_clean
    WHERE unit_price IS NOT NULL
    GROUP BY item_key
)
UPDATE fact_table_clean
SET unit_price = NULL
FROM iqr_calc
WHERE fact_table_clean.item_key = iqr_calc.item_key
  AND (fact_table_clean.unit_price::numeric < iqr_calc.lower_bound
    OR fact_table_clean.unit_price::numeric > iqr_calc.upper_bound);

UPDATE fact_table_clean
SET unit_price = avg_price::TEXT
FROM (
    SELECT item_key, ROUND(AVG(unit_price::numeric), 2) AS avg_price
    FROM fact_table_clean
    WHERE unit_price IS NOT NULL
    GROUP BY item_key
) AS clean_avg
WHERE fact_table_clean.item_key = clean_avg.item_key
  AND fact_table_clean.unit_price IS NULL;


--  3️⃣ تعويض الـ NULL المتبقية بالحساب
UPDATE fact_table_clean 
SET total_price = quantity::numeric * unit_price::numeric
WHERE total_price IS NULL
  AND quantity IS NOT NULL
  AND unit_price IS NOT NULL;

UPDATE fact_table_clean 
SET quantity = total_price::numeric / unit_price::numeric
WHERE quantity IS NULL
  AND total_price IS NOT NULL
  AND unit_price IS NOT NULL;

UPDATE fact_table_clean 
SET unit_price = total_price::numeric / quantity::numeric
WHERE unit_price IS NULL
  AND total_price IS NOT NULL
  AND quantity IS NOT NULL;


-- 4️⃣ إعادة حساب total_price من الأعمدة النظيفة
UPDATE fact_table_clean
SET total_price = (quantity::numeric * unit_price::numeric)::TEXT
WHERE quantity IS NOT NULL
  AND unit_price IS NOT NULL;

-- 6.3 item_clean
SELECT *
FROM item_clean;

SELECT
    COUNT(*)                      AS total_rows,
    COUNT(*) - COUNT(item_key)    AS item_key_nulls,
    COUNT(*) - COUNT(item_name)   AS item_name_nulls,
    COUNT(*) - COUNT(description) AS description_nulls,
    COUNT(*) - COUNT(unit_price)  AS unit_price_nulls,
    COUNT(*) - COUNT(man_country) AS man_country_nulls,
    COUNT(*) - COUNT(supplier)    AS supplier_nulls,
    COUNT(*) - COUNT(unit)        AS unit_nulls
FROM item_clean;

-- تعويض الـ NULL بـ Unknown
UPDATE item_clean
SET item_name = 'Unknown'
WHERE item_name IS NULL;

UPDATE item_clean
SET unit = 'Unknown'
WHERE unit IS NULL;

UPDATE item_clean
SET description = 'Unknown'
WHERE description IS NULL;

--  1️⃣ أضف الأعمدة الجديدة الأول
ALTER TABLE item_clean
ADD COLUMN main_category TEXT,
ADD COLUMN sub_category  TEXT;

--  2️⃣ عبّي الأعمدة من الـ description
UPDATE item_clean
SET
    main_category = INITCAP(TRIM(SPLIT_PART(description, '-', 1))),
    sub_category  = INITCAP(TRIM(SPLIT_PART(description, '-', 2)));

SELECT description, COUNT(*) AS count_description 
FROM item_clean 
GROUP BY description 
ORDER BY description;

SELECT 
    ROUND(MIN(unit_price::numeric)) AS min_unit_price,
    ROUND(MAX(unit_price::numeric)) AS max_unit_price,
    ROUND(AVG(unit_price::numeric)) AS avg_unit_price 
FROM item_clean;

-- 3️⃣ عالج الأوتلاير بالـ IQR بعد ما main_category اتعمل
WITH iqr_calc AS (
    SELECT
        main_category,
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY unit_price::numeric) -
        1.5 * (PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY unit_price::numeric) -
               PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY unit_price::numeric)) AS lower_bound,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY unit_price::numeric) +
        1.5 * (PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY unit_price::numeric) -
               PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY unit_price::numeric)) AS upper_bound
    FROM item_clean
    WHERE unit_price IS NOT NULL
    GROUP BY main_category
)
UPDATE item_clean
SET unit_price = NULL
FROM iqr_calc
WHERE item_clean.main_category = iqr_calc.main_category
  AND (item_clean.unit_price::numeric < iqr_calc.lower_bound
   OR  item_clean.unit_price::numeric > iqr_calc.upper_bound);

-- 4️⃣ عوّض كل الـ NULL بمتوسط الـ main_category النظيف
UPDATE item_clean
SET unit_price = avg_price::TEXT
FROM (
    SELECT main_category, 
           ROUND(AVG(unit_price::numeric), 2) AS avg_price
    FROM item_clean
    WHERE unit_price IS NOT NULL
    GROUP BY main_category
) AS clean_avg
WHERE item_clean.main_category = clean_avg.main_category
  AND item_clean.unit_price IS NULL;


-- 6.4 store_clean
SELECT
    COUNT(*)                      AS total_rows,
    COUNT(*) - COUNT(store_key)   AS store_key_nulls,
    COUNT(*) - COUNT(division)    AS division_nulls,
    COUNT(*) - COUNT(district)    AS district_nulls,
    COUNT(*) - COUNT(upazila)     AS upazila_nulls
FROM store_clean;

SELECT division, COUNT(*) AS count_division 
FROM store_clean 
GROUP BY division 
ORDER BY division;

SELECT district, COUNT(*) AS count_district 
FROM store_clean 
GROUP BY district 
ORDER BY district;

SELECT upazila, COUNT(*) AS count_upazila
FROM store_clean 
GROUP BY upazila 
ORDER BY upazila;


-- 6.5 time_clean
SELECT *
FROM time_clean;

SELECT
    COUNT(*)                      AS total_rows,
    COUNT(*) - COUNT(time_key)    AS time_key_nulls,
    COUNT(*) - COUNT(date)        AS date_nulls,
    COUNT(*) - COUNT(hour)        AS hour_nulls,
    COUNT(*) - COUNT(day)         AS day_nulls,
    COUNT(*) - COUNT(week)        AS week_nulls,
    COUNT(*) - COUNT(month)       AS month_nulls,
    COUNT(*) - COUNT(quarter)     AS quarter_nulls,
    COUNT(*) - COUNT(year)        AS year_nulls
FROM time_clean;

-- الخطوة 1: امسح كل الأعمدة وسيبها فاضية
UPDATE time_clean
SET
    hour    = NULL,
    day     = NULL,
    week    = NULL,
    month   = NULL,
    quarter = NULL,
    year    = NULL;

-- الخطوة 2: ابنيهم من الـ date من الأول
UPDATE time_clean
SET
    hour    = EXTRACT(HOUR    FROM TO_TIMESTAMP(date, 'DD/MM/YYYY HH24:MI'))::TEXT,
    day     = EXTRACT(DAY     FROM TO_TIMESTAMP(date, 'DD/MM/YYYY HH24:MI'))::TEXT,
    month   = EXTRACT(MONTH   FROM TO_TIMESTAMP(date, 'DD/MM/YYYY HH24:MI'))::TEXT,
    quarter = 'Q' || EXTRACT(QUARTER FROM TO_TIMESTAMP(date, 'DD/MM/YYYY HH24:MI'))::TEXT,
    year    = EXTRACT(YEAR    FROM TO_TIMESTAMP(date, 'DD/MM/YYYY HH24:MI'))::TEXT,
    week    = CASE EXTRACT(WEEK FROM TO_TIMESTAMP(date, 'DD/MM/YYYY HH24:MI'))::INT % 4
                WHEN 1 THEN '1st Week'
                WHEN 2 THEN '2nd Week'
                WHEN 3 THEN '3rd Week'
                WHEN 0 THEN '4th Week'
              END;


-- 6.6 trans_clean
SELECT
    COUNT(*)                       AS total_rows,
    COUNT(*) - COUNT(payment_key)  AS payment_key_nulls,
    COUNT(*) - COUNT(trans_type)   AS trans_type_nulls,
    COUNT(*) - COUNT(bank_name)    AS bank_name_nulls
FROM trans_clean;

UPDATE trans_clean
SET bank_name = 'Unknown'
WHERE bank_name IS NULL;

SELECT trans_type, COUNT(*) AS count_trans_type
FROM trans_clean 
GROUP BY trans_type 
ORDER BY trans_type;

SELECT bank_name, COUNT(*) AS count_bank_name
FROM trans_clean 
GROUP BY bank_name 
ORDER BY bank_name;
