-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 30-Abr-2019 às 19:13
-- Versão do servidor: 10.1.35-MariaDB
-- versão do PHP: 7.2.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `projetolocadora`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `aluguel`
--

CREATE TABLE `aluguel` (
  `Id_Aluguel` int(10) UNSIGNED NOT NULL,
  `DataAluguelInicio` datetime NOT NULL,
  `DataAluguelEntrega` datetime DEFAULT NULL,
  `Locadora_Id_Locadora` int(11) NOT NULL,
  `Filme_Id_Filme` int(10) UNSIGNED NOT NULL,
  `Usuario_Id_Usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `endereco`
--

CREATE TABLE `endereco` (
  `Id_Endereco` int(11) NOT NULL,
  `Estado` varchar(45) NOT NULL,
  `Bairro` varchar(45) NOT NULL,
  `Numero` varchar(45) NOT NULL,
  `Rua` varchar(45) NOT NULL,
  `CEP` varchar(45) NOT NULL,
  `Usuario_Id_Usuario` int(11) NOT NULL,
  `Locadora_Id_Locadora` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `filme`
--

CREATE TABLE `filme` (
  `Id_Filme` int(10) UNSIGNED NOT NULL,
  `Titulo` varchar(45) NOT NULL,
  `Produtora` varchar(45) DEFAULT NULL,
  `Descricao` varchar(45) DEFAULT NULL,
  `NotaFilme` float DEFAULT NULL,
  `DataLancamento` varchar(10) DEFAULT NULL,
  `Categoria` varchar(45) DEFAULT NULL,
  `ValorFilme` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `filme`
--

INSERT INTO `filme` (`Id_Filme`, `Titulo`, `Produtora`, `Descricao`, `NotaFilme`, `DataLancamento`, `Categoria`, `ValorFilme`) VALUES
(4, 'Teste 1', 'Testando 1', 'Filme teste 1', 8.5, '17/04/2019', 'Comédia', 5.5),
(5, 'Testando 2', 'TestProdu', 'Testando 6', 10, '27/04/2019', 'Comédia', 8),
(6, 'Teste 5', 'TestProd', 'Testando mais m', 5, '30/01/2015', 'Suspense', 5.5);

-- --------------------------------------------------------

--
-- Estrutura da tabela `locadora`
--

CREATE TABLE `locadora` (
  `Id_Locadora` int(11) NOT NULL,
  `Nome` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `locadorafilme`
--

CREATE TABLE `locadorafilme` (
  `Id_LocadoraFilme` int(11) NOT NULL,
  `Locadora_Id_Locadora` int(11) NOT NULL,
  `Filme_Id_Filme` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `usuario`
--

CREATE TABLE `usuario` (
  `Id_Usuario` int(11) NOT NULL,
  `Nome` varchar(45) NOT NULL,
  `Telefone` varchar(45) NOT NULL,
  `CPF` varchar(45) NOT NULL,
  `Email` varchar(45) DEFAULT NULL,
  `dataCadastro` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `usuario`
--

INSERT INTO `usuario` (`Id_Usuario`, `Nome`, `Telefone`, `CPF`, `Email`, `dataCadastro`) VALUES
(1, 'João Guerra', '(99)99999-9999', '000,000,000-00', 'joao@joao.com', '0000-00-00 00:00:00'),
(2, 'Lays Rocha', '(88)88888-8888', '111,111,111-11', 'lays@lays.com', '0000-00-00 00:00:00'),
(5, 'Lia Guerra', '(44)44444-4444', '000,000,000-00', 'lia@lia.com', '0000-00-00 00:00:00'),
(6, 'Lucas Guerra', '(99)99999-9999', '555,555,555-55', 'lucas@lucas.com', '0000-00-00 00:00:00'),
(7, 'Celia Machado', '(77)77777-7777', '222,222,222-22', 'celia@celia.com', '0000-00-00 00:00:00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `aluguel`
--
ALTER TABLE `aluguel`
  ADD PRIMARY KEY (`Id_Aluguel`,`Locadora_Id_Locadora`,`Filme_Id_Filme`,`Usuario_Id_Usuario`),
  ADD KEY `fk_Aluguel_Locadora1_idx` (`Locadora_Id_Locadora`),
  ADD KEY `fk_Aluguel_Filme1_idx` (`Filme_Id_Filme`),
  ADD KEY `fk_Aluguel_Usuario1_idx` (`Usuario_Id_Usuario`);

--
-- Indexes for table `endereco`
--
ALTER TABLE `endereco`
  ADD PRIMARY KEY (`Id_Endereco`,`Usuario_Id_Usuario`,`Locadora_Id_Locadora`),
  ADD UNIQUE KEY `Id_Endereco_UNIQUE` (`Id_Endereco`),
  ADD KEY `fk_Endereco_Usuario1_idx` (`Usuario_Id_Usuario`),
  ADD KEY `fk_Endereco_Locadora1_idx` (`Locadora_Id_Locadora`);

--
-- Indexes for table `filme`
--
ALTER TABLE `filme`
  ADD PRIMARY KEY (`Id_Filme`);

--
-- Indexes for table `locadora`
--
ALTER TABLE `locadora`
  ADD PRIMARY KEY (`Id_Locadora`),
  ADD UNIQUE KEY `Id_Locadora_UNIQUE` (`Id_Locadora`);

--
-- Indexes for table `locadorafilme`
--
ALTER TABLE `locadorafilme`
  ADD PRIMARY KEY (`Id_LocadoraFilme`,`Locadora_Id_Locadora`,`Filme_Id_Filme`),
  ADD UNIQUE KEY `Id_LocadoraFilme_UNIQUE` (`Id_LocadoraFilme`),
  ADD KEY `fk_LocadoraFilme_Locadora_idx` (`Locadora_Id_Locadora`),
  ADD KEY `fk_LocadoraFilme_Filme1_idx` (`Filme_Id_Filme`);

--
-- Indexes for table `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`Id_Usuario`),
  ADD UNIQUE KEY `Id_Usuario_UNIQUE` (`Id_Usuario`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `aluguel`
--
ALTER TABLE `aluguel`
  MODIFY `Id_Aluguel` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `endereco`
--
ALTER TABLE `endereco`
  MODIFY `Id_Endereco` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `filme`
--
ALTER TABLE `filme`
  MODIFY `Id_Filme` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `locadora`
--
ALTER TABLE `locadora`
  MODIFY `Id_Locadora` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `locadorafilme`
--
ALTER TABLE `locadorafilme`
  MODIFY `Id_LocadoraFilme` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `usuario`
--
ALTER TABLE `usuario`
  MODIFY `Id_Usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Limitadores para a tabela `aluguel`
--
ALTER TABLE `aluguel`
  ADD CONSTRAINT `fk_Aluguel_Filme1` FOREIGN KEY (`Filme_Id_Filme`) REFERENCES `filme` (`Id_Filme`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Aluguel_Locadora1` FOREIGN KEY (`Locadora_Id_Locadora`) REFERENCES `locadora` (`Id_Locadora`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Aluguel_Usuario1` FOREIGN KEY (`Usuario_Id_Usuario`) REFERENCES `usuario` (`Id_Usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `endereco`
--
ALTER TABLE `endereco`
  ADD CONSTRAINT `fk_Endereco_Locadora1` FOREIGN KEY (`Locadora_Id_Locadora`) REFERENCES `locadora` (`Id_Locadora`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Endereco_Usuario1` FOREIGN KEY (`Usuario_Id_Usuario`) REFERENCES `usuario` (`Id_Usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `locadorafilme`
--
ALTER TABLE `locadorafilme`
  ADD CONSTRAINT `fk_LocadoraFilme_Filme1` FOREIGN KEY (`Filme_Id_Filme`) REFERENCES `filme` (`Id_Filme`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_LocadoraFilme_Locadora` FOREIGN KEY (`Locadora_Id_Locadora`) REFERENCES `locadora` (`Id_Locadora`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
