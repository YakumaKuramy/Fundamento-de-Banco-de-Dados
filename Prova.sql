CREATE TABLE Ecoparque (
    id_ecoparque SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    bairro VARCHAR(50),
    cidade VARCHAR(50),
    area_total_m2 NUMERIC(10,2),
    data_inauguracao DATE);


CREATE TABLE Infraestrutura (
    id_infraestrutura SERIAL PRIMARY KEY,
    id_ecoparque INT NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    quantidade INT NOT NULL,
    FOREIGN KEY (id_ecoparque) REFERENCES Ecoparque(id_ecoparque)
);


CREATE TABLE Gestor (
    id_gestor SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    contato VARCHAR(100),
    id_ecoparque INT UNIQUE NOT NULL,
    FOREIGN KEY (id_ecoparque) REFERENCES Ecoparque(id_ecoparque)
);


CREATE TABLE Visitante (
    id_visitante SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE,
    genero VARCHAR(20)
);


CREATE TABLE Visita (
    id_visita SERIAL PRIMARY KEY,
    id_visitante INT NOT NULL,
    id_ecoparque INT NOT NULL,
    data_visita DATE NOT NULL,
    avaliacao INT CHECK (avaliacao BETWEEN 1 AND 5),
    FOREIGN KEY (id_visitante) REFERENCES Visitante(id_visitante),
    FOREIGN KEY (id_ecoparque) REFERENCES Ecoparque(id_ecoparque)
);


CREATE TABLE EventoAmbiental (
    id_evento SERIAL PRIMARY KEY,
    id_ecoparque INT NOT NULL,
    titulo VARCHAR(150) NOT NULL,
    descricao TEXT,
    data_evento DATE NOT NULL,
    tipo_evento VARCHAR(50),
    FOREIGN KEY (id_ecoparque) REFERENCES Ecoparque(id_ecoparque)
);


CREATE TABLE EquipeManutencao (
    id_equipe SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    especialidade VARCHAR(100)
);


CREATE TABLE EquipeEvento (
    id_evento INT NOT NULL,
    id_equipe INT NOT NULL,
    PRIMARY KEY (id_evento, id_equipe),
    FOREIGN KEY (id_evento) REFERENCES EventoAmbiental(id_evento),
    FOREIGN KEY (id_equipe) REFERENCES EquipeManutencao(id_equipe)
);


INSERT INTO Ecoparque (id_ecoparque, nome, bairro, cidade, area_total_m2, data_inauguracao) VALUES
(1, 'Parque Cocó', 'Cocó', 'Fortaleza', 120000.0, '2010-06-05'),
(2, 'Parque Rachel', 'Pres. Kennedy','Fortaleza', 90000.0, '2012-08-10'),
(3, 'Parque Crianças', 'Centro', 'Fortaleza', 15000.0, '2008-10-15'),
(4, 'Parque Barreto', 'Meireles', 'Fortaleza', 85000.0, '2015-11-20'),
(5, 'Parque Branco', 'Benfica', 'Fortaleza', 20000.0, '2009-09-13'),
(6, 'Parque Lagoa', 'Centro', 'Quixadá', 32000.0, '2016-03-21'),
(7, 'Parque Ecológico', 'Pedra Branca','Quixadá', 27000.0, '2017-01-12'),
(8, 'Parque Municipal', 'Derby', 'Sobral', 43000.0, '2014-12-02'),
(9, 'Parque Flores', 'Centro', 'Russas', 22000.0, '2011-05-07'),
(10, 'Parque Verde', 'Centro', 'Iguatu', 25000.0, '2013-04-11'),
(11, 'Parque Sol', 'Vila União', 'Maranguape', 17000.0, '2018-02-28'),
(12, 'Parque Primavera', 'Jardim Oásis','Canindé', 14000.0, '2020-10-10'),
(13, 'Parque Luz', 'Boa Vista', 'Cascavel', 29000.0, '2019-07-25'),
(14, 'Parque Açude', 'Monte Castelo','Quixeramobim',35000.0, '2011-06-01'),
(15, 'Parque Esperança', 'Bairro Novo', 'Fortaleza', 19000.0, '2023-03-01'),
(16, 'Parque Nova Era', 'Centro', 'Tauá', 18500.0, '2022-09-15'),
(17, 'Parque Bosque', 'Bosque', 'Quixeré', 16500.0, '2021-05-18'),
(18, 'Parque Horizonte', 'Horizonte', 'Horizonte', 30000.0, '2018-07-07'),
(19, 'Parque Sertão', 'Sertão', 'Morada Nova', 26000.0, '2021-12-11'),
(20, 'Parque Palmeiras', 'Palmeiras', 'Pacajus', 21000.0, '2020-01-23');


