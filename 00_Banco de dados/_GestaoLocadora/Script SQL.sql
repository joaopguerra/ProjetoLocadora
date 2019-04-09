-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Locadora`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Locadora` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Locadora` (
  `Id_Locadora` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Id_Locadora`),
  UNIQUE INDEX `Id_Locadora_UNIQUE` (`Id_Locadora` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Usuario` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Usuario` (
  `Id_Usuario` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Telefone` VARCHAR(45) NOT NULL,
  `CPF` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NULL,
  PRIMARY KEY (`Id_Usuario`),
  UNIQUE INDEX `Id_Usuario_UNIQUE` (`Id_Usuario` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Endereco`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Endereco` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Endereco` (
  `Id_Endereco` INT NOT NULL AUTO_INCREMENT,
  `Estado` VARCHAR(45) NOT NULL,
  `Bairro` VARCHAR(45) NOT NULL,
  `Numero` VARCHAR(45) NOT NULL,
  `Rua` VARCHAR(45) NOT NULL,
  `CEP` VARCHAR(45) NOT NULL,
  `Usuario_Id_Usuario` INT NOT NULL,
  `Locadora_Id_Locadora` INT NOT NULL,
  PRIMARY KEY (`Id_Endereco`, `Usuario_Id_Usuario`, `Locadora_Id_Locadora`),
  UNIQUE INDEX `Id_Endereco_UNIQUE` (`Id_Endereco` ASC),
  INDEX `fk_Endereco_Usuario1_idx` (`Usuario_Id_Usuario` ASC),
  INDEX `fk_Endereco_Locadora1_idx` (`Locadora_Id_Locadora` ASC),
  CONSTRAINT `fk_Endereco_Usuario1`
    FOREIGN KEY (`Usuario_Id_Usuario`)
    REFERENCES `mydb`.`Usuario` (`Id_Usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Endereco_Locadora1`
    FOREIGN KEY (`Locadora_Id_Locadora`)
    REFERENCES `mydb`.`Locadora` (`Id_Locadora`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Filme`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Filme` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Filme` (
  `Id_Filme` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Titulo` VARCHAR(45) NOT NULL,
  `Produtora` VARCHAR(45) NULL,
  `Descricao` VARCHAR(45) NULL,
  `NotaFilme` INT NULL,
  `DataLançamento` DATETIME NULL,
  `Categoria` VARCHAR(45) NULL,
  PRIMARY KEY (`Id_Filme`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`LocadoraFilme`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`LocadoraFilme` ;

CREATE TABLE IF NOT EXISTS `mydb`.`LocadoraFilme` (
  `Id_LocadoraFilme` INT NOT NULL AUTO_INCREMENT,
  `Locadora_Id_Locadora` INT NOT NULL,
  `Filme_Id_Filme` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Id_LocadoraFilme`, `Locadora_Id_Locadora`, `Filme_Id_Filme`),
  UNIQUE INDEX `Id_LocadoraFilme_UNIQUE` (`Id_LocadoraFilme` ASC),
  INDEX `fk_LocadoraFilme_Locadora_idx` (`Locadora_Id_Locadora` ASC),
  INDEX `fk_LocadoraFilme_Filme1_idx` (`Filme_Id_Filme` ASC),
  CONSTRAINT `fk_LocadoraFilme_Locadora`
    FOREIGN KEY (`Locadora_Id_Locadora`)
    REFERENCES `mydb`.`Locadora` (`Id_Locadora`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_LocadoraFilme_Filme1`
    FOREIGN KEY (`Filme_Id_Filme`)
    REFERENCES `mydb`.`Filme` (`Id_Filme`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Aluguel`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Aluguel` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Aluguel` (
  `Id_Aluguel` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `DataAluguelInicio` DATETIME NOT NULL,
  `DataAluguelEntrega` DATETIME NULL,
  `Locadora_Id_Locadora` INT NOT NULL,
  `Filme_Id_Filme` INT UNSIGNED NOT NULL,
  `Usuario_Id_Usuario` INT NOT NULL,
  PRIMARY KEY (`Id_Aluguel`, `Locadora_Id_Locadora`, `Filme_Id_Filme`, `Usuario_Id_Usuario`),
  INDEX `fk_Aluguel_Locadora1_idx` (`Locadora_Id_Locadora` ASC),
  INDEX `fk_Aluguel_Filme1_idx` (`Filme_Id_Filme` ASC),
  INDEX `fk_Aluguel_Usuario1_idx` (`Usuario_Id_Usuario` ASC),
  CONSTRAINT `fk_Aluguel_Locadora1`
    FOREIGN KEY (`Locadora_Id_Locadora`)
    REFERENCES `mydb`.`Locadora` (`Id_Locadora`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Aluguel_Filme1`
    FOREIGN KEY (`Filme_Id_Filme`)
    REFERENCES `mydb`.`Filme` (`Id_Filme`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Aluguel_Usuario1`
    FOREIGN KEY (`Usuario_Id_Usuario`)
    REFERENCES `mydb`.`Usuario` (`Id_Usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
