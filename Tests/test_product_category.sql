select id,cat,subcat,maintenance from bronze.erp_px_cat_g1v2

-- check for unmatched key from other table as per entity relation model

-- check for unwanted spaces
SELECT * 
FROM bronze.erp_px_cat_g1v2
where 
cat != trim(cat) 
or subcat != TRIM(subcat) 
or maintenance != TRIM(maintenance)


select distinct cat from bronze.erp_px_cat_g1v2
select distinct subcat from bronze.erp_px_cat_g1v2
select distinct maintenance from bronze.erp_px_cat_g1v2
-- NO changes quality of the table is good



-- cleaned Product category
INSERT INTO silver.erp_px_cat_g1v2(
id,
cat,
subcat,
maintenance
)
SELECT 
id,
cat,
subcat,
maintenance 
FROM bronze.erp_px_cat_g1v2



select * from silver.erp_px_cat_g1v2
