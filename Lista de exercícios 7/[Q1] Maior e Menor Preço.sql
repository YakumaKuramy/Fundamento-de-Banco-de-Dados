
CREATE TABLE products (
	id NUMERIC PRIMARY KEY,
	name VARCHAR,
	amount NUMERIC,
	price NUMERIC
);


INSERT INTO products (id, name, amount, price) VALUES
(1, 'two-doors wardrobe', 100, 800),
(2, 'dining table', 1000, 560),
(3, 'towel holder', 10000, 25.50),
(4, 'computer desk', 350, 320.50),
(5, 'chair', 3000, 210.64),
(6, 'single bed', 750, 460);


SELECT MAX(price) AS maior_preco, MIN(price) AS menor_preco
FROM products;

--> Este é um comentario <-- 
SELECT price FROM products
WHERE price = (SELECT MAX(price) FROM products)
OR price = (SELECT MIN(price) FROM products);