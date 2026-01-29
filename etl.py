import os
import pandas as pd
import sqlalchemy

# diretório do projeto (onde está etl.py)
BASE_DIR = os.path.dirname(os.path.abspath(__file__))

# conexão com banco
engine = sqlalchemy.create_engine(f"sqlite:///{os.path.join(BASE_DIR, 'database', 'database.db')}")

# lendo a query do arquivo de texto
sql_path = os.path.join(BASE_DIR, "etl_projeto.sql")
with open(sql_path, encoding="utf-8") as open_file:
    query = open_file.read()

# %%

dates = [
    '2025-01-01',
    '2025-02-01',
    '2025-03-01',
    '2025-04-01',
    '2025-05-01',
    '2025-06-01',
    '2025-07-01',
]

for i in dates:

    with engine.connect() as conn:
        result = conn.execute(sqlalchemy.text(
            "SELECT name FROM sqlite_master WHERE type='table';"
        ))
        print(result.fetchall())

    # EXECUTA A QUERY E TRAZ OS DADOS PARA O PYTHON
    df = pd.read_sql(query.format(date=i), engine)

    # PEGA OS DADOS DO PYTHON E MANDA PARA O BANCO NA TABELA feature_store_cliente
    df.to_sql("feature_store_cliente", engine, index=False, if_exists="append")
