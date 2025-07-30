from pydantic import BaseModel
from typing import Optional
from datetime import date

class Aluno(BaseModel):
    id_aluno: int
    nome: str
    data_nascimento: Optional[date]
    cpf: Optional[str]
    sexo: Optional[str]

class AlunoUpdate(BaseModel):
    nome: Optional[str]
    data_nascimento: Optional[date]
    cpf: Optional[str]
    sexo: Optional[str]


class Professor(BaseModel):
    id_professor: Optional[int]
    nome: str
    especialidade: Optional[str]
    data_contratacao: date

class ProfessorUpdate(BaseModel):
    nome: Optional[str]
    especialidade: Optional[str]
    data_contratacao: Optional[date]


class Disciplina(BaseModel):
    id_disciplina: Optional[int]
    nome: str
    carga_horaria: int

class DisciplinaUpdate(BaseModel):
    nome: Optional[str]
    carga_horaria: Optional[int]

class Turma(BaseModel):
    id_turma: Optional[int]
    nome: str
    serie: Optional[str]
    ano: int
    turno: Optional[str]

class TurmaUpdate(BaseModel):
    nome: Optional[str]
    serie: Optional[str]
    ano: Optional[int]
    turno: Optional[str]

class Matricula(BaseModel):
    id_matricula: Optional[int]
    id_aluno: int
    id_turma: int
    data_matricula: date

class MatriculaUpdate(BaseModel):
    id_aluno: Optional[int]
    id_turma: Optional[int]
    data_matricula: Optional[date]

class OfertaDisciplina(BaseModel):
    id_oferta: Optional[int]
    id_disciplina: int
    id_turma: int
    id_professor: int

class OfertaDisciplinaUpdate(BaseModel):
    id_disciplina: Optional[int]
    id_turma: Optional[int]
    id_professor: Optional[int]

class Desempenho(BaseModel):
    id_desempenho: Optional[int]
    id_matricula: int
    id_oferta: int
    nota1: Optional[float]
    nota2: Optional[float]
    nota3: Optional[float]
    media: Optional[float]
    faltas: Optional[int] = 0

class DesempenhoUpdate(BaseModel):
    nota1: Optional[float]
    nota2: Optional[float]
    nota3: Optional[float]
    media: Optional[float]
    faltas: Optional[int]
