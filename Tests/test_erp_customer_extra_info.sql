select * from bronze.erp_cust_az12
-- Identity unmatching data of cid from table which it is related
-- Identify birthdays out of ranges anamolies

-- Data standardization and consistency
SELECT distinct gen from bronze.erp_cust_az12
INSERT INTO silver.erp_cust_az12(
    cid,
    bdate,
    gen
)
SELECT 
CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid,4,LEN(cid))
     ELSE cid
END as cid,
CASE WHEN bdate > GETDATE() THEN NULL
     ELSE bdate
END AS bdate,
CASE WHEN UPPER(TRIM(gen)) IN ('F','FEMALE') THEN 'Female'
     WHEN UPPER(TRIM(gen)) IN ('M','MALE') THEN 'male'
     ELSE 'n/a'
END AS gen
FROM bronze.erp_cust_az12

-- Check ddl statements if any datatype to change
-- And always do qunatity check