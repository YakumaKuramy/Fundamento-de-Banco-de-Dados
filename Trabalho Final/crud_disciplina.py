from fastapi import APIRouter, HTTPException
from db import get_connection
from models_sgesc import Disciplina
from typing import List, Optional
from models_sgesc import DisciplinaUpdate

router = APIRouter()

@router.post("/disciplinas")
async def criar_disciplinas(dep: Disciplina):
    conn = get_connection()
    cur = conn.cursor()
    try:
        cur.execute(
            "INSERT INTO disciplinas (id_disciplina, nome, carga_horaria) VALUES (%s, %s, %s)",
            (dep.id_disciplina, dep.nome, dep.carga_horaria)
        )
        conn.commit()
    except Exception as e:
        conn.rollback()
        raise HTTPException(400, f"Erro ao criar disciplina: {e}")
    finally:
        cur.close()
        conn.close()
    return {"msg": "Disciplina criado com sucesso"}


@router.get("/disciplinas", response_model=List[Disciplina])
async def listar_disciplinas():
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("SELECT id_disciplina, nome, carga_horaria FROM disciplinas")
    rows = cur.fetchall()
    cur.close()
    conn.close()
    return [
        Disciplina(
            id_disciplina=d[0], nome=d[1], carga_horaria=d[2]
        ) for d in rows
    ]

@router.get("/disciplinas/{id_disciplina}", response_model=Disciplina)
async def get_disciplina(id_disciplina: int):
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("SELECT id_disciplina, nome, carga_horaria FROM disciplinas WHERE id_disciplina=%s", (id_disciplina,))
    row = cur.fetchone()
    cur.close()
    conn.close()
    if row:
        return Disciplina(id_disciplina=row[0], nome=row[1], carga_horaria=row[2])
    raise HTTPException(404, "Disciplina não encontrado")


@router.patch("/disciplinas/{id_disciplina}")
async def atualizar_disciplina_parcial(id_disciplina: int, dep: DisciplinaUpdate):
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("SELECT id_disciplina FROM disciplinas WHERE id_disciplina=%s", (id_disciplina,))
    if not cur.fetchone():
        cur.close()
        conn.close()
        raise HTTPException(404, "Disciplina não encontrado")
    fields = []
    values = []
    for campo, valor in dep.dict(exclude_unset=True).items():
        fields.append(f"{campo}=%s")
        values.append(valor)
    if not fields:
        cur.close()
        conn.close()
        raise HTTPException(400, "Nenhum campo informado para atualização")
    values.append(id_disciplina)
    try:
        cur.execute(f"UPDATE disciplinas SET {', '.join(fields)} WHERE id_disciplina=%s", values)
        conn.commit()
    except Exception as e:
        conn.rollback()
        raise HTTPException(400, f"Erro ao atualizar: {e}")
    finally:
        cur.close()
        conn.close()
    return {"msg": "Disciplina atualizado"}

@router.delete("/disciplinas/{id_disciplina}")
async def deletar_disciplina(id_disciplina: int):
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("DELETE FROM disciplinas WHERE id_disciplina=%s", (id_disciplina,))
    conn.commit()
    cur.close()
    conn.close()
    return {"msg": "Disciplina removida"}