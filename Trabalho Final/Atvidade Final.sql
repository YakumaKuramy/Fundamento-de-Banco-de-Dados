--> Visão 1: Média das notas e faltas por aluno e turma <--
CREATE OR REPLACE VIEW vw_desempenho_aluno AS
SELECT 
    a.nome AS aluno,
    t.nome AS turma,
    ROUND(AVG(d.media), 2) AS media_final,
    SUM(d.faltas) AS total_faltas
FROM aluno a
JOIN matricula m ON a.id_aluno = m.id_aluno
JOIN turma t ON m.id_turma = t.id_turma
JOIN desempenho d ON m.id_matricula = d.id_matricula
GROUP BY a.nome, t.nome
ORDER BY t.nome, a.nome;

SELECT * FROM vw_desempenho_aluno;


--> Visão 2: Disciplinas e professores por turma <--
CREATE OR REPLACE VIEW vw_professores_disciplinas AS
SELECT 
    p.nome AS professor,
    d.nome AS disciplina,
    t.nome AS turma,
    t.ano
FROM professor p
JOIN oferta_disciplina od ON p.id_professor = od.id_professor
JOIN disciplina d ON od.id_disciplina = d.id_disciplina
JOIN turma t ON od.id_turma = t.id_turma
ORDER BY t.ano, t.nome, p.nome;

SELECT * FROM vw_professores_disciplinas;

-- Criação de Usuarios no PostgreSQL

CREATE USER user_admin WITH PASSWORD 'user_admin_6789';
CREATE USER usuario_visualizacao WITH PASSWORD '123456';

-- Permissões para o usuário admin (controle total sobre o schema)
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO user_admin;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO user_admin;

-- Permissões restritas ao usuário de visualização
-- Concede acesso ao schema (obrigatório para ver qualquer objeto)
GRANT USAGE ON SCHEMA public TO usuario_visualizacao;

-- Criação da visão de desempenho por aluno
CREATE OR REPLACE VIEW vw_desempenho_aluno AS
SELECT 
    a.nome AS aluno,
    t.nome AS turma,
    ROUND(AVG(d.media), 2) AS media_final,
    SUM(d.faltas) AS total_faltas
FROM aluno a
JOIN matricula m ON a.id_aluno = m.id_aluno
JOIN turma t ON m.id_turma = t.id_turma
JOIN desempenho d ON m.id_matricula = d.id_matricula
GROUP BY a.nome, t.nome;

-- Criação da visão de professores e disciplinas por turma
CREATE OR REPLACE VIEW vw_professores_disciplinas AS
SELECT 
    p.nome AS professor,
    d.nome AS disciplina,
    t.nome AS turma,
    t.ano
FROM professor p
JOIN oferta_disciplina od ON p.id_professor = od.id_professor
JOIN disciplina d ON od.id_disciplina = d.id_disciplina
JOIN turma t ON od.id_turma = t.id_turma;

-- Permitir que o usuário visualize apenas essas views
GRANT SELECT ON vw_desempenho_aluno TO usuario_visualizacao;
GRANT SELECT ON vw_professores_disciplinas TO usuario_visualizacao;

