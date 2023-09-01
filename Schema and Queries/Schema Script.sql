-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ifood` DEFAULT CHARACTER SET utf8 ;
USE `ifood` ;

-- -----------------------------------------------------
-- Table `ifood`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ifood`.`categoria` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `categoria` ENUM('PF', 'PJ') NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ifood`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ifood`.`customer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(20) NOT NULL COMMENT 'adicionar constraint de unicidade para nome completo',
  `middle_name` VARCHAR(20) NOT NULL,
  `last_name` VARCHAR(20) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `birthdate` DATE NOT NULL,
  `categoria_id` INT NOT NULL,
  PRIMARY KEY (`id`, `categoria_id`),
  UNIQUE INDEX `idCliente_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `Email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_customer_categoria1_idx` (`categoria_id` ASC) VISIBLE,
  CONSTRAINT `fk_customer_categoria1`
    FOREIGN KEY (`categoria_id`)
    REFERENCES `ifood`.`categoria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ifood`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ifood`.`address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `postal_code` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `region` VARCHAR(45) NULL,
  `street` VARCHAR(45) NULL,
  `number` VARCHAR(45) NULL,
  `country` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ifood`.`restaurant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ifood`.`restaurant` (
  `id` INT NOT NULL,
  `res_name` VARCHAR(45) NULL,
  `address_id` INT NOT NULL,
  PRIMARY KEY (`id`, `address_id`),
  INDEX `fk_Restaurant_Address1_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `fk_Restaurant_Address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `ifood`.`address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ifood`.`customer_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ifood`.`customer_address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `address_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  PRIMARY KEY (`id`, `address_id`, `customer_id`),
  INDEX `fk_customer_address_address1_idx` (`address_id` ASC) VISIBLE,
  INDEX `fk_customer_address_customer1_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_customer_address_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `ifood`.`address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customer_address_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `ifood`.`customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ifood`.`order_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ifood`.`order_status` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `status` ENUM('Processando', 'Preparando', 'À caminho', 'Entregue') NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ifood`.`payment_method`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ifood`.`payment_method` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `payment_method` ENUM('credit', 'money', 'debit') NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ifood`.`food_order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ifood`.`food_order` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `restaurant_id` INT NOT NULL,
  `customer_address_id` INT NOT NULL,
  `order_status_id` INT NOT NULL,
  `payment_method_id` INT NOT NULL,
  `order_description` VARCHAR(255) NULL,
  `delivery_fee` VARCHAR(45) NULL,
  `order_request_datetime` DATETIME NOT NULL,
  `total_amount` VARCHAR(45) NOT NULL,
  `tracking_code` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`, `customer_id`, `restaurant_id`, `customer_address_id`, `order_status_id`, `payment_method_id`),
  INDEX `fk_Pedido_Cliente1_idx` (`customer_id` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Food_Order_Restaurant1_idx` (`restaurant_id` ASC) VISIBLE,
  INDEX `fk_food_order_customer_address1_idx` (`customer_address_id` ASC) VISIBLE,
  INDEX `fk_food_order_order_status1_idx` (`order_status_id` ASC) VISIBLE,
  UNIQUE INDEX `tracking_code_UNIQUE` (`tracking_code` ASC) VISIBLE,
  INDEX `fk_food_order_payment_method1_idx` (`payment_method_id` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Cliente1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `ifood`.`customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Food_Order_Restaurant1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `ifood`.`restaurant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_food_order_customer_address1`
    FOREIGN KEY (`customer_address_id`)
    REFERENCES `ifood`.`customer_address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_food_order_order_status1`
    FOREIGN KEY (`order_status_id`)
    REFERENCES `ifood`.`order_status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_food_order_payment_method1`
    FOREIGN KEY (`payment_method_id`)
    REFERENCES `ifood`.`payment_method` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ifood`.`menu_item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ifood`.`menu_item` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `price` VARCHAR(45) NOT NULL,
  `status` ENUM("Available", "Unavailable") NOT NULL DEFAULT 'Available',
  `restaurant_id` INT NOT NULL,
  PRIMARY KEY (`id`, `restaurant_id`),
  UNIQUE INDEX `Items_UNIQUE` (`name` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Menu_Item_Restaurant1_idx` (`restaurant_id` ASC) VISIBLE,
  CONSTRAINT `fk_Menu_Item_Restaurant1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `ifood`.`restaurant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ifood`.`order_menu_item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ifood`.`order_menu_item` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `menu_item_id` INT NOT NULL,
  `food_order_id` INT NOT NULL,
  `quantity_ordered` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`, `menu_item_id`, `food_order_id`),
  INDEX `fk_order_menu_item_Menu_Item1_idx` (`menu_item_id` ASC) VISIBLE,
  INDEX `fk_order_menu_item_Food_Order1_idx` (`food_order_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_menu_item_Menu_Item1`
    FOREIGN KEY (`menu_item_id`)
    REFERENCES `ifood`.`menu_item` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_menu_item_Food_Order1`
    FOREIGN KEY (`food_order_id`)
    REFERENCES `ifood`.`food_order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
