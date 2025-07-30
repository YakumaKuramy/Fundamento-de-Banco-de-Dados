CREATE TABLE aluno (
    id_aluno SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    data_nascimento DATE,
    cpf VARCHAR(14),
    sexo CHAR(1)
);

CREATE TABLE professor (
    id_professor SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    especialidade VARCHAR(100),
    data_contratacao DATE NOT NULL
);

CREATE TABLE disciplina (
    id_disciplina SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    carga_horaria INT NOT NULL CHECK (carga_horaria > 0)
);

CREATE TABLE turma (
    id_turma SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    serie VARCHAR(20),
    ano INT NOT NULL,
    turno VARCHAR(20) CHECK (turno IN ('Manhã', 'Tarde', 'Noite'))
);

CREATE TABLE matricula (
    id_matricula SERIAL PRIMARY KEY,
    id_aluno INT NOT NULL,
    id_turma INT NOT NULL,
    data_matricula DATE NOT NULL,
    FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno),
    FOREIGN KEY (id_turma) REFERENCES turma(id_turma)
);

CREATE TABLE oferta_disciplina (
    id_oferta SERIAL PRIMARY KEY,
    id_disciplina INT NOT NULL,
    id_turma INT NOT NULL,
    id_professor INT NOT NULL,
    FOREIGN KEY (id_disciplina) REFERENCES disciplina(id_disciplina),
    FOREIGN KEY (id_turma) REFERENCES turma(id_turma),
    FOREIGN KEY (id_professor) REFERENCES professor(id_professor)
);

CREATE TABLE desempenho (
    id_desempenho SERIAL PRIMARY KEY,
    id_matricula INT NOT NULL,
    id_oferta INT NOT NULL,
    nota1 NUMERIC(5,2),
    nota2 NUMERIC(5,2),
    nota3 NUMERIC(5,2),
    media NUMERIC(5,2),
    faltas INT DEFAULT 0,
    FOREIGN KEY (id_matricula) REFERENCES matricula(id_matricula),
    FOREIGN KEY (id_oferta) REFERENCES oferta_disciplina(id_oferta)
);


INSERT INTO aluno (nome, data_nascimento, cpf, sexo)
VALUES
('João da Silva', '2005-05-12', '123.456.789-10', 'M'),
('Maria Oliveira', '2006-08-20', '234.567.890-01', 'F'),
('Ana Souza', '2007-03-15', '159.142.031-12', 'F'),
('Bruno Lima', '2006-07-22', '256.254.324-23', 'M'),
('Carla Mendes', '2005-10-05', '736.639.538-43', 'F'),
('Diego Rocha', '2007-01-19', '484.274.164-45', 'M'),
('Eduarda Farias', '2006-09-30', '593.865.754-65', 'F'),
('Felipe Gomes', '2007-05-12', '691.896.786-67', 'M'),
('Gabriela Torres', '2005-11-23', '027.172.973-78', 'F'),
('Henrique Santos', '2006-12-01', '382.981.648-89', 'M');


INSERT INTO professor (nome, especialidade, data_contratacao) VALUES
('João Martins', 'Matemática', '2020-02-10'),
('Luciana Silva', 'Português', '2019-03-05'),
('Ricardo Alves', 'História', '2021-01-15'),
('Sandra Lima', 'Geografia', '2018-11-22'),
('Marcos Oliveira', 'Física', '2022-04-30'),
('Patrícia Souza', 'Biologia', '2017-09-01'),
('Tiago Costa', 'Química', '2020-06-18'),
('Aline Mendes', 'Educação Física', '2016-10-09'),
('João Alvez', 'Matemática', '2020-03-18'),
('Alice Almeida', 'Educação Social', '2016-07-09');


INSERT INTO disciplina (nome, carga_horaria) VALUES
('Matemática', 80),
('Português', 60),
('História', 40),
('Geografia', 40),
('Física', 60),
('Biologia', 60),
('Química', 60),
('Educação Física', 30),
('Educação Social', 30),
('Artes', 30); 

INSERT INTO turma (nome, serie, ano, turno) VALUES
('Turma A', '7º ano', 2024, 'Manhã'),
('Turma B', '8º ano', 2024, 'Manhã'),
('Turma C', '9º ano', 2024, 'Tarde'),
('Turma D', '1º ano EM', 2024, 'Tarde'),
('Turma E', '2º ano EM', 2024, 'Noite'),
('Turma F', '3º ano EM', 2024, 'Noite'),
('Turma G', '6º ano', 2024, 'Manhã'),
('Turma H', '1º ano EM', 2023, 'Tarde'),
('Turma I', '8º ano', 2024, 'Manhã'),
('Turma J', '9º ano', 2024, 'Tarde');


