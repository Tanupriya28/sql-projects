# Olist E-Commerce SQL Analytics Engineering Project

An end-to-end SQL analytics and data modeling project built using the Olist Brazilian E-Commerce dataset (~100K+ transactions) in MySQL.

This project simulates a real-world analytics engineering workflow — from raw data validation and schema correction to star schema modeling, KPI generation, and performance optimization.

---

## Project Overview

This project follows a structured SQL engineering lifecycle:

- Schema exploration and structural validation  
- Data quality and logical consistency checks  
- Non-destructive data cleaning using SQL views  
- Star schema modeling (fact & dimension views)  
- Business KPI generation  
- Advanced SQL analytics using CTEs and window functions  
- Performance optimization and scalability enhancements  

All transformations were implemented using SQL views to preserve raw data integrity.

---

## Project Structure

```
olist-sql-analytics/

├── schema_overview.sql
├── data_validation.sql
├── data_cleaning.sql
├── analytical_views.sql
├── business_analysis.sql
├── advanced_sql_concepts.sql
├── performance_optimization.sql
└── README.md
```

---

##  Data Modeling Approach (Star Schema)

The analytical layer was modeled using a star schema design to support scalable BI-style reporting.

### Fact Tables
- `fact_orders` (item-level granularity: one row per product per delivered order)
- `fact_payments`
- `fact_reviews`

### Dimension Tables
- `dim_customers`
- `dim_products`
- `dim_sellers`

The central fact table operates at **item-level grain**, enabling accurate revenue, seller, and product-level analysis.

---

##  Key Metrics Generated

- **15.4M+ BRL** total delivered revenue analyzed  
- **96K+ delivered orders** modeled  
- **110K+ item-level fact rows**  
- **3% repeat customer rate** (based on `customer_unique_id`)  
- Average Order Value (AOV)  
- Seller revenue rankings  
- Product category contribution analysis  
- Customer Lifetime Value (CLV)  
- Running revenue totals and percentage contribution analysis  

---

##  Advanced SQL Concepts Demonstrated

- Common Table Expressions (CTEs)
- Window Functions (`RANK`, `ROW_NUMBER`, `SUM OVER`)
- Running totals and cumulative revenue
- Revenue contribution percentage calculations
- Conditional segmentation using `CASE`
- Repeat vs one-time customer analysis
- Cohort-style retention logic

---

##  Performance & Scalability Enhancements

To simulate production-ready analytics systems:

- Converted improperly imported TEXT columns to structured types (`VARCHAR`, `DATETIME`)
- Cleaned invalid timestamps prior to datatype conversion
- Added primary keys for entity integrity
- Implemented composite and single-column indexes on join-heavy and filter-heavy columns
- Used `EXPLAIN` to inspect execution plans and reduce full table scans
- Created optimized analytical view with precomputed revenue column

> Note: MySQL views are not materialized. For large-scale production systems, summary tables, partitioning strategies, or materialized views would be recommended.

---

##  Tools & Technologies

- MySQL  
- Advanced SQL  
- Data Validation  
- Star Schema Modeling  
- CTEs & Window Functions  
- Query Optimization  
- Indexing Strategy  

---

##  Dataset

Olist Brazilian E-Commerce Dataset  
Public dataset available on Kaggle (~100K+ transactions)

---

##  Outcome

This project demonstrates end-to-end SQL analytics engineering capability — from raw data validation and schema correction to scalable analytical modeling, KPI generation, and performance optimization.

It reflects real-world practices used in analytics engineering and business intelligence environments.

