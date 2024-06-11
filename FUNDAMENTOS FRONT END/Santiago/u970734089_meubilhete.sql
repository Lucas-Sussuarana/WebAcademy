-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Tempo de geração: 16-Maio-2024 às 21:28
-- Versão do servidor: 10.11.7-MariaDB-cll-lve
-- versão do PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `u970734089_meubilhete`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `cartao`
--

CREATE TABLE `cartao` (
  `cartao_id` int(11) NOT NULL,
  `cartao_codcartão` varchar(255) NOT NULL,
  `cartao_unidades` int(11) NOT NULL,
  `cartao_saldo` float NOT NULL,
  `cartao_datavalidade` date NOT NULL,
  `cartao_datarecarga` date NOT NULL,
  `cartao_maxunidades` int(11) NOT NULL,
  `cartao_idusuario_fk` int(11) NOT NULL,
  `cartao_categoria_fk` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `cartao`
--

INSERT INTO `cartao` (`cartao_id`, `cartao_codcartão`, `cartao_unidades`, `cartao_saldo`, `cartao_datavalidade`, `cartao_datarecarga`, `cartao_maxunidades`, `cartao_idusuario_fk`, `cartao_categoria_fk`) VALUES
(1, '8529633347', 58, 55.5, '2033-05-12', '2024-05-16', 2, 2, 2),
(2, '74108529633', 10, 10, '2033-05-05', '2024-05-16', 4, 3, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `categoria`
--

CREATE TABLE `categoria` (
  `categoria_idcategoria` int(11) NOT NULL,
  `categoria_nomecategoria` varchar(255) NOT NULL,
  `categoria_valorpassagem` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `categoria`
--

INSERT INTO `categoria` (`categoria_idcategoria`, `categoria_nomecategoria`, `categoria_valorpassagem`) VALUES
(1, 'ESTUDANTE', 1),
(2, 'PADRÃO', 3.5);

-- --------------------------------------------------------

--
-- Estrutura da tabela `logcartao`
--

CREATE TABLE `logcartao` (
  `logcartao_idlog` int(11) NOT NULL,
  `logcartao_datautilizacao` datetime NOT NULL,
  `logcartao_idonibus_fk` int(11) NOT NULL,
  `logcartao_idcartao_fk` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `logcartao`
--

INSERT INTO `logcartao` (`logcartao_idlog`, `logcartao_datautilizacao`, `logcartao_idonibus_fk`, `logcartao_idcartao_fk`) VALUES
(1, '2024-05-16 15:00:58', 1, 2),
(3, '2024-05-16 20:25:44', 1, 1),
(4, '2024-05-16 20:26:27', 1, 1),
(5, '2024-05-16 20:28:12', 1, 1),
(6, '2024-05-16 20:31:30', 1, 1),
(7, '2024-05-16 20:32:13', 1, 2),
(8, '2024-05-16 20:32:36', 1, 2),
(9, '2024-05-16 20:32:56', 1, 1),
(13, '2024-05-16 20:35:53', 1, 1),
(14, '2024-05-16 20:36:11', 1, 2),
(15, '2024-05-16 20:36:31', 1, 2),
(16, '2024-05-16 20:37:29', 1, 1),
(17, '2024-05-16 20:45:34', 1, 1),
(22, '2024-05-16 21:17:03', 1, 1),
(23, '2024-05-16 21:17:48', 1, 1);

--
-- Acionadores `logcartao`
--
DELIMITER $$
CREATE TRIGGER `DEBITO_CARTAO` AFTER INSERT ON `logcartao` FOR EACH ROW BEGIN
    DECLARE novoLimiteUso INT;
    DECLARE novoSaldo FLOAT;
    DECLARE novaUnidade INT;
    DECLARE valorPassagem FLOAT;
    DECLARE categoriaCartao INT;
    DECLARE cartaoID INT;

    -- Obter o ID do cartão
    SELECT cartao.cartao_id
    INTO cartaoID
    FROM cartao
    WHERE cartao.cartao_id = NEW.logcartao_idcartao_fk
    LIMIT 1;

    -- Obter a categoria do cartão
    SELECT cartao.cartao_categoria_fk
    INTO categoriaCartao
    FROM cartao
    WHERE cartao.cartao_id = cartaoID
    LIMIT 1;

    -- Obter o valor da passagem da categoria
    SELECT categoria.categoria_valorpassagem
    INTO valorPassagem
    FROM categoria
    WHERE categoria.categoria_idcategoria = categoriaCartao
    LIMIT 1;

    -- Obter os limites e saldo atuais do cartão
    SELECT cartao_maxunidades, cartao_unidades, cartao_saldo
    INTO novoLimiteUso, novaUnidade, novoSaldo
    FROM cartao
    WHERE cartao.cartao_id = NEW.logcartao_idcartao_fk
    LIMIT 1;

    -- Atualizar o limite de uso, unidades e saldo do cartão
    UPDATE cartao
    SET 
        cartao_maxunidades = novoLimiteUso - 1,
        cartao_unidades = novaUnidade - 1,
        cartao_saldo = novoSaldo - valorPassagem
    WHERE cartao.cartao_id = NEW.logcartao_idcartao_fk;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `onibus`
--

CREATE TABLE `onibus` (
  `onibus_idonibus` int(11) NOT NULL,
  `onibus_codlinha` varchar(255) NOT NULL,
  `onibus_nomelinha` varchar(255) NOT NULL,
  `onibus_horario1` time NOT NULL,
  `onibus_paradas` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `onibus`
--

INSERT INTO `onibus` (`onibus_idonibus`, `onibus_codlinha`, `onibus_nomelinha`, `onibus_horario1`, `onibus_paradas`) VALUES
(1, '303', 'UNIVERSITARIO', '15:00:00', '0');

-- --------------------------------------------------------

--
-- Estrutura da tabela `pagamento`
--

CREATE TABLE `pagamento` (
  `pagamento_idpagamento` int(11) NOT NULL,
  `pagamento_cartaocc` varchar(255) NOT NULL,
  `pagamento_datavalidade` date NOT NULL,
  `pagamento_cvc` varchar(3) NOT NULL,
  `pagamento_bandeira` varchar(255) NOT NULL,
  `pagamento_holder` varchar(255) NOT NULL,
  `pagamento_modo` varchar(255) NOT NULL,
  `pagamento_idusuario_fk` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `pagamento`
--

INSERT INTO `pagamento` (`pagamento_idpagamento`, `pagamento_cartaocc`, `pagamento_datavalidade`, `pagamento_cvc`, `pagamento_bandeira`, `pagamento_holder`, `pagamento_modo`, `pagamento_idusuario_fk`) VALUES
(1, '4095 9603 8502 7445', '2024-05-16', '343', 'VISA', 'PAULO S LIMA', 'CREDITO', 2);

-- --------------------------------------------------------

--
-- Estrutura da tabela `usuario`
--

CREATE TABLE `usuario` (
  `usuario_idusuario` int(11) NOT NULL,
  `usuario_nomecompleto` varchar(255) NOT NULL,
  `usuario_cpf` varchar(255) NOT NULL,
  `usuario_datanascimento` date NOT NULL,
  `usuario_email` varchar(255) NOT NULL,
  `usuario_password` varchar(255) NOT NULL,
  `usuario_logadouro` varchar(255) NOT NULL,
  `usuario_numero` varchar(255) NOT NULL,
  `usuario_bairro` varchar(255) NOT NULL,
  `usuario_cep` varchar(255) NOT NULL,
  `usuario_codcartao` varchar(255) NOT NULL,
  `usuario_tipocartao_fk` int(11) NOT NULL,
  `usuario_fotouser` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `usuario`
--

INSERT INTO `usuario` (`usuario_idusuario`, `usuario_nomecompleto`, `usuario_cpf`, `usuario_datanascimento`, `usuario_email`, `usuario_password`, `usuario_logadouro`, `usuario_numero`, `usuario_bairro`, `usuario_cep`, `usuario_codcartao`, `usuario_tipocartao_fk`, `usuario_fotouser`) VALUES
(2, 'JOAO ', '74185296332', '2003-08-21', 'PACIFICUZINHO@HOTMAIL.COM', 'A6SSA54D55S\r\nW', 'AS', 'A', 'A', 'A', '741852963', 1, ''),
(3, 'PEDRO', 'A', '2024-05-08', 'A', 'A', 'A', 'A', 'A', 'A', '7418529987', 1, 'A');

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `cartao`
--
ALTER TABLE `cartao`
  ADD PRIMARY KEY (`cartao_id`),
  ADD KEY `cartao_idusuario_fk` (`cartao_idusuario_fk`),
  ADD KEY `cartao_categoria_fk` (`cartao_categoria_fk`);

--
-- Índices para tabela `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`categoria_idcategoria`);

--
-- Índices para tabela `logcartao`
--
ALTER TABLE `logcartao`
  ADD PRIMARY KEY (`logcartao_idlog`),
  ADD KEY `logcartao_idonibus_fk` (`logcartao_idonibus_fk`),
  ADD KEY `logcartao_idusuario_fk` (`logcartao_idcartao_fk`);

--
-- Índices para tabela `onibus`
--
ALTER TABLE `onibus`
  ADD PRIMARY KEY (`onibus_idonibus`);

--
-- Índices para tabela `pagamento`
--
ALTER TABLE `pagamento`
  ADD PRIMARY KEY (`pagamento_idpagamento`),
  ADD KEY `pagamento_idusuario_fk` (`pagamento_idusuario_fk`);

--
-- Índices para tabela `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`usuario_idusuario`),
  ADD KEY `usuario_tipocartao_fk` (`usuario_tipocartao_fk`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `cartao`
--
ALTER TABLE `cartao`
  MODIFY `cartao_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `categoria`
--
ALTER TABLE `categoria`
  MODIFY `categoria_idcategoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `logcartao`
--
ALTER TABLE `logcartao`
  MODIFY `logcartao_idlog` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de tabela `onibus`
--
ALTER TABLE `onibus`
  MODIFY `onibus_idonibus` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `pagamento`
--
ALTER TABLE `pagamento`
  MODIFY `pagamento_idpagamento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `usuario`
--
ALTER TABLE `usuario`
  MODIFY `usuario_idusuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `cartao`
--
ALTER TABLE `cartao`
  ADD CONSTRAINT `cartao_ibfk_1` FOREIGN KEY (`cartao_idusuario_fk`) REFERENCES `usuario` (`usuario_idusuario`),
  ADD CONSTRAINT `cartao_ibfk_2` FOREIGN KEY (`cartao_categoria_fk`) REFERENCES `categoria` (`categoria_idcategoria`);

--
-- Limitadores para a tabela `logcartao`
--
ALTER TABLE `logcartao`
  ADD CONSTRAINT `logcartao_ibfk_1` FOREIGN KEY (`logcartao_idonibus_fk`) REFERENCES `onibus` (`onibus_idonibus`),
  ADD CONSTRAINT `logcartao_ibfk_2` FOREIGN KEY (`logcartao_idcartao_fk`) REFERENCES `cartao` (`cartao_id`);

--
-- Limitadores para a tabela `pagamento`
--
ALTER TABLE `pagamento`
  ADD CONSTRAINT `pagamento_ibfk_1` FOREIGN KEY (`pagamento_idusuario_fk`) REFERENCES `usuario` (`usuario_idusuario`);

--
-- Limitadores para a tabela `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`usuario_tipocartao_fk`) REFERENCES `categoria` (`categoria_idcategoria`);

DELIMITER $$
--
-- Eventos
--
CREATE DEFINER=`u970734089_meubilhete`@`127.0.0.1` EVENT `RESETA_UNI` ON SCHEDULE EVERY 24 HOUR STARTS '2024-05-16 16:28:24' ENDS '2024-05-17 16:30:24' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cartao SET cartao.cartao_maxunidades=6 WHERE cartao.cartao_categoria_fk = 1$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
