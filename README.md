Retail Sales Data Warehouse | End-to-End ETL Pipeline
Engineering Lead: Omar Essam

---

Tech Stack
- Database: PostgreSQL
- Language: SQL (Advanced: CTEs, Window Functions, Pattern Matching)
- Architecture: Data Modeling (Star Schema Design)
- Core Skills: ETL Pipeline Design, Data Cleaning, & Transformation
- Analytics: Business Intelligence Concepts (RFM, Cohort Analysis)

---

Project Overview
This project demonstrates a complete Data Engineering lifecycle, transforming raw and inconsistent retail data into a structured PostgreSQL Data Warehouse.

The pipeline follows a full **ETL approach**, resulting in a clean **Star Schema** optimized for analytical queries, KPI reporting, and advanced business insights.

---

Architecture Flow

```text
Raw Data
   ↓
Data Cleaning
   ↓
Standardization
   ↓
Star Schema Modeling
   ↓
Analytics Layer
   ↓
Business Insights
```

---

Phase 1: Data Auditing & Cleaning
The goal of this phase was to ensure data reliability and consistency before modeling.

---

1.1 Initial Profiling & Identification
Defined the core schema by creating raw staging tables: `customer`, `fact_table`, `item`, `store`, `time`, and `trans` — each with TEXT-typed columns to ingest data as-is before any transformation.

<p align="center">
<img src="image/01_Initial_Data_Check.png.PNG" width="900">
</p>

---

1.2 Handling Missing Data
Created clean staging copies of all source tables using `CREATE TABLE ... AS SELECT * FROM`, preserving the full dataset structure as a base for transformation in subsequent steps.

<p align="center">
<img src="image/02_Handling_Missing_Values.png.PNG" width="900">
</p>

---

1.3 Data Standardization
Applied `TRIM`, `INITCAP`, and `REGEXP_REPLACE` to normalize text fields across all clean tables. Used `NULLIF` to convert empty strings to NULL, ensuring consistent and query-ready data.

<p align="center">
<img src="image/03_Data_Standardization.png.PNG" width="900">
</p>

---

1.4 Duplicate Removal
Leveraged the PostgreSQL `ctid` system column with `ROW_NUMBER()` to identify and delete duplicate records, keeping only the first occurrence per key — applied across `customer_clean` and `item_clean`.

<p align="center">
<img src="image/04_Removing_Duplicates.png.PNG" width="900">
</p>

---

1.5 Data Profiling & Null Value Management
In this phase, a comprehensive audit was performed on the numeric and text columns within the item_clean and fact_table_clean tables to identify data quality gaps.

Key Operations Performed:

Data Profiling: Utilized the COUNT function to compare total rows against non-null entries for columns like item_key, item_name, and description to calculate exact null counts.

Handling Missing Data: Executed an UPDATE statement to replace critical missing values in the item_name column with the placeholder 'Unknown'.

<p align="center">
<img src="image/05_Outlier_Detection_Method.png.PNG" width="900">
</p>

Data Quality Profiling: Using COUNT(*) minus COUNT(column_name) to identify the exact volume of missing values (NULLs) across multiple dimensions like item_key, item_name, and description.

Missing Value Strategy: Executing an UPDATE command to replace NULLs in critical descriptive fields with a standard 'Unknown' placeholder.

Statistical Foundation: Calculating MIN, MAX, and AVG for numeric columns to establish the baseline needed for IQR (Interquartile Range) outlier detection.
<p align="center">
<img src="image/06_IQR_Filtering_Results.png.PNG" width="900">
</p>



Phase 2: Data Modeling (Star Schema)
Building a scalable analytical environment using a Star Schema architecture.

2.1 Table Creation & Optimization
Transitioning from staging tables to final tables while optimizing data types for faster query execution.

Key Data Operations:

Outlier Neutralization: Replaced extreme outlier values in the quantity column using IQR (Interquartile Range) bounds calculated via Common Table Expressions (CTEs).

Missing Value Imputation: Filled NULL quantities with per-item average values to ensure completeness without distorting overall trends.

Schema Finalization: Cleaned and validated the fact_table_clean before promoting it to the core Star Schema layer.

<p align="center">
<img src="image/07_Creating_Final_Tables.png.PNG" width="900">
</p>

---

1.6 Data Quality Audit (Null Check)
Data Quality Auditing: You are performing a "Null Check" on the time_clean table. This query calculates the total row count and the number of missing values across all time-related columns (such as date, hour, and year) to verify data integrity before final transformation.

