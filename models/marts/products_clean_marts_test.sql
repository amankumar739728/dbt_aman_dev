{{ config(materialized='table') }}

SELECT
  product_id,
  product_name,
  category,
  price,
  stock_quantity,
  price * stock_quantity AS inventory_value,
  CURRENT_TIMESTAMP() AS updated_at
FROM {{ ref('staging_products') }}