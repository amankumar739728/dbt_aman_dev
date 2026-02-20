--It references staging, not source also it creates dependency order automatically
-- Purpose:
-- ✔ Final analytics tables
-- ✔ Business meaning
-- ✔ Optimized for queries

{{ config(materialized='table') }}

SELECT
  product_id,
  product_name,
  category,
  price,
  stock_quantity,
  price * stock_quantity AS inventory_value
FROM {{ ref('stg_products') }}