CREATE DATABASE IF NOT EXISTS retail_db;
USE retail_db;

CREATE TABLE OnlineRetail (
    InvoiceNo VARCHAR(20),
    StockCode VARCHAR(20),
    Description TEXT,
    Quantity INT,
    InvoiceDate DATETIME,
    UnitPrice DECIMAL(10,2),
    CustomerID VARCHAR(20),
    Country VARCHAR(50)
);

USE retail_db;
SELECT * FROM online_retail_ii LIMIT 10;

SELECT Description, SUM(Quantity) AS TotalQuantity
FROM online_retail_ii
GROUP BY Description
ORDER BY TotalQuantity DESC
LIMIT 10;

SELECT `Customer ID`, ROUND(SUM(Quantity * Price), 2) AS Revenue
FROM online_retail_ii
GROUP BY `Customer ID`
ORDER BY Revenue DESC
LIMIT 10;

SELECT DATE_FORMAT(InvoiceDate, '%Y-%m') AS Month, 
       ROUND(SUM(Quantity * Price), 2) AS TotalSales
FROM online_retail_ii
GROUP BY Month
ORDER BY Month;

SELECT Country, ROUND(SUM(Quantity * Price), 2) AS Revenue
FROM online_retail_ii
WHERE Country <> 'United Kingdom'
GROUP BY Country
ORDER BY Revenue DESC
LIMIT 5;

SELECT Description, ABS(SUM(Quantity)) AS TotalReturned
FROM online_retail_ii
WHERE Quantity < 0
GROUP BY Description
ORDER BY TotalReturned DESC
LIMIT 10;

SELECT 
  `Customer ID`,
  MAX(InvoiceDate) AS LastPurchaseDate,
  COUNT(DISTINCT Invoice) AS Frequency,
  ROUND(SUM(Quantity * Price), 2) AS Monetary
FROM online_retail_ii
WHERE `Customer ID` IS NOT NULL
GROUP BY `Customer ID`;

SELECT 
  `Customer ID`,
  
  NTILE(5) OVER (ORDER BY Recency DESC) AS Recency_Score,
  NTILE(5) OVER (ORDER BY Frequency) AS Frequency_Score,
  NTILE(5) OVER (ORDER BY Monetary) AS Monetary_Score,
  
  CONCAT(
    NTILE(5) OVER (ORDER BY Recency DESC),
    NTILE(5) OVER (ORDER BY Frequency),
    NTILE(5) OVER (ORDER BY Monetary)
  ) AS RFM_Score

FROM (
  SELECT 
    `Customer ID`,
    DATEDIFF('2011-12-10', MAX(InvoiceDate)) AS Recency,
    COUNT(DISTINCT Invoice) AS Frequency,
    ROUND(SUM(Quantity * Price), 2) AS Monetary
  FROM online_retail_ii
  WHERE `Customer ID` IS NOT NULL
  GROUP BY `Customer ID`
) AS rfm_data;

SELECT Segment, COUNT(*) AS CustomerCount
FROM (
  SELECT 
    `Customer ID`,
    CASE
      WHEN CONCAT(
             NTILE(5) OVER (ORDER BY Recency DESC),
             NTILE(5) OVER (ORDER BY Frequency),
             NTILE(5) OVER (ORDER BY Monetary)
           ) = '555' THEN 'Champions'
      WHEN NTILE(5) OVER (ORDER BY Recency DESC) >= 4 AND NTILE(5) OVER (ORDER BY Frequency) >= 4 THEN 'Loyal Customers'
      WHEN NTILE(5) OVER (ORDER BY Frequency) >= 4 THEN 'Frequent Shoppers'
      WHEN NTILE(5) OVER (ORDER BY Recency DESC) >= 4 THEN 'Recent Customers'
      WHEN NTILE(5) OVER (ORDER BY Monetary) >= 4 THEN 'Big Spenders'
      ELSE 'At Risk'
    END AS Segment
  FROM (
    SELECT 
      `Customer ID`,
      DATEDIFF('2011-12-10', MAX(InvoiceDate)) AS Recency,
      COUNT(DISTINCT Invoice) AS Frequency,
      ROUND(SUM(Quantity * Price), 2) AS Monetary
    FROM online_retail_ii
    WHERE `Customer ID` IS NOT NULL
    GROUP BY `Customer ID`
  ) AS rfm_data
) AS Segments
GROUP BY Segment
ORDER BY CustomerCount DESC;




