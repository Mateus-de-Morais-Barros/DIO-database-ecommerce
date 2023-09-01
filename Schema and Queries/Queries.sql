-- Seleciona Clientes com cadastro de PJ
SELECT CONCAT(first_name,' ',middle_name,' ',last_name) as Nome, categoria FROM ifood.customer
JOIN categoria ON categoria.id = categoria_id
WHERE categoria_id = 2;

-- Seleciona Produtos do cardápio e os nomes dos restaurantes
SELECT res_name Restaurante, name Produto, price Preço, status Status FROM menu_item 
JOIN restaurant ON restaurant_id = restaurant.id;

-- Tabela de Pedidos formatada unificando todos os dados
SELECT 
	CONCAT(first_name,' ',middle_name,' ',last_name) as Nome,
    res_name as Restaurante,
    CONCAT(state,' ',city,' ',street,' ',number) as Endereço,
    order_status.status as 'Status do Pedido',
    payment_method as 'Método de Pagamento',
    delivery_fee as 'Taxa de Entrega',
    order_request_datetime as 'Hora do Pedido',
    total_amount as Total,
    tracking_code as 'Código de Rastreamento'
FROM ifood.food_order
JOIN customer ON customer_id = customer.id
JOIN restaurant ON restaurant_id = restaurant.id
JOIN address ON customer_address_id = address.id
JOIN order_status ON order_status_id = order_status.id
JOIN payment_method ON payment_method_id = payment_method.id;

-- Correspondência de Pedidos e Clientes    
SELECT 
	CONCAT(first_name,' ',middle_name,' ',last_name) as Nome,
    res_name as Restaurante,
    order_status.status as 'Status do Pedido',
    menu_item.name as Produto
FROM ifood.food_order
JOIN customer ON customer_id = customer.id
JOIN restaurant ON restaurant_id = restaurant.id
JOIN order_status ON order_status_id = order_status.id
JOIN order_menu_item ON order_menu_item.food_order_id = food_order.id
JOIN menu_item ON menu_item_id = menu_item.id
ORDER BY 'Status do Pedido';

-- Quantos endereços cadastrados temos em Estados que começam por 'R'?
SELECT 
	COUNT(state) as 'Número de Endereços por Estado',
     state as Estado
FROM address
GROUP BY state
HAVING state LIKE 'R%';

