-- 1.run the command(dbt run --select products_clean) to execute below script
-- 2.check the written table in: SELECT * FROM DBT_DB.DBT_DEV_AMAN.PRODUCTS_CLEAN;

{{ config(materialized='table') }}

SELECT
  PRODUCT_ID,
  PRODUCT_NAME,
  CATEGORY,
  PRICE,
  STOCK_QUANTITY,
  PRICE * STOCK_QUANTITY AS INVENTORY_VALUE
FROM {{ source('raw', 'PRODUCTS') }}