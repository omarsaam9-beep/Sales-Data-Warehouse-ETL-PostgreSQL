-- SALES PERFORMANCE

SELECT SUM(total_price) AS total_revenue
FROM fact_table_final;

SELECT AVG(total_price) AS avg_order_value
FROM fact_table_final;

SELECT SUM(quantity) AS total_units_sold
FROM fact_table_final;

SELECT 
    t.year,
    t.month,
    SUM(f.total_price) AS monthly_revenue
FROM fact_table_final f
JOIN time_final t ON f.time_key = t.time_key
GROUP BY t.year, t.month
ORDER BY t.year, t.month;

SELECT 
    t.year,
    t.quarter,
    SUM(f.total_price) AS quarterly_revenue
FROM fact_table_final f
JOIN time_final t ON f.time_key = t.time_key
GROUP BY t.year, t.quarter
ORDER BY t.year, t.quarter;


-- 2️⃣ PRODUCT ANALYSIS

-- Top Selling Products (CLEANED)
SELECT 
    i.item_name,
    SUM(f.quantity) AS total_units_sold
FROM fact_table_final f
JOIN item_final i ON f.item_key = i.item_key
WHERE i.item_name <> 'Unknown'
GROUP BY i.item_name
ORDER BY total_units_sold DESC
LIMIT 10;

-- Highest Revenue Products (CLEANED)
SELECT 
    i.item_name,
    SUM(f.total_price) AS total_revenue
FROM fact_table_final f
JOIN item_final i ON f.item_key = i.item_key
WHERE i.item_name <> 'Unknown'
GROUP BY i.item_name
ORDER BY total_revenue DESC
LIMIT 10;

-- Least Moving Products
SELECT 
    i.item_name,
    SUM(f.quantity) AS total_units_sold
FROM fact_table_final f
JOIN item_final i ON f.item_key = i.item_key
WHERE i.item_name <> 'Unknown'
GROUP BY i.item_name
ORDER BY total_units_sold ASC
LIMIT 10;

-- Sales by Manufacturing Country
SELECT 
    i.man_country,
    SUM(f.total_price) AS total_revenue,
    SUM(f.quantity) AS total_units_sold
FROM fact_table_final f
JOIN item_final i ON f.item_key = i.item_key
WHERE i.man_country IS NOT NULL
GROUP BY i.man_country
ORDER BY total_revenue DESC;

-- Sales by Supplier
SELECT 
    i.supplier,
    SUM(f.total_price) AS total_revenue,
    SUM(f.quantity) AS total_units_sold
FROM fact_table_final f
JOIN item_final i ON f.item_key = i.item_key
WHERE i.supplier <> 'Unknown'
GROUP BY i.supplier
ORDER BY total_revenue DESC;


-- 3️⃣ STORE PERFORMANCE

SELECT 
    s.store_key,
    s.division,
    s.district,
    s.upazila,
    SUM(f.total_price) AS total_revenue
FROM fact_table_final f
JOIN store_final s ON f.store_key = s.store_key
GROUP BY s.store_key, s.division, s.district, s.upazila
ORDER BY total_revenue DESC;

SELECT 
    s.division,
    SUM(f.total_price) AS total_revenue,
    SUM(f.quantity) AS total_units_sold,
    COUNT(f.payment_key) AS total_transactions
FROM fact_table_final f
JOIN store_final s ON f.store_key = s.store_key
GROUP BY s.division
ORDER BY total_revenue DESC;

SELECT 
    s.division,
    s.district,
    SUM(f.total_price) AS total_revenue,
    SUM(f.quantity) AS total_units_sold
FROM fact_table_final f
JOIN store_final s ON f.store_key = s.store_key
GROUP BY s.division, s.district
ORDER BY total_revenue DESC;


-- 4️⃣ CUSTOMER INSIGHTS

SELECT COUNT(DISTINCT customer_key) AS total_customers
FROM customer_final;

SELECT COUNT(DISTINCT f.customer_key) AS active_customers
FROM fact_table_final f;

-- Top Customers (CLEANED)
SELECT 
    c.name,
    SUM(f.total_price) AS total_spent,
    COUNT(f.payment_key) AS total_transactions
FROM fact_table_final f
JOIN customer_final c ON f.customer_key = c.customer_key
WHERE c.name <> 'Unknown'
GROUP BY c.name
ORDER BY total_spent DESC
LIMIT 10;

-- Avg Customer Spending
SELECT AVG(customer_total) AS avg_customer_spending
FROM (
    SELECT 
        customer_key,
        SUM(total_price) AS customer_total
    FROM fact_table_final
    GROUP BY customer_key
) sub;

-- Product per Customer (CLEANED)
SELECT 
    c.name,
    i.item_name,
    SUM(f.quantity) AS total_quantity
