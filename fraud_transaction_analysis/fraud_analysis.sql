#Project Title
#Financial Fraud Detection & Transaction Risk Analysis Using SQL

#Dataset: PaySim Financial Transactions Dataset

#Creating the database
CREATE DATABASE fraud_analytics;
USE fraud_analytics;

#Loading data using infile so we dont miss any data from original source
CREATE TABLE transactions (
    step INT,
    type VARCHAR(20),
    amount DECIMAL(15,2),
    nameOrig VARCHAR(50),
    oldbalanceOrg DECIMAL(15,2),
    newbalanceOrig DECIMAL(15,2),
    nameDest VARCHAR(50),
    oldbalanceDest DECIMAL(15,2),
    newbalanceDest DECIMAL(15,2),
    isFraud INT,
    isFlaggedFraud INT
);

LOAD DATA LOCAL INFILE 'C:/finance_data/PS_20174392719_1491204439457_log.csv'
INTO TABLE transactions
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


#Dataset Overview
-- Total number of transactions
SELECT COUNT(*) AS total_transactions FROM transactions;

-- Transaction distribution by type
SELECT type,COUNT(*) AS total_transactions FROM transactions GROUP BY type ORDER BY total_transactions DESC;

#Money Flow Analysis
-- Total money moved by transaction type
SELECT type,SUM(amount) AS total_amount FROM transactions GROUP BY type ORDER BY total_amount DESC;

#Fraud Distribution Analysis
-- Fraud rate by transaction type
SELECT type,COUNT(*) AS total_transactions, SUM(isFraud) AS fraud_transactions, ROUND((SUM(isFraud) / COUNT(*)) * 100,4) AS fraud_rate FROM transactions
GROUP BY type ORDER BY fraud_rate DESC;

#Transaction Size Segmentation (CASE)
-- Classify transactions by size
SELECT CASE WHEN amount < 10000 THEN 'Small' WHEN amount BETWEEN 10000 AND 100000 THEN 'Medium' ELSE 'Large' END AS transaction_size,
COUNT(*) AS total_transactions,SUM(amount) AS total_amount FROM transactions GROUP BY transaction_size;

#Fraud Risk Classification
-- Risk segmentation using transaction type and amount
SELECT CASE WHEN type IN ('TRANSFER','CASH_OUT') AND amount > 200000 THEN 'High Risk' WHEN type IN ('TRANSFER','CASH_OUT') THEN 'Medium Risk'
ELSE 'Low Risk' END AS risk_level, COUNT(*) AS total_transactions, SUM(isFraud) AS fraud_transactions FROM transactions GROUP BY risk_level;

#Window Function Analysis
-- Percentage contribution of each transaction type
SELECT type, SUM(amount) AS total_amount,ROUND(SUM(amount) * 100.0 / SUM(SUM(amount)) OVER(),2) AS percent_of_total_money
FROM transactions GROUP BY type ORDER BY percent_of_total_money DESC;

#Fraud Transaction Behavior
-- Average fraud transaction amount
SELECT type, ROUND(AVG(amount),2) AS avg_amount_fraud FROM transactions WHERE isFraud = 1 GROUP BY type;

#Fraud Distribution using CTE
-- Fraud distribution analysis using CTE and window function
WITH fraud_counts AS (SELECT type, COUNT(*) AS fraud_transactions FROM transactions WHERE isFraud = 1 GROUP BY type)
SELECT type,fraud_transactions,ROUND(fraud_transactions * 100.0 / SUM(fraud_transactions) OVER(),2) AS percent_of_total_fraud
FROM fraud_counts ORDER BY percent_of_total_fraud DESC;

#Suspicious High Value Transactions
-- Identify large suspicious transactions
SELECT nameOrig, nameDest, type, amount FROM transactions WHERE type IN ('TRANSFER','CASH_OUT') AND amount > 1000000 ORDER BY amount DESC LIMIT 10;

#Fraud Rate by Transaction Size
-- Fraud rate by transaction size category
SELECT CASE WHEN amount < 10000 THEN 'Small' WHEN amount BETWEEN 10000 AND 100000 THEN 'Medium' ELSE 'Large' END AS transaction_size,
COUNT(*) AS total_transactions, SUM(isFraud) AS fraud_transactions, ROUND((SUM(isFraud)/COUNT(*))*100,4) AS fraud_rate FROM transactions
GROUP BY transaction_size ORDER BY fraud_rate DESC;

#Balance Inconsistency Detection
-- Detect transactions where balance change does not match transaction amount
SELECT COUNT(*) AS inconsistent_transactions FROM transactions WHERE oldbalanceOrg - amount <> newbalanceOrig;

#Fraud vs Normal Transaction Comparison
-- Compare average transaction amount for fraud vs normal transactions
SELECT isFraud, ROUND(AVG(amount),2) AS avg_transaction_amount FROM transactions GROUP BY isFraud;

#Fraud Trend by Time Step
-- Fraud transactions by time step
SELECT step, COUNT(*) AS total_transactions, SUM(isFraud) AS fraud_transactions FROM transactions GROUP BY step ORDER BY fraud_transactions DESC LIMIT 10;

#Index Creation (Performance Optimization)
-- Create indexes to optimize analytical queries
CREATE INDEX idx_transaction_type ON transactions(type);
CREATE INDEX idx_fraud_flag ON transactions(isFraud);
CREATE INDEX idx_transaction_amount ON transactions(amount);

#Query Execution Plan Analysis
-- Analyze query execution plan for fraud rate analysis
EXPLAIN SELECT type, COUNT(*) AS total_transactions, SUM(isFraud) AS fraud_transactions FROM transactions GROUP BY type;

#Top High-Risk Transactions (Optimized Query)
-- Retrieve largest high-risk transactions
SELECT nameOrig, nameDest, type, amount FROM transactions WHERE type IN ('TRANSFER','CASH_OUT') AND amount > 1000000 ORDER BY amount DESC LIMIT 10;

