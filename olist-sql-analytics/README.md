# 📦 Olist E-Commerce SQL Analytics Project

An end-to-end SQL analytics and data modeling project built using the Olist Brazilian E-Commerce dataset and MySQL.

This project demonstrates a complete real-world analytics workflow — from raw data validation and schema correction to analytical modeling, performance optimization, and business insight generation.

---

# 📌 Project Overview

This project follows a structured SQL engineering approach:

1. Schema exploration and structural validation of raw tables  
2. Data quality checks and logical validation  
3. Non-destructive data cleaning using SQL views  
4. Star schema modeling using fact and dimension views  
5. Business KPI generation  
6. Advanced SQL analytics (CTEs, window functions)  
7. Performance optimization and scalability improvements  

The raw dataset was preserved throughout the project. All transformations were implemented using views to maintain data integrity.

---

# 🗂 Project Structure

```
olist-sql-analytics/

├── 01_schema_overview.sql
├── 02_data_validation.sql
├── 03_data_cleaning.sql
├── 04_analytical_views.sql
├── 05_business_analysis.sql
├── 06_advanced_sql_concepts.sql
├── 07_performance_optimization.sql
└── README.md
```

---

# 🔍 Data Engineering Workflow

## 1️⃣ Schema & Data Validation

- Inspected table structures and row counts  
- Validated uniqueness of primary identifiers  
- Identified null values and logical inconsistencies  
- Detected invalid delivery timestamps  
- Checked duplicate logic in order items  

---

## 2️⃣ Non-Destructive Data Cleaning

- Filtered only delivered orders for revenue analysis  
- Created clean views instead of modifying raw tables  
- Preserved original data integrity  

Created clean analytical views:

- `clean_orders`
- `clean_order_items`
- `clean_customers`
- `clean_payments`
- `clean_reviews`

---

## 3️⃣ Analytical Data Modeling (Star Schema)

Built structured analytical views:

### Fact Tables
- `fact_orders`
- `fact_payments`
- `fact_reviews`

### Dimension Tables
- `dim_customers`
- `dim_products`
- `dim_sellers`

This enables scalable BI-style analytics and structured KPI generation.

---

# 📊 Business Analysis & KPIs

Generated key business metrics including:

- Total Revenue
- Daily Revenue Trends
- Average Order Value (AOV)
- Seller Revenue Ranking
- Product Category Performance
- Customer Order Frequency
- Repeat Customer Rate
- Average Delivery Time
- Payment Method Distribution
- Review Score Distribution

Advanced analysis included:

- Customer Lifetime Value (CLV)
- Revenue contribution percentage
- Running revenue totals
- Pareto (80/20) revenue analysis
- Cohort-style customer retention logic
- Repeat vs One-time customer segmentation

---

# ⚡ Advanced SQL Concepts Demonstrated

- Common Table Expressions (CTEs)
- Window Functions (RANK, ROW_NUMBER, SUM OVER)
- Running totals
- Revenue contribution percentage
- Cohort-style grouping logic
- Conditional segmentation using CASE

---

# 🚀 Performance & Scalability Enhancements

To simulate production-ready analytics systems, the following optimizations were implemented:

- Converted improperly imported TEXT columns to appropriate data types (VARCHAR, DATETIME).
- Cleaned invalid timestamp values before datatype conversion.
- Implemented indexing strategy on high-frequency join and filter columns.
- Created composite indexes for join-heavy tables.
- Used EXPLAIN to inspect execution plans and reduce full table scans.
- Precomputed revenue column in optimized analytical view.
- Discussed scalability strategies for large-scale datasets.

Note: MySQL views are not materialized. For large-scale production systems, materialized summary tables or partitioning strategies would be recommended.

---

# 🛠 Tools & Technologies

- MySQL
- SQL (Joins, Aggregations, Subqueries)
- CTEs
- Window Functions
- Data Validation
- Analytical Modeling
- Performance Optimization

---

# 📁 Dataset

Olist Brazilian E-Commerce Dataset  
Public dataset available on Kaggle.

---

# 🎯 Outcome

This project demonstrates end-to-end SQL engineering capability — from raw data validation and schema correction to analytical modeling, performance optimization, and business insight generation.

It reflects real-world practices used in analytics engineering and business intelligence workflows.