<p align="center">
<img src="image/08_Schema_Architecture_Overview.png.PNG" width="900">
</p>

Initial Schema Setup: You are establishing the base database structure by creating primary tables such as customer, fact_table, and item. All columns are initially defined as TEXT to allow for flexible data ingestion without type-mismatch errors.

Data Standardization: During the cleaning phase, you are refining the customer_clean table using TRIM to remove extra spaces, INITCAP to standardize name casing, and NULLIF to convert empty strings into proper NULL values.

Data Quality Auditing: You are performing a comprehensive "Null Check" on the time_clean table to calculate total rows and identify missing values across time-related columns like hour, day, and year.

Temporal Feature Engineering: You are rebuilding time features by extracting the hour, day, month, and year from the raw date string. Additionally, you are using a CASE statement to categorize dates into specific weeks of the month. 


<p align="center">
<img src="image/09_Primary_Foreign_Keys_Setup.png.PNG" width="900">
</p>

---

Phase 3: Business Intelligence & Advanced Analytics
Transforming the cleaned data into high-value executive insights.

---

3.1 Schema Integrity & Star Schema Finalization
Final Fact Table Creation: You are generating the fact_table_final by selecting data from the cleaned version of the fact table (fact_table_clean).

Data Type Casting: To optimize the database for analysis, you are converting columns from TEXT to their appropriate technical formats:

Quantity: Rounded and cast to SMALLINT for efficient storage.

Pricing: Both unit_price and total_price are cast to NUMERIC(10,2) to ensure precision for financial calculations. 

<p align="center">
<img src="image/10_Cohort_Analysis_Query.png.PNG" width="900">
</p>

---

3.2 Sales Performance KPIs
Calculated core sales metrics from `fact_table_final`: total revenue via `SUM(total_price)`, average order value via `AVG(total_price)`, and total units sold via `SUM(quantity)`.
Business Impact: Established the monetary baseline for evaluating customer value and product performance.

<p align="center">
<img src="image/13_Customer_Segmentation_RFM.png.PNG" width="900">
</p>

---

3.3 Financial & Growth KPIs
Initial Schema Setup: You are establishing the base database structure by creating primary tables such as customer, fact_table, and item. All columns are initially defined as TEXT to allow for flexible data ingestion without type-mismatch errors.

Data Standardization: During the cleaning phase, you are refining the customer_clean table using TRIM to remove extra spaces, INITCAP to standardize name casing, and NULLIF to convert empty strings into proper NULL values.

Data Quality Auditing: You are performing a comprehensive "Null Check" on the time_clean table to calculate total rows and identify missing values across time-related columns like hour, day, and year.

Temporal Feature Engineering: You are rebuilding time features by extracting the hour, day, month, and year from the raw date string. Additionally, you are using a CASE statement to categorize dates into specific weeks of the month.

Final Fact Table Creation: You are generating the fact_table_final by selecting data from the cleaned version of the fact table (fact_table_clean).

Data Type Casting: To optimize the database for analysis, you are converting columns from TEXT to their appropriate technical formats:

Quantity: Rounded and cast to SMALLINT for efficient storage.

Pricing: Both unit_price and total_price are cast to NUMERIC(10,2) to ensure precision for financial calculations.

<p align="center">
<img src="image/11_Monthly_Revenue_Trends.png.PNG" width="900">
</p>
The Core Operation
SUM(f.quantity): The script calculates the total number of units sold for each specific item.

JOIN item_final i: It connects the sales records (fact_table_final) to the product details table so it can retrieve the actual names of the items (item_name) instead of just ID numbers.

2. Data Cleaning
WHERE i.item_name <> 'Unknown': This is a crucial cleaning step. It filters out any records where the item name is labeled as "Unknown," ensuring the final report only contains valid, identifiable products.

3. Ranking and Limitation
GROUP BY i.item_name: This aggregates the sales data so that every product appears as a single row with its total sales volume.

ORDER BY total_units_sold DESC: It sorts the list from the highest sales to the lowest.

LIMIT 10: This restricts the output to only the top 10 results.

<p align="center">
<img src="image/14_Sales_Growth_KPIs.png.PNG" width="900">
</p>

---


Defining Primary Keys (The Blue Section)
Goal: To uniquely identify every row in your dimension tables.

Action: It sets columns like customer_key, item_key, and store_key as Primary Keys.

Effect: This ensures that you don't have duplicate records for the same customer or product, and it significantly speeds up data retrieval (searching).

