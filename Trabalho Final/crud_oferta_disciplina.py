from fastapi import APIRouter, HTTPException
from db import get_connection
from models_sgesc import OfertaDisciplina
from typing import List, Optional
from models_sgesc import OfertaDisciplinaUpdate

router = APIRouter()

@router.post("/ofertas_disciplinas", response_model=OfertaDisciplina)
async def criar_ofertas_disciplina(dep: OfertaDisciplina):
    conn = get_connection()
    cur = conn.cursor()
    try:
        cur.execute(
            "INSERT INTO oferta_disciplina (id_oferta, id_disciplina, id_turma, id_professor) VALUES (%s, %s, %s, %s)",
            (dep.id_oferta, dep.id_disciplina, dep.id_turma, dep.id_professor)
        )
        conn.commit()
    except Exception as e:
        conn.rollback()
        raise HTTPException(400, f"Erro ao criar oferta de disciplina: {e}")
    finally:
        cur.close()
        conn.close()
    return {"msg": "Oferta de disciplina criada com sucesso"}


@router.get("/ofertas_disciplinas", response_model=List[OfertaDisciplina])
async def listar_ofertas_disciplinas():
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("SELECT id_oferta, id_disciplina, id_turma, id_professor FROM oferta_disciplina")
    rows = cur.fetchall()
    cur.close()
    conn.close()
    return [
        OfertaDisciplina(
            id_oferta=d[0], id_disciplina=d[1], id_turma=d[2], id_professor=d[3]
        ) for d in rows
    ]

@router.get("/ofertas_disciplinas/{id_oferta}", response_model=OfertaDisciplina)
async def get_oferta_disciplina(id_oferta: int):
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("SELECT id_oferta, id_disciplina, id_turma, id_professor FROM oferta_disciplina WHERE id_oferta=%s", (id_oferta,))
    row = cur.fetchone()
    cur.close()
    conn.close()
    if row:
        return OfertaDisciplina(id_oferta=d[0], id_disciplina=d[1], id_turma=d[2], id_professor=d[3])
    raise HTTPException(404, "Oferta de Disciplina não encontrado")


@router.patch("/ofertas_disciplinas/{id_oferta}")
async def atualizar_professor_parcial(id_oferta: int, dep: OfertaDisciplinaUpdate):
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("SELECT id_oferta FROM oferta_disciplina WHERE id_oferta=%s", (id_oferta,))
    if not cur.fetchone():
        cur.close()
        conn.close()
        raise HTTPException(404, "Oferta de Disciplina não encontrado")
    fields = []
    values = []
    for campo, valor in dep.dict(exclude_unset=True).items():
        fields.append(f"{campo}=%s")
        values.append(valor)
    if not fields:
        cur.close()
        conn.close()
        raise HTTPException(400, "Nenhum campo informado para atualização")
    values.append(id_oferta)
    try:
        cur.execute(f"UPDATE oferta_disciplina SET {', '.join(fields)} WHERE id_oferta=%s", values)
        conn.commit()
    except Exception as e:
        conn.rollback()
        raise HTTPException(400, f"Erro ao atualizar: {e}")
    finally:
        cur.close()
        conn.close()
    return {"msg": "Oferta de Disciplina atualizada"}

@router.delete("/ofertas_disciplinas/{id_oferta}")
async def deletar_oferta_disciplina(id_oferta: int):
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("DELETE FROM oferta_disciplina WHERE id_oferta=%s", (id_oferta,))
    conn.commit()
    cur.close()
    conn.close()
    return {"msg": "Oferta de disciplina removida"}