with sales as(
    select 
        sales_id,
        date_sk,
        product_sk,
        customer_sk,
        quantity,
        unit_price
    from
        {{ ref('bronze-sales') }}
),


product as(
    select 
        product_sk,
        product_name,
        category
    from
        {{ ref('bronze-product') }}
),

customer as(
    select 
        customer_sk,
        first_name,
        last_name,
        loyalty_tier,
        gender
    from
        {{ ref('bronze-customer') }}
),

joined_query as(
select 
    s.sales_id,
    c.first_name,
    c.last_name,
    c.loyalty_tier,
    c.gender,
    p.product_name,
    p.category,
    {{ multiply('s.quantity', 's.unit_price') }} as total_price
from
    sales s
    left join product p
    on s.product_sk = p.product_sk
    left join customer c
    on s.customer_sk = c.customer_sk
)


select 
    gender,
    category,
    sum(total_price) as total_sales
from joined_query
group by 
    gender,
    category
order by 
    total_sales desc

