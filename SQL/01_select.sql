



-- Seleciona todos os campos da tabela clientes
-- SELECT *

-- FROM transacoes WHERE QtdePontos = 50

--------------------------------------------------------

-- SELECT * 

-- FROM clientes WHERE QtdePontos > 500

--------------------------------------------------------

-- SELECT * 

-- FROM produtos WHERE DescNomeProduto LIKE "churn%"

--------------------------------------------------------

-- SELECT IdTransacao, QtdePontos

-- FROM transacoes WHERE QtdePontos = 1

--------------------------------------------------------

-- SELECT IdTransacao,
--         DtCriacao,
--         strftime('%w', DtCriacao) IN ('0', '6') AS Dia_da_Semana
       

-- FROM transacoes
-- WHERE 

--------------------------------------------------------


-- SELECT idCliente,
--         sum(QtdePontos) AS total_pontos

-- FROM clientes
-- GROUP BY idCliente

--------------------------------------------------------

-- SELECT idCliente,
--     count(*) AS qtd_transacao

-- FROM transacoes
-- GROUP BY idCliente

--------------------------------------------------------

-- SELECT idCliente, DescSistemaOrigem, 
--         COUNT(*) AS qtd 

-- FROM transacoes

-- GROUP BY idCliente, DescSistemaOrigem

--------------------------------------------------------

-- SELECT date(DtCriacao) AS dia,
--         COUNT(*) AS total_transacoes
-- FROM transacoes
-- GROUP BY date(DtCriacao)
-- ORDER BY dia;

--------------------------------------------------------







-- SELECT idCliente, 
--         count(*) as qtd_transacoes
-- FROM transacoes
-- GROUP BY idCliente

-- SELECT idCliente,
--         SUM(qtdePontos) as total_pontos
-- FROM clientes
-- GROUP BY idCliente

-- SELECT idCliente, 
--     MIN(DtCriacao) as primeira_transacao

-- FROM transacoes
-- GROUP BY idCliente

-- SELECT idCliente, 
--     MAX(DtCriacao) as ultima_transacao

-- FROM transacoes
-- GROUP BY idCliente

-------------------------------------------------------

-- SELECT idCliente, 
--         count(*) as qtd_transacoes,
--         SUM(qtdePontos) as total_pontos,
--         MIN(DtCriacao) as primeira_transacao,
--         MAX(DtCriacao) as ultima_transacao
-- FROM transacoes WHERE DescSistemaOrigem = 'twitch' 
-- GROUP BY idCliente
-- HAVING COUNT(*) > 10
-- ORDER BY total_pontos DESC

