-- Countrywise Sale and Profit 
SELECT Country, SUM(Total_Amount) AS Total_Sale, SUM(Profit) Total_Profit
FROM salesdata
GROUP BY Country
ORDER BY total_profit DESC;

-- Countrywise Sale and Profit data of previous month
SELECT Country, SUM(Total_Amount) AS Total_Sale, SUM(Profit) Total_Profit
FROM salesdata
WHERE MONTH(Date) = 8
GROUP BY Country
ORDER BY total_profit DESC;

-- TOP10 BEST SELLING PRODUCTS 
SELECT Product_Name, SUM(Quantity_Purchased) AS Total_unit_sold
FROM salesdata
GROUP BY Product_Name
ORDER BY Total_unit_sold DESC
LIMIT 10;

-- Last month top10 best selling products
SELECT Product_Name, SUM(Quantity_Purchased) AS Total_unit_sold
FROM salesdata
WHERE MONTH(Date) = 8
GROUP BY Product_Name
ORDER BY Total_unit_sold DESC
LIMIT 10;

-- TOP10 store location With highest profit
SELECT Store_Location, Country, SUM(Profit) AS Total_Profit
FROM salesdata
GROUP BY Store_Location, Country
ORDER BY Total_Profit DESC
LIMIT 10;

-- TOP10 store location With highest profit of previous month
SELECT Store_Location, Country, SUM(Profit) AS Total_Profit
FROM salesdata
WHERE MONTH(Date) = 8
GROUP BY Store_Location, Country
ORDER BY Total_Profit DESC
LIMIT 10;

-- TOP 10 Sales Represetatives
SELECT Sales_Rep, SUM(Total_Amount) AS Total_Sales
FROM salesdata
GROUP BY Sales_Rep
ORDER BY Total_Sales DESC
LIMIT 10;

-- TOP 10 Sales Represetatives of prev month
SELECT Sales_Rep, SUM(Total_Amount) AS Total_Sales
FROM salesdata
WHERE MONTH(Date) = 8
GROUP BY Sales_Rep
ORDER BY Total_Sales DESC
LIMIT 10;

-- Sales and Profit Insights of prev month
SELECT MIN(Total_Amount) AS Min_sale,
	   ROUND(AVG(Total_Amount),2) AS Avg_sale,
       MAX(Total_Amount) AS Max_sale,
       ROUND(SUM(Total_Amount),2) AS Total_Sale,
       MIN(Profit)AS Min_profit,
       ROUND(AVG(Profit),2) AS Avg_profit,
       MAX(Profit) AS Max_profit,
       ROUND(SUM(Profit),2) AS Total_profit
FROM salesdata
WHERE MONTH(Date) = 8;
