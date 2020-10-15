

-- -----------------------------------------------------
-- Schema Amusement_Park_DB
-- -----------------------------------------------------

CREATE SCHEMA IF NOT EXISTS `Amusement_Park_DB` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `Amusement_Park_DB` ;

-- -----------------------------------------------------
-- Table `Amusement_Park_DB`.`amusement_park`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Amusement_Park_DB`.`amusement_park` ;

CREATE TABLE IF NOT EXISTS `Amusement_Park_DB`.`amusement_park` (
  `amusement_park_id` INT NOT NULL,
  `amusement_park_name` VARCHAR(45) NOT NULL,
  `park_open` TIME NOT NULL,
  `park_close` TIME NOT NULL,
  `park_country` VARCHAR(100) NOT NULL,
  `park_state_or_province` VARCHAR(100) NOT NULL,
  `park_city` VARCHAR(100) NOT NULL,
  `park_street_address` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`amusement_park_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Amusement_Park_DB`.`areas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Amusement_Park_DB`.`areas` ;

CREATE TABLE IF NOT EXISTS `Amusement_Park_DB`.`areas` (
  `area_id` INT NOT NULL AUTO_INCREMENT,
  `area_name` VARCHAR(45) NOT NULL,
  `area_description` VARCHAR(200) NULL,
  `area_pictures` VARCHAR(50) NULL,
  `amusement_park_id` INT NOT NULL,
  PRIMARY KEY (`area_id`),
  INDEX `amusement_park_areas` (`amusement_park_id` ASC),
  CONSTRAINT `amusement_park_areas`
    FOREIGN KEY (`amusement_park_id`)
    REFERENCES `Amusement_Park_DB`.`amusement_park` (`amusement_park_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Amusement_Park_DB`.`Rides_attractions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Amusement_Park_DB`.`attractions` ;

CREATE TABLE IF NOT EXISTS `Amusement_Park_DB`.`attractions` (
  `attraction_id` INT NOT NULL AUTO_INCREMENT,
  `attraction_name` VARCHAR(50) NOT NULL,
  `area_id` INT NOT NULL,
  `attraction_description` VARCHAR(200) NULL,
  `picture_path` VARCHAR(50) NULL,
  `is_working` TINYINT(1) NOT NULL,
  `date_opened` DATE NOT NULL,
  PRIMARY KEY (`attraction_id`),
  INDEX `area_id_idx` (`area_id` ASC),
  CONSTRAINT `area_id`
    FOREIGN KEY (`area_id`)
    REFERENCES `Amusement_Park_DB`.`areas` (`area_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Amusement_Park_DB`.`maintenance`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Amusement_Park_DB`.`maintenance` ;

