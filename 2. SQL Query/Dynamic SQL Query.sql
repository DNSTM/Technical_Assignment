CREATE PROCEDURE DBO.ORDER_LTV 
	@FACT_TYPE NVARCHAR (400),          /* SALES, QUANTITY ORDERED, REFUND, QUANTITY RETURNED  */
	@DURATION_INDICATOR NVARCHAR (400), /* DAY, MONTH, YEAR */ 
	@DURATION_VALUE INT					/* INTEGER VALUE */
AS
BEGIN
	DECLARE @QUERY NVARCHAR (MAX);
	DECLARE @FIELD_NAME NVARCHAR (200);

	IF @DURATION_VALUE < 1 
	BEGIN
		PRINT 'ERROR: Invalid duration value. You should enter positive integer value.' ;
		RETURN;
	END;  

	-- Confirmation for the parameter @fact_type
	IF UPPER (@FACT_TYPE) NOT IN ('SALES', 'QUANTITY ORDERED', 'REFUND', 'QUANTITY RETURNED')
	BEGIN
		PRINT 'ERROR: Invalid fact type. You should choose one of (SALES, QUANTITY ORDERED, REFUND, QUANTITY RETURNED) ' ;
		RETURN;
	END;

	-- Confirmation for the parameter @duration_indicator
	IF UPPER (@DURATION_INDICATOR) NOT IN ('DAY', 'MONTH', 'YEAR')
	BEGIN
		PRINT 'ERROR: Invalid duration indicator. You should choose one of (DAY, MONTH, YEAR) ' ;
		RETURN;
	END;
	
	IF UPPER (@FACT_TYPE) = 'SALES'
	BEGIN

		SET @QUERY = '
			SELECT 
				ACCOUNT_ID,
				SUM(TOTAL_CHARGED_AMT * QUANTITY_ORDERED) TOTAL_SALES_LAST_' + CAST(@DURATION_VALUE AS NVARCHAR (100))+ '_' + UPPER (@DURATION_INDICATOR) + ' 
			FROM DBO.fact_order
			WHERE QUANTITY_ORDERED > 0
			AND ORDER_DATE_TIME > DATEADD(' + UPPER (@DURATION_INDICATOR) + ',-' + CAST (@DURATION_VALUE AS NVARCHAR (100))+ ',GETDATE())
			GROUP BY ACCOUNT_ID
		';
	END
	ELSE IF UPPER (@FACT_TYPE) = 'QUANTITY ORDERED'
	BEGIN

		SET @QUERY = '
			SELECT 
				ACCOUNT_ID,
				SUM(QUANTITY_ORDERED) TOTAL_QUANTITY_LAST_' + CAST(@DURATION_VALUE AS NVARCHAR (100)) + '_' + UPPER (@DURATION_INDICATOR) + '
			FROM DBO.fact_order
			WHERE QUANTITY_ORDERED > 0
			AND ORDER_DATE_TIME > DATEADD(' + UPPER (@DURATION_INDICATOR) + ',-' + CAST(@DURATION_VALUE AS NVARCHAR (100)) + ',GETDATE())
			GROUP BY ACCOUNT_ID
		';
	END
	ELSE IF UPPER (@FACT_TYPE) = 'REFUND'
	BEGIN

		SET @QUERY = '
			SELECT 
				ACCOUNT_ID,
				SUM(TOTAL_CHARGED_AMT * QUANTITY_RETURNED) TOTAL_REFUND_LAST_' + CAST(@DURATION_VALUE AS NVARCHAR (100)) + '_' + UPPER (@DURATION_INDICATOR) + '
			FROM DBO.fact_order
			WHERE QUANTITY_RETURNED > 0
			AND ORDER_DATE_TIME > DATEADD(' + UPPER (@DURATION_INDICATOR) + ',-' + CAST(@DURATION_VALUE AS NVARCHAR (100)) + ',GETDATE())
			GROUP BY ACCOUNT_ID
		';
	END
	ELSE IF UPPER (@FACT_TYPE) = 'QUANTITY RETURNED'
	BEGIN

		SET @QUERY = '
			SELECT 
				ACCOUNT_ID,
				SUM(QUANTITY_RETURNED) TTL_QUANTITY_RETURNED_LAST_' + CAST(@DURATION_VALUE AS NVARCHAR (100)) + '_' + UPPER (@DURATION_INDICATOR) + '
			FROM DBO.fact_order
			WHERE QUANTITY_RETURNED > 0
			AND ORDER_DATE_TIME > DATEADD(' + UPPER (@DURATION_INDICATOR) + ',-' + CAST(@DURATION_VALUE AS NVARCHAR (100)) + ',GETDATE())
			GROUP BY ACCOUNT_ID
		';
	END;
	
	EXEC SP_EXECUTESQL @QUERY

END; 


EXEC DBO.ORDER_LTV 'REFUND' , 'YEAR', 2