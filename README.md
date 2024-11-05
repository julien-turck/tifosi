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
    ON DELETE CASCADE
    ON UPDATE CASCADE) 
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
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_client_has_focaccia_focaccia1`
    FOREIGN KEY (`focaccia_id_focaccia`)
    REFERENCES `tifosi`.`focaccia` (`id_focaccia`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
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
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_client_has_menu_menu1`
    FOREIGN KEY (`menu_id_menu`)
    REFERENCES `tifosi`.`menu` (`id_menu`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
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
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_focaccia_has_ingredient_ingredient1`
    FOREIGN KEY (`ingredient_id_ingredient`)
    REFERENCES `tifosi`.`ingredient` (`id_ingredient`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
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
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_menu_has_boisson_boisson1`
    FOREIGN KEY (`boisson_id_boisson`)
    REFERENCES `tifosi`.`boisson` (`id_boisson`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

## script SQL permettant l'insertion de la donnée test

INSERT INTO `ingredient` (`nom_ingredient`) VALUES ('Ail'), ('Ananas'), ('Artichaut'), ('bacon'), ('Base Tomate'), ('Base crème'), ('Champignon'), ('Chèvre'), ('Cresson'), ('Emmental'), ('Gorgonzola'), ('Jambon cuit'), ('Jambon fumé'), ('Oeuf'), ('Oignon'), ('Olive noire'), ('Olive verte'), ('Parmesan'), ('Piment'), ('Poivre'), ('Pomme de terre'), ('Raclette'), ('Salami'), ('Tomate cerise');
INSERT INTO `marque` (`nom_marque`) VALUES ('Coca-cola'), ('Cristalline'), ('Monster'), ('Pepsico');
INSERT INTO `boisson` (`nom_boisson`, `marque_id_marque`) VALUES ('Coca-cola zéro', 1), ('Coca-cola original', 1), ('Fanta citron', 1), ('Fanta orange', 1), ('Capri-sun', 1), ('Pepsi', 4), ('Pepsi Max Zéro', 4), ('Lipton zéro citron', 4), ('Lipton Peach', 4), ('Monster energy ultra gold', 3), ('Monster energy ultra blue', 3), ('Eau de source', 2);
INSERT INTO `focaccia` (`nom_focaccia`, `prix_focaccia`) VALUES ('Mozaccia', '9.80'), ('Gorgonzollaccia', '10.80'), ('Raclaccia', '8.90'), ('Emmentalaccia', '9.80'), ('Tradizione', '8.90'), ('Hawaienne', '11.20'), ('Américaine', '10.80'), ('Paysanne', '12.80'); 

## Manières de réaliser le backup de la base de données

### Executer le script d'import de la base de données ci-dessus

### Importer le fichier tifosi.sql depuis l'onglet import de phpmyadmin

### Importer le fichier backup_tifosi.sql en tapant les scripts ci-dessous dans le shell de Xampp :
- pour réaliser le backup : mysql -u root tifosi > backup_tifosi.sql
- pour importer le backup : mysql -u root tifosi < backup_tifosi.sql
