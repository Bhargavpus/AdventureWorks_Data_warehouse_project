

-- In order to connet the two tables as per entity relationship 
-- check for keys that are not in silver_crm_cust_ino
select 
cid,
cntry
from bronze.erp_loc_a101
where cid not in (select cst_key from silver.crm_cust_info)

-- As per result cid in erp.loc_a101 has - in the cid compare to cust_id 
-- in crm_cust_info which actually key to combine the table hence modify
SELECT 
REPLACE(cid,'-','') AS cid
FROM Bronze.erp_loc_a101

-- Normalize and Handle missing or Blank country column (standardization)
SELECT 
REPLACE(cid,'-','') AS cid,
CASE WHEN TRIM(cntry) = 'DE' THEN 'Germany'
     WHEN TRIM(cntry) IN ('US','USA') THEN 'United States'
     WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
END AS cntry
FROM Bronze.erp_loc_a101


-- Cleaned customer_location
INSERT INTO  silver.erp_loc_a101(
    cid,
    cntry
)
SELECT 
REPLACE(cid,'-','') AS cid,
CASE WHEN TRIM(cntry) = 'DE' THEN 'Germany'
     WHEN TRIM(cntry) IN ('US','USA') THEN 'United States'
     WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
END AS cntry
FROM Bronze.erp_loc_a101





select distinct cntry from bronze.erp_loc_a101


select cst_key from silver.crm_cust_info