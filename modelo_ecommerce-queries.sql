
-- 1. Qual a relação de nomes dos fornecedores e os nomes dos produtos que eles fornecem?
SELECT 
    f.NomeFantasia AS Fornecedor,
    p.Nome AS Produto,
    pf.PrecoCusto AS 'Preço de Custo'
FROM ProdutoFornecedor pf
JOIN Fornecedor f ON pf.idFornecedor = f.idFornecedor
JOIN Produto p ON pf.idProduto = p.idProduto
ORDER BY f.NomeFantasia;

-- 2. Quantos pedidos foram feitos por cada cliente?

SELECT 
    c.Nome AS Cliente,
    COUNT(p.idPedido) AS 'Total de Pedidos'
FROM Cliente c
JOIN Pedidos p ON c.idCliente = p.idCliente
GROUP BY c.Nome;

-- 3. Algum fornecedor também está cadastrado como cliente?

SELECT 
    f.RazaoSocial AS Fornecedor,
    c.RazaoSocial AS Cliente
FROM Fornecedor f
JOIN Cliente c ON f.CNPJ = c.CNPJ
WHERE f.CNPJ IS NOT NULL;

-- 4. Qual a relação de produtos, seus fornecedores e a quantidade disponível em cada local de estoque?

SELECT 
    p.Nome AS Produto,
    f.NomeFantasia AS Fornecedor,
    le.NomeEstoque AS Local,
    pe.Quantidade
FROM Produto p
JOIN ProdutoFornecedor pf ON p.idProduto = pf.idProduto
JOIN Fornecedor f ON pf.idFornecedor = f.idFornecedor
LEFT JOIN ProdutoEstoque pe ON p.idProduto = pe.idProduto
LEFT JOIN LocaisEstoque le ON pe.idLocal = le.idLocal
ORDER BY p.Nome, f.NomeFantasia;

-- 5. Quais produtos da categoria 'Periféricos' custam mais de R$ 300, ordenados do mais caro para o mais barato?

SELECT Nome, Categoria, Valor
FROM Produto
WHERE Categoria = 'Periféricos' AND Valor > 300.00
ORDER BY Valor DESC;

-- 6. Quais clientes fizeram 2 ou mais pedidos?

SELECT 
    c.Nome,
    COUNT(p.idPedido) AS 'Quantidade de Pedidos'
FROM Cliente c
JOIN Pedidos p ON c.idCliente = p.idCliente
GROUP BY c.Nome
HAVING COUNT(p.idPedido) >= 2;

-- 7. Qual é o faturamento total (em R$) que cada fornecedor gerou para a loja, ordenado do maior para o menor?

SELECT
    f.NomeFantasia AS Fornecedor,
    SUM(ip.Quantidade * ip.PrecoUnitario) AS FaturamentoGerado
FROM ItensPedido ip
JOIN Fornecedor f ON ip.idFornecedor = f.idFornecedor
GROUP BY f.NomeFantasia
ORDER BY FaturamentoGerado DESC;

-- 8. Qual é o nosso estoque total (somando todos os depósitos) para cada produto?

SELECT
    p.Nome AS Produto,
    SUM(pe.Quantidade) AS EstoqueTotal
FROM ProdutoEstoque pe
JOIN Produto p ON pe.idProduto = p.idProduto
GROUP BY p.Nome
ORDER BY EstoqueTotal ASC;

-- 9. Quais produtos estão no nosso catálogo, mas nunca foram vendidos?

SELECT Nome, Categoria, Valor
FROM Produto
WHERE idProduto NOT IN (
    SELECT DISTINCT idProduto FROM ItensPedido
);

-- 10. Qual o gasto total por cliente, classificando-os como 'Premium' (gastos > R$ 1000) ou 'Regular'?

SELECT
    c.Nome AS Cliente,
    SUM(p.ValorTotal) AS GastoTotal,
    CASE
        WHEN SUM(p.ValorTotal) > 1000 THEN 'Premium'
        ELSE 'Regular'
    END AS CategoriaCliente
FROM Pedidos p
JOIN Cliente c ON p.idCliente = c.idCliente
GROUP BY c.Nome
ORDER BY GastoTotal DESC;

-- 11. Quantas vezes cada método de pagamento foi utilizado e qual o valor total transacionado por cada um?

SELECT
    Metodo,
    COUNT(idPagamento) AS QuantidadeDeUsos,
    SUM(Valor) AS ValorTotalTransacionado
FROM Pagamento
GROUP BY Metodo;

