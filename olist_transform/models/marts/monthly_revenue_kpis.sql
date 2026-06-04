with monthly_base_metrics as (
    select
        order_month,
        sum(total_revenue) as gross_revenue,
        count(distinct order_id) as total_orders
    from {{ ref('fct_orders') }}
    -- Enterprise Move: Only calculate financial metrics on finalized, delivered sales
    where order_status = 'delivered'
    group by 1
)

select
    order_month,
    round(gross_revenue, 2) as gross_revenue,
    total_orders,
    -- Compute Average Order Value (AOV)
    round(gross_revenue / total_orders, 2) as average_order_value,
    
    -- Cache previous month's revenue using a window function for MoM comparison
    round(lag(gross_revenue) over (order by order_month), 2) as previous_month_revenue,
    
    -- Compute Month-on-Month Growth Rate %
    round(
        ((gross_revenue - lag(gross_revenue) over (order by order_month)) / lag(gross_revenue) over (order by order_month)) * 100, 
        2
    ) as mom_growth_pct

from monthly_base_metrics
order by order_month