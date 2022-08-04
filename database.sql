DROP TABLE IF EXISTS Renovation_Managment_System.Car_Company_Data;
DROP TABLE IF EXISTS Renovation_Managment_System.Industrial_Hall_Data;
DROP TABLE IF EXISTS Renovation_Managment_System.Manager;
DROP TABLE IF EXISTS Renovation_Managment_System.Renovation_Company_Data;
DROP TABLE IF EXISTS Renovation_Managment_System.Data_Of_Renovation;
DROP TABLE IF EXISTS Renovation_Managment_System.Deputy_Manager;

DROP DATABASE IF EXISTS Renovation_Managment_System;

CREATE DATABASE Renovation_Managment_System;

-- First Table --
CREATE TABLE IF NOT EXISTS Renovation_Managment_System.Car_Company_Data(
    car_company_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    post_code VARCHAR(50) NOT NULL,
    city VARCHAR(100) NOT NULL,
    company_name VARCHAR(50) NOT NULL,
    num_of_industrial_halls INT UNSIGNED NOT NULL,
    PRIMARY KEY (car_company_id)
    )ENGINE = INNODB
    COLLATE 'utf8_general_ci';

-- Second Table --
CREATE TABLE IF NOT EXISTS Renovation_Managment_System.Industrial_Hall_Data(
    industrial_hall_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    car_company_id INT UNSIGNED NOT NULL,
    industrial_hall_token VARCHAR(25) NOT NULL,
    area INT UNSIGNED NOT NULL,
    num_of_employees INT UNSIGNED NOT NULL,
    PRIMARY KEY(industrial_hall_id) 
    )ENGINE = INNODB
    COLLATE 'utf8_general_ci';

-- Third Table --
CREATE TABLE IF NOT EXISTS Renovation_Managment_System.Manager(
    manager_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    manager_name VARCHAR(50) NOT NULL,
    manager_surname VARCHAR(50) NOT NULL,
    manager_token VARCHAR(50) NOT NULL,
    manager_age INT UNSIGNED NOT NULL,
    manager_phone_number INT UNSIGNED DEFAULT 0,
    industrial_hall_token VARCHAR(25) NOT NULL,
    industrial_hall_id INT UNSIGNED NOT NULL,
    PRIMARY KEY(manager_id) 
    )ENGINE = INNODB
    COLLATE 'utf8_general_ci';
    
-- Fourth Table --    
CREATE TABLE IF NOT EXISTS Renovation_Managment_System.Renovation_Company_Data(
    renovation_company_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    renovation_company_name VARCHAR(50) NOT NULL,
    ceo_name VARCHAR(25) NOT NULL DEFAULT 'No data available',
    ceo_surname VARCHAR(25) NOT NULL DEFAULT 'No data available',
    number_of_employees INT NOT NULL DEFAULT -1,
    PRIMARY KEY(renovation_company_id) 
    )ENGINE = INNODB
    COLLATE 'utf8_general_ci';    
    
-- Fifth Table --
CREATE TABLE IF NOT EXISTS Renovation_Managment_System.Data_Of_Renovation(
    renovation_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    industrial_hall_id INT UNSIGNED NOT NULL,
    renovation_company_id INT UNSIGNED NOT NULL,
    start_data DATE DEFAULT '1000-01-01',
    end_data DATE DEFAULT '1000-01-01' ,
    supervisior_id INT UNSIGNED NOT NULL,
    PRIMARY KEY(renovation_id) 
    )ENGINE = INNODB
    COLLATE 'utf8_general_ci';   

-- Sixth Table --
CREATE TABLE IF NOT EXISTS Renovation_Managment_System.Deputy_Manager(
    deputy_manager_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    deputy_manager_name VARCHAR(50) NOT NULL,
    deputy_manager_surname VARCHAR(50) NOT NULL,
    deputy_manager_token VARCHAR(50) NOT NULL,
    manager_token VARCHAR(50) NOT NULL,
    PRIMARY KEY(deputy_manager_id) 
    )ENGINE = INNODB
    COLLATE 'utf8_general_ci';    

 