INSERT INTO matricula (id_aluno, id_turma, data_matricula) VALUES
(1, 1, '2024-01-10'),
(2, 1, '2024-01-10'),
(3, 2, '2024-01-10'),
(4, 2, '2024-01-10'),
(5, 3, '2024-01-10'),
(6, 3, '2024-01-10'),
(7, 4, '2024-01-10'),
(8, 4, '2024-01-10'),
(9, 4, '2024-01-10'),
(10, 4, '2024-01-10');


INSERT INTO oferta_disciplina (id_disciplina, id_turma, id_professor) VALUES
(1, 1, 1), 
(2, 1, 2),
(3, 2, 3),
(4, 2, 4),
(5, 3, 5),
(6, 3, 6),
(7, 4, 7),
(8, 4, 8),
(9, 4, 7),
(10, 4, 8); 

INSERT INTO desempenho (id_matricula, id_oferta, nota1, nota2, nota3, media, faltas) VALUES
(1, 1, 8.0, 7.5, 9.0, 8.2, 2),
(1, 2, 7.0, 8.0, 7.5, 7.5, 1),
(2, 1, 5.0, 6.5, 6.0, 5.8, 4),
(2, 2, 7.5, 7.0, 8.0, 7.5, 0),
(3, 3, 9.0, 8.5, 9.5, 9.0, 0),
(3, 4, 6.0, 6.0, 6.5, 6.2, 2),
(4, 3, 8.0, 9.0, 8.5, 8.5, 1),
(4, 4, 9.0, 9.0, 9.0, 9.0, 0),
(5, 3, 8.0, 9.0, 8.5, 8.5, 1),
(5, 4, 9.0, 9.0, 9.0, 9.0, 0);


"""
--- Listar todos os alunos com suas turmas
SELECT a.nome AS aluno, t.nome AS turma, t.serie, t.turno
FROM aluno a
JOIN matricula m ON a.id_aluno = m.id_aluno
JOIN turma t ON m.id_turma = t.id_turma;


--- Listar os professores e as disciplinas que eles lecionam
SELECT p.nome AS professor, d.nome AS disciplina
FROM professor p
JOIN oferta_disciplina od ON p.id_professor = od.id_professor
JOIN disciplina d ON od.id_disciplina = d.id_disciplina;


--- Verificar o desempenho de cada aluno (notas e média)
SELECT a.nome AS aluno, d.nome AS disciplina,
       des.nota1, des.nota2, des.nota3, des.media
FROM desempenho des
JOIN matricula m ON des.id_matricula = m.id_matricula
JOIN aluno a ON m.id_aluno = a.id_aluno
JOIN oferta_disciplina od ON des.id_oferta = od.id_oferta
JOIN disciplina d ON od.id_disciplina = d.id_disciplina;


--- Contar o número de alunos por turma
SELECT t.nome AS turma, COUNT(m.id_aluno) AS total_alunos
FROM turma t
LEFT JOIN matricula m ON t.id_turma = m.id_turma
GROUP BY t.nome;

--- Listar os alunos que estão com média abaixo de 6
SELECT a.nome AS aluno, d.nome AS disciplina, des.media
FROM desempenho des
JOIN matricula m ON des.id_matricula = m.id_matricula
JOIN aluno a ON m.id_aluno = a.id_aluno
JOIN oferta_disciplina od ON des.id_oferta = od.id_oferta
JOIN disciplina d ON od.id_disciplina = d.id_disciplina
WHERE des.media < 6;


--- Listar disciplinas por turma
SELECT t.nome AS turma, d.nome AS disciplina
FROM oferta_disciplina od
JOIN disciplina d ON od.id_disciplina = d.id_disciplina
JOIN turma t ON od.id_turma = t.id_turma
ORDER BY t.nome;


--- Listar alunos com maior número de faltas
SELECT a.nome AS aluno, d.nome AS disciplina, des.faltas
FROM desempenho des
JOIN matricula m ON des.id_matricula = m.id_matricula
JOIN aluno a ON m.id_aluno = a.id_aluno
JOIN oferta_disciplina od ON des.id_oferta = od.id_oferta
JOIN disciplina d ON od.id_disciplina = d.id_disciplina
ORDER BY des.faltas DESC
LIMIT 10;
"""

