
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
--******************************* Total QUANTITY_ORDERED *****************************************

-- 8.  Total Quantity Ordered 14 days
SELECT 
	ACCOUNT_ID,
	SUM(QUANTITY_ORDERED) TOTAL_QUANTITY_LAST_14_DAYS 
FROM DBO.fact_order
WHERE QUANTITY_ORDERED > 0
AND ORDER_DATE_TIME > DATEADD(DAY,-14,GETDATE())
GROUP BY ACCOUNT_ID

-- 9.  Total Quantity Ordered 30 days
SELECT 
	ACCOUNT_ID,
	SUM(QUANTITY_ORDERED) TOTAL_QUANTITY_LAST_30_DAYS 
FROM DBO.fact_order
WHERE QUANTITY_ORDERED > 0
AND ORDER_DATE_TIME > DATEADD(DAY,-30,GETDATE())
GROUP BY ACCOUNT_ID

-- 10. Total Quantity Ordered 3 months
SELECT 
	ACCOUNT_ID,
	SUM(QUANTITY_ORDERED) TOTAL_QUANTITY_LAST_3_MONTHS
FROM DBO.fact_order
WHERE QUANTITY_ORDERED > 0
AND ORDER_DATE_TIME > DATEADD(MONTH,-3,GETDATE())
GROUP BY ACCOUNT_ID

-- 11. Total Quantity Ordered 6 months
SELECT 
	ACCOUNT_ID,
	SUM(QUANTITY_ORDERED) TOTAL_QUANTITY_LAST_6_MONTHS
FROM DBO.fact_order
WHERE QUANTITY_ORDERED > 0
AND ORDER_DATE_TIME > DATEADD(MONTH,-6,GETDATE())
GROUP BY ACCOUNT_ID

-- 12. Total Quantity Ordered 1 year
SELECT 
	ACCOUNT_ID,
	SUM(QUANTITY_ORDERED) TOTAL_QUANTITY_LAST_1_YEAR
FROM DBO.fact_order
WHERE QUANTITY_ORDERED > 0
AND ORDER_DATE_TIME > DATEADD(YEAR,-1,GETDATE())
GROUP BY ACCOUNT_ID

--************************************************************************************************
--************************************************************************************************
--******************************* Total Refund ***************************************************

-- 13. Total Refund 14 days
SELECT 
	ACCOUNT_ID,
	SUM(TOTAL_CHARGED_AMT * QUANTITY_RETURNED) TOTAL_REFUND_LAST_14_DAYS 
FROM DBO.fact_order
WHERE QUANTITY_RETURNED > 0
AND ORDER_DATE_TIME > DATEADD(DAY,-14,GETDATE())
GROUP BY ACCOUNT_ID

-- 14. Total Refund 30 days
SELECT 
	ACCOUNT_ID,
	SUM(TOTAL_CHARGED_AMT * QUANTITY_RETURNED) TOTAL_REFUND_LAST_30_DAYS 
FROM DBO.fact_order
WHERE QUANTITY_RETURNED > 0
AND ORDER_DATE_TIME > DATEADD(DAY,-30,GETDATE())
GROUP BY ACCOUNT_ID

-- 15. Total Refund 3 months
SELECT 
	ACCOUNT_ID,
	SUM(TOTAL_CHARGED_AMT * QUANTITY_RETURNED) TOTAL_REFUND_LAST_3_MONTHS
FROM DBO.fact_order
WHERE QUANTITY_RETURNED > 0
AND ORDER_DATE_TIME > DATEADD(MONTH,-3,GETDATE())
GROUP BY ACCOUNT_ID

-- 16. Total Refund 6 months
SELECT 
	ACCOUNT_ID,
	SUM(TOTAL_CHARGED_AMT * QUANTITY_RETURNED) TOTAL_REFUND_LAST_6_MONTHS
