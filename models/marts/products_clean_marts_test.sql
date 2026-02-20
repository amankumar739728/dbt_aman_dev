{{ config(materialized='table') }}

SELECT
  product_id,
  product_name,
  category,
  price,
  stock_quantity,
  price * stock_quantity AS inventory_value
FROM {{ ref('stg_products') }}