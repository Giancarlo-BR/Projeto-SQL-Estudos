Anotações feitas no Notion:


# [Link do curso](https://www.youtube.com/watch?v=VmkJG8awKqM&list=PLvlkVRRKOYFRo651oD0JptVqfQGDvMi3j)

### Dificuldades que encontrei ao fazer o projeto

- substr, julianday e operações de diff etc: Quando comecei já me deparei com algo tipo →

```sql
julianday(’{date}’) - (alguma coisa) AS diffDate
```

```sql
substr(dtCriacao,1,10)
```

As vezes é difícil entender o que tá acontecendo na query quando se usa operações com data nesse nível, ainda mais quando é alguém escolhendo as palavras que vai usar, por exemplo, eu não usaria “dtCriacao” para nomear a data de criação, acho essa forma pouco prática.

- **Window Functions (`ROW_NUMBER`, `PARTITION BY`):** A sintaxe é bem verbosa e demorei pra visualizar a diferença pro `GROUP BY` normal →

```sql
row_number() OVER (PARTITION BY IdCliente ORDER BY qtdeVida DESC) AS rnVida
```

Entender que ele tá criando um ranking *dentro* de cada grupo de clientes sem colapsar as linhas deu um nó na cabeça no início.

- **Agregações condicionais (`CASE WHEN` dentro do `COUNT/SUM`):** O código fica gigante e repetitivo, parece meio "gambiarra" ter que fazer isso linha a linha →

```sql
count(CASE WHEN diffDate <= 56 THEN IdTransacao END) AS qtdeTransacoes56,
sum(CASE WHEN qtdePontos > 0 AND diffDate <= 56 THEN qtdePontos ELSE 0 END)
```

É muito fácil errar uma condição ali no meio e estragar a métrica toda sem perceber.
