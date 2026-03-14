# Financial Fraud Detection & Transaction Risk Analysis (SQL)

## Project Overview
This project analyzes a large-scale financial transaction dataset to identify fraud patterns, transaction risks, and anomalous behaviors using SQL.

The analysis focuses on understanding how fraud occurs, which transaction types are most vulnerable, and how transaction characteristics such as size and timing influence fraud likelihood.

Dataset used: **PaySim Financial Transaction Dataset**

Total transactions analyzed: **6,362,620**

---

## Objectives
- Explore transaction distribution and money flow across transaction types
- Identify where fraudulent activity occurs in the system
- Detect suspicious transaction patterns and anomalies
- Perform risk segmentation using rule-based logic
- Analyze fraud behavior using advanced SQL techniques

---

## SQL Concepts Used
The project demonstrates several important SQL techniques:

- Aggregations (`SUM`, `AVG`, `COUNT`)
- Conditional logic (`CASE`)
- Window functions
- Common Table Expressions (CTEs)
- Fraud rate calculations
- Risk segmentation
- Query optimization with indexes
- Query execution plan analysis (`EXPLAIN`)

---

## Key Insights

### 1. Fraud Occurs in Specific Transaction Types
Fraudulent transactions occur exclusively in:

- **TRANSFER**
- **CASH_OUT**

These two transaction types represent the primary fraud channels.

---

### 2. Fraud Follows a Transfer → Cash-Out Pattern
Fraud activity is almost evenly split:

| Transaction Type | Fraud Share |
|-----------------|-------------|
| CASH_OUT | 50.12% |
| TRANSFER | 49.88% |

This suggests attackers first **transfer funds between accounts**, then **withdraw them through cash-out transactions**.

---

### 3. Fraud Transactions Are Much Larger
Average transaction values:

| Category | Avg Transaction Amount |
|---------|------------------------|
| Normal Transactions | ~178K |
| Fraud Transactions | ~1.46M |

Fraudulent transactions are approximately **8× larger than normal transactions**.

---

### 4. Large Transactions Have Higher Fraud Probability
Fraud rates increase with transaction size:

| Transaction Size | Fraud Rate |
|-----------------|------------|
| Small | 0.0216% |
| Medium | 0.0638% |
| Large | 0.2293% |

This indicates that **large financial transfers represent the highest fraud risk**.

---

### 5. Major Money Flow Channels
Transaction types contributing to total money flow:

| Type | Contribution |
|------|-------------|
| TRANSFER | 42.41% |
| CASH_OUT | 34.46% |
| CASH_IN | 20.65% |

TRANSFER and CASH_OUT together account for **~77% of all money movement**, making them critical monitoring points.

---

## Example High-Risk Transactions

SELECT 
nameOrig,
nameDest,
type,
amount
FROM transactions
WHERE type IN ('TRANSFER','CASH_OUT')
AND amount > 1000000
ORDER BY amount DESC
LIMIT 10;

These queries identify extremely large transactions (some exceeding 90 million) that represent potential high-risk financial activity.

## Project Structure
fraud-transaction-analysis
│
├── sql
│   └── fraud_analysis.sql
│
└── README.md

## Dataset

PaySim Financial Transaction Dataset

### Kaggle Dataset Link:
https://www.kaggle.com/datasets/ealaxi/paysim1

## Conclusion

- This analysis demonstrates how SQL can be used to uncover fraud patterns, perform risk segmentation, and analyze financial transaction behavior at scale.

- The results highlight the importance of monitoring large transfer and cash-out transactions, which represent the primary fraud vectors in this dataset.

