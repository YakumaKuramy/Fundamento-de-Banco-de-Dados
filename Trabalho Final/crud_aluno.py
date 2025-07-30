from fastapi import APIRouter, HTTPException
from db import get_connection
from models_sgesc import Aluno
from typing import List, Optional
from models_sgesc import AlunoUpdate

router = APIRouter()

@router.post("/alunos")
async def criar_aluno(dep: Aluno):
    conn = get_connection()
    cur = conn.cursor()
    try:
        cur.execute(
            "INSERT INTO aluno (id_aluno, nome, data_nascimento, cpf, sexo) VALUES (%s, %s, %s, %s, %s)",
            (dep.id_aluno, dep.nome, dep.data_nascimento, dep.cpf, dep.sexo)
        )
        conn.commit()
    except Exception as e:
        conn.rollback()
        raise HTTPException(400, f"Erro ao criar aluno: {e}")
    finally:
        cur.close()
        conn.close()
    return {"msg": "Aluno criado com sucesso"}


@router.get("/alunos", response_model=List[Aluno])
async def listar_alunos():
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("SELECT id_aluno, nome, data_nascimento, cpf, sexo FROM aluno")
    rows = cur.fetchall()
    cur.close()
    conn.close()
    return [
        Aluno(
            id_aluno=d[0], nome=d[1], data_nascimento=d[2], cpf=d[3], sexo=d[4]
        ) for d in rows
    ]

@router.get("/alunos/{id_aluno}", response_model=Aluno)
async def get_aluno(id_aluno: int):
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("SELECT id_aluno, nome, data_nascimento, cpf, sexo FROM aluno WHERE id_aluno=%s", (id_aluno,))
    row = cur.fetchone()
    cur.close()
    conn.close()
    if row:
        return Aluno(id_aluno=row[0], nome=row[1], data_nascimento=row[2], cpf=row[3], sexo=row[4])
    raise HTTPException(404, "Aluno não encontrado")


@router.patch("/alunos/{id_aluno}")
async def atualizar_aluno_parcial(id_aluno: int, dep: AlunoUpdate):
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("SELECT id_aluno FROM aluno WHERE id_aluno=%s", (id_aluno,))
    if not cur.fetchone():
        cur.close()
        conn.close()
        raise HTTPException(404, "Aluno não encontrado")
    fields = []
    values = []
    for campo, valor in dep.dict(exclude_unset=True).items():
        fields.append(f"{campo}=%s")
        values.append(valor)
    if not fields:
        cur.close()
        conn.close()
        raise HTTPException(400, "Nenhum campo informado para atualização")
    values.append(id_aluno)
    try:
        cur.execute(f"UPDATE aluno SET {', '.join(fields)} WHERE id_aluno=%s", values)
        conn.commit()
    except Exception as e:
        conn.rollback()
        raise HTTPException(400, f"Erro ao atualizar: {e}")
    finally:
        cur.close()
        conn.close()
    return {"msg": "Aluno atualizado"}

@router.delete("/alunos/{id_aluno}")
async def deletar_aluno(id_aluno: int):
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("DELETE FROM aluno WHERE id_aluno=%s", (id_aluno,))
    conn.commit()
    cur.close()
    conn.close()
    return {"msg": "Aluno removido"}