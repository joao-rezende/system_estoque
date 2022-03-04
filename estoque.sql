-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Tempo de geração: 04-Mar-2022 às 10:51
-- Versão do servidor: 8.0.25-0ubuntu0.20.04.1
-- versão do PHP: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `estoque`
--

DELIMITER $$
--
-- Procedimentos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `clienteLiberado` (IN `pIdCliente` INT, OUT `liberado` BOOLEAN)  BEGIN 
	DECLARE totalVendas REAL(10,2) DEFAULT 0.00;
	DECLARE limite REAL(10,2) DEFAULT 0.00;  
    CALL totalVendasFiadaCli(pIdCliente, totalVendas);
    SELECT limiteCredito INTO limite FROM cliente WHERE idCliente = pIdCliente;
    IF (totalVendas > limite) 
        THEN
            SET liberado = false;
        ELSE
            SET liberado = true;
   	END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `totalVenda` (IN `pIdVenda` INT, OUT `total` REAL(10,2))  BEGIN 
	SELECT SUM(vendaItens.precoVendido * vendaItens.qtdVendida) INTO total
    FROM venda
    NATURAL JOIN vendaItens
    WHERE venda.idVenda = pIdVenda
    GROUP BY venda.idVenda;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `totalVendasFiadaCli` (IN `pIdCliente` INT, OUT `total` REAL(10,2))  BEGIN 
	SELECT SUM(vendaItens.precoVendido * vendaItens.qtdVendida) INTO total
    FROM venda
    NATURAL JOIN vendaItens
    WHERE venda.idCliente = pIdCliente
    	AND formaPagamento = 'F'
    GROUP BY venda.idVenda;
    
    IF (total IS NULL)
        THEN 
          SET total = 0;
    END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `cliente`
--

