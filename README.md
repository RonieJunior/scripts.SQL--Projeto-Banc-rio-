📘– Sistema Bancário Corinto Digital S/A
🏦 Projeto: Sistema Bancário Integrado
Este projeto foi desenvolvido para a empresa Corinto Digital S/A, uma fintech que opera exclusivamente no ambiente digital, oferecendo serviços como contas, cartões, investimentos e empréstimos.
Com o crescimento da instituição, surgiu a necessidade de integrar todos os dados em um único banco, eliminando erros, duplicações e falhas de rastreio nos sistemas internos.
Este documento apresenta toda a modelagem do banco de dados e funcionalidades aplicadas.

📑 1. Cenário da Empresa
A Corinto Digital S/A enfrentava problemas causados por sistemas fragmentados:
✔ Sistemas separados para clientes, contas, cartões, investimentos e empréstimos
✔ Dados duplicados
✔ Falta de precisão nas transações
✔ Dificuldade para rastrear produtos financeiros
✔ Problemas de vinculação entre cliente, conta e cartão
Com isso, um novo sistema integrado foi desenvolvido para centralizar todas as informações em um único banco relacional.

🧩 2. Entidades do Sistema
O banco de dados foi modelado com as seguintes entidades principais:

1. Cliente
Atributos:
ID_cliente (PK)
cpf
nome_completo
data_nascimento
idade (derivado)
telefone
email
endereço (entidade relacionada)

2. Endereço
Atributos:
ID_endereco (PK)
rua
numero
cep
cidade
estado
Relacionamento: Cliente 1:1 Endereço

3. Conta
Atributos:
ID_conta (PK)
agencia
numero_conta
tipo_conta
saldo
Relacionamento: Cliente 1:N Conta

4. Cartão
Atributos:
ID_cartao (PK)
numero_cartao
validade
cvv
limite
Relacionamento: Cliente 1:1 Cartão

5. Transação
Atributos:
ID_transacao (PK)
data_hora
valor
tipo_transacao (débito, crédito, pix, transferência)
Relacionamento: Conta 1:N Transação

6. Empréstimo
Atributos:
ID_emprestimo (PK)
valor_solicitado
parcela
juros_mensal
valor_total (valor_solicitado + juros)
Relacionamento: Conta 1:N Empréstimo

8. Investimento
Atributos:
ID_investimento (PK)
tipo_investimento (CDB, LCI, Tesouro, Ações)
tempo_resgate
valor_inicial
valor_atual (derivado)
Relacionamento: Conta N:N Investimento

🧠 3. Modelagem Conceitual (DER)
🔗 Link do DER:
https://lucid.app/lucidchart/5baf6235-6e88-4616-8dcb-5bbbd42e674f
Representação em alto nível mostrando entidades, atributos e relacionamentos.

🧮 4. Modelagem Lógica
🔗 Link da modelagem lógica:
https://lucid.app/lucidchart/5baf6235-6e88-4616-8dcb-5bbbd42e674f
Transformação do modelo conceitual em esquema relacional.

🧱 5. Modelagem Física
O modelo físico foi implementado em PostgreSQL / Supabase.
Inclui criação de tabelas, chaves primárias, estrangeiras e integridade relacional.

📊 6. Dados
Foram gerados:
500 clientes
500 endereços
500 conta
500 cartões
500 transações
500 empréstimos
500 investimentos
Todos respeitando as regras de relacionamento entre entidades.

🔄 7. CRUD – Tabela Cliente
INSERT
INSERT INTO cliente (cpf, nome_completo, data_nascimento, telefone, email)
VALUES ('12345678901', 'João da Silva', '1980-05-21', '11988887777', 'joao@gmail.com');

SELECT
SELECT * FROM cliente;

UPDATE
UPDATE cliente
SET telefone = '11999998888'
WHERE ID_cliente = 10;

DELETE
DELETE FROM cliente
WHERE ID_cliente = 15;

📈 10. Relatórios (Consultas Avançadas)
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


🏁 Conclusão
Este projeto entrega:

✔ Um banco relacional sólido
✔ Modelagem conceitual, lógica e física completas
✔ Relacionamentos consistentes
✔ Geração de dados em larga escala
✔ Consultas úteis para análises reais
✔ Base pronta para integração com um sistema bancário digital
