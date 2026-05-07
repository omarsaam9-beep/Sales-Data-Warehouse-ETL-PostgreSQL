Retail Sales Data Warehouse | End-to-End ETL Pipeline
Engineering Lead: Omar Essam



Tech Stack
- Database: PostgreSQL  
- Language:SQL (Advanced: CTEs, Window Functions, Pattern Matching)  
- Architecture: Data Modeling (Star Schema Design)  
- Core Skills: ETL Pipeline Design, Data Cleaning & Transformation  
- Analytics: Business Intelligence Concepts (RFM, Cohort Analysis)  


 Project Overview
This project demonstrates a complete Data Engineering lifecycle, transforming raw and inconsistent retail data into a structured PostgreSQL Data Warehouse.

The pipeline follows a full **ETL approach (Extract → Transform → Load)**, resulting in a clean **Star Schema** optimized for analytical queries, KPI reporting, and advanced business insights.



 Architecture Flow
Raw Data → Data Cleaning → Standardization → Star Schema Modeling → Analytics Layer → Business Insights



Phase 1: Data Auditing & Cleaning
The goal of this phase was to ensure data reliability and consistency before modeling.

 1.1 Initial Profiling & Identification
Identified missing values, inconsistent formats, and duplicate records in the source data.  
![Initial Check](./Documentation/01_Initial_Data_Check.png)

 1.2 Handling Missing Data
Replaced NULLs with 'Unknown' where appropriate to preserve referential integrity during joins.  
![Missing Values](./Documentation/02_Handling_Missing_Values.png)

 1.3 Data Standardization
Applied `TRIM`, `INITCAP`, and `REGEXP_REPLACE` to unify text fields and collapse multiple spaces.  
![Standardization](./Documentation/03_Data_Standardization.png)

 1.4 Duplicate Removal
Used PostgreSQL `ctid` to eliminate duplicate records and prevent revenue inflation.  
![Removing Duplicates](./Documentation/04_Removing_Duplicates.png)

 1.5 Outlier Detection & Treatment
Applied statistical profiling followed by the **IQR (Interquartile Range)** method to remove extreme outliers.  
![Outlier Detection](./Documentation/05_Outlier_Detection_Method.png)  
![IQR Results](./Documentation/06_IQR_Filtering_Results.png)

---

 Phase 2: Data Modeling (Star Schema)
Building a scalable analytical environment using a Star Schema architecture.

 2.1 Table Creation & Optimization
Transition from staging to final tables while optimizing data types for performance.  
![Creating Tables](./Documentation/07_Creating_Final_Tables.png)

2.2 Schema Architecture & Integrity
Defined fact and dimension tables and established **Primary Keys (PK)** and **Foreign Keys (FK)** to ensure referential integrity.  
![Schema Overview](./Documentation/08_Schema_Architecture_Overview.png)  
![PK/FK Setup](./Documentation/09_Primary_Foreign_Keys_Setup.png)

---

 Phase 3: Business Intelligence & Advanced Analytics

 3.1 Cohort Analysis
Tracked customer retention and behavioral patterns over time.  
**Business Impact:** Enabled identification of customer retention trends for loyalty strategies.  
![Cohort Analysis](./Documentation/10_Cohort_Analysis_Query.png)

---

 3.2 RFM Customer Segmentation
Segmented customers based on Recency, Frequency, and Monetary value.  
**Business Impact:** Enabled targeted marketing and customer segmentation strategies.  
![RFM Segmentation](./Documentation/13_Customer_Segmentation_RFM.png)

---

### 3.3 Financial & Growth KPIs
Monitored Month-over-Month (MoM) revenue trends using Window Functions.  
![Monthly Trends](./Documentation/11_Monthly_Revenue_Trends.png)  
![Growth KPIs](./Documentation/14_Sales_Growth_KPIs.png)



 3.4 Product & Performance Analysis
Identified top-performing products and quarterly business performance.  
![Top Products](./Documentation/12_Top_Performing_Products.png)  
![Quarterly Report](./Documentation/15_Quarterly_Performance_Report.png)



 3.5 Final Dataset Output
Preview of the cleaned and structured dataset ready for BI tools or ML models.  
![Final Dataset](./Documentation/16_Final_Cleaned_Dataset_Sample.png)



 Challenges Faced & Solved
- Handling missing values without breaking relational joins  
- Preventing duplicate records from inflating KPIs  
- Designing scalable Star Schema from raw unstructured data  
- Optimizing complex analytical queries for performance  



 Key Business Impact
- Improved data accuracy by removing duplicates and outliers  
- Enabled customer segmentation for targeted marketing strategies  
- Built automated KPI tracking system for decision-making  
- Delivered insights into customer behavior and revenue trends  


About the Author
Omar Essam  
- Business Information Systems Student – Tanta University  
- Focus: Data Analysis , SQL Warehousing, and Business Intelligence  