INSERT INTO Infraestrutura (id_infraestrutura, id_ecoparque, tipo, quantidade) VALUES
(1, 1, 'Playground', 3), (2, 1, 'Quadra Esportiva', 2),
(3, 2, 'Lago', 1), (4, 2, 'Pista de Cooper', 1),
(5, 3, 'Academia', 2), (6, 3, 'Quadra Esportiva', 1),
(7, 4, 'Trilha', 1), (8, 4, 'Playground', 1),
(9, 5, 'Quadra de Vôlei', 2),(10, 5, 'Lago', 1),
(11, 6, 'Parquinho', 1), (12, 6, 'Pista de Skate', 1),
(13, 7, 'Academia', 2), (14, 7, 'Quadra Poliesportiva', 1),
(15, 8, 'Trilha', 1), (16, 8, 'Campo de Futebol', 1),
(17, 9, 'Playground', 1), (18, 9, 'Pista de Caminhada', 1),
(19, 10, 'Quadra de Areia', 1),(20, 10, 'Lago', 1),
(21, 11, 'Trilha', 1), (22, 11, 'Parquinho', 1),
(23, 12, 'Academia', 1), (24, 12, 'Quadra Esportiva', 1),
(25, 13, 'Lago', 1), (26, 13, 'Parquinho', 1),
(27, 19, 'Parquinho', 1), (28, 20, 'Trilha', 1);


INSERT INTO Gestor (id_gestor, nome, contato, id_ecoparque) VALUES
(1, 'João Santana', 'joao@ecolife.com', 1),
(2, 'Maria do Carmo', 'maria@ecolife.com', 2),
(3, 'Ana Oliveira', 'ana@ecolife.com', 3),
(4, 'Lucas Barros', 'lucas@ecolife.com', 4),
(5, 'Ricardo Almeida', 'ricardo@ecolife.com', 5),
(6, 'Sandra Souza', 'sandra@ecolife.com', 6),
(7, 'Paulo Silva', 'paulo@ecolife.com', 7),
(8, 'Rita Sampaio', 'rita@ecolife.com', 8),
(9, 'Carlos Mendes', 'carlos@ecolife.com', 9),
(10, 'Aline Dias', 'aline@ecolife.com', 10),
(11, 'Breno Vasconcelos','breno@ecolife.com', 11),
(12, 'Helena Furtado', 'helena@ecolife.com', 12),
(13, 'Pedro Gama', 'pedro@ecolife.com', 13),
(14, 'Flávia Miranda', 'flavia@ecolife.com', 14),
(15, 'Igor Paiva', 'igor@ecolife.com', 15);


INSERT INTO Visitante (id_visitante, nome, data_nascimento, genero) VALUES
(1, 'João Souza', '1990-01-10', 'Masculino'),
(2, 'Maria Ribeiro', '1995-02-11', 'Feminino'),
(3, 'Ana Costa', '1998-03-12', 'Feminino'),
(4, 'Lucas Lima', '1988-04-13', 'Masculino'),
(5, 'Ricardo Lopes', '1980-05-14', 'Masculino'),
(6, 'Sandra Rocha', '1984-06-10', 'Feminino'),
(7, 'Paulo Sergio', '1992-06-11', 'Masculino'),
(8, 'Rita Moura', '1996-06-12', 'Feminino'),
(9, 'Carlos Torres', '1978-02-01', 'Masculino'),
(10, 'Aline Batista', '1997-02-21', 'Feminino'),
(11, 'Breno Tavares', '1993-03-05', 'Masculino'),
(12, 'Helena Soares', '1986-03-15', 'Feminino'),
(13, 'Pedro Martins', '1994-04-07', 'Masculino'),
(14, 'Flávia Queiroz', '1999-04-22', 'Feminino'),
(15, 'Igor Duarte', '1983-05-10', 'Masculino'),
(16, 'Visitante16', '2000-01-01', 'Masculino'),
(17, 'Visitante17', '2001-02-02', 'Feminino'),
(18, 'Visitante18', '2002-03-03', 'Masculino'),
(19, 'Visitante19', '2003-04-04', 'Feminino'),
(20, 'Visitante20', '2004-05-05', 'Masculino');


INSERT INTO Visita (id_visita, id_visitante, id_ecoparque, data_visita, avaliacao) VALUES
(1, 2, 2, '2024-06-02', 4), (2, 2, 3, '2024-06-03', 4), (3, 2, 5, '2024-06-04', 5),
(4, 2, 6, '2024-06-05', 4), (5, 2, 7, '2024-06-06', 4), (6, 2, 8, '2024-06-07', 4),
(7, 3, 3, '2024-06-08', 5), (8, 3, 6, '2024-06-09', NULL), (9, 3, 7, '2024-06-10', 5),
(10, 3, 8, '2024-06-11', 4), (11, 3, 9, '2024-06-12', NULL),
(12, 1, 1, '2024-06-13', 5), (13, 1, 2, '2024-06-14', 4), (14, 1, 4, '2024-06-15', 4), (15, 1, 5, '2024-06-16', 5),
(16, 4, 1, '2024-06-17', NULL), (17, 4, 2, '2024-06-18', 4), (18, 4, 3, '2024-06-19', 5), (19, 4, 4, '2024-06-20', 5),
(20, 5, 10, '2024-06-21', 5),
(21, 6, 11, '2024-06-22', 4),
(22, 7, 12, '2024-06-23', 3),
(23, 8, 13, '2024-06-24', 5),
(24, 9, 19, '2024-06-25', 4),
(25, 10, 20, '2024-06-26', 5),
(26, 11, 1, '2024-06-27', 3),
(27, 12, 2, '2024-06-28', NULL),
(28, 13, 3, '2024-06-29', 5),
(29, 14, 4, '2024-06-30', 3),
(30, 15, 5, '2024-07-01', 4);


