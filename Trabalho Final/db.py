import psycopg2

def get_connection():
    return psycopg2.connect(
        dbname="aluno2",
        user="postgres",
        password="Marcos1379",
        host="localhost"
    )