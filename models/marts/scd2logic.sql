-- scd2 logic
-- if table is not created then run this---> dbt run --full-refresh --select scd2logic
-- then run as usual: dbt run

{{ config(
    materialized='incremental',
    unique_key='product_sk',
    incremental_strategy='merge',
    post_hook="
        UPDATE {{ this }} t
        SET valid_to = CURRENT_TIMESTAMP(),
            is_current = FALSE
        FROM {{ ref('staging_products') }} s
        WHERE t.product_id = s.product_id
          AND t.is_current = TRUE
          AND t.row_hash <> s.row_hash
          AND t.valid_to IS NULL
    "
) }}

with source_data as (

    select
        product_id,
        product_name,
        category,
        price,
        stock_quantity,
        row_hash,
        current_timestamp() as valid_from,
        null as valid_to,
        true as is_current,
        price * stock_quantity as inventory_value,

        -- version surrogate key
        md5(product_id || '-' || current_timestamp()) as product_sk

    from {{ ref('staging_products') }}

)

{% if is_incremental() %}
, current_target as (
    select *
    from {{ this }}
    where is_current = true
)
{% endif %}

select
    s.product_id,
    s.product_name,
    s.category,
    s.price,
    s.stock_quantity,
    s.row_hash,
    s.valid_from,
    s.valid_to,
    s.is_current,
    s.inventory_value,
    s.product_sk

from source_data s

{% if is_incremental() %}
left join current_target t
  on s.product_id = t.product_id
where
       t.product_id is null
   or  s.row_hash <> t.row_hash
{% endif %}