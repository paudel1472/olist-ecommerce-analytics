with source_data as (
    select * from {{ source('olist_raw', 'raw_orders') }}
)

select 
    order_id,
    customer_id,
    order_status,
    cast(order_purchase_timestamp as TIMESTAMP) as purchase_at
from source_data