{{ config(materialized='table') }}

SELECT
  PRODUCT_ID::INTEGER AS product_id,
  TRIM(PRODUCT_NAME) AS product_name,
  UPPER(CATEGORY) AS category,
  PRICE::NUMBER(10,2) AS price,
  STOCK_QUANTITY::INTEGER AS stock_quantity,
  MD5(CONCAT(
    COALESCE(PRODUCT_NAME::VARCHAR, ''),
    COALESCE(CATEGORY::VARCHAR, ''),
    COALESCE(PRICE::VARCHAR, ''),
    COALESCE(STOCK_QUANTITY::VARCHAR, '')
  )) AS row_hash
FROM {{ source('raw', 'PRODUCTS') }}