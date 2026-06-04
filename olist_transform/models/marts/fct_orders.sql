with orders as (
    select 
        order_id,
        customer_id,
        order_status,
        -- Architect Move: Remap the staging column name to match our fact schema contract
        purchase_at as purchased_at
    from {{ ref('stg_orders') }}
),

items as (
    select 
        order_id,
        sum(item_price) as total_item_revenue,
        sum(freight_cost) as total_freight_revenue,
        count(order_id) as total_items_ordered
    from {{ ref('stg_order_item') }}
    group by order_id
),

payments as (
    select 
        order_id,
        sum(total_payment_amount) as total_amount_paid
    from {{ ref('stg_order_payments') }}
    group by order_id
)

select
    -- Dimensions & Keys
    o.order_id,
    o.customer_id,
    o.order_status,
    o.purchased_at,
    date_trunc('month', o.purchased_at) as order_month,
    
    -- Financial Metrics
    coalesce(i.total_item_revenue, 0.00) as item_revenue,
    coalesce(i.total_freight_revenue, 0.00) as freight_revenue,
    coalesce(p.total_amount_paid, 0.00) as total_revenue,
    coalesce(i.total_items_ordered, 0) as total_items_ordered

from orders o
left join items i on o.order_id = i.order_id
left join payments p on o.order_id = p.order_id