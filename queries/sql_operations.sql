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