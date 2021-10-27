----------------------
-- OPERACOES NO SELECT
----------------------
SELECT 
	p.product_id,
	p.product_category_name,
	p.product_height_cm,
	p.product_length_cm,
	p.product_weight_g,
	p.product_height_cm * p.product_length_cm  * p.product_width_cm as volume,
	case when p.product_category_name = 'perfumaria' then 'loja' else 'website' end AS fonte,
	case when p.product_height_cm < 10 then 'small'
		 when p.product_height_cm >= 10 and p.product_height_cm < 15 then 'medium'
		 when p.product_height_cm >= 15 and p.product_height_cm <= 20 then 'large' else 'extra_large' end AS package
FROM products p
WHERE
	( p.product_category_name = 'perfumaria' or p.product_category_name = 'artes' )
	and p.product_weight_g > 1000
order by p.product_weight_g ASC;

--------------------------
----- COUNT
--------------------------

SELECT 
	product_category_name,
	case when product_height_cm < 10 then 'small'
		 when product_height_cm >= 10 and product_height_cm  < 15 then 'medium'
		 when product_height_cm  >= 15 and product_height_cm <= 20 then 'large'
		 else 'extra_large' end AS package,
	count( product_id ) AS num_products
from products p
where product_category_name != 'NULL'
group by product_category_name 
order by num_products DESC;

-----------------------
------- LEFT JOIN
-----------------------

select
	o.order_id,
	o.customer_id,
	p.product_category_name,
	s.seller_state 
from orders o inner join order_items oi 	   on      							     (oi.order_id = o.order_id)
			  inner join products p    	       on  								 (p.product_id = oi.product_id)
			  left join order_payment op     on      								 (op.order_id = o.order_id)
			  left join customer c             on 								(c.customer_id = o.customer_id)
			  left join order_reviews or2      on    							    (or2.order_id = o.order_id)
			  inner join sellers s             on   							   (s.seller_id = oi.seller_id)
			  inner join geolocation g         on  (g.geolocation_zip_code_prefix = c.customer_zip_code_prefix)
limit 10;








	