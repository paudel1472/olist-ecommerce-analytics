with source_data as (
    select * from {{ source('olist_raw', 'raw_order_items') }}
)

select
    order_id,
    order_item_id,
    product_id,
    cast(price as decimal(10,2)) as item_price,
    cast(freight_value as decimal(10,2)) as freight_cost

from source_data