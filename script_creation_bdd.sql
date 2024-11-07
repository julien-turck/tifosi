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