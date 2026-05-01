/*
==================================================================

Stored procedure: Load Bronze Layer (Source -> Bronze)

===================================================================
Script Purpose:
	This stored procedure loads data into the 'bronze' schema from external CSV files.
	it perform the following actions:
	- Truncates the bronze tables before loading data.
	-Useing the 'BULK INSERT' command to load data from csv files to bronze tables.

===================================================================
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @Start_time DATETIME , @End_time DATETIME , @batch_start_time DATETIME ,@batch_end_time DATETIME;
	BEGIN TRY 
		SET @batch_start_time=GETDATE()
		PRINT '===============================';
		PRINT 'Loading The Bronze Layer';
		PRINT '===============================';


		PRINT '----------------------------------';
		PRINT 'Loading The CRM Tables';
		PRINT '----------------------------------';

		SET @Start_time =GETDATE()
		PRINT '>>Truncating The bronze.crm_cust_info Table '
		PRINT '>>Inserting The bronze.crm_cust_info Table '
		TRUNCATE TABLE bronze.crm_cust_info;
		BULK INSERT bronze.crm_cust_info 
		FROM 'C:\Users\Omarr\OneDrive\Desktop\datasets\source_crm/cust_info.csv'
		WITH(
			FIRSTROW = 2 ,
			FIELDTERMINATOR =',',
			TABLOCK 
	);	SET @End_time =GETDATE()
	PRINT'>>Load Duration:'+ CAST(DATEDIFF(second,@Start_time,@End_time)AS NVARCHAR)+ ' Second';

		SET @Start_time =GETDATE()
		PRINT '>>Truncating The bronze.crm_prd_info Table '
		PRINT '>>Inserting The bronze.crm_prd_info Table'
		TRUNCATE TABLE bronze.crm_prd_info
		BULK INSERT bronze.crm_prd_info 
		FROM 'C:\Users\Omarr\OneDrive\Desktop\datasets\source_crm/prd_info.csv'
		WITH(
			FIRSTROW = 2 ,
			FIELDTERMINATOR =',',
			TABLOCK 
	);	SET @End_time =GETDATE()
		PRINT'>>Load Duration:'+ CAST(DATEDIFF(second,@Start_time,@End_time)AS NVARCHAR)+ ' Second';

		SET @Start_time =GETDATE()
		PRINT '>>Truncating The bronze.crm_sales_details Table '
		PRINT '>>Inserting The bronze.crm_sales_details Table'
		TRUNCATE TABLE bronze.crm_sales_details;
		BULK INSERT bronze.crm_sales_details 
		FROM 'C:\Users\Omarr\OneDrive\Desktop\datasets\source_crm/sales_details.csv'
		WITH(
			FIRSTROW = 2 ,
			FIELDTERMINATOR =',',
			TABLOCK 
	);	SET @End_time =GETDATE()
		PRINT'>>Load Duration:'+ CAST(DATEDIFF(second,@Start_time,@End_time)AS NVARCHAR)+ ' Second';

		PRINT '----------------------------------';
		PRINT 'Loading The ERP Tables';
		PRINT '----------------------------------';

		SET @Start_time =GETDATE()
		PRINT '>>Truncating The bronze.erp_CUST_AZ12 Table '
		PRINT '>>Inserting The bronze.erp_CUST_AZ12 Table'
		TRUNCATE TABLE bronze.erp_CUST_AZ12 ;
		BULK INSERT bronze.erp_CUST_AZ12 
		FROM 'C:\Users\Omarr\OneDrive\Desktop\datasets\source_erp/CUST_AZ12.csv'
		WITH(
			FIRSTROW = 2 ,
			FIELDTERMINATOR =',',
			TABLOCK 
		);
		SET @End_time=GETDATE()
		PRINT 'Loading Duration:'+CAST(DATEDIFF(second,@Start_time,@End_time)AS NVARCHAR)+ ' Second';

		SET @Start_time= GETDATE()
		PRINT '>>Truncating The bronze.erp_LOC_A101 Table '
		PRINT '>>Inserting The bronze.erp_LOC_A101 Table'
		TRUNCATE TABLE bronze.erp_LOC_A101;
		BULK INSERT bronze.erp_LOC_A101 
		FROM 'C:\Users\Omarr\OneDrive\Desktop\datasets\source_erp/LOC_A101.csv'
		WITH(
			FIRSTROW = 2 ,
			FIELDTERMINATOR =',',
			TABLOCK 
		);
		SET @End_time=GETDATE()
		PRINT'Loadind Duration:'+CAST(DATEDIFF(second,@Start_time,@End_time)AS NVARCHAR)+ ' Second';


		SET @Start_time=GETDATE()
		PRINT '>>Truncating The bronze.erp_PX_CAT_G1V2 Table '
		PRINT '>>Inserting The bronze.erp_PX_CAT_G1V2 Table'
		TRUNCATE TABLE bronze.erp_PX_CAT_G1V2;
		BULK INSERT bronze.erp_PX_CAT_G1V2 
		FROM 'C:\Users\Omarr\OneDrive\Desktop\datasets\source_erp/PX_CAT_G1V2.csv'
		WITH(
			FIRSTROW = 2 ,
			FIELDTERMINATOR =',',
			TABLOCK
			);
			SET @End_time =GETDATE()
			PRINT'Loading Duration:'+ CAST(DATEDIFF(second,@Start_time,@End_time)AS NVARCHAR)+ ' Second';


			SET @batch_end_time=GETDATE();
			PRINT '==============================';
			PRINT'Loading Bronze Layer is completed';
			PRINT'Total Load Duration: '+CAST(DATEDIFF(second,@start_time,@End_time)AS NVARCHAR )+' second';
			PRINT '=============================='

	END TRY 
	BEGIN CATCH
	PRINT '========================'
	PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
	PRINT 'Error Message'+ ERROR_MESSAGE();
	PRINT 'Error Message'+ CAST (ERROR_NUMBER() AS NVARCHAR);
	PRINT 'Error Message'+CAST(ERROR_STATE() AS NVARCHAR);
	PRINT '========================'
	END CATCH
END ;
