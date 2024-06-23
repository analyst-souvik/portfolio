select * from customers;
select * from geolocation;
select * from olist_orders;
select * from order_items;
select * from order_payments;
select * from order_reviews;
select * from products;
select * from product_category_name_translation;
select * from sellers;

----------------------------------------------------------------------------------
# TOTAL CUSTOMERS
select  distinct count(customer_unique_id) as Total_customers from customers;

----------------------------------------------------------------------------------

# TOTAL SALES
select format(round(sum(payment_value),2),0) as Total_sales from order_payments;

----------------------------------------------------------------------------------

# AVERAGE REVIEW SCORE

select round(avg(review_score),2) as Average_review_score
from order_reviews;

----------------------------------------------------------------------------------

# WEEKEND vs WEEKDAY PAYMENT STATS    
    
select case when dayofweek(o.order_purchase_timestamp) in (1, 7) then 'Weekend'
        else 'Weekday'
		end as day_type,
format(count(op.order_id),0) as total_orders,
format(round(sum(op.payment_value), 2),0) as total_payment_value,
concat(round(sum(op.payment_value) / (select round(sum(payment_value) , 2) from order_payments)*100, 2), '%') as total_percentage
from order_payments op
join olist_orders o on op.order_id = o.order_id
group by day_type;

----------------------------------------------------------------------------------

# NUMBER OF ORDERS WITH REVIEW SCORE 5 AND PAYMENT TYPE AS CC

select payment_type,format(count(op.order_id),0) as Number_of_Payments
from order_payments op
join order_reviews r on r.order_id=op.order_id
where payment_type="credit_card" and review_score=5
group by 1;

----------------------------------------------------------------------------------

# AVERAGE NO OF DAYS TAKEN BY PET SHOP FOR DELIVERY

select round(avg(datediff(order_delivered_customer_date, order_purchase_timestamp))) as avg_delivery_days
from olist_orders o
join order_items i on o.order_id = i.order_id
join products p on i.product_id=p.product_id
where p.product_category_name = 'pet_shop';

----------------------------------------------------------------------------------

# AVERAGE PRICE AND PAYMENT VALUES FROM CUSTOMERS OF SAO PAULO CITY

select customer_city as City,round(avg(price),2) as Average_price,round(avg(payment_value),2) as Average_payment_value
from customers c
join olist_orders o on c.customer_id = o.customer_id
join order_items ot on o.order_id=ot.order_id
join order_payments op on ot.order_id = op.order_id
where customer_city= "sao paulo";

----------------------------------------------------------------------------------

# RELATIONSHIP BETWEEN SHIPPING DAYS VS REVIEW SCORE

select distinct datediff(order_delivered_customer_date, order_purchase_timestamp) as shipping_days,
round(avg(review_score),2) as average_review_score
from olist_orders o
join order_reviews r on o.order_id = r.order_id
group by datediff(order_delivered_customer_date, order_purchase_timestamp)
order by shipping_days;

----------------------------------------------------------------------------------

# PAYMENT VALUE BY PAYMENT TYPE

select payment_type,format(round(sum(payment_value),2),0) as payment_value
from order_payments
group by 1;

----------------------------------------------------------------------------------

# TOP 5 STATES BY SALES

select customer_state as State,round(sum(payment_value),2) as Sales
from customers c
join olist_orders o on c.customer_id=o.customer_id
join order_payments op on o.order_id=op.order_id
group by 1
order by 2 desc
limit 5;

----------------------------------------------------------------------------------

# TOP 5 PRODUCT CATEGORIES BY SALES

select product_category_name_english as Product_category,round(sum(payment_value),2) as Payment_value
from order_payments op
join order_items ot on op.order_id=ot.order_id
join products p on ot.product_id=p.product_id
join product_category_name_translation pc on p.product_category_name=pc.ï»¿product_category_name
group by 1
order by 2 desc
limit 5;

----------------------------------------------------------------------------------

# YEAR WISE SALES

select distinct year(order_purchase_timestamp) as _Year_,format(sum(payment_value), 2) as Sales
from order_payments op
join olist_orders o on op.order_id = o.order_id
group by _Year_
order by Sales;

----------------------------------------------------------------------------------
