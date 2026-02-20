-- Purpose:
-- ✔ Clean structure
-- ✔ Consistent naming
-- ✔ Safe reusable base
-- ✔ One-to-one with source tables

{{ config(materialized='view') }}

SELECT
  PRODUCT_ID::INTEGER AS product_id,
  TRIM(PRODUCT_NAME) AS product_name,
  UPPER(CATEGORY) AS category,
  PRICE::NUMBER(10,2) AS price,
  STOCK_QUANTITY::INTEGER AS stock_quantity
FROM {{ source('raw', 'PRODUCTS') }}