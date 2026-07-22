-- ==========================================================
-- 1. CREATE DATABASE
-- ==========================================================

DROP DATABASE IF EXISTS RetailAnalytics;

CREATE DATABASE RetailAnalytics;

USE RetailAnalytics;

-- ==========================================================
-- 2. CREATE TABLE
-- ==========================================================

CREATE TABLE OnlineRetail (
    Invoice VARCHAR(20),
    StockCode VARCHAR(20),
    Description VARCHAR(255),
    Quantity INT,
    InvoiceDate DATETIME,
    Price DECIMAL(10,2),
    CustomerID INT,
    Country VARCHAR(100),
    TotalPrice DECIMAL(12,2),
    Month VARCHAR(7),
    DayName VARCHAR(20)
);



LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/clean_data_sql.csv'
INTO TABLE OnlineRetail
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    Invoice,
    StockCode,
    Description,
    Quantity,
    @InvoiceDate,
    Price,
    CustomerID,
    Country,
    TotalPrice,
    Month,
    DayName
)
SET InvoiceDate = STR_TO_DATE(@InvoiceDate, '%Y-%m-%d %H:%i:%s');

-- View first 10 records
SELECT *
FROM OnlineRetail
LIMIT 10;

-- Total number of records
SELECT COUNT(*) AS TotalRows
FROM OnlineRetail;

-- Total number of columns
SELECT COUNT(*) AS TotalColumns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='RetailAnalytics'
AND TABLE_NAME='OnlineRetail';

-- Total unique customers
SELECT COUNT(DISTINCT CustomerID) AS UniqueCustomers
FROM OnlineRetail;

-- Total unique invoices
SELECT COUNT(DISTINCT Invoice) AS UniqueInvoices
FROM OnlineRetail;

-- Total unique products
SELECT COUNT(DISTINCT StockCode) AS UniqueProducts
FROM OnlineRetail;

-- Available countries
SELECT DISTINCT Country
FROM OnlineRetail
ORDER BY Country;

-- Dataset date range
SELECT
    MIN(InvoiceDate) AS FirstOrder,
    MAX(InvoiceDate) AS LastOrder
FROM OnlineRetail;

-- ==========================================================
-- 2. DATA QUALITY CHECKS
-- ==========================================================

-- Missing Customer IDs
SELECT COUNT(*) AS MissingCustomerIDs
FROM OnlineRetail
WHERE CustomerID IS NULL;

-- Missing Product Descriptions
SELECT COUNT(*) AS MissingDescriptions
FROM OnlineRetail
WHERE Description IS NULL
OR Description='';

-- Returned Orders
SELECT COUNT(*) AS ReturnedOrders
FROM OnlineRetail
WHERE Quantity<0;

-- Duplicate Invoice Numbers
SELECT
    Invoice,
    COUNT(*) AS Frequency
FROM OnlineRetail
GROUP BY Invoice
HAVING COUNT(*)>1
ORDER BY Frequency DESC;


-- ==========================================================
-- 3. SALES ANALYSIS
-- ==========================================================

-- Total Revenue
SELECT
    ROUND(SUM(TotalPrice),2) AS TotalRevenue
FROM OnlineRetail;

-- Average Transaction Value
SELECT
    ROUND(AVG(TotalPrice),2) AS AverageTransactionValue
FROM OnlineRetail;

-- Highest Transaction
SELECT
    MAX(TotalPrice) AS HighestTransaction
FROM OnlineRetail;

-- Lowest Transaction
SELECT
    MIN(TotalPrice) AS LowestTransaction
FROM OnlineRetail;

-- Total Quantity Sold
SELECT
    SUM(Quantity) AS TotalItemsSold
FROM OnlineRetail;

-- ==========================================================
-- 4. MONTHLY SALES ANALYSIS
-- ==========================================================

SELECT
    Month,
    ROUND(SUM(TotalPrice),2) AS Revenue
FROM OnlineRetail
GROUP BY Month
ORDER BY Revenue DESC;

-- ==========================================================
-- 5. WEEKDAY SALES ANALYSIS
-- ==========================================================

SELECT
    DayName,
    ROUND(SUM(TotalPrice),2) AS Revenue
FROM OnlineRetail
GROUP BY DayName
ORDER BY Revenue DESC;


-- ==========================================================
-- 6. COUNTRY ANALYSIS
-- ==========================================================

SELECT
    Country,
    COUNT(DISTINCT CustomerID) AS Customers,
    ROUND(SUM(TotalPrice),2) AS Revenue
FROM OnlineRetail
GROUP BY Country
ORDER BY Revenue DESC;

-- ==========================================================
-- 7. TOP 10 COUNTRIES
-- ==========================================================

SELECT
    Country,
    ROUND(SUM(TotalPrice),2) AS Revenue
