-- duplicate and null check
-- Expectation no result
select 
Prod_id,
count(*) 
from bronze.crm_prd_info
group by Prod_id
having count(*) > 1 or prod_id is null
-- Outcome : No Result

select distinct prd_key from bronze.crm_prd_info;
select distinct sls_prd_key from bronze.crm_sales_details

-- Check key closely take experts opinions

-- check any space in prd_nm and all columns with string value
select prd_nm from bronze.crm_prd_info 
where prd_nm != TRIM(prd_nm)

-- check for nulls or negtive numbers in prd_cost
select prd_cost from bronze.crm_prd_info
where prd_cost <0 or prd_cost is Null


SELECT
prd_id,
prd_key,
REPLACE(SUBSTRING(prd_key,1,5),'-','_') AS cat_id,
SUBSTRING(prd_key,7,LEN(prd_key)) AS prd_key,
prd_nm,
ISNULL(prd_cost,0) as prd_cost,
CASE WHEN UPPER(TRIM(prd_line)) = 'M' THEN 'Mountain'
     WHEN UPPER(TRIM(prd_line)) = 'R' THEN 'Road'
     WHEN UPPER(TRIM(prd_line)) = 'S' THEN 'Other Sales'
     WHEN UPPER(TRIM(prd_line)) = 'T' THEN 'Touring'
     ELSE 'n/a'
END AS prd_line,
CAST(prd_start_dt AS DATE) AS prd_start_dt ,
LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt) AS prd_end_dt
FROM bronze.crm_prd_info

select * from silver.crm_prd_info