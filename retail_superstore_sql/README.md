# Retail Superstore – SQL Data Warehouse Project

## Project Overview
This project demonstrates the design and implementation of a **Retail Sales Data Warehouse** using MySQL. Raw transactional data from the Superstore dataset was transformed into an **analytics-ready Star Schema**, enabling efficient reporting and business intelligence queries.

The project simulates a real-world **data engineering pipeline**, including bulk data ingestion, data cleaning, dimensional modeling, referential integrity enforcement, query optimization, and analytical view creation.

---

# Skills Demonstrated

- SQL Data Warehousing
- Data Cleaning & Transformation
- Dimensional Data Modeling (Star Schema)
- Fact–Dimension Table Design
- Referential Integrity Enforcement
- Query Optimization using Indexing
- Data Validation & Quality Checks
- Analytical Query Development

---

# Dataset Information

| Attribute | Value |
|--------|------|
| Dataset | Superstore Sales Dataset |
| Source | Kaggle |
| Format | CSV |
| Total Transactions | 9,994 |
| Time Range | 2014-01-03 → 2017-12-30 |
| Domain | Retail Sales |

---

# Data Warehouse Architecture

A **Star Schema** was designed to support scalable analytics and reporting.

```
                 dim_customer
                       |
                       |
dim_product ---- fact_sales ---- dim_location
                       |
                       |
                    dim_date
```

---

# Fact Table

## fact_sales

Stores order-line level transactional data.

Metrics stored:

- Sales
- Profit
- Quantity
- Discount

The fact table connects to dimension tables using **foreign keys**.

---

# Dimension Tables

## dim_customer
Customer information and segmentation.

## dim_product
Product hierarchy including category and sub-category.

## dim_location
Geographic attributes including country, state, city, and region.

## dim_date
Calendar attributes used for time-based analytics.

---

# ETL & Data Cleaning

The ETL pipeline included multiple steps to transform raw CSV data into structured warehouse tables.

## Data Ingestion

- Bulk data loaded using `LOAD DATA LOCAL INFILE`
- Character encoding resolved using `CHARACTER SET latin1`

## Data Transformation

- Mixed date formats converted to SQL `DATE` using conditional `STR_TO_DATE`
- Created cleaned date columns for reliable time analysis
- Inserted distinct records into dimension tables to remove duplicates
- Generated surrogate keys for the location dimension

---

# Data Integrity & Constraints

To ensure warehouse reliability, several constraints were implemented.

- Primary key created for `fact_sales`
- Foreign key relationships established with dimension tables
- NOT NULL constraints applied to critical business fields
- Referential integrity enforced between all fact and dimension tables

---

# Performance Optimization

Indexes were created on frequently queried columns to improve analytical performance.

Indexed columns:

- `order_date`
- `customer_id`
- `product_id`
- `location_id`

These indexes significantly reduce query execution time for joins and aggregations.

---

# Data Quality Validation

Several validation checks were performed to ensure dataset integrity.

## Row Count Validation

| Raw Records | Fact Records |
|------------|-------------|
| 9,994 | 9,994 |

This confirms **no data loss occurred during transformation**.

---

## Loss-Making Orders

| Metric | Value |
|------|------|
| Loss Making Transactions | 1,871 |

These orders indicate cases where discounts exceeded profit margins.

---

# Key Business Metrics

| Metric | Value |
|------|------|
| Total Revenue | $2,297,201 |
| Total Profit | $286,397 |
| Unique Customers | 793 |
| Unique Products | 1,862 |
| Total Transactions | 9,994 |

---

# Regional Sales Performance

| Region | Total Sales | Total Profit |
|------|------------|-------------|
| West | 725,457.93 | 108,418.79 |
| East | 678,781.36 | 91,522.84 |
| Central | 501,239.88 | 39,706.45 |
| South | 391,721.90 | 46,749.71 |

### Insight

The **West region generates the highest revenue and profit**, indicating strong market performance and customer demand.

---

# Top Customers by Revenue

| Customer | Total Sales |
|---------|-------------|
| Sean Miller | 25,043 |
| Tamara Chand | 19,052 |
| Raymond Buch | 15,117 |
| Tom Ashbrook | 14,595 |
| Adrian Barton | 14,473 |
| Sanjit Chand | 14,142 |
| Ken Lonsdale | 14,175 |
| Hunter Lopez | 12,873 |
| Christopher Conant | 12,129 |
| Sanjit Engle | 12,209 |

### Insight

A small group of customers contributes significantly to total revenue, suggesting opportunities for **loyalty programs and targeted marketing strategies**.

---

# Most Profitable Products

| Product | Total Profit |
|--------|-------------|
| Canon imageCLASS 2200 Advanced Copier | 25,199 |
| Fellowes PB500 Electric Punch Binding Machine | 7,753 |
| Hewlett Packard LaserJet 3310 Copier | 6,984 |
| Canon PC1060 Personal Laser Copier | 4,571 |
| Plantronics Savi W720 Multi-Device Wireless Headset | 4,425 |
| HP Designjet T520 Inkjet Printer | 4,094 |
| Ativa V4110MDD Micro-Cut Shredder | 3,772 |
| 3D Systems Cube Printer | 3,717 |
| Ibico EPI-21 Electric Binding System | 3,345 |
| Zebra ZM400 Thermal Label Printer | 3,343 |

### Insight

Technology-related office equipment contributes the **highest profit margins**, highlighting strong performance in the technology category.

---

# Monthly Sales Trend (Sample)

| Year | Month | Sales | Profit |
|----|----|------|------|
| 2014 | 1 | 14,236 | 2,450 |
| 2014 | 2 | 4,519 | 862 |
| 2014 | 3 | 55,691 | 498 |
| 2014 | 4 | 28,295 | 3,488 |
| 2014 | 5 | 23,648 | 2,738 |

### Insight

Sales show seasonal fluctuations throughout the year, with several months exhibiting **high revenue but lower profit margins**, indicating discount-driven sales strategies.

---

# Business Insights

- Total revenue exceeded **$2.29M across 9,994 transactions**.
- **1,871 orders resulted in negative profit**, indicating discount-driven margin erosion.
- The **West region leads in revenue and profitability**.
- Monthly sales trends reveal **seasonal spikes in demand**, supporting time-based marketing strategies.

---

# Execution Order

Run SQL scripts in the following order:

1. `database_setup.sql`
2. `raw_data_ingestion.sql`
3. `data_cleaning.sql`
4. `dimensions.sql`
5. `fact_sales.sql`
6. `constraints_indexes.sql`
7. `analytics_views.sql`
8. `validation.sql`

---

# Tools & Technologies

- MySQL
- SQL
- Kaggle Dataset
- Dimensional Modeling (Star Schema)
- Indexing & Query Optimization

---

# Author

Designed and implemented as a **SQL Data Warehouse Engineering project** demonstrating end-to-end data modeling, ETL processing, and analytical reporting capabilities.
