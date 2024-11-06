# tifosi

Dans ce repository se trouve mon projet de création de base de données pour le restaurant Tifosi.
Il se compose : de différents scripts SQL pour l'importation de la base, son peuplement ainsi que pour effectuer un backup de celle-ci.
Enfin, un utilisateur spécifique avec des droits d'administration a été créé pour cette base : 
- nom : tifosi
- mot de passe : tifosi

## script SQL permettant l'import de la base de données

CREATE SCHEMA IF NOT EXISTS `tifosi` DEFAULT CHARACTER SET utf8mb3 ;
USE `tifosi` ;

-- -----------------------------------------------------
-- Table `tifosi`.`marque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tifosi`.`marque` (
  `id_marque` INT NOT NULL AUTO_INCREMENT,
  `nom_marque` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_marque`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `tifosi`.`boisson`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tifosi`.`boisson` (
  `id_boisson` INT NOT NULL AUTO_INCREMENT,
  `nom_boisson` VARCHAR(45) NOT NULL,
  `marque_id_marque` INT NOT NULL,
  PRIMARY KEY (`id_boisson`, `marque_id_marque`),
  CONSTRAINT `fk_boisson_marque1`
    FOREIGN KEY (`marque_id_marque`)
    REFERENCES `tifosi`.`marque` (`id_marque`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `tifosi`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tifosi`.`client` (
  `id_client` INT NOT NULL AUTO_INCREMENT,
  `nom_client` VARCHAR(45) NOT NULL,
  `age` INT NOT NULL,
  `cp_client` INT NOT NULL,
  PRIMARY KEY (`id_client`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

-- -----------------------------------------------------
-- Table `tifosi`.`focaccia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tifosi`.`focaccia` (
  `id_focaccia` INT NOT NULL AUTO_INCREMENT,
  `nom_focaccia` VARCHAR(45) NOT NULL,
  `prix_focaccia` FLOAT NOT NULL,
  PRIMARY KEY (`id_focaccia`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;



-- -----------------------------------------------------
-- Table `tifosi`.`menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tifosi`.`menu` (
  `id_menu` INT NOT NULL AUTO_INCREMENT,
  `nom_menu` VARCHAR(45) NOT NULL,
  `prix_menu` FLOAT NOT NULL,
  `focaccia_id_focaccia` INT NOT NULL,
  PRIMARY KEY (`id_menu`, `focaccia_id_focaccia`),
  CONSTRAINT `fk_menu_focaccia`
    FOREIGN KEY (`focaccia_id_focaccia`)
    REFERENCES `tifosi`.`focaccia` (`id_focaccia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION) 
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;



-- -----------------------------------------------------
-- Table `tifosi`.`ingredient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tifosi`.`ingredient` (
  `id_ingredient` INT NOT NULL AUTO_INCREMENT,
  `nom_ingredient` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_ingredient`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `tifosi`.`achete`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tifosi`.`achete` (
  `client_id_client` INT NULL,
  `focaccia_id_focaccia` INT NULL,
  `jour` DATE NOT NULL,
  PRIMARY KEY (`client_id_client`, `focaccia_id_focaccia`),
  CONSTRAINT `fk_client_has_focaccia_client1`
    FOREIGN KEY (`client_id_client`)
    REFERENCES `tifosi`.`client` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_client_has_focaccia_focaccia1`
    FOREIGN KEY (`focaccia_id_focaccia`)
    REFERENCES `tifosi`.`focaccia` (`id_focaccia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `tifosi`.`paye`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tifosi`.`paye` (
  `client_id_client` INT NULL,
  `menu_id_menu` INT NULL,
  `jour` DATE NOT NULL,
  PRIMARY KEY (`client_id_client`, `menu_id_menu`),
  CONSTRAINT `fk_client_has_menu_client1`
    FOREIGN KEY (`client_id_client`)
    REFERENCES `tifosi`.`client` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_client_has_menu_menu1`
    FOREIGN KEY (`menu_id_menu`)
    REFERENCES `tifosi`.`menu` (`id_menu`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `tifosi`.`comprend`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tifosi`.`comprend` (
  `focaccia_id_focaccia` INT NOT NULL,
  `ingredient_id_ingredient` INT NULL,
  PRIMARY KEY (`focaccia_id_focaccia`, `ingredient_id_ingredient`),
  CONSTRAINT `fk_focaccia_has_ingredient_focaccia1`
    FOREIGN KEY (`focaccia_id_focaccia`)
    REFERENCES `tifosi`.`focaccia` (`id_focaccia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_focaccia_has_ingredient_ingredient1`
    FOREIGN KEY (`ingredient_id_ingredient`)
    REFERENCES `tifosi`.`ingredient` (`id_ingredient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `tifosi`.`contient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tifosi`.`contient` (
  `menu_id_menu` INT NOT NULL,
  `boisson_id_boisson` INT NULL,
  PRIMARY KEY (`menu_id_menu`, `boisson_id_boisson`),
  CONSTRAINT `fk_menu_has_boisson_menu1`
    FOREIGN KEY (`menu_id_menu`)
    REFERENCES `tifosi`.`menu` (`id_menu`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_menu_has_boisson_boisson1`
    FOREIGN KEY (`boisson_id_boisson`)
    REFERENCES `tifosi`.`boisson` (`id_boisson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE USER 'tifosi'@'localhost' IDENTIFIED BY 'tifosi';
GRANT ALL PRIVILEGES ON * . * TO 'tifosi'@'localhost';

## script SQL permettant l'insertion de la donnée test

INSERT INTO `ingredient` (`nom_ingredient`) VALUES ('Ail'), ('Ananas'), ('Artichaut'), ('bacon'), ('Base Tomate'), ('Base crème'), ('Champignon'), ('Chèvre'), ('Cresson'), ('Emmental'), ('Gorgonzola'), ('Jambon cuit'), ('Jambon fumé'), ('Oeuf'), ('Oignon'), ('Olive noire'), ('Olive verte'), ('Parmesan'), ('Piment'), ('Poivre'), ('Pomme de terre'), ('Raclette'), ('Salami'), ('Tomate cerise');
INSERT INTO `marque` (`nom_marque`) VALUES ('Coca-cola'), ('Cristalline'), ('Monster'), ('Pepsico');
INSERT INTO `boisson` (`nom_boisson`, `marque_id_marque`) VALUES ('Coca-cola zéro', 1), ('Coca-cola original', 1), ('Fanta citron', 1), ('Fanta orange', 1), ('Capri-sun', 1), ('Pepsi', 4), ('Pepsi Max Zéro', 4), ('Lipton zéro citron', 4), ('Lipton Peach', 4), ('Monster energy ultra gold', 3), ('Monster energy ultra blue', 3), ('Eau de source', 2);
INSERT INTO `focaccia` (`nom_focaccia`, `prix_focaccia`) VALUES ('Mozaccia', '9.80'), ('Gorgonzollaccia', '10.80'), ('Raclaccia', '8.90'), ('Emmentalaccia', '9.80'), ('Tradizione', '8.90'), ('Hawaienne', '11.20'), ('Américaine', '10.80'), ('Paysanne', '12.80'); 

## script SQL permettant le backup de la base de données

-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mer. 06 nov. 2024 à 10:16
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `tifosi`
--
CREATE DATABASE IF NOT EXISTS `tifosi` DEFAULT CHARACTER SET utf8mb3;
USE `tifosi`;
-- --------------------------------------------------------

--
-- Structure de la table `achete`
--
DROP TABLE IF EXISTS `achete`;
CREATE TABLE IF NOT EXISTS `achete` (
  `client_id_client` int(11) NOT NULL,
  `focaccia_id_focaccia` int(11) NOT NULL,
  `jour` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- --------------------------------------------------------


--
-- Structure de la table `boisson`
--
DROP TABLE IF EXISTS `boisson`;
CREATE TABLE IF NOT EXISTS `boisson` (
  `id_boisson` int(11) NOT NULL,
  `nom_boisson` varchar(45) NOT NULL,
  `marque_id_marque` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Déchargement des données de la table `boisson`
--

INSERT INTO `boisson` (`id_boisson`, `nom_boisson`, `marque_id_marque`) VALUES
(1, 'Coca-cola zéro', 1),
(2, 'Coca-cola original', 1),
(3, 'Fanta citron', 1),
(4, 'Fanta orange', 1),
(5, 'Capri-sun', 1),
(6, 'Pepsi', 4),
(7, 'Pepsi Max Zéro', 4),
(8, 'Lipton zéro citron', 4),
(9, 'Lipton Peach', 4),
(10, 'Monster energy ultra gold', 3),
(11, 'Monster energy ultra blue', 3),
(12, 'Eau de source', 2);

-- --------------------------------------------------------

--
-- Structure de la table `client`
--
DROP TABLE IF EXISTS `client`;
CREATE TABLE IF NOT EXISTS `client` (
  `id_client` int(11) NOT NULL,
  `nom_client` varchar(45) NOT NULL,
  `age` int(11) NOT NULL,
  `cp_client` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `comprend`
--
DROP TABLE IF EXISTS `comprend`;
CREATE TABLE IF NOT EXISTS `comprend` (
  `focaccia_id_focaccia` int(11) NOT NULL,
  `ingredient_id_ingredient` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `contient`
--
DROP TABLE IF EXISTS `contient`;
CREATE TABLE IF NOT EXISTS `contient` (
  `menu_id_menu` int(11) NOT NULL,
  `boisson_id_boisson` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `focaccia`
--
DROP TABLE IF EXISTS `focaccia`;
CREATE TABLE IF NOT EXISTS `focaccia` (
  `id_focaccia` int(11) NOT NULL,
  `nom_focaccia` varchar(45) NOT NULL,
  `prix_focaccia` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Déchargement des données de la table `focaccia`
--

INSERT INTO `focaccia` (`id_focaccia`, `nom_focaccia`, `prix_focaccia`) VALUES
(1, 'Mozaccia', 9.8),
(2, 'Gorgonzollaccia', 10.8),
(3, 'Raclaccia', 8.9),
(4, 'Emmentalaccia', 9.8),
(5, 'Tradizione', 8.9),
(6, 'Hawaienne', 11.2),
(7, 'Américaine', 10.8),
(8, 'Paysanne', 12.8);

-- --------------------------------------------------------

--
-- Structure de la table `ingredient`
--
DROP TABLE IF EXISTS `ingredient`;
CREATE TABLE IF NOT EXISTS `ingredient` (
  `id_ingredient` int(11) NOT NULL,
  `nom_ingredient` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Déchargement des données de la table `ingredient`
--

INSERT INTO `ingredient` (`id_ingredient`, `nom_ingredient`) VALUES
(1, 'Ail'),
(2, 'Ananas'),
(3, 'Artichaut'),
(4, 'bacon'),
(5, 'Base Tomate'),
(6, 'Base crème'),
(7, 'Champignon'),
(8, 'Chèvre'),
(9, 'Cresson'),
(10, 'Emmental'),
(11, 'Gorgonzola'),
(12, 'Jambon cuit'),
(13, 'Jambon fumé'),
(14, 'Oeuf'),
(15, 'Oignon'),
(16, 'Olive noire'),
(17, 'Olive verte'),
(18, 'Parmesan'),
(19, 'Piment'),
(20, 'Poivre'),
(21, 'Pomme de terre'),
(22, 'Raclette'),
(23, 'Salami'),
(24, 'Tomate cerise');

-- --------------------------------------------------------

--
-- Structure de la table `marque`
--
DROP TABLE IF EXISTS `marque`;
CREATE TABLE IF NOT EXISTS `marque` (
  `id_marque` int(11) NOT NULL,
  `nom_marque` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Déchargement des données de la table `marque`
--

INSERT INTO `marque` (`id_marque`, `nom_marque`) VALUES
(1, 'Coca-cola'),
(2, 'Cristalline'),
(3, 'Monster'),
(4, 'Pepsico');

-- --------------------------------------------------------

--
-- Structure de la table `menu`
--
DROP TABLE IF EXISTS `menu`;
CREATE TABLE IF NOT EXISTS `menu` (
  `id_menu` int(11) NOT NULL,
  `nom_menu` varchar(45) NOT NULL,
  `prix_menu` float NOT NULL,
  `focaccia_id_focaccia` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `paye`
--
DROP TABLE IF EXISTS `paye`;
CREATE TABLE IF NOT EXISTS `paye` (
  `client_id_client` int(11) NOT NULL,
  `menu_id_menu` int(11) NOT NULL,
  `jour` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `achete`
--
ALTER TABLE `achete`
  ADD PRIMARY KEY (`client_id_client`,`focaccia_id_focaccia`),
  ADD KEY `fk_client_has_focaccia_focaccia1` (`focaccia_id_focaccia`);

--
-- Index pour la table `boisson`
--
ALTER TABLE `boisson`
  ADD PRIMARY KEY (`id_boisson`,`marque_id_marque`),
  ADD KEY `fk_boisson_marque1` (`marque_id_marque`);

--
-- Index pour la table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`id_client`);

--
-- Index pour la table `comprend`
--
ALTER TABLE `comprend`
  ADD PRIMARY KEY (`focaccia_id_focaccia`,`ingredient_id_ingredient`),
  ADD KEY `fk_focaccia_has_ingredient_ingredient1` (`ingredient_id_ingredient`);

--
-- Index pour la table `contient`
--
ALTER TABLE `contient`
  ADD PRIMARY KEY (`menu_id_menu`,`boisson_id_boisson`),
  ADD KEY `fk_menu_has_boisson_boisson1` (`boisson_id_boisson`);

--
-- Index pour la table `focaccia`
--
ALTER TABLE `focaccia`
  ADD PRIMARY KEY (`id_focaccia`);

--
-- Index pour la table `ingredient`
--
ALTER TABLE `ingredient`
  ADD PRIMARY KEY (`id_ingredient`);

--
-- Index pour la table `marque`
--
ALTER TABLE `marque`
  ADD PRIMARY KEY (`id_marque`);

--
-- Index pour la table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`id_menu`,`focaccia_id_focaccia`),
  ADD KEY `fk_menu_focaccia` (`focaccia_id_focaccia`);

--
-- Index pour la table `paye`
--
ALTER TABLE `paye`
  ADD PRIMARY KEY (`client_id_client`,`menu_id_menu`),
  ADD KEY `fk_client_has_menu_menu1` (`menu_id_menu`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `boisson`
--
ALTER TABLE `boisson`
  MODIFY `id_boisson` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT pour la table `client`
--
ALTER TABLE `client`
  MODIFY `id_client` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `focaccia`
--
ALTER TABLE `focaccia`
  MODIFY `id_focaccia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `ingredient`
--
ALTER TABLE `ingredient`
  MODIFY `id_ingredient` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT pour la table `marque`
--
ALTER TABLE `marque`
  MODIFY `id_marque` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `menu`
--
ALTER TABLE `menu`
  MODIFY `id_menu` int(11) NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `achete`
--
ALTER TABLE `achete`
  ADD CONSTRAINT `fk_client_has_focaccia_client1` FOREIGN KEY (`client_id_client`) REFERENCES `client` (`id_client`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_client_has_focaccia_focaccia1` FOREIGN KEY (`focaccia_id_focaccia`) REFERENCES `focaccia` (`id_focaccia`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `boisson`
--
ALTER TABLE `boisson`
  ADD CONSTRAINT `fk_boisson_marque1` FOREIGN KEY (`marque_id_marque`) REFERENCES `marque` (`id_marque`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `comprend`
--
ALTER TABLE `comprend`
  ADD CONSTRAINT `fk_focaccia_has_ingredient_focaccia1` FOREIGN KEY (`focaccia_id_focaccia`) REFERENCES `focaccia` (`id_focaccia`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_focaccia_has_ingredient_ingredient1` FOREIGN KEY (`ingredient_id_ingredient`) REFERENCES `ingredient` (`id_ingredient`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `contient`
--
ALTER TABLE `contient`
  ADD CONSTRAINT `fk_menu_has_boisson_boisson1` FOREIGN KEY (`boisson_id_boisson`) REFERENCES `boisson` (`id_boisson`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_menu_has_boisson_menu1` FOREIGN KEY (`menu_id_menu`) REFERENCES `menu` (`id_menu`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `menu`
--
ALTER TABLE `menu`
  ADD CONSTRAINT `fk_menu_focaccia` FOREIGN KEY (`focaccia_id_focaccia`) REFERENCES `focaccia` (`id_focaccia`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `paye`
--
ALTER TABLE `paye`
  ADD CONSTRAINT `fk_client_has_menu_client1` FOREIGN KEY (`client_id_client`) REFERENCES `client` (`id_client`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_client_has_menu_menu1` FOREIGN KEY (`menu_id_menu`) REFERENCES `menu` (`id_menu`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;



