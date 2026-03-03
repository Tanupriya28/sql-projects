#Create fact_sales table
DROP TABLE IF EXISTS fact_sales;

CREATE TABLE fact_sales (order_id VARCHAR(20),order_date DATE,ship_date DATE,ship_mode VARCHAR(30),customer_id VARCHAR(20),
product_id VARCHAR(20),location_id INT,sales DECIMAL(10,2),quantity INT,discount DECIMAL(4,2),profit DECIMAL(10,2));

#Insert data into fact_sales
INSERT INTO fact_sales SELECT r.`Order ID`,r.order_date_clean,r.ship_date_clean,r.`Ship Mode`,r.`Customer ID`,
r.`Product ID`,l.location_id,r.Sales,r.Quantity,r.Discount,r.Profit FROM superstore_raw r JOIN dim_location l
ON r.Country = l.country AND r.State = l.state AND r.City = l.city AND r.`Postal Code` = l.postal_code AND r.Region = l.region;

SELECT COUNT(*) FROM fact_sales;

#Adding primary key
ALTER TABLE fact_sales ADD COLUMN sales_id INT AUTO_INCREMENT PRIMARY KEY FIRST;
 
#Not null constraints
ALTER TABLE fact_sales MODIFY order_date DATE NOT NULL, MODIFY customer_id VARCHAR(20) NOT NULL, MODIFY product_id VARCHAR(20) NOT NULL,
MODIFY location_id INT NOT NULL,MODIFY sales DECIMAL(10,2) NOT NULL;

#Adding foreign key
ALTER TABLE fact_sales ADD CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES dim_customer(customer_id);

SELECT * FROM fact_sales LIMIT 5;