CREATE TABLE `cliente` (
  `idCliente` int NOT NULL,
  `email` varchar(80) NOT NULL,
  `limiteCredito` double(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `cliente`
--

INSERT INTO `cliente` (`idCliente`, `email`, `limiteCredito`) VALUES
(1, 'cliente1@bd.com.br', 1000.00),
(2, 'cliente2@bd.com.br', 2000.00);

-- --------------------------------------------------------

--
-- Estrutura da tabela `compra`
--

CREATE TABLE `compra` (
  `idCompra` int NOT NULL,
  `numCompra` int NOT NULL,
  `numNota` varchar(44) NOT NULL,
  `dataCompra` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `valorCompra` double(10,2) NOT NULL,
  `idSupermercado` int NOT NULL,
  `idFornecedor` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `compra`
--

INSERT INTO `compra` (`idCompra`, `numCompra`, `numNota`, `dataCompra`, `valorCompra`, `idSupermercado`, `idFornecedor`) VALUES
(1, 1, '000002', '2021-03-16 19:49:42', 265.80, 1, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `compraItens`
--

CREATE TABLE `compraItens` (
  `idCompra` int NOT NULL,
  `idProduto` int NOT NULL,
  `precoComprado` double(10,2) NOT NULL,
  `qtdComprada` double(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `compraItens`
--

INSERT INTO `compraItens` (`idCompra`, `idProduto`, `precoComprado`, `qtdComprada`) VALUES
(1, 3, 1.12, 15.00),
(1, 5, 2.49, 100.00);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `dadosProdutoSupermercado`
-- (Veja abaixo para a view atual)
--
CREATE TABLE `dadosProdutoSupermercado` (
`codBarras` int
,`descricao` varchar(100)
,`idProduto` int
,`idSupermercado` int
,`ncm` varchar(8)
,`preco` double(10,2)
,`qtdItens` int
,`qtdProdutoEmbalagem` int
,`setor` varchar(50)
,`unidadeEmbalagem` varchar(20)
,`unidadeMedida` varchar(20)
);

-- --------------------------------------------------------

--
-- Estrutura da tabela `fornecedor`
--

CREATE TABLE `fornecedor` (
  `idFornecedor` int NOT NULL,
  `ramoAtividade` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `idPessoaJuridica` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `fornecedor`
--

INSERT INTO `fornecedor` (`idFornecedor`, `ramoAtividade`, `email`, `idPessoaJuridica`) VALUES
(1, 'Alimentício', 'fornecedor1@email.com.br', 2),
(2, 'Produtos Limpeza', 'fornecedor2@email.com.br', 4);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `fornecedorCompleto`
-- (Veja abaixo para a view atual)
--
CREATE TABLE `fornecedorCompleto` (
`bairro` varchar(45)
,`cep` varchar(8)
,`cidade` varchar(45)
,`cnpj` varchar(14)
,`complemento` varchar(45)
,`email` varchar(45)
,`estado` varchar(2)
,`fantasia` varchar(80)
,`idCliente` int
,`idFornecedor` int
,`idPessoaJuridica` int
,`logradouro` varchar(45)
,`numero` int
,`ramoAtividade` varchar(45)
,`razaoSocial` varchar(100)
,`telefones` text
);

-- --------------------------------------------------------

--
-- Estrutura da tabela `host_snmp_cache`
--

CREATE TABLE `host_snmp_cache` (
  `host_id` mediumint UNSIGNED NOT NULL DEFAULT '0',
  `snmp_query_id` mediumint UNSIGNED NOT NULL DEFAULT '0',
  `field_name` varchar(50) NOT NULL DEFAULT '',
  `field_value` varchar(512) DEFAULT NULL,
  `snmp_index` varchar(255) NOT NULL DEFAULT '',
  `oid` text NOT NULL,
  `present` tinyint NOT NULL DEFAULT '1',
  `last_updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Estrutura da tabela `pessoaFisica`
--

CREATE TABLE `pessoaFisica` (
  `idPessoaFisica` int NOT NULL,
  `cpf` varchar(11) NOT NULL,
  `nome` varchar(80) NOT NULL,
  `rg` varchar(9) NOT NULL,
  `cep` varchar(8) NOT NULL,
  `logradouro` varchar(45) NOT NULL,
  `numero` int NOT NULL,
  `complemento` varchar(45) DEFAULT NULL,
  `bairro` varchar(45) NOT NULL,
  `estado` varchar(2) NOT NULL,
  `cidade` varchar(45) NOT NULL,
  `idCliente` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `pessoaFisica`
--

INSERT INTO `pessoaFisica` (`idPessoaFisica`, `cpf`, `nome`, `rg`, `cep`, `logradouro`, `numero`, `complemento`, `bairro`, `estado`, `cidade`, `idCliente`) VALUES
(1, '44444444444', 'Cliente Dois', '14144444', '37200000', 'Rua Z', 4, NULL, 'Vila', 'MG', 'Lavras', 2);

-- --------------------------------------------------------

--
-- Estrutura da tabela `pessoaJuridica`
--

CREATE TABLE `pessoaJuridica` (
  `idPessoaJuridica` int NOT NULL,
  `cnpj` varchar(14) NOT NULL,
  `razaoSocial` varchar(100) NOT NULL,
  `fantasia` varchar(80) NOT NULL,
  `cep` varchar(8) NOT NULL,
  `logradouro` varchar(45) DEFAULT NULL,
  `numero` int NOT NULL,
  `complemento` varchar(45) DEFAULT NULL,
  `bairro` varchar(45) NOT NULL,
  `estado` varchar(2) NOT NULL,
  `cidade` varchar(45) NOT NULL,
  `idCliente` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `pessoaJuridica`
--

INSERT INTO `pessoaJuridica` (`idPessoaJuridica`, `cnpj`, `razaoSocial`, `fantasia`, `cep`, `logradouro`, `numero`, `complemento`, `bairro`, `estado`, `cidade`, `idCliente`) VALUES
(1, '11111111111111', 'Cliente 1 LTDA', 'Cliente 1', '37200000', 'Rua Número 1', 1, 'Apt 202', 'Centro', 'MG', 'Lavras', 1),
(2, '22222222222222', 'Fornecedor 1 ME', 'Fornecedor 1', '37200000', 'Rua A', 2, 'Casa B', 'Jardim', 'MG', 'Lavras', NULL),
(3, '33333333333333', 'Supermercado 1 ME - Teste', 'Supermercado 1', '37200000', 'Rua D', 3, '', 'Vila', 'MG', 'Lavras', NULL),
(4, '44444444444444', 'Fornecedor Dois LTDA', 'Fornecedor Dois', '37200000', 'Rua F', 3, NULL, 'Jardins', 'MG', 'Lavras', NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `produto`
--

CREATE TABLE `produto` (
  `idProduto` int NOT NULL,
  `codBarras` int NOT NULL,
  `setor` varchar(50) DEFAULT NULL,
  `descricao` varchar(100) NOT NULL,
  `ncm` varchar(8) NOT NULL,
  `qtdProdutoEmbalagem` int DEFAULT NULL,
  `unidadeEmbalagem` varchar(20) DEFAULT NULL,
  `unidadeMedida` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `produto`
--

INSERT INTO `produto` (`idProduto`, `codBarras`, `setor`, `descricao`, `ncm`, `qtdProdutoEmbalagem`, `unidadeEmbalagem`, `unidadeMedida`) VALUES
(1, 1, 'HORTIFRUTI', 'Maçã Argentina', '02345678', 1, 'KG', 'KG'),
(2, 1, 'Higiene', 'Xampu Seda Anti Caspa', '05478952', 12, 'CX', 'UN'),
(3, 1, 'Massas', 'Macarrão Parafuso Santa Amália', '45202369', 20, 'CX', 'UN'),
(4, 1, 'Massas', 'Molho de Tomate Heinz', '85214796', 24, 'CX', 'UN'),
(5, 1, 'Bebidas Alcoólicas', 'Cerveja Latão Skol', '05708525', 12, 'FD', 'UN'),
(6, 1, 'Higiene', 'Xampu Seda Anti Queda', '98652345', 12, 'CX', 'UN');

-- --------------------------------------------------------

--
-- Estrutura da tabela `produtoSupermercado`
--

CREATE TABLE `produtoSupermercado` (
  `idProduto` int NOT NULL,
  `idSupermercado` int NOT NULL,
  `qtdItens` int NOT NULL,
  `preco` double(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `produtoSupermercado`
--

INSERT INTO `produtoSupermercado` (`idProduto`, `idSupermercado`, `qtdItens`, `preco`) VALUES
(1, 1, 20, 5.99),
(2, 1, 35, 8.99),
(3, 1, 50, 2.78),
(4, 1, 38, 2.38),
(5, 1, 85, 3.89),
(6, 1, 88, 8.99);

-- --------------------------------------------------------

--
-- Estrutura da tabela `supermercado`
--

CREATE TABLE `supermercado` (
  `idSupermercado` int NOT NULL,
  `idPessoaJuridica` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `supermercado`
--

INSERT INTO `supermercado` (`idSupermercado`, `idPessoaJuridica`) VALUES
(1, 3);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `supermercadoCompleto`
-- (Veja abaixo para a view atual)
--
CREATE TABLE `supermercadoCompleto` (
`bairro` varchar(45)
,`cep` varchar(8)
,`cidade` varchar(45)
,`cnpj` varchar(14)
,`complemento` varchar(45)
,`email` varchar(80)
,`estado` varchar(2)
,`fantasia` varchar(80)
,`idCliente` int
,`idPessoaJuridica` int
,`limiteCredito` double(10,2)
,`logradouro` varchar(45)
,`numero` int
,`razaoSocial` varchar(100)
);

-- --------------------------------------------------------

--
-- Estrutura da tabela `telefonePesFisica`
--

CREATE TABLE `telefonePesFisica` (
  `idPessoaFisica` int NOT NULL,
  `telefone` varchar(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `telefonePesFisica`
--

INSERT INTO `telefonePesFisica` (`idPessoaFisica`, `telefone`) VALUES
(1, '999994444');

-- --------------------------------------------------------

--
-- Estrutura da tabela `telefonePesJuridica`
--

CREATE TABLE `telefonePesJuridica` (
  `idPessoaJuridica` int NOT NULL,
  `telefone` varchar(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `telefonePesJuridica`
--

INSERT INTO `telefonePesJuridica` (`idPessoaJuridica`, `telefone`) VALUES
(1, '999991111'),
(2, '33332222'),
(2, '999992222'),
(3, '31313131'),
(3, '999999999');

-- --------------------------------------------------------

--
-- Estrutura da tabela `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int NOT NULL,
  `nome` varchar(80) DEFAULT NULL,
  `email` varchar(80) DEFAULT NULL,
  `senha` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `usuarios`
--

INSERT INTO `usuarios` (`id`, `nome`, `email`, `senha`) VALUES
(1, 'João Vitor', 'joao@email.com', '123'),
(2, 'Mariana', 'mariana@email.com', '123');

-- --------------------------------------------------------

--
-- Estrutura da tabela `venda`
--

CREATE TABLE `venda` (
  `idVenda` int NOT NULL,
  `numVenda` int NOT NULL,
  `numNota` varchar(44) NOT NULL,
  `formaPagamento` varchar(1) NOT NULL,
  `dataVenda` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `valorVenda` double(10,2) NOT NULL,
  `idSupermercado` int NOT NULL,
  `idCliente` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `venda`
--

INSERT INTO `venda` (`idVenda`, `numVenda`, `numNota`, `formaPagamento`, `dataVenda`, `valorVenda`, `idSupermercado`, `idCliente`) VALUES
(1, 1, '000001', 'D', '2021-03-16 19:49:42', 13.99, 1, 2),
(2, 2, '000002', 'F', '2021-03-16 19:49:42', 97.00, 1, 2);

-- --------------------------------------------------------

--
-- Estrutura da tabela `vendaItens`
--

CREATE TABLE `vendaItens` (
  `idVenda` int NOT NULL,
  `idProduto` int NOT NULL,
  `precoVendido` double(10,2) NOT NULL,
  `qtdVendida` double(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `vendaItens`
--

INSERT INTO `vendaItens` (`idVenda`, `idProduto`, `precoVendido`, `qtdVendida`) VALUES
(1, 2, 8.99, 1.00),
(1, 4, 2.50, 2.00),
(2, 2, 10.00, 5.00),
(2, 4, 2.50, 2.00),
(2, 5, 3.50, 12.00);

--
-- Acionadores `vendaItens`
--
DELIMITER $$
CREATE TRIGGER `after_delete_venda_item` AFTER DELETE ON `vendaItens` FOR EACH ROW BEGIN   
   DECLARE idSup INT;
   DECLARE totalVenda REAL(10,2);
   SELECT idSupermercado INTO idSup FROM venda WHERE idVenda = old.idVenda;
   UPDATE produtoSupermercado SET qtdItens = qtdItens + old.qtdVendida WHERE produtoSupermercado.idProduto = old.idProduto AND produtoSupermercado.idSupermercado = idSup;
   
   CALL totalVenda(old.idVenda, totalVenda);
   
   UPDATE venda SET valorVenda = totalVenda WHERE idVenda = old.idVenda;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_update_venda_item` AFTER UPDATE ON `vendaItens` FOR EACH ROW BEGIN   
   DECLARE idSup INT;
   DECLARE totalVenda REAL(10,2);
   SELECT idSupermercado INTO idSup FROM venda WHERE idVenda = new.idVenda;
   UPDATE produtoSupermercado SET qtdItens = qtdItens + old.qtdVendida - new.qtdVendida WHERE produtoSupermercado.idProduto = new.idProduto AND produtoSupermercado.idSupermercado = idSup;
   
   CALL totalVenda(new.idVenda, totalVenda);
   
   UPDATE venda SET valorVenda = totalVenda WHERE idVenda = new.idVenda;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para vista `dadosProdutoSupermercado`
--
DROP TABLE IF EXISTS `dadosProdutoSupermercado`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `dadosProdutoSupermercado`  AS  select `produtoSupermercado`.`idProduto` AS `idProduto`,`produtoSupermercado`.`idSupermercado` AS `idSupermercado`,`produtoSupermercado`.`qtdItens` AS `qtdItens`,`produtoSupermercado`.`preco` AS `preco`,`produto`.`codBarras` AS `codBarras`,`produto`.`setor` AS `setor`,`produto`.`descricao` AS `descricao`,`produto`.`ncm` AS `ncm`,`produto`.`qtdProdutoEmbalagem` AS `qtdProdutoEmbalagem`,`produto`.`unidadeEmbalagem` AS `unidadeEmbalagem`,`produto`.`unidadeMedida` AS `unidadeMedida` from (`produtoSupermercado` join `produto` on((`produtoSupermercado`.`idProduto` = `produto`.`idProduto`))) ;

-- --------------------------------------------------------

--
-- Estrutura para vista `fornecedorCompleto`
--
DROP TABLE IF EXISTS `fornecedorCompleto`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `fornecedorCompleto`  AS  select `fornecedor`.`idFornecedor` AS `idFornecedor`,`fornecedor`.`email` AS `email`,`fornecedor`.`ramoAtividade` AS `ramoAtividade`,`pessoaJuridica`.`idPessoaJuridica` AS `idPessoaJuridica`,`pessoaJuridica`.`cnpj` AS `cnpj`,`pessoaJuridica`.`razaoSocial` AS `razaoSocial`,`pessoaJuridica`.`fantasia` AS `fantasia`,`pessoaJuridica`.`cep` AS `cep`,`pessoaJuridica`.`logradouro` AS `logradouro`,`pessoaJuridica`.`numero` AS `numero`,`pessoaJuridica`.`complemento` AS `complemento`,`pessoaJuridica`.`bairro` AS `bairro`,`pessoaJuridica`.`estado` AS `estado`,`pessoaJuridica`.`cidade` AS `cidade`,`pessoaJuridica`.`idCliente` AS `idCliente`,group_concat(`telefonePesJuridica`.`telefone` separator ',') AS `telefones` from ((`fornecedor` join `pessoaJuridica` on((`pessoaJuridica`.`idPessoaJuridica` = `fornecedor`.`idPessoaJuridica`))) left join `telefonePesJuridica` on((`telefonePesJuridica`.`idPessoaJuridica` = `fornecedor`.`idPessoaJuridica`))) group by `fornecedor`.`idFornecedor` ;

-- --------------------------------------------------------

--
-- Estrutura para vista `supermercadoCompleto`
--
DROP TABLE IF EXISTS `supermercadoCompleto`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `supermercadoCompleto`  AS  select `pessoaJuridica`.`idCliente` AS `idCliente`,`pessoaJuridica`.`idPessoaJuridica` AS `idPessoaJuridica`,`pessoaJuridica`.`cnpj` AS `cnpj`,`pessoaJuridica`.`razaoSocial` AS `razaoSocial`,`pessoaJuridica`.`fantasia` AS `fantasia`,`pessoaJuridica`.`cep` AS `cep`,`pessoaJuridica`.`logradouro` AS `logradouro`,`pessoaJuridica`.`numero` AS `numero`,`pessoaJuridica`.`complemento` AS `complemento`,`pessoaJuridica`.`bairro` AS `bairro`,`pessoaJuridica`.`estado` AS `estado`,`pessoaJuridica`.`cidade` AS `cidade`,`cliente`.`email` AS `email`,`cliente`.`limiteCredito` AS `limiteCredito` from (`pessoaJuridica` join `cliente` on((`pessoaJuridica`.`idCliente` = `cliente`.`idCliente`))) ;

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`idCliente`);

--
-- Índices para tabela `compra`
--
ALTER TABLE `compra`
  ADD PRIMARY KEY (`idCompra`),
  ADD UNIQUE KEY `uk_compra_supermercado` (`numCompra`,`idSupermercado`),
  ADD KEY `fk_compra_fornecedor` (`idFornecedor`),
  ADD KEY `fk_compra_supermercado1` (`idSupermercado`);

--
-- Índices para tabela `compraItens`
--
ALTER TABLE `compraItens`
  ADD PRIMARY KEY (`idCompra`,`idProduto`),
  ADD KEY `fk_compra_itens_produto` (`idProduto`);

--
-- Índices para tabela `fornecedor`
--
ALTER TABLE `fornecedor`
  ADD PRIMARY KEY (`idFornecedor`),
  ADD KEY `fk_fornecedor_pessoa_juridica` (`idPessoaJuridica`);

--
-- Índices para tabela `host_snmp_cache`
--
ALTER TABLE `host_snmp_cache`
  ADD PRIMARY KEY (`host_id`,`snmp_query_id`,`field_name`,`snmp_index`),
  ADD KEY `host_id` (`host_id`,`field_name`),
  ADD KEY `snmp_index` (`snmp_index`),
  ADD KEY `field_name` (`field_name`),
  ADD KEY `field_value` (`field_value`),
  ADD KEY `snmp_query_id` (`snmp_query_id`),
  ADD KEY `last_updated` (`last_updated`),
  ADD KEY `present` (`present`);

--
-- Índices para tabela `pessoaFisica`
--
ALTER TABLE `pessoaFisica`
  ADD PRIMARY KEY (`idPessoaFisica`),
  ADD UNIQUE KEY `uk_cpf` (`cpf`),
  ADD UNIQUE KEY `uk_rg` (`rg`),
  ADD KEY `fk_pes_fisica_cliente` (`idCliente`);

--
-- Índices para tabela `pessoaJuridica`
--
ALTER TABLE `pessoaJuridica`
  ADD PRIMARY KEY (`idPessoaJuridica`),
  ADD UNIQUE KEY `uk_cnpj` (`cnpj`),
  ADD KEY `fk_pes_juridica_cliente` (`idCliente`);

--
-- Índices para tabela `produto`
--
ALTER TABLE `produto`
  ADD PRIMARY KEY (`idProduto`);

--
-- Índices para tabela `produtoSupermercado`
--
ALTER TABLE `produtoSupermercado`
  ADD PRIMARY KEY (`idSupermercado`,`idProduto`),
  ADD KEY `fk_produto_supermercado_produto` (`idProduto`);

--
-- Índices para tabela `supermercado`
--
ALTER TABLE `supermercado`
  ADD PRIMARY KEY (`idSupermercado`),
  ADD KEY `fk_supermercado_pes_fisica` (`idPessoaJuridica`);

--
-- Índices para tabela `telefonePesFisica`
--
ALTER TABLE `telefonePesFisica`
  ADD PRIMARY KEY (`idPessoaFisica`,`telefone`),
  ADD UNIQUE KEY `uk_telefone_fisica` (`idPessoaFisica`,`telefone`);

--
-- Índices para tabela `telefonePesJuridica`
--
ALTER TABLE `telefonePesJuridica`
  ADD PRIMARY KEY (`idPessoaJuridica`,`telefone`),
  ADD UNIQUE KEY `uk_telefone_juridica` (`idPessoaJuridica`,`telefone`);

--
-- Índices para tabela `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `venda`
--
ALTER TABLE `venda`
  ADD PRIMARY KEY (`idVenda`),
  ADD UNIQUE KEY `uk_venda_supermercado` (`numVenda`,`idSupermercado`),
  ADD KEY `fk_venda_supermercado` (`idSupermercado`),
  ADD KEY `fk_venda_cliente` (`idCliente`);

--
-- Índices para tabela `vendaItens`
--
ALTER TABLE `vendaItens`
  ADD PRIMARY KEY (`idVenda`,`idProduto`),
  ADD KEY `fk_venda_itens_produto` (`idProduto`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `cliente`
--
ALTER TABLE `cliente`
  MODIFY `idCliente` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `compra`
--
ALTER TABLE `compra`
  MODIFY `idCompra` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `fornecedor`
--
ALTER TABLE `fornecedor`
  MODIFY `idFornecedor` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `pessoaFisica`
--
ALTER TABLE `pessoaFisica`
  MODIFY `idPessoaFisica` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `pessoaJuridica`
--
ALTER TABLE `pessoaJuridica`
  MODIFY `idPessoaJuridica` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `produto`
--
ALTER TABLE `produto`
  MODIFY `idProduto` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `supermercado`
--
ALTER TABLE `supermercado`
  MODIFY `idSupermercado` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `venda`
--
ALTER TABLE `venda`
  MODIFY `idVenda` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `compra`
--
ALTER TABLE `compra`
  ADD CONSTRAINT `fk_compra_fornecedor` FOREIGN KEY (`idFornecedor`) REFERENCES `fornecedor` (`idFornecedor`) ON DELETE RESTRICT,
  ADD CONSTRAINT `fk_compra_supermercado1` FOREIGN KEY (`idSupermercado`) REFERENCES `supermercado` (`idSupermercado`) ON DELETE RESTRICT;

--
-- Limitadores para a tabela `compraItens`
--
ALTER TABLE `compraItens`
  ADD CONSTRAINT `fk_compra_itens_compra` FOREIGN KEY (`idCompra`) REFERENCES `compra` (`idCompra`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_compra_itens_produto` FOREIGN KEY (`idProduto`) REFERENCES `produto` (`idProduto`) ON DELETE RESTRICT;

--
-- Limitadores para a tabela `fornecedor`
--
ALTER TABLE `fornecedor`
  ADD CONSTRAINT `fk_fornecedor_pessoa_juridica` FOREIGN KEY (`idPessoaJuridica`) REFERENCES `pessoaJuridica` (`idPessoaJuridica`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `pessoaFisica`
--
ALTER TABLE `pessoaFisica`
  ADD CONSTRAINT `fk_pes_fisica_cliente` FOREIGN KEY (`idCliente`) REFERENCES `cliente` (`idCliente`) ON DELETE SET NULL;

--
-- Limitadores para a tabela `pessoaJuridica`
--
ALTER TABLE `pessoaJuridica`
  ADD CONSTRAINT `fk_pes_juridica_cliente` FOREIGN KEY (`idCliente`) REFERENCES `cliente` (`idCliente`) ON DELETE SET NULL;

--
-- Limitadores para a tabela `produtoSupermercado`
--
ALTER TABLE `produtoSupermercado`
  ADD CONSTRAINT `fk_produto_supermercado_produto` FOREIGN KEY (`idProduto`) REFERENCES `produto` (`idProduto`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_produto_supermercado_supermercado` FOREIGN KEY (`idSupermercado`) REFERENCES `supermercado` (`idSupermercado`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `supermercado`
--
ALTER TABLE `supermercado`
  ADD CONSTRAINT `fk_supermercado_pes_fisica` FOREIGN KEY (`idPessoaJuridica`) REFERENCES `pessoaJuridica` (`idPessoaJuridica`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `telefonePesFisica`
--
ALTER TABLE `telefonePesFisica`
  ADD CONSTRAINT `fk_telefone_pes_fisica_pes_fisica` FOREIGN KEY (`idPessoaFisica`) REFERENCES `pessoaFisica` (`idPessoaFisica`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `telefonePesJuridica`
--
ALTER TABLE `telefonePesJuridica`
  ADD CONSTRAINT `fk_telefone_pes_juridica_pes_juridica` FOREIGN KEY (`idPessoaJuridica`) REFERENCES `pessoaJuridica` (`idPessoaJuridica`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `venda`
--
ALTER TABLE `venda`
  ADD CONSTRAINT `fk_venda_cliente` FOREIGN KEY (`idCliente`) REFERENCES `cliente` (`idCliente`) ON DELETE RESTRICT,
  ADD CONSTRAINT `fk_venda_supermercado` FOREIGN KEY (`idSupermercado`) REFERENCES `supermercado` (`idSupermercado`) ON DELETE RESTRICT;

--
-- Limitadores para a tabela `vendaItens`
--
ALTER TABLE `vendaItens`
  ADD CONSTRAINT `fk_venda_itens_produto` FOREIGN KEY (`idProduto`) REFERENCES `produto` (`idProduto`) ON DELETE RESTRICT,
  ADD CONSTRAINT `fk_venda_itens_venda` FOREIGN KEY (`idVenda`) REFERENCES `venda` (`idVenda`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
