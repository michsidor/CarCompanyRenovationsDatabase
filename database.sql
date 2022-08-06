DROP TABLE IF EXISTS Renovation_Managment_System.Car_Company_Data;
DROP TABLE IF EXISTS Renovation_Managment_System.Industrial_Hall_Data;
DROP TABLE IF EXISTS Renovation_Managment_System.Manager;
DROP TABLE IF EXISTS Renovation_Managment_System.Renovation_Company_Data;
DROP TABLE IF EXISTS Renovation_Managment_System.Data_Of_Renovation;
DROP TABLE IF EXISTS Renovation_Managment_System.Deputy_Manager;
DROP TABLE IF EXISTS Renovation_Managment_System.Supervisior_Data;

DROP DATABASE IF EXISTS Renovation_Managment_System;

DROP PROCEDURE IF EXISTS renovation_managment_system.AddingValues_if1;
DROP PROCEDURE IF EXISTS renovation_managment_system.AddingValues_if2;
DROP PROCEDURE IF EXISTS renovation_managment_system.AddingValues_if3;
DROP PROCEDURE IF EXISTS renovation_managment_system.AddingValues_if4;

CREATE DATABASE Renovation_Managment_System;


-- 29 hal bedzie --
-- First Table - Informacje o firmie samochodowej(np.BMW, Wolkswagen) oraz gdzie sie znajduja ich oddzialy --
CREATE TABLE IF NOT EXISTS Renovation_Managment_System.Car_Company_Data(
    car_company_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    company_name VARCHAR(50) NOT NULL,
    city VARCHAR(100) NOT NULL,
    post_code VARCHAR(50) NOT NULL,
    num_of_industrial_halls INT UNSIGNED NOT NULL,
    PRIMARY KEY (car_company_id)
    )ENGINE = INNODB
    COLLATE 'utf8_general_ci';

-- Second Table - informacje o konkternej hali w konkretnej firmie(powierzchnia,liczba pracownikow, oraz znak hali(token)) --
CREATE TABLE IF NOT EXISTS Renovation_Managment_System.Industrial_Hall_Data(
    industrial_hall_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    car_company_id INT UNSIGNED NOT NULL,
    industrial_hall_token VARCHAR(25) NOT NULL,
    area INT UNSIGNED NOT NULL,
    num_of_employees INT UNSIGNED NOT NULL,
    PRIMARY KEY(industrial_hall_id) 
    )ENGINE = INNODB
    COLLATE 'utf8_general_ci';

-- Third Table - informacje o managerze i o tym jaka hale pilnuje --
CREATE TABLE IF NOT EXISTS Renovation_Managment_System.Manager(
    manager_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    manager_name VARCHAR(50) NOT NULL,
    manager_surname VARCHAR(50) NOT NULL,
    manager_token VARCHAR(50) NOT NULL,
    manager_age INT UNSIGNED NOT NULL,
    manager_phone_number VARCHAR(255) DEFAULT 'brak',
    manager_start_holiday DATE DEFAULT '1000-01-01',
    manager_end_holiday DATE DEFAULT '1000-01-01',
    industrial_hall_token VARCHAR(25) NOT NULL,
    industrial_hall_id INT UNSIGNED NOT NULL,
    PRIMARY KEY(manager_id) 
    )ENGINE = INNODB
    COLLATE 'utf8_general_ci';
    
-- Fourth Table - informacje o przelozonym oraz o tym(INNER JOIN pokaze nam jaka hale powinien pilnowac) -- 
CREATE TABLE IF NOT EXISTS Renovation_Managment_System.Deputy_Manager(
    deputy_manager_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    deputy_manager_name VARCHAR(50) NOT NULL,
    deputy_manager_surname VARCHAR(50) NOT NULL,
    deputy_manager_token VARCHAR(50) NOT NULL,
    deputy_manager_start_holiday DATE DEFAULT '1000-01-01',
    deputy_manager_end_holiday DATE DEFAULT '1000-01-01',
    manager_token VARCHAR(50) NOT NULL,
    PRIMARY KEY(deputy_manager_id) 
    )ENGINE = INNODB
    COLLATE 'utf8_general_ci';    
    
-- Fifth Table - informacje o firmie ktora bedzie przeprowadzac remonto --
CREATE TABLE IF NOT EXISTS Renovation_Managment_System.Renovation_Company_Data(
    renovation_company_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    renovation_company_name VARCHAR(50) NOT NULL,
    ceo_name VARCHAR(25) NOT NULL DEFAULT 'No data available',
    ceo_surname VARCHAR(25) NOT NULL DEFAULT 'No data available',
    number_of_employees INT NOT NULL DEFAULT -1,
    PRIMARY KEY(renovation_company_id) 
    )ENGINE = INNODB
    COLLATE 'utf8_general_ci';    
  
-- Sixth Table - informacje o remoncie, od kiedy do kiedy powinien byc --  
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

-- Seventh Table zbiora tablicza mowiaca nam kiedy remont bedzie sie na pewno odbywac i kto bedzie go pilnowac --
CREATE TABLE IF NOT EXISTS Renovation_Managment_System.Supervisior_Data(
    supervisior_id VARCHAR(50) NOT NULL,
    work_start DATE DEFAULT '1000-01-01',
    work_end DATE DEFAULT '1000-01-01',
    work_done BOOLEAN
    )ENGINE = INNODB
    COLLATE 'utf8_general_ci';
    
