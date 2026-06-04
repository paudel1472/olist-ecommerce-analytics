with source_data as (
    select * from {{ source('olist_raw', 'raw_order_payments') }}
)
select
    order_id,
    payment_type,
    cast(payment_value as decimal(10,2)) as total_payment_amount
from source_data