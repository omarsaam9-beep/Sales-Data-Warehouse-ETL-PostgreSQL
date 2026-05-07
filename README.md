يا عمر، أنا مقدر جداً إحباطك، المنظر فعلاً "مبهدل" لأن جيت هاب بيتعامل مع الكلام ده كأنه نص مجرد (Plain Text) فبيطلعه كله سايح في بعضه. الصور مش ظاهرة لأن الروابط اللي عندك ناقصة، والكلام مش متنسق لأن علامات الـ **Markdown** مش محطوطة صح.

عشان تخلي الـ **README** بتاعك واجهة مشرفة زيك كـ **Data Engineer**، امسح كل اللي في الملف عندك، وانسخ الكود اللي تحت ده "بالظبط" واعمله **Paste**. أنا ظبطت فيه:
1.  **المسارات:** خليت الصور تتقرأ من فولدر `image` زي ما هو عندك في الـ Repository.
2.  **التنسيق:** العناوين، الجداول، والنقاط بقت منظمة.
3.  **الاحترافية:** ضفت لمسات تخلي الـ Recruiter ينبهر بشغلك.

---

### الكود النهائي (انسخ من أول هنا):

```markdown
# 🛒 Retail Sales Data Warehouse | End-to-End ETL Pipeline
**Engineering Lead: Omar Essam**

---

## 🧰 Tech Stack
- **Database:** PostgreSQL
- **Language:** SQL (Advanced: CTEs, Window Functions, Pattern Matching)
- **Architecture:** Data Modeling (Star Schema Design)
- **Core Skills:** ETL Pipeline Design, Data Cleaning, & Transformation
- **Analytics:** Business Intelligence Concepts (RFM, Cohort Analysis)

---

## 📖 Project Overview
This project demonstrates a complete **Data Engineering lifecycle**, transforming raw and inconsistent retail data into a structured PostgreSQL Data Warehouse.

The pipeline follows a full **ETL approach**, resulting in a clean **Star Schema** optimized for analytical queries, KPI reporting, and advanced business insights.

---

## 🏗️ Architecture Flow
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

## 🧹 Phase 1: Data Auditing & Cleaning
The goal of this phase was to ensure data reliability and consistency before modeling.

### 1.1 Initial Profiling & Identification
Identified missing values, inconsistent formats, and duplicate records in the source data.
<br>
<img src="image/01_Initial_Data_Check.png.PNG" width="850">

### 1.2 Handling Missing Data
Replaced NULLs with 'Unknown' where appropriate to preserve referential integrity during joins.
<br>
<img src="image/02_Handling_Missing_Values.png.PNG" width="850">

### 1.3 Data Standardization
Applied `TRIM`, `INITCAP`, and `REGEXP_REPLACE` to unify text fields and collapse multiple spaces.
<br>
<img src="image/03_Data_Standardization.png.PNG" width="850">

### 1.4 Duplicate Removal
Leveraged the PostgreSQL `ctid` system column to eliminate redundant records and prevent revenue inflation.
<br>
<img src="image/04_Removing_Duplicates.png.PNG" width="850">

### 1.5 Outlier Detection & Treatment
Used statistical profiling followed by the **IQR (Interquartile Range)** method to remove extreme outliers.
<br>
<img src="image/05_Outlier_Detection_Method.png.PNG" width="850">
<img src="image/06_IQR_Filtering_Results.png.PNG" width="850">

---

## 🏗️ Phase 2: Data Modeling (Star Schema)
Building a scalable analytical environment using a Star Schema architecture.

### 2.1 Table Creation & Optimization
Transitioning from staging to final tables while optimizing data types for faster query execution.
<br>
<img src="image/07_Creating_Final_Tables.png.PNG" width="850">

### 2.2 Schema Architecture & Integrity
A comprehensive overview of the fact and dimension table structures. Establishing **Primary Keys (PK)** and **Foreign Keys (FK)**.
<br>
<img src="image/08_Schema_Architecture_Overview.png.PNG" width="850">
<img src="image/09_Primary_Foreign_Keys_Setup.png.PNG" width="850">

---

## 📊 Phase 3: Business Intelligence & Advanced Analytics
Transforming the cleaned data into high-value executive insights.

### 3.1 Advanced Cohort Analysis
Tracking customer retention patterns over time.
> **Business Impact:** *Enabled identification of retention patterns and behavioral trends for targeted marketing.*
<br>
<img src="image/10_Cohort_Analysis_Query.png.PNG" width="850">

### 3.2 RFM Customer Segmentation
Categorizing customers based on Recency, Frequency, and Monetary value.
> **Business Impact:** *Provided a framework for targeted marketing by segmenting high-value vs. at-risk customers.*
<br>
<img src="image/13_Customer_Segmentation_RFM.png.PNG" width="850">

### 3.3 Financial & Growth KPIs
Monitoring Month-over-Month (MoM) revenue trends and sales performance using Window Functions.
<br>
<img src="image/11_Monthly_Revenue_Trends.png.PNG" width="850">
<img src="image/14_Sales_Growth_KPIs.png.PNG" width="850">

### 3.4 Product & Performance Intelligence
Identifying top-performing products and quarterly business performance.
<br>
<img src="image/12_Top_Performing_Products.png.PNG" width="850">
<img src="image/15_Quarterly_Performance_Report.png.PNG" width="850">

### 3.5 The Final Product
A preview of the cleaned dataset, ready for BI tools and further analysis.
<br>
<img src="image/16_Final_Cleaned_Dataset_Sample.png.PNG" width="850">

---

## ⚠️ Challenges Faced & Solved
- **Referential Integrity:** Handling missing values in ID columns without breaking table joins.
- **Data Inflation:** Preventing duplicate records from inflating revenue and transaction KPIs.
- **Performance:** Optimizing complex analytical queries (Cohorts/RFM) for faster execution.

## 👤 About the Author
**Omar Essam**
- Business Information Systems – Tanta University
```

---

**نصيحة أخيرة:** أول ما تحط الكود ده وتعمل **Commit changes**، الصفحة هتتحول تماماً وهتلاقي كل الصور اشتغلت بالتنسيق المظبوط. قولي لو في أي صورة لسه مش ظاهرة!
