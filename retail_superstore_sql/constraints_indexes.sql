#Adding foreign keys

ALTER TABLE fact_sales ADD CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES dim_customer(customer_id);

ALTER TABLE fact_sales ADD CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES dim_product(product_id);

ALTER TABLE fact_sales ADD CONSTRAINT fk_date FOREIGN KEY (order_date) REFERENCES dim_date(date_id);

ALTER TABLE fact_sales ADD CONSTRAINT fk_location FOREIGN KEY (location_id) REFERENCES dim_location(location_id);

#Adding indexes
CREATE INDEX idx_fact_date ON fact_sales(order_date);
CREATE INDEX idx_fact_customer ON fact_sales(customer_id);
CREATE INDEX idx_fact_product ON fact_sales(product_id);
CREATE INDEX idx_fact_location ON fact_sales(location_id);