INSERT INTO EventoAmbiental (id_evento, id_ecoparque, titulo, descricao, data_evento, tipo_evento) VALUES
(1, 1, 'Mutirão Ecológico', 'Limpeza coletiva.', '2024-07-01', 'Limpeza'),
(2, 2, 'Plantio de Árvores', 'Reflorestamento.', '2024-07-05', 'Reflorestamento'),
(3, 3, 'Oficina Compostagem', 'Compostagem doméstica.', '2024-07-10', 'Oficina'),
(4, 4, 'Corrida Verde', 'Corrida ecológica.', '2024-07-12', 'Esportivo'),
(5, 5, 'Piquenique Sustent.', 'Alimentação saudável.', '2024-07-13', 'Recreativo'),
(6, 6, 'Palestra Educação', 'Conscientização.', '2024-07-15', 'Palestra'),
(7, 7, 'Aula de Yoga', 'Yoga ao amanhecer.', '2024-07-18', 'Saúde'),
(8, 8, 'Campanha Mudas', 'Plantio de mudas.', '2024-07-20', 'Campanha'),
(9, 9, 'Festival da Água', 'Jogos sobre uso da água.', '2024-07-22', 'Festival'),
(10, 10, 'Passeio Fotográfico', 'Fotografia natureza.', '2024-07-23', 'Passeio'),
(11, 11, 'Limpeza de Riacho', 'Limpeza do riacho.', '2024-07-24', 'Limpeza'),
(12, 12, 'Teatro Sustentável', 'Peça educativa.', '2024-07-25', 'Cultural'),
(13, 13, 'Feira de Orgânicos', 'Produtos locais.', '2024-07-26', 'Feira'),
(14, 14, 'Oficina Reciclagem', 'Reciclagem artesanal.', '2024-07-27', 'Oficina'),
(15, 1, 'Evento Sem Equipe1', 'Evento teste.', '2024-07-28', 'Outro'),
(16, 2, 'Evento Sem Equipe2', 'Evento teste.', '2024-07-29', 'Outro'),
(17, 3, 'Evento Sem Equipe3', 'Evento teste.', '2024-07-30', 'Outro'),
(18, 4, 'Evento Sem Equipe4', 'Evento teste.', '2024-07-31', 'Outro'),
(19, 5, 'Evento Sem Equipe5', 'Evento teste.', '2024-08-01', 'Outro');


INSERT INTO EquipeManutencao (id_equipe, nome, especialidade) VALUES
(1, 'Equipe Verde', 'Jardinagem'),
(2, 'Equipe Limpeza', 'Limpeza Geral'),
(3, 'Equipe Recicla', 'Reciclagem'),
(4, 'Equipe Saúde', 'Atividades Físicas'),
(5, 'Equipe Aventura', 'Esportes e Trilhas'),
(6, 'Equipe Arte', 'Educação Ambiental'),
(7, 'Equipe Luz', 'Iluminação'),
(8, 'Equipe Água', 'Gestão Hídrica'),
(9, 'Equipe Orgânicos', 'Horta Comunitária'),
(10, 'Equipe Árvore', 'Plantio de Mudas'),
(11, 'Equipe Fauna', 'Biólogos'),
(12, 'Equipe Mídia', 'Comunicação'),
(13, 'Equipe Técnica', 'Manutenção Predial'),
(14, 'Equipe Social', 'Inclusão Social'),
(15, 'Equipe Monitoria', 'Guias de Passeio'),
(16, 'Equipe Solo', 'Solo e Plantio'),
(17, 'Equipe Pedras', 'Geologia'),
(18, 'Equipe Mar', 'Limpeza Aquática'),
(19, 'Equipe Faixa', 'Sinalização'),
(20, 'Equipe Digital', 'Tecnologia');


INSERT INTO EquipeEvento (id_evento, id_equipe) VALUES
(1, 1), (1, 2), (2, 10), (2, 3), (3, 6), (3, 3), (4, 4), (4, 5), (5, 9), (5, 2),
(6, 6), (6, 12), (7, 4), (7, 14), (8, 10), (8, 11), (9, 8), (9, 2), (10, 11), (10, 15),
(11, 2), (11, 8), (12, 6), (12, 13), (13, 9), (13, 12), (14, 3), (14, 6);


