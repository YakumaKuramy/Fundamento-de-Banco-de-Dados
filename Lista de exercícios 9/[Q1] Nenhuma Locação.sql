CREATE TABLE customers (
    id NUMERIC PRIMARY KEY,
    name VARCHAR,
    street VARCHAR,
    city VARCHAR
);


CREATE TABLE locations (
    id NUMERIC PRIMARY KEY,
    locations_date DATE,
    id_customers NUMERIC,
    FOREIGN KEY (id_customers) REFERENCES customers(id)
);


INSERT INTO customers (id, name, street, city) VALUES
(1, 'Giovanna Goncalves Oliveira', 'Rua Mato Grosso', 'Canoas'),
(2, 'Kauã Azevedo Ribeiro', 'Travessa Ibiá', 'Uberlândia'),
(3, 'Rebeca Barbosa Santos', 'Rua Observatório Meteorológico', 'Salvador'),
(4, 'Sarah Carvalho Correia', 'Rua Antônio Carlos da Silva', 'Apucarana'),
(5, 'João Almeida Lima', 'Rua Rio Taiuva', 'Ponta Grossa'),
(6, 'Diogo Melo Dias', 'Rua Duzentos e Cinquenta', 'Várzea Grande');



INSERT INTO locations (id, locations_date, id_customers) VALUES
(1, '2016-10-09', 3),
(2, '2016-09-02', 1),
(3, '2016-08-02', 2),
(4, '2016-09-02', 4),
(5, '2016-03-02', 6),
(6, '2016-04-04', 4);


SELECT id, name
FROM customers
WHERE id NOT IN (
    SELECT DISTINCT id_customers
    FROM locations
)
ORDER BY id;
