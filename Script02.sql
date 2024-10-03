select c.name, c.surname, count(o.order_id) as total_orders
from opt_clients c
join opt_orders o on c.id = o.client_id
join opt_products p on o.product_id = p.product_id
where o.order_date >= '2023-01-01'
group by c.id, c.name, c.surname



create index idx_client_id on opt_orders(client_id);
create index idx_order_date on opt_orders(order_date);

with client_orders as (
    select o.client_id, count(o.order_id) as total_orders
    from opt_orders o
    where o.order_date >= '2023-01-01'
    group by o.client_id
)
select c.name, c.surname, coalesce(co.total_orders, 0) as total_orders
from opt_clients c
left join client_orders co on c.id = co.client_id;
