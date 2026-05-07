


-- 5.1 customer_clean
SELECT *, ROW_NUMBER() OVER (PARTITION BY customer_key ORDER BY customer_key) AS row_num
FROM customer_clean;

DELETE FROM customer_clean
WHERE ctid NOT IN (
    SELECT MIN(ctid)
    FROM customer_clean
    GROUP BY customer_key
);


-- 5.2 item_clean
SELECT *, ROW_NUMBER() OVER (PARTITION BY item_key ORDER BY item_key) AS row_num
FROM item_clean;

DELETE FROM item_clean
WHERE ctid NOT IN (
    SELECT MIN(ctid)
    FROM item_clean
    GROUP BY item_key
);


-- 5.3 store_clean
SELECT *, ROW_NUMBER() OVER (PARTITION BY store_key ORDER BY store_key) AS row_num
FROM store_clean;

DELETE FROM store_clean
WHERE ctid NOT IN (
    SELECT MIN(ctid)
    FROM store_clean
    GROUP BY store_key
);


-- 5.4 time_clean
SELECT *, ROW_NUMBER() OVER (PARTITION BY time_key ORDER BY time_key) AS row_num
FROM time_clean;

DELETE FROM time_clean
WHERE ctid NOT IN (
    SELECT MIN(ctid)
    FROM time_clean
    GROUP BY time_key
);


-- 5.5 trans_clean
SELECT *, ROW_NUMBER() OVER (PARTITION BY payment_key ORDER BY payment_key) AS row_num
FROM trans_clean;

DELETE FROM trans_clean
WHERE ctid NOT IN (
    SELECT MIN(ctid)
    FROM trans_clean
    GROUP BY payment_key
);
