-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 29-Mar-2019 às 10:33
-- Versão do servidor: 10.1.36-MariaDB
-- versão do PHP: 7.2.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gestaolocadora`
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
  `NotaFilme` int(11) DEFAULT NULL,
  `DataLançamento` datetime DEFAULT NULL,
  `Categoria` varchar(45) DEFAULT NULL
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
  `Email` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  MODIFY `Id_Filme` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `locadorafilme`
--
ALTER TABLE `locadorafilme`
  MODIFY `Id_LocadoraFilme` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `usuario`
--
ALTER TABLE `usuario`
  MODIFY `Id_Usuario` int(11) NOT NULL AUTO_INCREMENT;

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
  ADD CONSTRAINT `fk_Endereco_Locadora1` FOREIGN KEY (`Locadora_Id_Locadora`) REFERENCES `mydb`.`locadora` (`Id_Locadora`) ON DELETE NO ACTION ON UPDATE NO ACTION,
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
