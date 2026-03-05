#Monthly Sales Trend
SELECT d.year,d.month,SUM(f.sales) total_sales FROM fact_sales f JOIN dim_date d ON f.order_date = d.date_id GROUP BY d.year, d.month
ORDER BY d.year, d.month;

#Sales by Product Category
SELECT p.category,SUM(f.sales) total_sales,SUM(f.profit) total_profit FROM fact_sales f JOIN dim_product p ON f.product_id = p.product_id
GROUP BY p.category ORDER BY total_sales DESC;

#Top 10 Customers by Sales
SELECT c.customer_name, SUM(f.sales) total_sales FROM fact_sales f JOIN dim_customer c ON f.customer_id = c.customer_id
GROUP BY c.customer_name ORDER BY total_sales DESC LIMIT 10;

#Sales by Region
SELECT l.region,SUM(f.sales) total_sales,SUM(f.profit) total_profit FROM fact_sales f JOIN dim_location l ON f.location_id = l.location_id
GROUP BY l.region ORDER BY total_sales DESC;

#Most Profitable Products
SELECT p.product_name, SUM(f.profit) total_profit FROM fact_sales f JOIN dim_product p ON f.product_id = p.product_id
GROUP BY p.product_name ORDER BY total_profit DESC LIMIT 10;

#Top Product in Each Category
SELECT category, product_name, total_sales
FROM (SELECT p.category,p.product_name,SUM(f.sales) AS total_sales,RANK() OVER(PARTITION BY p.category ORDER BY SUM(f.sales) DESC) AS rnk
FROM fact_sales f JOIN dim_product p ON f.product_id = p.product_id GROUP BY p.category, p.product_name) t WHERE rnk = 1;

#Running Monthly Sales
SELECT  d.year,d.month,SUM(f.sales) AS monthly_sales,SUM(SUM(f.sales)) OVER(ORDER BY d.year, d.month) AS running_sales FROM fact_sales f
JOIN dim_date d ON f.order_date = d.date_id GROUP BY d.year, d.month ORDER BY d.year, d.month;