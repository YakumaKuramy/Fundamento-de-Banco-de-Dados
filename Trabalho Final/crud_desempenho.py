from fastapi import APIRouter, HTTPException
from db import get_connection
from models_sgesc import Desempenho
from typing import List, Optional
from models_sgesc import DesempenhoUpdate

router = APIRouter()

@router.post("/desempenho")
async def criar_desempenho(dep: Desempenho):
    conn = get_connection()
    cur = conn.cursor()
    try:
        cur.execute(
            "INSERT INTO desempenho (id_desempenho, id_matricula, id_oferta, nota1, nota2, nota3, media, faltas) VALUES (%s, %s, %s, %s)",
            (dep.id_desempenho, dep.id_matricula, dep.id_oferta, dep.nota1, dep.nota2, dep.nota3, dep.media, dep.faltas )
        )
        conn.commit()
    except Exception as e:
        conn.rollback()
        raise HTTPException(400, f"Erro ao criar desempenho: {e}")
    finally:
        cur.close()
        conn.close()
    return {"msg": "Desempenho criado com sucesso"}


@router.get("/desempenho", response_model=List[Desempenho])
async def listar_desempenho():
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("SELECT id_desempenho, id_matricula, id_oferta, nota1, nota2, nota3, media, faltas FROM desempenho")
    rows = cur.fetchall()
    cur.close()
    conn.close()
    return [
        Desempenho(
            id_desempenho=d[0], id_matricula=d[1], id_oferta=d[2], nota1=d[3], nota2=d[4], nota3=d[5], media=d[6], faltas=d[7]  
        ) for d in rows
    ]

@router.get("/desempenho/{id_desempenho}", response_model=Desempenho)
async def get_desempenho(id_desempenho: int):
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("SELECT id_desempenho, id_matricula, id_oferta, nota1, nota2, nota3, media, faltas FROM desempenho WHERE id_desempenho=%s", (id_desempenho,))
    row = cur.fetchone()
    cur.close()
    conn.close()
    if row:
        return Desempenho(id_desempenho=d[0], id_matricula=d[1], id_oferta=d[2], nota1=d[3], nota2=d[4], nota3=d[5], media=d[6], faltas=d[7])
    raise HTTPException(404, "Desempenho não encontrado")


@router.patch("/desempenho/{id_desempenho}")
async def atualizar_desempenho_parcial(id_desempenho: int, dep: DesempenhoUpdate):
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("SELECT id_desempenho FROM desempenho WHERE id_desempenho=%s", (id_desempenho,))
    if not cur.fetchone():
        cur.close()
        conn.close()
        raise HTTPException(404, "Desempenho não encontrado")
    fields = []
    values = []
    for campo, valor in dep.dict(exclude_unset=True).items():
        fields.append(f"{campo}=%s")
        values.append(valor)
    if not fields:
        cur.close()
        conn.close()
        raise HTTPException(400, "Nenhum campo informado para atualização")
    values.append(id_desempenho)
    try:
        cur.execute(f"UPDATE desempenho SET {', '.join(fields)} WHERE id_desempenho=%s", values)
        conn.commit()
    except Exception as e:
        conn.rollback()
        raise HTTPException(400, f"Erro ao atualizar: {e}")
    finally:
        cur.close()
        conn.close()
    return {"msg": "Desempenho atualizado"}

@router.delete("/desempenho/{id_desempenho}")
async def deletar_desempenho(id_desempenho: int):
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("DELETE FROM desempenho WHERE id_desempenho=%s", (id_desempenho,))
    conn.commit()
    cur.close()
    conn.close()
    return {"msg": "Desempenho removido"}