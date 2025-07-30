from fastapi import APIRouter, HTTPException
from db import get_connection
from models_sgesc import Turma
from typing import List, Optional
from models_sgesc import TurmaUpdate

router = APIRouter()

@router.post("/turmas")
async def criar_turma(dep: Turma):
    conn = get_connection()
    cur = conn.cursor()
    try:
        cur.execute(
            "INSERT INTO turma (id_turma, nome, serie, ano, turno) VALUES (%s, %s, %s, %s, %s)",
            (dep.id_turma, dep.nome, dep.serie, dep.ano, dep.turno)
        )
        conn.commit()
    except Exception as e:
        conn.rollback()
        raise HTTPException(400, f"Erro ao criar turma: {e}")
    finally:
        cur.close()
        conn.close()
    return {"msg": "Turma criada com sucesso"}


@router.get("/turmas", response_model=List[Turma])
async def listar_turmas():
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("SELECT id_turma, nome, serie, ano, turno FROM turma")
    rows = cur.fetchall()
    cur.close()
    conn.close()
    return [
        Turma(
            id_turma=d[0], nome=d[1], serie=d[2], ano=d[3], turno=d[4]
        ) for d in rows
    ]

@router.get("/turmas/{id_turma}", response_model=Turma)
async def get_turma(id_turma: int):
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("SELECT id_turma, nome, serie, ano, turno FROM turma WHERE id_turma=%s", (id_turma,))
    row = cur.fetchone()
    cur.close()
    conn.close()
    if row:
        return Turma(id_turma=row[0], nome=row[1], serie=row[2], ano=row[3], turno=row[4])
    raise HTTPException(404, "Turma não encontrado")


@router.patch("/turmas/{id_turma}")
async def atualizar_turma_parcial(id_turma: int, dep: TurmaUpdate):
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("SELECT id_turma FROM turma WHERE id_turma=%s", (id_turma,))
    if not cur.fetchone():
        cur.close()
        conn.close()
        raise HTTPException(404, "Turma não encontrado")
    fields = []
    values = []
    for campo, valor in dep.dict(exclude_unset=True).items():
        fields.append(f"{campo}=%s")
        values.append(valor)
    if not fields:
        cur.close()
        conn.close()
        raise HTTPException(400, "Nenhum campo informado para atualização")
    values.append(id_turma)
    try:
        cur.execute(f"UPDATE turma SET {', '.join(fields)} WHERE id_turma=%s", values)
        conn.commit()
    except Exception as e:
        conn.rollback()
        raise HTTPException(400, f"Erro ao atualizar: {e}")
    finally:
        cur.close()
        conn.close()
    return {"msg": "Turma atualizada"}

@router.delete("/turmas/{id_turma}")
async def deletar_turma(id_turma: int):
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("DELETE FROM turma WHERE id_turma=%s", (id_turma,))
    conn.commit()
    cur.close()
    conn.close()
    return {"msg": "Turma removida"}