FROM fact_table_final f
JOIN customer_final c ON f.customer_key = c.customer_key
JOIN item_final i ON f.item_key = i.item_key
WHERE c.name <> 'Unknown'
AND i.item_name <> 'Unknown'
GROUP BY c.name, i.item_name
ORDER BY total_quantity DESC
LIMIT 10;


-- 5️⃣ ADVANCED ANALYTICS

WITH rfm_base AS (
    SELECT 
        f.customer_key,
        c.name,
        MAX(t.date)::DATE AS last_purchase_date,
        COUNT(f.payment_key) AS frequency,
        SUM(f.total_price) AS monetary
    FROM fact_table_final f
    JOIN customer_final c ON f.customer_key = c.customer_key
    JOIN time_final t ON f.time_key = t.time_key
    GROUP BY f.customer_key, c.name
)
SELECT * FROM rfm_base;







WITH rfm_base AS (
    SELECT 
        f.customer_key,
        c.name,
        MAX(t.date)::DATE AS last_purchase_date,
        COUNT(f.payment_key) AS frequency,
        SUM(f.total_price) AS monetary
    FROM fact_table_final f
    JOIN customer_final c ON f.customer_key = c.customer_key
    JOIN time_final t ON f.time_key = t.time_key
    GROUP BY f.customer_key, c.name
),
rfm_scores AS (
    SELECT *,
        NTILE(5) OVER (ORDER BY last_purchase_date DESC) AS r_score,
        NTILE(5) OVER (ORDER BY frequency DESC) AS f_score,
        NTILE(5) OVER (ORDER BY monetary DESC) AS m_score
    FROM rfm_base
)
SELECT 
    customer_key,
    name,
    r_score,
    f_score,
    m_score,
    (r_score + f_score + m_score) AS rfm_total
FROM rfm_scores
ORDER BY rfm_total DESC;



WITH rfm_base AS (
    SELECT 
        f.customer_key,
        c.name,
        MAX(t.date)::DATE AS last_purchase_date,
        COUNT(f.payment_key) AS frequency,
        SUM(f.total_price) AS monetary
    FROM fact_table_final f
    JOIN customer_final c ON f.customer_key = c.customer_key
    JOIN time_final t ON f.time_key = t.time_key
    GROUP BY f.customer_key, c.name
),
rfm_scores AS (
    SELECT *,
        NTILE(5) OVER (ORDER BY last_purchase_date DESC) AS r_score,
        NTILE(5) OVER (ORDER BY frequency DESC) AS f_score,
        NTILE(5) OVER (ORDER BY monetary DESC) AS m_score
    FROM rfm_base
)
SELECT 
    name,
    r_score,
    f_score,
    m_score,
    CASE 
        WHEN r_score >= 4 AND f_score >= 4 AND m_score >= 4 THEN 'Champion'
        WHEN r_score >= 3 AND f_score >= 3 THEN 'Loyal Customer'
        WHEN r_score <= 2 AND f_score >= 3 THEN 'At Risk'
        WHEN r_score <= 2 THEN 'Lost Customer'
        ELSE 'Potential Loyalist'
    END AS segment
FROM rfm_scores;


WITH first_purchase AS (
    SELECT 
        f.customer_key,
        MIN(t.year || '-' || LPAD(t.month::TEXT,2,'0')) AS cohort_month
    FROM fact_table_final f
    JOIN time_final t ON f.time_key = t.time_key
    GROUP BY f.customer_key
),
purchases AS (
    SELECT 
        f.customer_key,
        t.year || '-' || LPAD(t.month::TEXT,2,'0') AS purchase_month
    FROM fact_table_final f
    JOIN time_final t ON f.time_key = t.time_key
),
cohort_data AS (
    SELECT 
        fp.cohort_month,
        p.purchase_month,
        COUNT(DISTINCT p.customer_key) AS active_customers
    FROM first_purchase fp
    JOIN purchases p ON fp.customer_key = p.customer_key
    GROUP BY fp.cohort_month, p.purchase_month
)
SELECT 
    cohort_month,
    purchase_month,
    active_customers
FROM cohort_data
ORDER BY cohort_month, purchase_month;



WITH monthly AS (
    SELECT 
        t.year,
        t.month,
        SUM(f.total_price) AS revenue
    FROM fact_table_final f
    JOIN time_final t ON f.time_key = t.time_key
    GROUP BY t.year, t.month
)
SELECT 
    year,
    month,
    revenue,
    LAG(revenue) OVER (ORDER BY year, month) AS prev_month_revenue,
    ROUND(
        (revenue - LAG(revenue) OVER (ORDER BY year, month)) 
        / LAG(revenue) OVER (ORDER BY year, month) * 100, 2
    ) AS mom_growth_pct
FROM monthly
ORDER BY year, month;   

