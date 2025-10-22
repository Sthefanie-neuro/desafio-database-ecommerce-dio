-- Cria o banco de dados e o seleciona
CREATE DATABASE ecommerce_db;
USE ecommerce_db;

-- Recria todas as tabelas com as regras finais
CREATE TABLE `Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT, `TipoPessoa` CHAR(1) NOT NULL, `Nome` VARCHAR(150) NOT NULL,
  `RazaoSocial` VARCHAR(150) NULL, `CPF` VARCHAR(11) NULL, `CNPJ` VARCHAR(14) NULL,
  `Email` VARCHAR(100) NOT NULL, `Telefone` VARCHAR(20) NOT NULL, `DataCadastro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idCliente`), UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) VISIBLE, UNIQUE INDEX `CNPJ_UNIQUE` (`CNPJ` ASC) VISIBLE,
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE,
  CONSTRAINT `chk_documento` CHECK ((`CPF` IS NOT NULL AND `CNPJ` IS NULL) OR (`CPF` IS NULL AND `CNPJ` IS NOT NULL))
);
CREATE TABLE `Fornecedor` (
  `idFornecedor` INT NOT NULL AUTO_INCREMENT, `TipoPessoa` CHAR(1) NOT NULL, `NomeFantasia` VARCHAR(150) NULL,
  `RazaoSocial` VARCHAR(150) NOT NULL, `CPF` VARCHAR(11) NULL, `CNPJ` VARCHAR(14) NULL,
  PRIMARY KEY (`idFornecedor`), UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) VISIBLE, UNIQUE INDEX `CNPJ_UNIQUE` (`CNPJ` ASC) VISIBLE
);
CREATE TABLE `Produto` (
  `idProduto` INT NOT NULL AUTO_INCREMENT, `Nome` VARCHAR(150) NOT NULL, `Descricao` TEXT NULL,
  `Categoria` VARCHAR(50) NULL, `Valor` DECIMAL(10,2) NOT NULL, PRIMARY KEY (`idProduto`)
);
CREATE TABLE `LocaisEstoque` (
  `idLocal` INT NOT NULL AUTO_INCREMENT, `NomeEstoque` VARCHAR(100) NOT NULL, `EnderecoEstoque` VARCHAR(255) NULL,
  PRIMARY KEY (`idLocal`)
);
CREATE TABLE `Pedidos` (
  `idPedido` INT NOT NULL AUTO_INCREMENT, `idCliente` INT NOT NULL, `DataPedido` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Status_pedido` VARCHAR(30) NOT NULL, `ValorTotal` DECIMAL(10,2) NOT NULL, PRIMARY KEY (`idPedido`),
  CONSTRAINT `fk_Pedidos_Cliente` FOREIGN KEY (`idCliente`) REFERENCES `Cliente` (`idCliente`) ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE TABLE `Pagamento` (
  `idPagamento` INT NOT NULL AUTO_INCREMENT, `idPedido` INT NOT NULL, `Metodo` VARCHAR(45) NOT NULL,
  `Status` VARCHAR(30) NOT NULL, `Valor` DECIMAL(10,2) NOT NULL, PRIMARY KEY (`idPagamento`),
  UNIQUE INDEX `idPedido_UNIQUE` (`idPedido` ASC) VISIBLE,
  CONSTRAINT `fk_Pagamento_Pedidos` FOREIGN KEY (`idPedido`) REFERENCES `Pedidos` (`idPedido`) ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE TABLE `Entrega` (
  `idEntrega` INT NOT NULL AUTO_INCREMENT, `idPedido` INT NOT NULL, `Status` VARCHAR(30) NOT NULL,
  `CodigoRastreio` VARCHAR(50) NULL, `Transportadora` VARCHAR(50) NULL, PRIMARY KEY (`idEntrega`),
  UNIQUE INDEX `idPedido_UNIQUE` (`idPedido` ASC) VISIBLE,
  CONSTRAINT `fk_Entrega_Pedidos` FOREIGN KEY (`idPedido`) REFERENCES `Pedidos` (`idPedido`) ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE TABLE `ProdutoFornecedor` (
  `idProduto` INT NOT NULL, `idFornecedor` INT NOT NULL, `PrecoCusto` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`idProduto`, `idFornecedor`),
  CONSTRAINT `fk_ProdutoFornecedor_Produto` FOREIGN KEY (`idProduto`) REFERENCES `Produto` (`idProduto`),
  CONSTRAINT `fk_ProdutoFornecedor_Fornecedor` FOREIGN KEY (`idFornecedor`) REFERENCES `Fornecedor` (`idFornecedor`)
);
CREATE TABLE `ProdutoEstoque` (
  `idProduto` INT NOT NULL, `idLocal` INT NOT NULL, `Quantidade` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idProduto`, `idLocal`),
  CONSTRAINT `fk_ProdutoEstoque_Produto` FOREIGN KEY (`idProduto`) REFERENCES `Produto` (`idProduto`),
  CONSTRAINT `fk_ProdutoEstoque_LocaisEstoque` FOREIGN KEY (`idLocal`) REFERENCES `LocaisEstoque` (`idLocal`)
);
CREATE TABLE `ItensPedido` (
  `idPedido` INT NOT NULL, `idProduto` INT NOT NULL, `idFornecedor` INT NOT NULL,
  `Quantidade` INT NOT NULL, `PrecoUnitario` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`idPedido`, `idProduto`, `idFornecedor`),
  CONSTRAINT `fk_ItensPedido_Pedidos` FOREIGN KEY (`idPedido`) REFERENCES `Pedidos` (`idPedido`),
  CONSTRAINT `fk_ItensPedido_Produto` FOREIGN KEY (`idProduto`) REFERENCES `Produto` (`idProduto`),
  CONSTRAINT `fk_ItensPedido_Fornecedor` FOREIGN KEY (`idFornecedor`) REFERENCES `Fornecedor` (`idFornecedor`)
);