CREATE TABLE IF NOT EXISTS `Amusement_Park_DB`.`maintenance` (
  `maintenance_id` INT NOT NULL,
  `attraction_id` INT NOT NULL,
  `incidence_date` TIMESTAMP NOT NULL,
  `resolution_date` TIMESTAMP NULL,
  `repair_cost` DECIMAL(10,0) NULL,
  PRIMARY KEY (`maintenance_id`),
  INDEX `attraction_id_maintenance` (`attraction_id` ASC),
  CONSTRAINT `attraction_id_maintenance`
    FOREIGN KEY (`attraction_id`)
    REFERENCES `Amusement_Park_DB`.`attractions` (`attraction_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;





-- -----------------------------------------------------
-- Table `Amusement_Park_DB`.`ticket_types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Amusement_Park_DB`.`ticket_types` ;

CREATE TABLE IF NOT EXISTS `Amusement_Park_DB`.`ticket_types` (
  `ticket_type_id` INT NOT NULL AUTO_INCREMENT,
  `ticket_name` VARCHAR(45) NOT NULL,
  `ticket_restrictions` VARCHAR(200) NOT NULL,
  `ticket_price` FLOAT NULL,
  PRIMARY KEY (`ticket_type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Amusement_Park_DB`.`ticket_sales`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Amusement_Park_DB`.`ticket_sales` ;

CREATE TABLE IF NOT EXISTS `Amusement_Park_DB`.`ticket_sales` (
  `ticket_id` INT NOT NULL AUTO_INCREMENT,
  `ticket_type_id` INT NOT NULL,
  `sale_date` DATE NOT NULL,
  `redemption_date` DATE NULL,
  `amusement_park_id` INT NOT NULL,
  `sale_location` ENUM('Box Office','Online') NULL,
  PRIMARY KEY (`ticket_id`),
  INDEX `ticket_type_id_sales` (`ticket_type_id` ASC),
  INDEX `amusement_park_id_sales` (`amusement_park_id` ASC),
  CONSTRAINT `ticket_type_sales`
    FOREIGN KEY (`ticket_type_id`)
    REFERENCES `Amusement_Park_DB`.`ticket_types` (`ticket_type_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `amusement_park_sales`
    FOREIGN KEY (`amusement_park_id`)
    REFERENCES `Amusement_Park_DB`.`amusement_park` (`amusement_park_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;




-- -----------------------------------------------------
-- Table `Amusement_Park_DB`.`restaurants`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Amusement_Park_DB`.`restaurants` ;

CREATE TABLE IF NOT EXISTS `Amusement_Park_DB`.`restaurants` (
  `restaurant_id` INT NOT NULL,
  `restaurant_name` VARCHAR(45) NOT NULL,
  `food_category_id` INT NOT NULL,
  `area_id` INT NOT NULL,
  PRIMARY KEY (`restaurant_id`),
  INDEX `area_id_restaurants` (`area_id` ASC),
  CONSTRAINT `area_id_restaurants`
    FOREIGN KEY (`area_id`)
    REFERENCES `Amusement_Park_DB`.`areas` (`area_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Amusement_Park_DB`.`food_categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Amusement_Park_DB`.`food_categories` ;

CREATE TABLE IF NOT EXISTS `Amusement_Park_DB`.`food_categories` (
  `food_category_id` INT NOT NULL,
  `food_categories_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`food_category_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Amusement_Park_DB`.`restaurant_daily_reports`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Amusement_Park_DB`.`restaurant_daily_reports` ;

CREATE TABLE IF NOT EXISTS `Amusement_Park_DB`.`restaurant_daily_reports` (
  `report_date` DATE NOT NULL,
  `restaurant_id` INT NOT NULL,
  `gross_income` DECIMAL(10,0) NOT NULL,
  `patrons_served` INT NOT NULL,
  PRIMARY KEY (`report_date`),
  INDEX `restaurant_id_reports` (`restaurant_id` ASC),
  CONSTRAINT `restaurant_id_reports`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `Amusement_Park_DB`.`restaurants` (`restaurant_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Amusement_Park_DB`.`daily_ride_report`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Amusement_Park_DB`.`daily_ride_report` ;

CREATE TABLE IF NOT EXISTS `Amusement_Park_DB`.`daily_ride_report` (
  `ride_report_date` DATE NOT NULL,
  `attraction_id` INT NOT NULL,
  `total_riders` INT NOT NULL,
  PRIMARY KEY (`ride_report_date`),
  INDEX `attraction_id_ride_reports` (`attraction_id` ASC),
  CONSTRAINT `attraction_id_ride_reports`
    FOREIGN KEY (`attraction_id`)
    REFERENCES `Amusement_Park_DB`.`attractions` (`attraction_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Amusement_Park_DB`.`job_titles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Amusement_Park_DB`.`job_titles` ;

CREATE TABLE IF NOT EXISTS `Amusement_Park_DB`.`job_titles` (
  `job_title_id` INT NOT NULL AUTO_INCREMENT,
  `job_title` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`job_title_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Amusement_Park_DB`.`employees`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Amusement_Park_DB`.`employees` ;

CREATE TABLE IF NOT EXISTS `Amusement_Park_DB`.`employees` (
  `ssn` INT NOT NULL,
  `amusement_park_id` INT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `middle_initial` VARCHAR(1) NOT NULL,
  `full_time` TINYINT(1) NOT NULL,
  `payrate` DECIMAL(10,0) NOT NULL,
  `hired_date` DATE NOT NULL,
  `job_title_id` INT NOT NULL,
  `date_left` DATE NULL,
  `rehireable` TINYINT(1) NULL,
  PRIMARY KEY (`ssn`),
  INDEX `amusement_park_id_employees_idx` (`amusement_park_id` ASC),
  INDEX `job_title_id_idx` (`job_title_id` ASC),
  CONSTRAINT `amusement_park_id_employees`
    FOREIGN KEY (`amusement_park_id`)
    REFERENCES `Amusement_Park_DB`.`amusement_park` (`amusement_park_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `job_title_id`
    FOREIGN KEY (`job_title_id`)
    REFERENCES `Amusement_Park_DB`.`job_titles` (`job_title_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;



