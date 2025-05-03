create or alter procedure bronze.load_bronze As
Begin

Declare @Start_time Datetime, @end_time Datetime, @batch_Start_time Datetime, @Batch_End_Time Datetime;
Begin Try
Set @batch_Start_time= GETDATE()
	PRINT '==============================================';
	PRINT 'Loading Bronze Layer';
	PRINT '==============================================';


	PRINT '---------------------------------------------';
	PRINT 'Loading CRM Tables';
	PRINT '---------------------------------------------';

	Set @Start_time= GETDATE();

	PRINT '>> Truncating Table: bronze.crm_cust_info';
	Truncate table bronze.crm_cust_info;

	PRINT '>> Inserting Table: bronze .crm_cust_info';
	Bulk insert bronze.crm_cust_info
	from 'C:\Users\shash\Desktop\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
	with(
		Firstrow = 2,
		fieldterminator = ',',
		tablock
	);

	Set @end_time= GETDATE();
	print ' >>Load Duration: ' + Cast(Datediff(second, @Start_time,@end_time) as nvarchar) + ' Seconds';
	Print '----------------------'

	Set @Start_time= GETDATE();
	PRINT '>> Truncating Table: crm_prd_info '
	Truncate table bronze.crm_prd_info;

	PRINT '>> Inserting Table:crm_prd_info'
	Bulk insert bronze.crm_prd_info
	from 'C:\Users\shash\Desktop\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
	with ( 
		Firstrow = 2,
		fieldterminator = ',',
		tablock
	);

	Set @end_time= GETDATE();
	print ' >>Load Duration: ' + Cast(Datediff(second, @Start_time,@end_time) as nvarchar) + ' Seconds';
	Print '----------------------'

	Set @Start_time= GETDATE();
	PRINT '>> Truncating Table: crm_sales_details'
	Truncate table bronze.crm_sales_details;
	PRINT '>> Inserting Table: crm_sales_details'
	Bulk insert bronze.crm_sales_details
	from 'C:\Users\shash\Desktop\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
	with ( 
		Firstrow = 2,
		fieldterminator = ',',
		tablock
	);

	Set @end_time= GETDATE();
	print ' >>Load Duration: ' + Cast(Datediff(second, @Start_time,@end_time) as nvarchar) + ' Seconds';
	


	PRINT '---------------------------------------------'
	PRINT 'Loading ERP Tables'
	PRINT '---------------------------------------------'

	Set @Start_time= GETDATE();
	PRINT '>> Truncating Table:bronze.erp_loc_a101 '

	Truncate table bronze.erp_loc_a101;

	PRINT '>> Inserting Table: bronze.erp_loc_a101'
	Bulk insert bronze.erp_loc_a101
	from 'C:\Users\shash\Desktop\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
	with ( 
		Firstrow = 2,
		fieldterminator = ',',
		tablock
	);

	Set @end_time= GETDATE();
	print ' >>Load Duration: ' + Cast(Datediff(second, @Start_time,@end_time) as nvarchar) + ' Seconds';
	Print '----------------------'

	Set @Start_time= GETDATE();
	PRINT '>> Truncating Table: erp_cust_az12'
	Truncate table bronze.erp_cust_az12;

	PRINT '>> Inserting Table: erp_cust_az12'
	Bulk insert bronze.erp_cust_az12
	from 'C:\Users\shash\Desktop\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
	with ( 
		Firstrow = 2,
		fieldterminator = ',',
		tablock
	);

	Set @end_time= GETDATE();
	print ' >>Load Duration: ' + Cast(Datediff(second, @Start_time,@end_time) as nvarchar) + ' Seconds';
	Print '----------------------'

	Set @Start_time= GETDATE();
	PRINT '>> Truncating Table: erp_px_cat_g1v2'
	Truncate table bronze.erp_px_cat_g1v2;

	PRINT '>> Inserting Table:erp_px_cat_g1v2';
	Bulk insert bronze.erp_px_cat_g1v2
	from 'C:\Users\shash\Desktop\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
	with ( 
		Firstrow = 2,
		fieldterminator = ',',
		tablock
	);

	Set @end_time= GETDATE();
	print ' >>Load Duration: ' + Cast(Datediff(second, @Start_time,@end_time) as nvarchar) + ' Seconds';
	Print '----------------------'

	Set @Batch_End_Time= GETDATE()
	print ' >>Load Duration: ' + Cast(Datediff(second, @Batch_Start_Time,@Batch_End_Time) as nvarchar) + ' Seconds';
	Print '----------------------'
End Try

Begin Catch

	Print'====================================='
	print 'ERROR OCCURED DURING LOADING BRONZE LAYER'
	print 'Error Message'+ Error_message();
	print 'Error Message'+Cast(Error_Number() as Nvarchar);
	print 'Error Message'+Cast(Error_State() as Nvarchar);
	Print'====================================='
End Catch


End;

---
Exec bronze.load_bronze