INSERT INTO Renovation_Managment_System.Car_Company_Data VALUES
(NULL,'Volkswagen','Poznan','60-655',2),
(NULL,'Volkswagen','Wrzesnia','60-657',1),
(NULL,'Volkswagen','Polkowice','59-100',1),
(NULL,'Volkswagen','Wrocław','53-015',1),
(NULL,'Volkswagen','Wrocław','51-411',3),
(NULL,'Volkswagen','Piaseczno','05-500',3),
(NULL,'Volkswagen','Warszawa','04-111',1),
(NULL,'BMW','Mikolow','43-190',3),
(NULL,'BMW','Worclaw','53-015',2),
(NULL,'BMW','Warszawa','04-175',1),
(NULL,'BMW','Poznan','61-312',4),
(NULL,'Mitsubishi','Rzeszow','35-083',2),
(NULL,'Mitsubishi','Torun','87-100',1),
(NULL,'Mitsubishi','Gdynia','81-005',2),
(NULL,'Mitsubishi','Kalisz','62-800',2);

INSERT INTO Renovation_Managment_System.Manager(manager_surname,manager_name,manager_age,manager_phone_number,manager_start_holiday,manager_end_holiday)
VALUES
('Schmitt','Carine ',20,'508555955','2022-10-01','2022-10-07'),
('King','Jean',30,'617555855','2022-10-08','2022-10-15'),
('Nelson','Susan',42,'412642550','2022-10-16','2022-10-23'),
('Bergulfsen','Jonas',31,'089703455','2022-10-24','2022-10-31'),
('Labrune','Janine',28,'422121555','2022-11-01','2022-11-08'),
('Keitel','Roland',25,'312049195','2022-11-09','2022-11-16'),
('Piestrzeniewicz','Zbyszek',26,'030007455','2022-11-17','2022-11-24'),
('Freyre','Diego',45,'702555183','2022-11-25','2022-11-30'),
('Murphy','Julie',55,'039520455','2022-12-01','2022-12-08'),
('Saveley','Mary',44,'415555145','2022-12-09','2022-12-15'),
('Rancé','Martin',23,'642755536','2022-12-20','2022-12-27'),
('Frick','Michael',33,'499669025','2022-12-02','2022-12-05'),
('Taylor','Leslie',44,'312049195','2022-05-01','2022-05-09'),
('Cassidy','Dean',55,'030007455','2022-05-10','2022-05-17'),
('Walker','Brydey',66,'981443655','2022-05-20','2022-05-27'),
('Michal','Kowalski',45,'914555456','2022-05-04','2022-05-15'),
('Michal','Kowalski',56,'508555955','2022-05-02','2022-05-20'),
('Citeaux','Frédérique',67, '650555138','2022-06-01','2022-06-20'),
('Gao','Mike',34,'649125555','2022-06-05','2022-06-12'),
('Saavedra','Eduardo ',23,'201555935','2022-06-21','2022-06-28'),
('Young','Mary',48,'358980455','2022-06-14','2022-06-21'),
('Kloss','Horst ',49,'215555469','2022-07-01','2022-07-10'),
('Ibsen','Palle',50,'215555436','2022-07-14','2022-07-21'),
('Camino','Alejandra',51,'296755458','2022-07-22','2022-07-29'),
('Fresnière','Jean ',20,'215503555','2022-07-23','2022-07-30'),
('Thompson','Valarie',36,'603555864','2022-08-01','2022-08-10'),
('Bennett','Helen ',38,'617555855','2022-08-15','2022-08-22'),
('Roulet','Annette' ,39,'656295556','2022-08-25','2022-08-31'),
('Messner','Renate ',43,'071155536','2022-09-01','2022-09-20');

-- PROCEDURY -- 

DELIMITER //
CREATE PROCEDURE renovation_managment_system.AddingValues_if1 ()
BEGIN
INSERT INTO industrial_hall_data(industrial_hall_token)
SELECT CONCAT(LEFT(company_name,1) ,LEFT(city,3), RIGHT(post_code,2),'-1') as Wynik
FROM car_company_data;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE renovation_managment_system.AddingValues_if2 ()
BEGIN
INSERT INTO industrial_hall_data(industrial_hall_token)
SELECT CONCAT(LEFT(company_name,1) ,LEFT(city,3), RIGHT(post_code,2),'-2') as Wynik
FROM car_company_data
WHERE num_of_industrial_halls > 1;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE renovation_managment_system.AddingValues_if3 ()
BEGIN
INSERT INTO industrial_hall_data(industrial_hall_token)
SELECT CONCAT(LEFT(company_name,1) ,LEFT(city,3), RIGHT(post_code,2),'-3') as Wynik
FROM car_company_data
WHERE num_of_industrial_halls > 2;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE renovation_managment_system.AddingValues_if4 ()
BEGIN
INSERT INTO industrial_hall_data(industrial_hall_token)
SELECT CONCAT(LEFT(company_name,1) ,LEFT(city,3), RIGHT(post_code,2),'-4') as Wynik
FROM car_company_data
WHERE num_of_industrial_halls > 3;
END//
DELIMITER ;

Call renovation_managment_system.AddingValues_if1();
Call renovation_managment_system.AddingValues_if2();
Call renovation_managment_system.AddingValues_if3();
Call renovation_managment_system.AddingValues_if4();

UPDATE industrial_hall_data
SET industrial_hall_token = UPPER(industrial_hall_token);
