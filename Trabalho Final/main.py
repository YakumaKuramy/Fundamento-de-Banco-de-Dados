from fastapi import FastAPI
#from crud_departamento import router as departamento_router
from crud_aluno import router as aluno_router
from crud_professor import router as professor_router
from crud_desempenho import router as desempenho_router
from crud_disciplina import router as disciplina_router
from crud_matricula import router as matricula_router
from crud_oferta_disciplina import router as oferta_disciplina_router
from crud_turma import router as turma_router

app = FastAPI(
    title="API SGESC - Sistema de Gestão Escolar",
    version="1.0"
)


#app.include_router(departamento_router, prefix="/departamentos", tags=["Departamento"])
app.include_router(aluno_router, prefix="/aluno", tags=["Aluno"])
app.include_router(professor_router, prefix="/professores", tags=["Professor"])
app.include_router(desempenho_router, prefix="/desempenho", tags=["Desempenho"])
app.include_router(disciplina_router, prefix="/disciplinas", tags=["Disciplina"])
app.include_router(matricula_router, prefix="/matriculas", tags=["Matricula"])
app.include_router(oferta_disciplina_router, prefix="/ofertas_disciplinas", tags=["Oferta Disciplina"])
app.include_router(turma_router, prefix="/turmas", tags=["Turma"])

# uvicorn main:app --reload

# python -m uvicorn main:app --reload
