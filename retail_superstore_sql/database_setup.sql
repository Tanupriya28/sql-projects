DROP DATABASE IF EXISTS superstore_dw;
CREATE DATABASE superstore_dw;
USE superstore_dw;

SHOW VARIABLES LIKE 'local_infile';


DROP TABLE IF EXISTS superstore_raw;
CREATE TABLE superstore_raw (
  `Row ID` INT,
  `Order ID` VARCHAR(50),
  `Order Date` VARCHAR(20),
  `Ship Date` VARCHAR(20),
  `Ship Mode` VARCHAR(50),
  `Customer ID` VARCHAR(50),
  `Customer Name` VARCHAR(100),
  Segment VARCHAR(50),
  Country VARCHAR(50),
  City VARCHAR(50),
  State VARCHAR(50),
  `Postal Code` VARCHAR(20),
  Region VARCHAR(50),
  `Product ID` VARCHAR(50),
  Category VARCHAR(50),
  `Sub-Category` VARCHAR(50),
  `Product Name` VARCHAR(200),
  Sales DECIMAL(10,2),
  Quantity INT,
  Discount DECIMAL(4,2),
  Profit DECIMAL(10,2)
);

LOAD DATA LOCAL INFILE 'C:/superstore.csv'
INTO TABLE superstore_raw
CHARACTER SET latin1
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) FROM superstore_raw;


SHOW COLUMNS FROM superstore_raw;
