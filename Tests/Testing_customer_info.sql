-- duplicate and null check
-- expectation should be no result if not 
-- we should handle duplicates and nulls using row_number function

select 
cst_id,
count(*) 
from silver.crm_cust_info
group by cst_id
having count(*) >1

select * from silver.crm_cust_info

-- checking for unwanted spaces from all columns having string values
-- expectation should be no result
select 
cst_firstname
from silver.crm_cust_info
where cst_firstname != TRIM(cst_firstname)

select 
cst_lastname
from silver.crm_cust_info
where cst_lastname != TRIM(cst_lastname)

select 
cst_marital_status
from silver.crm_cust_info
where cst_marital_status != TRIM(cst_marital_status)

select 
cst_gndr
from silver.crm_cust_info
where cst_gndr != TRIM(cst_gndr)

-- Data Standardization and Consistency

-- In our data warehouse, we aim to store 
-- clear and meaningful values rather than using abbrivated terms

SELECT DISTINCT cst_gndr FROM silver.crm_cust_info

SELECT DISTINCT cst_marital_status FROM silver.crm_cust_info

-- check for date columns and check for fomatts
-- At the end do quality checks
--===========================================================================================