FROM OnlineRetail
GROUP BY Country
ORDER BY Revenue DESC
LIMIT 10;

-- ==========================================================
-- 8. CUSTOMER ANALYSIS
-- ==========================================================

-- Top 10 Customers by Revenue
SELECT
    CustomerID,
    ROUND(SUM(TotalPrice),2) AS Revenue
FROM OnlineRetail
GROUP BY CustomerID
ORDER BY Revenue DESC
LIMIT 10;

-- Customers with Most Orders
SELECT
    CustomerID,
    COUNT(DISTINCT Invoice) AS OrdersPlaced
FROM OnlineRetail
GROUP BY CustomerID
ORDER BY OrdersPlaced DESC
LIMIT 10;

-- Average Spending Per Customer
SELECT
    CustomerID,
    ROUND(AVG(TotalPrice),2) AS AverageSpend
FROM OnlineRetail
GROUP BY CustomerID
ORDER BY AverageSpend DESC
LIMIT 10;

-- ==========================================================
-- 9. PRODUCT ANALYSIS
-- ==========================================================

-- Top Selling Products
SELECT
    Description,
    SUM(Quantity) AS QuantitySold
FROM OnlineRetail
GROUP BY Description
ORDER BY QuantitySold DESC
LIMIT 10;

-- Highest Revenue Products
SELECT
    Description,
    ROUND(SUM(TotalPrice),2) AS Revenue
FROM OnlineRetail
GROUP BY Description
ORDER BY Revenue DESC
LIMIT 10;

-- Most Frequently Purchased Products
SELECT
    Description,
    COUNT(*) AS PurchaseFrequency
FROM OnlineRetail
GROUP BY Description
ORDER BY PurchaseFrequency DESC
LIMIT 10;


-- ==========================================================
-- 10. INVOICE ANALYSIS
-- ==========================================================

-- Largest Invoice
SELECT
    Invoice,
    ROUND(SUM(TotalPrice),2) AS InvoiceValue
FROM OnlineRetail
GROUP BY Invoice
ORDER BY InvoiceValue DESC
LIMIT 1;

-- Average Items Per Invoice
SELECT
    AVG(ItemCount) AS AverageItemsPerInvoice
FROM
(
    SELECT
        Invoice,
        COUNT(*) AS ItemCount
    FROM OnlineRetail
    GROUP BY Invoice
) AS InvoiceSummary;


-- ==========================================================
-- 11. WINDOW FUNCTIONS
-- ==========================================================

-- Customer Revenue Ranking
SELECT
    CustomerID,
    ROUND(SUM(TotalPrice),2) AS Revenue,
    RANK() OVER(ORDER BY SUM(TotalPrice) DESC) AS CustomerRank
FROM OnlineRetail
GROUP BY CustomerID;

-- Dense Rank
SELECT
    CustomerID,
    ROUND(SUM(TotalPrice),2) AS Revenue,
    DENSE_RANK() OVER(ORDER BY SUM(TotalPrice) DESC) AS DenseRank
FROM OnlineRetail
GROUP BY CustomerID;

-- Running Revenue by Date
SELECT
    DATE(InvoiceDate) AS SalesDate,
    ROUND(SUM(TotalPrice),2) AS DailyRevenue,
    ROUND(
        SUM(SUM(TotalPrice))
        OVER(ORDER BY DATE(InvoiceDate)),
        2
    ) AS RunningRevenue
FROM OnlineRetail
GROUP BY DATE(InvoiceDate);


-- ==========================================================
-- 12. BUSINESS QUESTIONS
-- ==========================================================

-- Top Revenue Country
SELECT
    Country,
    ROUND(SUM(TotalPrice),2) AS Revenue
FROM OnlineRetail
GROUP BY Country
ORDER BY Revenue DESC
LIMIT 1;

-- Top Revenue Month
SELECT
    Month,
    ROUND(SUM(TotalPrice),2) AS Revenue
FROM OnlineRetail
GROUP BY Month
ORDER BY Revenue DESC
LIMIT 1;

-- Top Revenue Weekday
SELECT
    DayName,
    ROUND(SUM(TotalPrice),2) AS Revenue
FROM OnlineRetail
GROUP BY DayName
ORDER BY Revenue DESC
LIMIT 1;

-- Top Customer
SELECT
    CustomerID,
    ROUND(SUM(TotalPrice),2) AS Revenue
FROM OnlineRetail
GROUP BY CustomerID
ORDER BY Revenue DESC
LIMIT 1;

-- Top Product by Revenue
SELECT
    Description,
    ROUND(SUM(TotalPrice),2) AS Revenue
FROM OnlineRetail
GROUP BY Description
ORDER BY Revenue DESC
LIMIT 1;

-- ==========================================================
-- END OF PROJECT
-- ==========================================================