FROM DBO.fact_order
WHERE QUANTITY_RETURNED > 0
AND ORDER_DATE_TIME > DATEADD(MONTH,-6,GETDATE())
GROUP BY ACCOUNT_ID

-- 17. Total Refund 1 year
SELECT 
	ACCOUNT_ID,
	SUM(TOTAL_CHARGED_AMT * QUANTITY_RETURNED) TOTAL_REFUND_LAST_1_YEAR
FROM DBO.fact_order
WHERE QUANTITY_RETURNED > 0
AND ORDER_DATE_TIME > DATEADD(YEAR,-1,GETDATE())
GROUP BY ACCOUNT_ID


--************************************************************************************************
--************************************************************************************************
--******************************* Total Quantity Returned ****************************************

-- 18. Total Quantity Returned 14 days
SELECT 
	ACCOUNT_ID,
	SUM(QUANTITY_RETURNED) TTL_QUANTITY_RETURNED_LAST_14_DAYS 
FROM DBO.fact_order
WHERE QUANTITY_RETURNED > 0
AND ORDER_DATE_TIME > DATEADD(DAY,-14,GETDATE())
GROUP BY ACCOUNT_ID

-- 19. Total Quantity Returned 30 days
SELECT 
	ACCOUNT_ID,
	SUM(QUANTITY_RETURNED) TTL_QUANTITY_RETURNED_LAST_30_DAYS 
FROM DBO.fact_order
WHERE QUANTITY_RETURNED > 0
AND ORDER_DATE_TIME > DATEADD(DAY,-30,GETDATE())
GROUP BY ACCOUNT_ID

-- 20. Total Quantity Returned 3 months
SELECT 
	ACCOUNT_ID,
	SUM(QUANTITY_RETURNED) TTL_QUANTITY_RETURNED_LAST_3_MONTHS
FROM DBO.fact_order
WHERE QUANTITY_RETURNED > 0
AND ORDER_DATE_TIME > DATEADD(MONTH,-3,GETDATE())
GROUP BY ACCOUNT_ID

-- 21. Total Quantity Returned 6 months
SELECT 
	ACCOUNT_ID,
	SUM(QUANTITY_RETURNED) TTL_QUANTITY_RETURNED_LAST_6_MONTHS
FROM DBO.fact_order
WHERE QUANTITY_RETURNED > 0
AND ORDER_DATE_TIME > DATEADD(MONTH,-6,GETDATE())
GROUP BY ACCOUNT_ID

-- 22. Total Quantity Returned 1 year
SELECT 
	ACCOUNT_ID,
	SUM(QUANTITY_RETURNED) TTL_QUANTITY_RETURNED_LAST_1_YEAR
FROM DBO.fact_order
WHERE QUANTITY_RETURNED > 0
AND ORDER_DATE_TIME > DATEADD(MONTH,-1,GETDATE())
GROUP BY ACCOUNT_ID


--************************************************************************************************
--************************************************************************************************
--2. Top 10 customers ordered by Total Sales having more than 3 orders in their lifetime

WITH TOP_1O_CUSTOEMRS AS 
(
	SELECT 
		F1.account_id,
		F1.total_charged_amt,
		COUNT(F1.order_id) OVER (PARTITION BY ACCOUNT_ID) COUNT_OF_ORDERS_PER_ACCOUNT,
		SUM (F1.TOTAL_CHARGED_AMT * F1.QUANTITY_ORDERED) OVER (PARTITION BY ACCOUNT_ID) TOTAL_SALES_PER_ACCOUNT
	FROM DBO.fact_order AS F1
	WHERE QUANTITY_ORDERED > 0
)
SELECT DISTINCT TOP 10 ACCOUNT_ID, TOTAL_SALES_PER_ACCOUNT FROM TOP_1O_CUSTOEMRS AS T1
WHERE T1.COUNT_OF_ORDERS_PER_ACCOUNT > 3
ORDER BY 2 DESC


--************************************************************************************************
--************************************************************************************************



