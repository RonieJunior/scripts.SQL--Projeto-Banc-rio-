RELATÓRIO

--1. Listar todos os clientes com saldo acima de R$ 5.000--
SELECT c.ID_cliente, c.nome_completo, ct.saldo
FROM cliente c
JOIN conta ct ON c.ID_cliente = ct.ID_conta
WHERE ct.saldo > 5000
ORDER BY ct.saldo DESC;

--2. Ver todas as transações de um cliente específico (exemplo: ID_conta = 120)--
SELECT  c.nome_completo, t.ID_transacao, t.tipo_transacao, t.valor, t.data_hora
FROM transações t
JOIN conta ct ON t.ID_conta = ct.ID_conta
JOIN cliente c ON ct.ID_conta = c.ID_cliente
WHERE ct.ID_conta = 120
ORDER BY t.data_hora DESC;

--3. Listar clientes que possuem empréstimos acima de R$ 10.000--
SELECT c.ID_cliente, c.nome_completo, e.valor_total
FROM cliente c
JOIN emprestimo e ON c.ID_cliente = e.ID_conta
WHERE e.valor_total > 10000
ORDER BY e.valor_total DESC;

--4. Mostrar os clientes que têm investimentos com valor atual acima de R$ 15.000--
SELECT c.nome_completo, i.tipo_investimento, i.valor_atual
FROM cliente c
JOIN investimento i ON c.ID_cliente = i.ID_conta
WHERE i.valor_atual > 15000
ORDER BY i.valor_atual DESC;

--5. Listar os clientes e seus respectivos cartões (com validade próxima)--
SELECT c.nome_completo, ca.numero_cartão, ca.validade
FROM cliente c
JOIN Cartões ca ON c.ID_cliente = ca.ID_cliente
WHERE ca.validade LIKE '%/26'
ORDER BY ca.validade ASC;

--6. Buscar clientes acima de 50 anos com saldo acima de R$ 2.000--
SELECT c.nome_completo, c.idade, ct.saldo
FROM cliente c
JOIN conta ct ON c.ID_cliente = ct.ID_conta
WHERE c.idade > 50
  AND ct.saldo > 2000
ORDER BY c.idade DESC;

--7. Listar endereços e seus respectivos clientes do estado de SP--
SELECT c.nome_completo, e.rua, e.numero, e.cep, e.estado
FROM cliente c
JOIN endereço e ON c.ID_cliente = e.ID_cliente
WHERE e.estado = 'SP'
ORDER BY c.nome_completo ASC;

--8. Mostrar a quantidade de transações por cliente--
SELECT c.nome_completo, COUNT(t.ID_transacao) AS total_transações
FROM cliente c
JOIN conta ct ON c.ID_cliente = ct.ID_conta
JOIN transações t ON t.ID_conta = ct.ID_conta
GROUP BY c.ID_cliente
ORDER BY total_transações DESC;

--9. Listar clientes com mais de um produto financeiro (investimento + empréstimo)--
SELECT c.nome_completo, i.valor_atual AS investimento, e.valor_total AS emprestimo
FROM cliente c
JOIN investimento i ON c.ID_cliente = i.ID_conta
JOIN emprestimo e ON c.ID_cliente = e.ID_conta
ORDER BY c.nome_completo;

--10. Top 20 maiores transações do banco, mostrando o cliente--
SELECT c.nome_completo, t.tipo_transacao, t.valor, t.data_hora
FROM transações t
JOIN conta ct ON t.ID_conta = ct.ID_conta
JOIN cliente c ON ct.ID_conta = c.ID_cliente
ORDER BY t.valor DESC
LIMIT 20;