2. Defining Foreign Keys (The Bottom Section)
Goal: To create a formal link between your "Fact Table" (where the sales happen) and your "Dimension Tables" (where the details live).

Action: It adds Foreign Key constraints to the fact_table_final. For example:

The customer_key in the Fact Table must exist in the customer_final table.

The item_key in the Fact Table must exist in the item_final table.

Relationship: This creates the "Star" in your Star Schema, where the Fact Table sits in the center, connected to all the descriptive dimensions (Customer, Item, Store, Time, Trans)

<p align="center">
<img src="image/12_Top_Performing_Products.png.PNG" width="900">
</p>

This SQL code is designed to perform a Time-Series Analysis to calculate monthly revenue and the Month-over-Month (MoM) Growth Percentage.Here is a breakdown of the code in English:1. The CTE (Common Table Expression): monthlyThe code starts with WITH monthly AS (...). This creates a temporary result set that organizes the raw data.Purpose: It joins the fact table (fact_table_final) with a time dimension table (time_final).Aggregation: It uses SUM(f.total_price) to calculate the total revenue for every unique combination of Year and Month.2. The Main Query: Analytical FunctionsThe second part of the code performs the actual "intelligence" using Window Functions:LAG(revenue): This function looks at the "previous row" in the sequence. It fetches the revenue from the preceding month so you can compare it to the current month. In the output, this is labeled as prev_month_revenue.Growth Calculation: It uses the standard growth formula:$$\text{Growth \%} = \frac{\text{Current Month} - \text{Previous Month}}{\text{Previous Month}} \times 100$$ROUND(..., 2): This ensures the resulting percentage is clean and easy to read by limiting it to two decimal places.3. Data Output AnalysisLooking at the results table in your screenshot:Row 1: The prev_month_revenue is [null] because there is no data prior to January 2014 to compare it to.Row 2 (February): You can see a massive spike. The revenue jumped from ~$496k to ~$1.12M, resulting in a 126.07% growth.Negative Growth: In April (Row 4)

<p align="center">
<img src="image/15_Quarterly_Performance_Report.png.PNG" width="900">
</p>

---

This SQL code is a classic example of **Cohort Analysis**. Its goal is to group customers based on when they made their first purchase (their "cohort") and then track how many of those customers returned to make purchases in subsequent months.

Here is the step-by-step breakdown:

### 1. The First CTE: `first_purchase`
* **Goal:** To find the "birth date" of each customer.
* **Logic:** It looks for the minimum (`MIN`) date associated with each `customer_key`.
* **Formatting:** It uses `LPAD` and string concatenation to create a standardized `YYYY-MM` format (e.g., "2014-01"). This establishes the **Cohort Month**.

### 2. The Second CTE: `purchases`
* **Goal:** To list every single month that every customer made a purchase.
* **Logic:** Unlike the first part, this doesn't look for the minimum; it simply maps every transaction to its specific `purchase_month` in the same `YYYY-MM` format.

### 3. The Third CTE: `cohort_data`
* **Goal:** To link the "birth month" to all "activity months."
* **Logic:**
    * It joins the two previous tables on `customer_key`.
    * It groups the data by the `cohort_month` (when they started) and the `purchase_month` (when they came back).
    * **`COUNT(DISTINCT ...)`**: This calculates the number of unique active customers for each specific cohort-to-purchase month combination.

---

### What does this tell a Business?
This query is the foundation for a **Retention Heatmap**. By looking at the output, you can answer questions like:
* "Of the customers who joined in January, how many were still buying in June?"
* "Are customers who joined in the Summer more loyal than those who joined in the Winter?"

### Technical Note:
The code uses PostgreSQL syntax (indicated by the `::TEXT` type casting). The `LPAD(..., 2, '0')` is a smart move—it ensures that Month 1 becomes "01", keeping your dates chronologically sortable as text strings.

Is this for a specific project, or are you building a dashboard to visualize this retention data?

<p align="center">
<img src="image/16_Final_Cleaned_Dataset_Sample.png.PNG" width="900">
</p>

---

Challenges Faced & Solved

- **Referential Integrity:** Handling missing values in ID columns without breaking table joins.
- **Data Inflation:** Preventing duplicate records from inflating revenue and transaction KPIs.
- **Performance:** Optimizing complex analytical queries (Cohorts/RFM) for faster execution.

---

About the Author
Omar Essam

- Business Information Systems – Tanta University
