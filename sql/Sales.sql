-- CREATE Database and add all tabels
CREATE DATABASE IF NOT EXISTS Sales;
USE Sales;
CREATE TABLE Canada_sales(
Transaction_ID VARCHAR(50) PRIMARY KEY,
Date VARCHAR(10),
Country VARCHAR(50),
Product_ID VARCHAR(50),
Product_Name VARCHAR(150),
Category VARCHAR(50),
Price_per_Unit DECIMAL(10,2),
Quantity_Purchased INT,
Cost_Price DECIMAL(10,2),
Discount_Applied DECIMAL(10,2),
Payment_Method	VARCHAR(50),
Customer_Age_Group VARCHAR(50),
Customer_Gender	VARCHAR(50),
Store_Location	VARCHAR(50),
Sales_Rep VARCHAR(50)
);
CREATE TABLE China_sales(
Transaction_ID VARCHAR(50) PRIMARY KEY,
Date VARCHAR(10),
Country VARCHAR(50),
Product_ID VARCHAR(50),
Product_Name VARCHAR(150),
Category VARCHAR(50),
Price_per_Unit DECIMAL(10,2),
Quantity_Purchased INT,
Cost_Price DECIMAL(10,2),
Discount_Applied DECIMAL(10,2),
Payment_Method	VARCHAR(50),
Customer_Age_Group VARCHAR(50),
Customer_Gender	VARCHAR(50),
Store_Location	VARCHAR(50),
Sales_Rep VARCHAR(50)
);
USE Sales;
CREATE TABLE India_sales(
Transaction_ID VARCHAR(50) PRIMARY KEY,
Date VARCHAR(10),
Country VARCHAR(50),
Product_ID VARCHAR(50),
Product_Name VARCHAR(150),
Category VARCHAR(50),
Price_per_Unit DECIMAL(10,2),
Quantity_Purchased INT,
Cost_Price DECIMAL(10,2),
Discount_Applied DECIMAL(10,2),
Payment_Method	VARCHAR(50),
Customer_Age_Group VARCHAR(50),
Customer_Gender	VARCHAR(50),
Store_Location	VARCHAR(50),
Sales_Rep VARCHAR(50)
);
USE Sales;
CREATE TABLE Nigeria_sales(
Transaction_ID VARCHAR(50) PRIMARY KEY,
Date VARCHAR(10),
Country VARCHAR(50),
Product_ID VARCHAR(50),
Product_Name VARCHAR(150),
Category VARCHAR(50),
Price_per_Unit DECIMAL(10,2),
Quantity_Purchased INT,
Cost_Price DECIMAL(10,2),
Discount_Applied DECIMAL(10,2),
Payment_Method	VARCHAR(50),
Customer_Age_Group VARCHAR(50),
Customer_Gender	VARCHAR(50),
Store_Location	VARCHAR(50),
Sales_Rep VARCHAR(50)
);
USE Sales;
CREATE TABLE UK_sales(
Transaction_ID VARCHAR(50) PRIMARY KEY,
Date VARCHAR(10),
Country VARCHAR(50),
Product_ID VARCHAR(50),
Product_Name VARCHAR(150),
Category VARCHAR(50),
Price_per_Unit DECIMAL(10,2),
Quantity_Purchased INT,
Cost_Price DECIMAL(10,2),
Discount_Applied DECIMAL(10,2),
Payment_Method	VARCHAR(50),
Customer_Age_Group VARCHAR(50),
Customer_Gender	VARCHAR(50),
Store_Location	VARCHAR(50),
Sales_Rep VARCHAR(50)
);
USE Sales;
CREATE TABLE US_sales(
Transaction_ID VARCHAR(50) PRIMARY KEY,
Date VARCHAR(10),
Country VARCHAR(50),
Product_ID VARCHAR(50),
Product_Name VARCHAR(150),
Category VARCHAR(50),
Price_per_Unit DECIMAL(10,2),
Quantity_Purchased INT,
Cost_Price DECIMAL(10,2),
Discount_Applied DECIMAL(10,2),
Payment_Method	VARCHAR(50),
Customer_Age_Group VARCHAR(50),
Customer_Gender	VARCHAR(50),
Store_Location	VARCHAR(50),
Sales_Rep VARCHAR(50)
);
USE sales;
CREATE TABLE SalesData AS
SELECT * FROM Canada_sales
UNION ALL
SELECT * FROM China_sales
UNION ALL
SELECT * FROM India_sales
UNION ALL
SELECT * FROM Nigeria_sales
UNION ALL
SELECT * FROM Uk_sales
UNION ALL
SELECT * FROM US_sales;
SELECT COUNT(*) FROM salesdata;

-- converted date datatype fron str to date
SELECT * 
FROM sales.salesdata;
SET SQL_SAFE_UPDATES = 0;
UPDATE salesdata
SET Date = STR_TO_DATE(Date, '%m/%d/%Y');

-- find null values
SELECT * 
FROM salesdata
WHERE Transaction_ID IS NULL
OR Country IS NULL
OR Product_ID IS NULL
OR Category IS NULL
OR Price_per_Unit IS NULL
OR Quantity_Purchased = 0
OR Cost_Price IS NULL
OR Discount_Applied IS NULL;
-- updated null values
UPDATE sales.salesdata
SET Price_per_Unit = (
    SELECT avg_price
    FROM (
        SELECT AVG(Price_per_Unit) AS avg_price
        FROM sales.salesdata
        WHERE Price_per_Unit IS NOT NULL
    ) AS temp_avg
)
WHERE Transaction_ID = '001898f7-b696-4356-91dc-8f2b73d09c63';

-- find duplicates
SELECT COUNT(*) 
FROM (
    SELECT transaction_id, country, COUNT(*) AS dup_count
    FROM sales.salesdata
    GROUP BY transaction_id, country
    HAVING COUNT(*) > 1
) AS duplicates;


SELECT * FROM salesdata;
-- Add total_amount column
ALTER TABLE salesdata
ADD COLUMN Total_Amount NUMERIC(10,2);
UPDATE sales.salesdata
SET Total_Amount = (Price_per_Unit * Quantity_Purchased) - Discount_Applied;
-- Add profit column
ALTER TABLE salesdata
ADD COLUMN Profit NUMERIC(10,2);
UPDATE sales.salesdata
SET Profit = Total_Amount - (Cost_Price * Quantity_Purchased);


