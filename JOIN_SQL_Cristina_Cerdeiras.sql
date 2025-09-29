USE w3schools;

SELECT * FROM customers;
SELECT * FROM employees;
SELECT * FROM orders;

-- 1) Nombre del cliente y fecha de sus pedidos
SELECT c.customer_name, o.order_date
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
ORDER BY c.customer_name, o.order_date;

-- 2) Todos los clientes y, si tienen, sus pedidos
SELECT c.customer_name, o.order_id, o.order_date, o.status
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
ORDER BY c.customer_id, o.order_date;

-- 3) Todas las órdenes y los clientes, si es que tienen
SELECT o.order_id, o.order_date, o.status, c.customer_name
FROM orders o
LEFT JOIN customers c ON c.customer_id = o.customer_id
ORDER BY o.order_id;
 
-- 4) Nº total de pedidos por cliente
SELECT c.customer_name, COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_orders DESC, c.customer_name;
 
-- 5) Clientes que tienen más de 5 pedidos
SELECT c.customer_name, COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > 5
ORDER BY total_orders DESC;
 
-- 6) Total de pedidos por cliente con estado 'Shipped'
SELECT c.customer_name, COUNT(o.order_id) AS shipped_orders
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
WHERE o.status = 'Shipped'
GROUP BY c.customer_id, c.customer_name
ORDER BY shipped_orders DESC;
 
-- 7) Clientes con más de 3 pedidos en estado 'Pending'
SELECT c.customer_name, COUNT(o.order_id) AS pending_orders
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
WHERE o.status = 'Pending'
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > 3
ORDER BY pending_orders DESC;
 
-- 8) Clientes que han realizado pedidos en 2024
SELECT DISTINCT c.customer_name
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
WHERE YEAR(o.order_date) = 2024
ORDER BY c.customer_name;
 
-- 9) Órdenes de clientes que viven en "ciudades" específicas
-- (El esquema no tiene ciudad; ejemplo usando país)
SELECT o.order_id, o.order_date, c.customer_name, c.country
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
WHERE c.country IN ('Spain','Germany')
ORDER BY o.order_date;
 
-- 10) Clientes cuyos nombres comienzan con 'J'
SELECT *
FROM customers
WHERE customer_name LIKE 'J%';
 
-- 11) Órdenes entre 2024-02-01 y 2024-04-30
SELECT o.order_id, o.order_date, o.status, c.customer_name
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
WHERE o.order_date BETWEEN '2024-02-01' AND '2024-04-30'
ORDER BY o.order_date, o.order_id;
 
-- 12) Órdenes con estado 'Pending' o 'Cancelled'
SELECT o.order_id, o.order_date, o.status, c.customer_name
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
WHERE o.status IN ('Pending','Cancelled')
ORDER BY o.order_date;
 
-- 13) Pedidos de clientes de 'Madrid' con estado 'Shipped'
-- (No hay ciudad; alternativa: clientes de Spain con 'Shipped')
SELECT o.order_id, o.order_date, c.customer_name, c.country
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
WHERE c.country = 'Spain' AND o.status = 'Shipped'
ORDER BY o.order_date;
 
-- 14) Todos los clientes y sus pedidos, incluyendo los que no tienen pedidos en 2024
-- (Hacemos LEFT JOIN y movemos el filtro de año al ON)
SELECT c.customer_name, o.order_id, o.order_date, o.status
FROM customers c
LEFT JOIN orders o
  ON o.customer_id = c.customer_id
AND YEAR(o.order_date) = 2024
ORDER BY c.customer_name, o.order_date;
 
-- 15) Clientes que tienen más de 3 pedidos (en total)
SELECT c.customer_name, COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > 3
ORDER BY total_orders DESC;
 
-- 16) Clientes con más de 5 pedidos en estado 'Shipped'
SELECT c.customer_name, COUNT(o.order_id) AS shipped_orders
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
WHERE o.status = 'Shipped'
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > 5
ORDER BY shipped_orders DESC;
 
-- 17) Nº de pedidos por cliente y por estado
SELECT c.customer_name, o.status, COUNT(*) AS num_orders
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_name, o.status
ORDER BY c.customer_name, o.status;
 
-- 18) Nombre del cliente y un mensaje según el estado de sus pedidos
-- (por pedido)
SELECT c.customer_name,
       o.order_id,
       o.status,
       CASE o.status
         WHEN 'Shipped'   THEN 'Pedido enviado'
         WHEN 'Pending'   THEN 'Pedido pendiente'
         WHEN 'Cancelled' THEN 'Pedido cancelado'
         ELSE 'Estado desconocido'
       END AS status_msg
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
ORDER BY c.customer_name, o.order_date;
