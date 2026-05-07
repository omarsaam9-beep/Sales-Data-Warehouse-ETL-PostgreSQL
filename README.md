المشكلة اللي ظاهرة في الصورة دي (الأيقونات الصغيرة اللي مكتوب جنبها Initial Check وغيره) معناها إن **GitHub مش لاقي مسار الصور صح**، أو إن الصور مش موجودة في نفس الفولدر اللي فيه ملف الـ README.

بص يا عمر، عشان نحل المشكلة دي نهائياً، انسخ الكود اللي تحت ده. أنا عدلت فيه **المسارات** عشان يقرأ الصور من الفولدر الرئيسي عندك بالظبط زي ما هي مكتوبة في الـ Repository:

---

### انسخ الكود ده وحطه في ملف الـ README.md:

```markdown
# 🛒 Retail Sales Data Warehouse | End-to-End ETL Pipeline
**Engineering Lead: Omar Essam**

## 🧰 Tech Stack
- **Database:** PostgreSQL
- **Language:** SQL (Advanced: CTEs, Window Functions, Pattern Matching)
- **Architecture:** Data Modeling (Star Schema Design)
- **Core Skills:** ETL Pipeline Design, Data Cleaning, & Transformation
- **Analytics:** Business Intelligence Concepts (RFM, Cohort Analysis)

## 📖 Project Overview
This project demonstrates a complete Data Engineering lifecycle, transforming raw and inconsistent retail data into a structured PostgreSQL Data Warehouse. 

The pipeline follows a full **ETL approach**, resulting in a clean **Star Schema** optimized for analytical queries, KPI reporting, and advanced business insights.

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
<img src="01_Initial_Data_Check.png.PNG" width="800">

### 1.2 Handling Missing Data
Replaced NULLs with 'Unknown' where appropriate to preserve referential integrity during joins.
<br>
<img src="02_Handling_Missing_Values.png.PNG" width="800">

### 1.3 Data Standardization
Applied `TRIM`, `INITCAP`, and `REGEXP_REPLACE` to unify text fields and collapse multiple spaces.
<br>
<img src="03_Data_Standardization.png.PNG" width="800">

### 1.4 Duplicate Removal
Leveraged the PostgreSQL `ctid` system column to eliminate redundant records and prevent revenue inflation.
<br>
<img src="04_Removing_Duplicates.png.PNG" width="800">

### 1.5 Outlier Detection & Treatment
Used statistical profiling followed by the **IQR (Interquartile Range)** method to remove extreme outliers.
<br>
<img src="05_Outlier_Detection_Method.png.PNG" width="800">
<img src="06_IQR_Filtering_Results.png.PNG" width="800">

---

## 🏗️ Phase 2: Data Modeling (Star Schema)
Building a scalable analytical environment using a Star Schema architecture.

### 2.1 Table Creation & Optimization
Transitioning from staging to final tables while optimizing data types for faster query execution.
<br>
<img src="07_Creating_Final_Tables.png.PNG" width="800">

### 2.2 Schema Architecture & Integrity
A comprehensive overview of the fact and dimension table structures. Establishing **Primary Keys (PK)** and **Foreign Keys (FK)**.
<br>
<img src="08_Schema_Architecture_Overview.png.PNG" width="800">
<img src="09_Primary_Foreign_Keys_Setup.png.PNG" width="800">

---

## 📊 Phase 3: Business Intelligence & Advanced Analytics
Transforming the cleaned data into high-value executive insights.

### 3.1 Advanced Cohort Analysis
Tracking customer retention patterns over time. 
> **Business Impact:** *Enabled identification of retention patterns and behavioral trends, allowing for data-driven customer loyalty strategies.*
<br>
<img src="10_Cohort_Analysis_Query.png.PNG" width="800">

### 3.2 RFM Customer Segmentation
Categorizing customers based on Recency, Frequency, and Monetary value.
> **Business Impact:** *Provided a framework for targeted marketing strategies by segmenting high-value vs. at-risk customers.*
<br>
<img src="13_Customer_Segmentation_RFM.png.PNG" width="800">

### 3.3 Financial & Growth KPIs
Monitoring Month-over-Month (MoM) revenue trends using Window Functions.
<br>
<img src="11_Monthly_Revenue_Trends.png.PNG" width="800">
<img src="14_Sales_Growth_KPIs.png.PNG" width="800">

### 3.4 Product & Performance Intelligence
Identifying top-performing products and quarterly business performance.
<br>
<img src="12_Top_Performing_Products.png.PNG" width="800">
<img src="15_Quarterly_Performance_Report.png.PNG" width="800">

### 3.5 The Final Product
A preview of the "Gold Standard" cleaned dataset.
<br>
<img src="16_Final_Cleaned_Dataset_Sample.png.PNG" width="800">

---

## ⚠️ Challenges Faced & Solved
- **Referential Integrity:** Handling missing values in ID columns without breaking crucial table joins.
- **Data Inflation:** Preventing duplicate records from inflating revenue and transaction KPIs.
- **Performance:** Optimizing complex analytical queries (Cohorts/RFM) for faster execution.

## 👤 About the Author
**Omar Essam**
- Business Information Systems Student – Tanta University
- Focus: Building scalable data systems & business intelligence solutions.
```

---

### ليه أنا استخدمت `<img>` المرة دي؟
1. **للتأكد من العرض:** الـ HTML tag ده (`<img src="...">`) أحياناً بيكون أضمن في GitHub لما المسارات بتعلق.
2. **الحجم:** ضفت `width="800"` عشان الصور تظهر بحجم كبير وواضح للـ Recruiter.
3. **الامتداد:** تأكدت إن الامتداد مكتوب `.png.PNG` زي ما هو ظاهر في ملفاتك بالضبط.

**جرب التعديل ده دلوقتي وهتلاقي الصور نورت في الصفحة!** قولي لو لسه في حاجة معلقة معاك.
