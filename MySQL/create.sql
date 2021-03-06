-- MySQL Script generated by MySQL Workbench
-- Sat Oct 30 13:07:58 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema library
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema library
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `library` DEFAULT CHARACTER SET utf8 ;
USE `library` ;

-- -----------------------------------------------------
-- Table `library`.`publishing_house`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library`.`publishing_house` (
  `publishing_house_id` INT NOT NULL AUTO_INCREMENT,
  `publishing_house_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`publishing_house_id`),
  UNIQUE INDEX `pb_id_UNIQUE` (`publishing_house_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`book`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library`.`book` (
  `ISBN` INT NOT NULL,
  `book_title` VARCHAR(45) NOT NULL,
  `publishing_house_id` INT NOT NULL,
  `date_published` DATE NULL,
  PRIMARY KEY (`ISBN`),
  UNIQUE INDEX `ISBN_UNIQUE` (`ISBN` ASC) VISIBLE,
  INDEX `publishing_house_id_idx` (`publishing_house_id` ASC) VISIBLE,
  CONSTRAINT `publishing_house_id`
    FOREIGN KEY (`publishing_house_id`)
    REFERENCES `library`.`publishing_house` (`publishing_house_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`author`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library`.`author` (
  `author_id` INT NOT NULL AUTO_INCREMENT,
  `author_name` VARCHAR(45) NOT NULL,
  `author_surname` VARCHAR(45) NOT NULL,
  `date_birth` DATE NULL,
  `date_death` DATE NULL,
  PRIMARY KEY (`author_id`),
  UNIQUE INDEX `author_id_UNIQUE` (`author_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`literature_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library`.`literature_category` (
  `literature_category_id` INT NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`literature_category_id`),
  UNIQUE INDEX `literature_category_UNIQUE` (`literature_category_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library`.`country` (
  `country_id` INT NOT NULL AUTO_INCREMENT,
  `country_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`country_id`),
  UNIQUE INDEX `country_id_UNIQUE` (`country_id` ASC) VISIBLE,
  UNIQUE INDEX `country_name_UNIQUE` (`country_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`adress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library`.`adress` (
  `adress_id` INT NOT NULL AUTO_INCREMENT,
  `city_name` VARCHAR(45) NOT NULL,
  `postal_code` VARCHAR(45) NOT NULL,
  `street_name` VARCHAR(45) NOT NULL,
  `building_number` VARCHAR(45) NOT NULL,
  `country_id` INT NOT NULL,
  `other_details` VARCHAR(45) NULL,
  PRIMARY KEY (`adress_id`),
  UNIQUE INDEX `adress_id_UNIQUE` (`adress_id` ASC) VISIBLE,
  INDEX `country_id_idx` (`country_id` ASC) VISIBLE,
  CONSTRAINT `country_id`
    FOREIGN KEY (`country_id`)
    REFERENCES `library`.`country` (`country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`library`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library`.`library` (
  `library_id` INT NOT NULL AUTO_INCREMENT,
  `library_name` VARCHAR(45) NOT NULL,
  `adress_id` INT NOT NULL,
  PRIMARY KEY (`library_id`),
  UNIQUE INDEX `library_id_UNIQUE` (`library_id` ASC) VISIBLE,
  INDEX `adress_id_idx` (`adress_id` ASC) VISIBLE,
  CONSTRAINT `adress_id`
    FOREIGN KEY (`adress_id`)
    REFERENCES `library`.`adress` (`adress_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`book_in_library`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library`.`book_in_library` (
  `book_in_library_id` INT NOT NULL AUTO_INCREMENT,
  `ISBN` INT NOT NULL,
  `library_id` INT NOT NULL,
  PRIMARY KEY (`book_in_library_id`),
  INDEX `ISBN_idx` (`ISBN` ASC) VISIBLE,
  INDEX `library_id_idx` (`library_id` ASC) VISIBLE,
  CONSTRAINT `ISBN`
    FOREIGN KEY (`ISBN`)
    REFERENCES `library`.`book` (`ISBN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `library_id`
    FOREIGN KEY (`library_id`)
    REFERENCES `library`.`library` (`library_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`member_contacts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library`.`member_contacts` (
  `member_contacts_id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`member_contacts_id`),
  UNIQUE INDEX `member_contacts_id_UNIQUE` (`member_contacts_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`member`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library`.`member` (
  `member_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `adress_id` INT NOT NULL,
  `member_contacts_id` INT NOT NULL,
  PRIMARY KEY (`member_id`),
  UNIQUE INDEX `id_UNIQUE` (`member_id` ASC) VISIBLE,
  INDEX `adress_id_idx` (`adress_id` ASC) VISIBLE,
  INDEX `fk_member_member_contacts1_idx` (`member_contacts_id` ASC) VISIBLE,
  CONSTRAINT `adress_id`
    FOREIGN KEY (`adress_id`)
    REFERENCES `library`.`adress` (`adress_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_member_member_contacts1`
    FOREIGN KEY (`member_contacts_id`)
    REFERENCES `library`.`member_contacts` (`member_contacts_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`loaned_book`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library`.`loaned_book` (
  `loaned_book_id` INT NOT NULL,
  `book_in_library_id` INT NOT NULL,
  `member_id` INT NOT NULL,
  `date_loaned` DATE NOT NULL,
  `date_due` DATE NOT NULL,
  `date_returned` DATE NULL,
  PRIMARY KEY (`loaned_book_id`),
  UNIQUE INDEX `id_UNIQUE` (`loaned_book_id` ASC) VISIBLE,
  INDEX `book_in_library_id_idx` (`book_in_library_id` ASC) VISIBLE,
  INDEX `member_id_idx` (`member_id` ASC) VISIBLE,
  CONSTRAINT `book_in_library_id`
    FOREIGN KEY (`book_in_library_id`)
    REFERENCES `library`.`book_in_library` (`book_in_library_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `member_id`
    FOREIGN KEY (`member_id`)
    REFERENCES `library`.`member` (`member_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`book_has_literature_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library`.`book_has_literature_category` (
  `book_ISBN` INT NOT NULL,
  `literature_category_literature_category` INT NOT NULL,
  PRIMARY KEY (`book_ISBN`, `literature_category_literature_category`),
  INDEX `fk_book_has_literature_category_literature_category1_idx` (`literature_category_literature_category` ASC) VISIBLE,
  INDEX `fk_book_has_literature_category_book1_idx` (`book_ISBN` ASC) VISIBLE,
  CONSTRAINT `fk_book_has_literature_category_book1`
    FOREIGN KEY (`book_ISBN`)
    REFERENCES `library`.`book` (`ISBN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_book_has_literature_category_literature_category1`
    FOREIGN KEY (`literature_category_literature_category`)
    REFERENCES `library`.`literature_category` (`literature_category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`book_has_author`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library`.`book_has_author` (
  `book_ISBN` INT NOT NULL,
  `author_author_id` INT NOT NULL,
  PRIMARY KEY (`book_ISBN`, `author_author_id`),
  INDEX `fk_book_has_author_author1_idx` (`author_author_id` ASC) VISIBLE,
  INDEX `fk_book_has_author_book1_idx` (`book_ISBN` ASC) VISIBLE,
  CONSTRAINT `fk_book_has_author_book1`
    FOREIGN KEY (`book_ISBN`)
    REFERENCES `library`.`book` (`ISBN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_book_has_author_author1`
    FOREIGN KEY (`author_author_id`)
    REFERENCES `library`.`author` (`author_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
