--- Check relation between tables using entity-relation/integration diagram
select * 
from bronze.crm_sales_details
where sls_prd_key not in (select prd_key from  silver.crm_prd_info)

select * 
from bronze.crm_sales_details
where sls_cust_id not in (select cst_id from  silver.crm_cust_info)


-- Checking Date columns
select 
nullif(sls_order_dt,0) sls_order_dt
from bronze.crm_sales_details
WHERE sls_order_dt <= 0 
or len(sls_order_dt) != 8
or sls_order_dt > 20500101
or sls_order_dt < 19000101

-- Check Data consistency between sales quantity and Price
-- >> sales = Quanity* price
-- >> Values must not be null, Zero or negtive

SELECT DISTINCT
sls_sales,
sls_quantity,
sls_price,
CASE WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity * ABS(sls_price)
     THEN sls_quantity * ABS(sls_price)
END AS sla_sales,
CASE WHEN sls_price IS NULL OR sls_price <= 0
     THEN sls_sales /NULLIF(sls_quantity,0)
END AS sls_price
FROM bronze.crm_sales_details
where sls_sales != sls_quantity*sls_price
or sls_sales is null or sls_quantity is null or sls_price is null
or sls_sales <=0 or sls_quantity <= 0 or sls_price<=0
order by sls_sales,sls_quantity,sls_price

-- AT the end always check DDL statement if any modifications to be done
-- AND always do quality check



SELECT
sls_ord_num,
sls_prd_key,
sls_cust_id,
CASE WHEN sls_order_dt = 0 OR LEN(sls_order_dt) != 8 THEN NULL
     ELSE  CAST(CAST(sls_order_dt AS VARCHAR) AS DATE)
END AS sls_order_dt,
CASE WHEN sls_ship_dt = 0 OR LEN(sls_ship_dt) != 8 THEN NULL
     ELSE  CAST(CAST(sls_ship_dt AS VARCHAR) AS DATE)
END AS sls_ship_dt,
CASE WHEN sls_due_dt = 0 OR LEN(sls_due_dt) != 8 THEN NULL
     ELSE  CAST(CAST(sls_due_dt AS VARCHAR) AS DATE)
END AS sls_due_dt,
CASE WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity * ABS(sls_price)
     THEN sls_quantity * ABS(sls_price)
     ELSE sls_sales
END AS sla_sales,
sls_quantity,
CASE WHEN sls_price IS NULL OR sls_price <= 0
     THEN sls_sales /NULLIF(sls_quantity,0)
     ELSE sls_price
END AS sls_price
FROM bronze.crm_sales_details
