from fastapi import APIRouter, HTTPException
from db import get_connection
from models_sgesc import Matricula
from typing import List, Optional
from models_sgesc import MatriculaUpdate

router = APIRouter()

@router.post("/matriculas")
async def criar_matricula(dep: Matricula):
    conn = get_connection()
    cur = conn.cursor()
    try:
        cur.execute(
            "INSERT INTO matricula (id_matricula, id_aluno, id_turma, data_matricula) VALUES (%s, %s, %s, %s)",
            (dep.id_matricula, dep.id_aluno, dep.id_turma, dep.data_matricula)
        )
        conn.commit()
    except Exception as e:
        conn.rollback()
        raise HTTPException(400, f"Erro ao criar matricula: {e}")
    finally:
        cur.close()
        conn.close()
    return {"msg": "Matricula criada com sucesso"}


@router.get("/matriculas", response_model=List[Matricula])
async def listar_matriculas():
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("SELECT id_matricula, id_aluno, id_turma, data_matricula FROM matricula")
    rows = cur.fetchall()
    cur.close()
    conn.close()
    return [
        Matricula(
            id_matricula=d[0], id_aluno=d[1], id_turma=d[2], data_matricula=d[3]
        ) for d in rows
    ]

@router.get("/matriculas/{id_matricula}", response_model=Matricula)
async def get_matriculas(id_matricula: int):
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("SELECT id_matricula, id_aluno, id_turma, data_matricula FROM matricula WHERE id_matricula=%s", (id_matricula,))
    row = cur.fetchone()
    cur.close()
    conn.close()
    if row:
        return Matricula(id_matricula=d[0], id_aluno=d[1], id_turma=d[2], data_matricula=d[3])
    raise HTTPException(404, "Matricula não encontrada")


@router.patch("/matriculas/{id_matricula}")
async def atualizar_matricula_parcial(id_matricula: int, dep: MatriculaUpdate):
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("SELECT id_matricula FROM matricula WHERE id_matricula=%s", (id_matricula,))
    if not cur.fetchone():
        cur.close()
        conn.close()
        raise HTTPException(404, "Matricula não encontrada")
    fields = []
    values = []
    for campo, valor in dep.dict(exclude_unset=True).items():
        fields.append(f"{campo}=%s")
        values.append(valor)
    if not fields:
        cur.close()
        conn.close()
        raise HTTPException(400, "Nenhum campo informado para atualização")
    values.append(id_matricula)
    try:
        cur.execute(f"UPDATE matricula SET {', '.join(fields)} WHERE id_matricula=%s", values)
        conn.commit()
    except Exception as e:
        conn.rollback()
        raise HTTPException(400, f"Erro ao atualizar: {e}")
    finally:
        cur.close()
        conn.close()
    return {"msg": "Matricula atualizado"}

@router.delete("/matriculas/{id_matricula}")
async def deletar_matricula(id_matricula: int):
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("DELETE FROM matricula WHERE id_matricula=%s", (id_matricula,))
    conn.commit()
    cur.close()
    conn.close()
    return {"msg": "Matricula removida"}