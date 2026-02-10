Anotações feitas no Notion:


# [Link do curso](https://www.youtube.com/watch?v=VmkJG8awKqM&list=PLvlkVRRKOYFRo651oD0JptVqfQGDvMi3j)

# Projeto SQL – Feature Store de Clientes

## Visão Geral

Este projeto tem como objetivo **construir uma feature store de clientes** a partir de dados transacionais, utilizando **SQL (SQLite)** para agregações analíticas e **Python** para orquestrar o processo de ETL.

A ideia central é gerar, para cada cliente e para uma **data de referência**, um conjunto rico de variáveis (features) que descrevem:

* comportamento de uso ao longo do tempo
* engajamento recente
* saldo e movimentação de pontos
* preferências de produtos
* padrões temporais (dia da semana e período do dia)

Esse tipo de estrutura é muito comum em **analytics**, **BI**, **machine learning** e **modelos de churn/engajamento**.

---

## Tecnologias Utilizadas

* **SQLite** – banco de dados relacional
* **SQL** – agregações, CTEs e window functions
* **Python 3**
* **Pandas** – manipulação de dados
* **SQLAlchemy** – conexão com o banco

---

## Estrutura do Projeto

```
Projeto-SQL-Estudos/
│
├── etl_projeto.sql        # Query principal de construção das features
├── etl.py                 # Script de ETL e carga no banco
├── database/
│   └── database.db        # Banco SQLite
└── README.md              # Documentação do projeto
```

---

## Modelo de Dados (Premissas)

O projeto assume a existência das seguintes tabelas no banco:

* **clientes**

  * IdCliente
  * dtCriacao

* **transacoes**

  * IdTransacao
  * IdCliente
  * QtdePontos
  * dtCriacao

* **transacao_produto**

  * IdTransacao
  * IdProduto

* **produtos**

  * IdProduto
  * DescNomeProduto
  * DescCategoriaProduto

---

## Funcionamento da Query SQL (`etl_projeto.sql`)

A query utiliza **CTEs (WITH)** para organizar o raciocínio analítico. O fluxo é incremental:

### 1. `tb_transacoes`

Normaliza datas, calcula:

* diferença de dias entre a transação e a data de referência (`diffDate`)
* hora da transação (`dtHora`)

Somente transações **anteriores à data de referência** são consideradas.

---

### 2. `tb_cliente`

Calcula a **idade do cliente** em dias na data de referência.

---

### 3. `tb_sumario_transacoes`

Gera métricas agregadas por cliente:

* Quantidade de transações:

  * vida inteira
  * últimos 56, 28, 14 e 7 dias

* Pontos:

  * saldo total
  * pontos positivos e negativos por janela temporal

* Recência:

  * dias desde a última interação

Essa CTE é o **núcleo numérico** da feature store.

---

### 4. `tb_transacao_produto`

Enriquece as transações com informações de produto e categoria.

---

### 5. `tb_cliente_produto`

Conta quantas vezes cada cliente interagiu com cada produto:

* ao longo da vida
* nas janelas de tempo recentes

---

### 6. `tb_cliente_produto_rn`

Usa **window functions (`row_number`)** para identificar:

* produto mais frequente do cliente
* produto mais frequente em cada janela (56, 28, 14, 7 dias)

---

### 7. `tb_cliente_dia` e `tb_cliente_dia_rn`

Identifica o **dia da semana** em que o cliente mais transaciona (últimos 28 dias).

---

### 8. `tb_cliente_periodo` e `tb_cliente_periodo_rn`

Classifica transações por período do dia:

* madrugada
* manhã
* tarde
* noite

E identifica o período mais frequente para cada cliente.

---

### 9. `tb_join`

Consolida todas as informações em uma única linha por cliente:

* métricas numéricas
* idade do cliente
* produtos preferidos
* dia da semana mais ativo
* período do dia mais ativo

---

### 10. Resultado Final

A query retorna:

* data de referência (`dtRef`)
* todas as features do cliente
* métrica de engajamento:

```
engajamento28Vida = qtdeTransacoes28 / qtdeTransacoesVida
```

---

## Funcionamento do ETL em Python (`etl.py`)

O script Python executa a query para **múltiplas datas de referência**, criando um histórico de features.

### Passo a passo:

1. Cria conexão com o banco SQLite
2. Lê o arquivo `etl_projeto.sql`
3. Define uma lista de datas de referência
4. Para cada data:

   * injeta a data na query
   * executa a SQL
   * carrega o resultado em um DataFrame
   * grava os dados na tabela `feature_store_cliente`

Os dados são **appendados**, permitindo análises temporais.

---

## Como Rodar o Projeto

### 1. Criar ambiente

```bash
python -m venv venv
source venv/bin/activate  # Linux / Mac
venv\Scripts\activate     # Windows
```

### 2. Instalar dependências

```bash
pip install pandas sqlalchemy
```

### 3. Garantir o banco SQLite

O arquivo `database/database.db` deve existir e conter as tabelas esperadas.

### 4. Executar o ETL

```bash
python etl.py
```

Após a execução, a tabela **feature_store_cliente** será criada/populada no banco.

---

## Objetivo Educacional

Este projeto foi criado para praticar:

* SQL analítico avançado
* CTEs e window functions
* construção de feature stores
* integração SQL + Python
* raciocínio de dados orientado a produto

---

## Possíveis Evoluções

* Normalizar melhor janelas temporais
* Criar índices no banco
* Versionar features
* Separar camada de staging e analytics
* Exportar para Parquet ou CSV

---

## Autor

Projeto desenvolvido para estudo e prática de engenharia de dados e analytics.
