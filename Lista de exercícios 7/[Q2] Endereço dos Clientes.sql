CREATE TABLE customers (
	id NUMERIC PRIMARY KEY,
	name VARCHAR,
	street VARCHAR,
	city VARCHAR,
	state CHAR(2),
	credit_limit NUMERIC
);


INSERT INTO customers (id, name, street, city, state, credit_limit) VALUES
(1, 'Pedro Augusto da Rocha', 'Rua Pedro Carlos Hoffman', 'Porto Alegre', 'RS', 700.00),
(2, 'Antonio Carlos Mamel', 'Av. Pinheiros', 'Belo Horizonte', 'MG', 3500.50),
(3, 'Luiza Augusta Mhor', 'Rua Salto Grande', 'Niteroi', 'RJ', 4000.00),
(4, 'Jane Ester', 'Av 7 de setembro', 'Erechim', 'RS', 800.00),
(5, 'Marcos Antônio dos Santos', 'Av Farrapos', 'Porto Alegre', 'RS', 4250.25);


SELECT name, street
FROM customers
WHERE city = 'Porto Alegre';
