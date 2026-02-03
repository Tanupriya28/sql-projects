#Monthly sales & profit view
CREATE OR REPLACE VIEW monthly_sales_summary AS
SELECT d.year,d.month,SUM(f.sales)  AS total_sales,SUM(f.profit) AS total_profit FROM fact_sales f
JOIN dim_date d ON f.order_date = d.date_id GROUP BY d.year, d.month ORDER BY d.year, d.month;

#Testing the view
SELECT * FROM monthly_sales_summary LIMIT 10;







