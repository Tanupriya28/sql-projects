#Check for invalid numbers
-- Sales should not be negative
SELECT * FROM fact_sales WHERE sales < 0;

-- Quantity should be positive
SELECT * FROM fact_sales WHERE quantity <= 0;

-- Discount must be between 0 and 1
SELECT * FROM fact_sales WHERE discount < 0 OR discount > 1;

#Row count check 
SELECT (SELECT COUNT(*) FROM superstore_raw) AS raw_rows, (SELECT COUNT(*) FROM fact_sales) AS fact_rows;

-- Negative profit (loss-making orders)
SELECT * FROM fact_sales WHERE profit < 0 LIMIT 5;

