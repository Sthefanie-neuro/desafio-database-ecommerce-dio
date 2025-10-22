# Desafio de Modelagem de Banco de Dados para E-commerce

Este repositório contém a solução para o desafio de projeto de modelagem de um banco de dados para um cenário de e-commerce, abrangendo desde o esquema lógico até consultas complexas para análise de dados.

## Descrição do Esquema Lógico

O modelo de dados foi projetado para suportar as operações de um e-commerce que trabalha com múltiplos fornecedores e locais de estoque, seguindo um modelo similar ao de dropshipping ou marketplace.

### Principais Tabelas:

* **Cliente**: Armazena os dados dos clientes, diferenciando Pessoa Física (PF) de Pessoa Jurídica (PJ) através da coluna `TipoPessoa`.
* **Produto**: Catálogo central de todos os produtos disponíveis para venda.
* **Fornecedor**: Cadastro dos fornecedores que disponibilizam os produtos.
* **Pedidos**: Registra o "cabeçalho" de cada venda, vinculando um cliente, data e valor total.
* **ItensPedido**: Tabela de junção que detalha cada pedido, especificando qual produto, de qual fornecedor, em qual quantidade e por qual preço foi vendido. Esta é a tabela central que viabiliza a regra de negócio de "um pedido poder ter vários fornecedores".
* **ProdutoFornecedor**: Tabela de junção que define o catálogo de sourcing, ou seja, quais produtos cada fornecedor pode oferecer e a que custo.
* **LocaisEstoque** e **ProdutoEstoque**: Gerenciam a quantidade de cada produto em diferentes locais físicos de armazenamento.
* **Pagamento** e **Entrega**: Tabelas com relação 1:1 com `Pedidos` para armazenar informações de pagamento e logística de cada venda.

## Como Utilizar

1.  **Criação do Schema:** Execute o script `script_criacao_banco.sql` para criar o banco de dados e todas as tabelas.
2.  **Inserção de Dados:** Execute o script `script_insercao_dados.sql` para popular o banco de dados com dados de teste.
3.  **Consultas:** O arquivo `queries.sql` contém diversas consultas que respondem a perguntas de negócio e demonstram o uso de cláusulas como JOIN, GROUP BY, HAVING, WHERE e ORDER BY para análise dos dados.
