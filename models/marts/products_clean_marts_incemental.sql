-- dbt run --full-refresh --select products_clean_marts_incemental

-- incremental model
{{ config(
    materialized='incremental',
    unique_key='product_id'
) }}

SELECT
  s.product_id,
  s.product_name,
  s.category,
  s.price,
  s.stock_quantity,
  CURRENT_TIMESTAMP() AS updated_at,
  s.row_hash,
  s.price * s.stock_quantity AS inventory_value
FROM {{ ref('staging_products') }} s

{% if is_incremental() %}
LEFT JOIN {{ this }} t
  ON s.product_id = t.product_id
WHERE t.row_hash IS NULL OR s.row_hash <> t.row_hash
{% endif %}