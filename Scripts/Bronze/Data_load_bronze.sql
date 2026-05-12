
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    DECLARE @start_time DATETIME , @end_time DATETIME , @batch_start_time DATETIME, @batch_end_time DATETIME;
    BEGIN TRY
	    SET @batch_start_time = GETDATE();
		PRINT '============================================='
		PRINT 'Loading Bronze Layer'
		PRINT '============================================='


		PRINT '----------------------------------------------'
		PRINT 'Loading CRM Tables'
		PRINT '----------------------------------------------'

		SET @start_time = GETDATE()
		PRINT '>> Truncating Table: bronze.crm_cust_info <<'
		TRUNCATE TABLE bronze.crm_cust_info

		PRINT '>> Inserting Table: bronze.crm_cust_info <<'
		BULK INSERT Bronze.crm_cust_info
		fROM 
		'C:\Users\bharg\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ','
		)
		SET @end_time = GETDATE()
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' Seconds';
		PRINT '>> ----------------------------------<<'


		SET @start_time = GETDATE()
		PRINT '>> Truncating Table: bronze.crm_cust_info <<'
		TRUNCATE TABLE Bronze.crm_prd_info

		PRINT '>> Inserting Table: bronze.crm_cust_info <<'
		BULK INSERT Bronze.crm_prd_info
		FROM 
		'C:\Users\bharg\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ','
		)
		SET @end_time = GETDATE()
		PRINT 'Load Duration:' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+ ' Seconds';
		PRINT '<<----------------------------->>'

		SET @start_time = GETDATE()
		PRINT '>> Truncating Table: Bronze.crm_sales_details <<'
		TRUNCATE TABLE Bronze.crm_sales_details

		PRINT '>> Inserting Table:Bronze.crm_sales_details <<'
		BULK INSERT Bronze.crm_sales_details
		FROM 'C:\Users\bharg\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ','
		)
		SET @end_time = GETDATE()
		PRINT 'Load Duration:' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+ ' Seconds';
		PRINT '<<----------------------------->>'



		PRINT '--------------------------------------------------'
		PRINT 'Loading ERP Tables'
		PRINT '--------------------------------------------------'

		SET @start_time = GETDATE()
		PRINT '>> Truncating Table:Bronze.erp_cust_az12 <<'
		TRUNCATE TABLE Bronze.erp_cust_az12

		PRINT '>> Inserting Table:Bronze.erp_cust_az12 <<'
		BULK INSERT Bronze.erp_cust_az12
		FROM 'C:\Users\bharg\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ','
		)
		SET @end_time = GETDATE()
		PRINT 'Load Duration:' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+ ' Seconds';
		PRINT '<<----------------------------->>'

		
		SET @start_time = GETDATE()
		PRINT '>> Truncating Table:Bronze.erp_loc_a101 <<'
		TRUNCATE TABLE Bronze.erp_loc_a101
		PRINT '>> Inserting Table:Bronze.erp_loc_a101 <<'
		BULK INSERT Bronze.erp_loc_a101
		FROM 'C:\Users\bharg\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ','
		)
		SET @end_time = GETDATE()
		PRINT 'Load Duration:' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+ ' Seconds';
		PRINT '<<----------------------------->>'

		
		SET @start_time = GETDATE()
		PRINT '>> Truncating Table:Bronze.erp_px_cat_g1v2 <<'
		TRUNCATE TABLE Bronze.erp_px_cat_g1v2
		PRINT '>> Inserting Table:Bronze.erp_px_cat_g1v2 <<'
		BULK INSERT Bronze.erp_px_cat_g1v2
		FROM 'C:\Users\bharg\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ','
		)
		SET @end_time = GETDATE()
		PRINT 'Load Duration:' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+ ' Seconds';
		PRINT '<<----------------------------->>'

		SET @batch_end_time = GETDATE();
		PRINT '================================================'
		PRINT 'Loading bronze Layer is Completed';
		PRINT '  - Total Load Duration ' + CAST(DATEDIFF(second,@batch_start_time,@batch_end_time) as NVARCHAR) + ' Seconds'
		PRINT '================================================'


	END TRY
	BEGIN CATCH
	    PRINT '=================================================='
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
		PRINT 'ERROR MESSAGE' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'ERROR MESSAGE' + CAST(ERROR_STATE() AS NVARCHAR)
		PRINT '=================================================='
	END CATCH
END