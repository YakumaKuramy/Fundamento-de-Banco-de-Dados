from fastapi import APIRouter, HTTPException
from db import get_connection
from models_sgesc import Professor
from typing import List, Optional
from models_sgesc import ProfessorUpdate

router = APIRouter()

@router.post("/professores")
async def criar_professor(dep: Professor):
    conn = get_connection()
    cur = conn.cursor()
    try:
        cur.execute(
            "INSERT INTO professor (id_professor, nome, especialidade, data_contratacao) VALUES (%s, %s, %s, %s)",
            (dep.id_professor, dep.nome, dep.especialidade, dep.data_contratacao)
        )
        conn.commit()
    except Exception as e:
        conn.rollback()
        raise HTTPException(400, f"Erro ao criar professor: {e}")
    finally:
        cur.close()
        conn.close()
    return {"msg": "Professor criado com sucesso"}


@router.get("/professores", response_model=List[Professor])
async def listar_professores():
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("SELECT id_professor, nome, especialidade, data_contratacao FROM professor")
    rows = cur.fetchall()
    cur.close()
    conn.close()
    return [
        Professor(
            id_professor=d[0], nome=d[1], especialidade=d[2], data_contratacao=d[3]
        ) for d in rows
    ]

@router.get("/professores/{id_professor}", response_model=Professor)
async def get_professor(id_professor: int):
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("SELECT id_professor, nome, especialidade, data_contratacao FROM professor WHERE id_professor=%s", (id_professor,))
    row = cur.fetchone()
    cur.close()
    conn.close()
    if row:
        return Professor(id_professor=d[0], nome=d[1], especialidade=d[2], data_contratacao=d[3])
    raise HTTPException(404, "Professor não encontrado")


@router.patch("/professores/{id_professor}")
async def atualizar_professor_parcial(id_professor: int, dep: ProfessorUpdate):
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("SELECT id_professor FROM professor WHERE id_professor=%s", (id_professor,))
    if not cur.fetchone():
        cur.close()
        conn.close()
        raise HTTPException(404, "Professor não encontrado")
    fields = []
    values = []
    for campo, valor in dep.dict(exclude_unset=True).items():
        fields.append(f"{campo}=%s")
        values.append(valor)
    if not fields:
        cur.close()
        conn.close()
        raise HTTPException(400, "Nenhum campo informado para atualização")
    values.append(id_professor)
    try:
        cur.execute(f"UPDATE professor SET {', '.join(fields)} WHERE id_professor=%s", values)
        conn.commit()
    except Exception as e:
        conn.rollback()
        raise HTTPException(400, f"Erro ao atualizar: {e}")
    finally:
        cur.close()
        conn.close()
    return {"msg": "Professor atualizado"}

@router.delete("/professores/{id_professor}")
async def deletar_professor(id_professor: int):
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("DELETE FROM professor WHERE id_professor=%s", (id_professor,))
    conn.commit()
    cur.close()
    conn.close()
    return {"msg": "Professor removido"}