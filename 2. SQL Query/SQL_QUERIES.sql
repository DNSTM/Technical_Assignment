
--************************************************************************************************
-- 1. First Order Date
WITH FACT_ORDERS AS (
	SELECT 
		ACCOUNT_ID,
		ORDER_DATE_TIME, 
		ROW_NUMBER () OVER (PARTITION BY ACCOUNT_ID ORDER BY ORDER_DATE_TIME ASC) ORDERS_RANK 
	FROM DBO.fact_order AS F1
	WHERE F1.QUANTITY_ORDERED > 0
)
SELECT ACCOUNT_ID, ORDER_DATE_TIME AS FIRST_ORDER_DATE FROM FACT_ORDERS AS F1 WHERE F1.ORDERS_RANK  = 1

--************************************************************************************************
-- 2. Last Order Date
WITH FACT_ORDERS AS (
	SELECT 
		ACCOUNT_ID,
		ORDER_DATE_TIME, 
		ROW_NUMBER () OVER (PARTITION BY ACCOUNT_ID ORDER BY ORDER_DATE_TIME DESC) ORDERS_RANK 
	FROM DBO.fact_order AS F1
	WHERE F1.QUANTITY_ORDERED > 0
)
SELECT ACCOUNT_ID, ORDER_DATE_TIME AS LAST_ORDER_DATE FROM FACT_ORDERS AS F1 WHERE F1.ORDERS_RANK  = 1

--************************************************************************************************
--************************************************************************************************
--******************************* Total Sales *****************************************************
-- 3.Total Sales 14 days
SELECT 
	ACCOUNT_ID,
	SUM(TOTAL_CHARGED_AMT * QUANTITY_ORDERED) TOTAL_SALES_LAST_14_DAYS 
FROM DBO.fact_order
WHERE QUANTITY_ORDERED > 0
AND ORDER_DATE_TIME > DATEADD(DAY,-14,GETDATE())
GROUP BY ACCOUNT_ID
--************************************************************************************************
-- 4.Total Sales 30 days
SELECT 
	ACCOUNT_ID,
	SUM(TOTAL_CHARGED_AMT * QUANTITY_ORDERED) TOTAL_SALES_LAST_30_DAYS 
FROM DBO.fact_order
WHERE QUANTITY_ORDERED > 0
AND ORDER_DATE_TIME > DATEADD(DAY,-30,GETDATE())
GROUP BY ACCOUNT_ID

--************************************************************************************************
-- 5. Total Sales 3 months
SELECT 
	ACCOUNT_ID,
	SUM(TOTAL_CHARGED_AMT * QUANTITY_ORDERED) TOTAL_SALES_LAST_3_MONTHS
FROM DBO.fact_order
WHERE QUANTITY_ORDERED > 0
AND ORDER_DATE_TIME > DATEADD(MONTH,-3,GETDATE())
GROUP BY ACCOUNT_ID

--************************************************************************************************
-- 6. Total Sales 6 months
SELECT 
	ACCOUNT_ID,
	SUM(TOTAL_CHARGED_AMT * QUANTITY_ORDERED) TOTAL_SALES_LAST_3_MONTHS
FROM DBO.fact_order
WHERE QUANTITY_ORDERED > 0
AND ORDER_DATE_TIME > DATEADD(MONTH,-6,GETDATE())
GROUP BY ACCOUNT_ID

--************************************************************************************************
-- 7. Total Sales 1 year
SELECT 
	ACCOUNT_ID,
	SUM(TOTAL_CHARGED_AMT * QUANTITY_ORDERED) TOTAL_SALES_LAST_3_MONTHS
FROM DBO.fact_order
WHERE QUANTITY_ORDERED > 0
AND ORDER_DATE_TIME > DATEADD(YEAR,-1,GETDATE())
GROUP BY ACCOUNT_ID
--************************************************************************************************
--************************************************************************************************
--******************************* Total Sales *****************************************************

-- 8.  Total Quantity Ordered 14 days
-- 9.  Total Quantity Ordered 30 days
-- 10. Total Quantity Ordered 3 months
-- 11. Total Quantity Ordered 6 months
-- 12. Total Quantity Ordered 1 year








