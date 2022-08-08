DROP TABLE IF EXISTS Renovation_Managment_System.Car_Company_Data;
DROP TABLE IF EXISTS Renovation_Managment_System.Industrial_Hall_Data;
DROP TABLE IF EXISTS Renovation_Managment_System.Manager;
DROP TABLE IF EXISTS Renovation_Managment_System.Renovation_Company_Data;
DROP TABLE IF EXISTS Renovation_Managment_System.Data_Of_Renovation;
DROP TABLE IF EXISTS Renovation_Managment_System.Deputy_Manager;
DROP TABLE IF EXISTS Renovation_Managment_System.Supervisior_Data;

DROP DATABASE IF EXISTS Renovation_Managment_System;

DROP PROCEDURE IF EXISTS renovation_managment_system.AddingValues_if1; -- 1
DROP PROCEDURE IF EXISTS renovation_managment_system.AddingValues_if2; -- 2
DROP PROCEDURE IF EXISTS renovation_managment_system.AddingValues_if3; -- 3
DROP PROCEDURE IF EXISTS renovation_managment_system.AddingValues_if4; -- 4
DROP PROCEDURE IF EXISTS renovation_managment_system.AddingValueArea; -- 5
DROP PROCEDURE IF EXISTS renovation_managment_system.AddingValueManager; -- 6

DROP VIEW IF EXISTS renovation_managment_system.manager_company_view; -- 1
DROP VIEW IF EXISTS renovation_managment_system.deputy_manager_harder_task; -- 2
DROP VIEW IF EXISTS renovation_managment_system.InformationVolkswagen; -- 3
DROP VIEW IF EXISTS renovation_managment_system.InformationBMW; -- 4
DROP VIEW IF EXISTS renovation_managment_system.InformationMitsubishi; -- 5

CREATE DATABASE Renovation_Managment_System;
USE Renovation_Managment_System; -- we do not have to use f.e.: Renovation_Managment_System.Manager

-- 29 hal bedzie --
-- First Table - Informacje o firmie samochodowej(np.BMW, Wolkswagen) oraz gdzie sie znajduja ich oddzialy --
CREATE TABLE IF NOT EXISTS Car_Company_Data(
    car_company_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    company_name VARCHAR(50) NOT NULL,
    city VARCHAR(100) NOT NULL,
    post_code VARCHAR(50) NOT NULL,
    num_of_industrial_halls INT UNSIGNED NOT NULL,
    PRIMARY KEY (car_company_id)
    )ENGINE = INNODB
    COLLATE 'utf8_general_ci';

-- Second Table - informacje o konkternej hali w konkretnej firmie(powierzchnia,liczba pracownikow, oraz znak hali(token)) --
CREATE TABLE IF NOT EXISTS Industrial_Hall_Data(
    industrial_hall_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    car_company_id INT UNSIGNED NOT NULL,
    industrial_hall_token VARCHAR(25) NOT NULL,
    area INT UNSIGNED NOT NULL,
    num_of_employees INT UNSIGNED NOT NULL,
    PRIMARY KEY(industrial_hall_id) 
    )ENGINE = INNODB
    COLLATE 'utf8_general_ci';

-- Third Table - informacje o managerze i o tym jaka hale pilnuje --
CREATE TABLE IF NOT EXISTS Manager(
    manager_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    manager_name VARCHAR(50) NOT NULL,
    manager_surname VARCHAR(50) NOT NULL,
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
CREATE TABLE IF NOT EXISTS Deputy_Manager(
    deputy_manager_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    deputy_manager_name VARCHAR(50) NOT NULL,
    deputy_manager_surname VARCHAR(50) NOT NULL,
    deputy_manager_phone VARCHAR(100) NOT NULL,
    deputy_manager_start_holiday DATE DEFAULT '1000-01-01',
    deputy_manager_end_holiday DATE DEFAULT '1000-01-01',
    manager_id INT UNSIGNED NOT NULL,
    PRIMARY KEY(deputy_manager_id) 
    )ENGINE = INNODB
    COLLATE 'utf8_general_ci';    
    
-- Fifth Table - informacje o firmie ktora bedzie przeprowadzac remonto --
CREATE TABLE IF NOT EXISTS Renovation_Company_Data(
    renovation_company_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    renovation_company_name VARCHAR(50) NOT NULL,
    ceo_name VARCHAR(25) NOT NULL DEFAULT 'No data available',
    ceo_surname VARCHAR(25) NOT NULL DEFAULT 'No data available',
    number_of_employees INT NOT NULL DEFAULT -1,
    PRIMARY KEY(renovation_company_id) 
    )ENGINE = INNODB
    COLLATE 'utf8_general_ci';    
  
-- Sixth Table - informacje o remoncie, od kiedy do kiedy powinien byc --  
CREATE TABLE IF NOT EXISTS Data_Of_Renovation(
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
CREATE TABLE IF NOT EXISTS Supervisior_Data(
    supervisior_id VARCHAR(50) NOT NULL,
    work_start DATE DEFAULT '1000-01-01',
    work_end DATE DEFAULT '1000-01-01',
    work_done BOOLEAN
    )ENGINE = INNODB
    COLLATE 'utf8_general_ci';

-- PROCEDURES -- 
-- 1 
DELIMITER //
CREATE PROCEDURE AddingValuesIndustrialHallData_if1 ()
BEGIN
INSERT INTO industrial_hall_data(car_company_id,industrial_hall_token)
SELECT car_company_id,CONCAT(LEFT(company_name,1) ,LEFT(city,3), RIGHT(post_code,2),'-1') as Wynik
FROM car_company_data;
END//
DELIMITER ;

-- 2
DELIMITER //
CREATE PROCEDURE AddingValuesIndustrialHallData_if2 ()
BEGIN
INSERT INTO industrial_hall_data(car_company_id,industrial_hall_token)
SELECT car_company_id,CONCAT(LEFT(company_name,1) ,LEFT(city,3), RIGHT(post_code,2),'-2') as Wynik
FROM car_company_data
WHERE num_of_industrial_halls > 1;
END//
DELIMITER ;

-- 3
DELIMITER //
CREATE PROCEDURE AddingValuesIndustrialHallData_if3 ()
BEGIN
INSERT INTO industrial_hall_data(car_company_id,industrial_hall_token)
SELECT car_company_id,CONCAT(LEFT(company_name,1) ,LEFT(city,3), RIGHT(post_code,2),'-3') as Wynik
FROM car_company_data
WHERE num_of_industrial_halls > 2;
END//
DELIMITER ;

-- 4
DELIMITER //
CREATE PROCEDURE AddingValueIndustrialHallDatas_if4 ()
BEGIN
INSERT INTO industrial_hall_data(car_company_id,industrial_hall_token)
SELECT car_company_id, CONCAT(LEFT(company_name,1) ,LEFT(city,3), RIGHT(post_code,2),'-4') as Wynik
FROM car_company_data
WHERE num_of_industrial_halls > 3;
END//
DELIMITER ;

-- 5
DELIMITER //
CREATE PROCEDURE AddingValueArea (IN id INT, IN size INT, IN n_of_emp INT)
BEGIN
UPDATE industrial_hall_data
SET 
area = size,
num_of_employees = n_of_emp
WHERE industrial_hall_id = id;
END//
DELIMITER ;

-- 6
DELIMITER //
CREATE PROCEDURE AddingValueManagerData (IN id INT,IN nm VARCHAR(50), IN sn VARCHAR(50), IN ag INT, IN pn VARCHAR(50), IN sh DATE,IN eh DATE)
BEGIN
UPDATE manager
SET 
manager_name = nm,
manager_surname = sn,
manager_age = ag,
manager_phone_number = pn,
manager_start_holiday = sh,
manager_end_holiday = eh
WHERE   manager_id=id;
END//
DELIMITER ;

-- 7
DELIMITER //
CREATE PROCEDURE AddingValueManager()
BEGIN
INSERT INTO manager(industrial_hall_token,industrial_hall_id)
SELECT industrial_hall_token,industrial_hall_id 
FROM industrial_hall_data;
END//
DELIMITER ;
-- END OF PROCEDURES ----------------------------------------------------------------------------------------
 
-- INSERTING VALUES TO ALL TABLES ------------------------------------------------------------------------- 
INSERT INTO Car_Company_Data VALUES
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



Call AddingValuesIndustrialHallData_if1();
ALTER TABLE industrial_hall_data AUTO_INCREMENT = 1;
Call AddingValuesIndustrialHallData_if2();
ALTER TABLE industrial_hall_data AUTO_INCREMENT = 1;
Call AddingValuesIndustrialHallData_if3();
ALTER TABLE industrial_hall_data AUTO_INCREMENT = 1;
Call AddingValueIndustrialHallDatas_if4();

UPDATE industrial_hall_data
SET industrial_hall_token = UPPER(industrial_hall_token);

CALL AddingValueArea(1,50,8000);
CALL AddingValueArea(2,39,7000);
CALL AddingValueArea(3,20,3000);
CALL AddingValueArea(4,15,2000);
CALL AddingValueArea(5,16,15000);
CALL AddingValueArea(6,18,5000);
CALL AddingValueArea(7,21,800);
CALL AddingValueArea(8,10,300);
CALL AddingValueArea(9,8,600);
CALL AddingValueArea(10,13,300);
CALL AddingValueArea(11,14,700);
CALL AddingValueArea(12,16,1500);
CALL AddingValueArea(13,19,2000);
CALL AddingValueArea(14,22,2300);
CALL AddingValueArea(15,27,3400);
CALL AddingValueArea(16,26,8000);
CALL AddingValueArea(17,24,9100);
CALL AddingValueArea(18,22,11000);
CALL AddingValueArea(19,20,2300);
CALL AddingValueArea(20,16,10300);
CALL AddingValueArea(21,17,500);
CALL AddingValueArea(22,19,300);
CALL AddingValueArea(23,30,1000);
CALL AddingValueArea(24,21,4800);
CALL AddingValueArea(25,35,2200);
CALL AddingValueArea(26,43,700);
CALL AddingValueArea(27,40,950);
CALL AddingValueArea(28,45,13400);
CALL AddingValueArea(29,60,5300);

CALL AddingValueManager();

CALL AddingValueManagerData(1,'Schmitt','Carine ',20,'508555955','2022-10-01','2022-10-07');
CALL AddingValueManagerData(2,'King','Jean',30,'617555855','2022-10-08','2022-10-15');
CALL AddingValueManagerData(3,'Nelson','Susan',42,'412642550','2022-10-16','2022-10-23');
CALL AddingValueManagerData(4,'Bergulfsen','Jonas',31,'089703455','2022-10-24','2022-10-31');
CALL AddingValueManagerData(5,'Labrune','Janine',28,'422121555','2022-11-01','2022-11-08');
CALL AddingValueManagerData(6,'Keitel','Roland',25,'312049195','2022-11-09','2022-11-16');
CALL AddingValueManagerData(7,'Piestrzeniewicz','Zbyszek',26,'030007455','2022-11-17','2022-11-24');
CALL AddingValueManagerData(8,'Freyre','Diego',45,'702555183','2022-11-25','2022-11-30');
CALL AddingValueManagerData(9,'Murphy','Julie',55,'039520455','2022-12-01','2022-12-08');
CALL AddingValueManagerData(10,'Saveley','Mary',44,'415555145','2022-12-09','2022-12-15');
CALL AddingValueManagerData(11,'Rancé','Martin',23,'642755536','2022-12-20','2022-12-27');
CALL AddingValueManagerData(12,'Frick','Michael',33,'499669025','2022-12-02','2022-12-05');
CALL AddingValueManagerData(13,'Taylor','Leslie',44,'312049195','2022-05-01','2022-05-09');
CALL AddingValueManagerData(14,'Cassidy','Dean',55,'030007455','2022-05-10','2022-05-17');
CALL AddingValueManagerData(15,'Walker','Brydey',66,'981443655','2022-05-20','2022-05-27');
CALL AddingValueManagerData(16,'Michal','Kowalski',56,'508555955','2022-05-02','2022-05-20');
CALL AddingValueManagerData(17,'Citeaux','Frédérique',67, '650555138','2022-06-01','2022-06-20');
CALL AddingValueManagerData(18,'Gao','Mike',34,'649125555','2022-06-05','2022-06-12');
CALL AddingValueManagerData(19,'Saavedra','Eduardo ',23,'201555935','2022-06-21','2022-06-28');
CALL AddingValueManagerData(20,'Young','Mary',48,'358980455','2022-06-14','2022-06-21');
CALL AddingValueManagerData(21,'Kloss','Horst ',49,'215555469','2022-07-01','2022-07-10');
CALL AddingValueManagerData(22,'Ibsen','Palle',50,'215555436','2022-07-14','2022-07-21');
CALL AddingValueManagerData(23,'Camino','Alejandra',51,'296755458','2022-07-22','2022-07-29');
CALL AddingValueManagerData(24,'Fresnière','Jean ',20,'215503555','2022-07-23','2022-07-30');
CALL AddingValueManagerData(25,'Thompson','Valarie',36,'603555864','2022-08-01','2022-08-10');
CALL AddingValueManagerData(26,'Bennett','Helen ',38,'617555855','2022-08-15','2022-08-22');
CALL AddingValueManagerData(27,'Roulet','Annette' ,39,'656295556','2022-08-25','2022-08-31');
CALL AddingValueManagerData(28,'Messner','Renate ',43,'071155536','2022-09-01','2022-09-20');
CALL AddingValueManagerData(29,'Michal','Sidor',22,'567834212','2022-09-21','2022-09-30');

INSERT INTO deputy_manager(deputy_manager_surname, deputy_manager_name, deputy_manager_phone, deputy_manager_start_holiday, deputy_manager_end_holiday, manager_id)
VALUES
('Kowalewski','Michal','649553330','2022-07-22','2022-07-31',1),
('Snowden','Tony','649555550','2022-07-31','2022-08-02',2),
('Roel','José Pedro ','555882453','2022-01-01','2022-01-08',3),
('Semenov','Alexander ','781229305','2022-01-09','2022-01-15',4),
('Moos','Hanna ','062108555','2022-01-18','2022-01-25',5),
('Thompson','Steve','310555372','2022-01-26','2022-01-31',6),
('Ricotti','Franco','390225155','2022-02-01','2022-02-10',7),
('Clenahan','Sean','6193844655','2022-02-11','2022-02-22',8),
('Anton','Carmen','349137285','2022-02-03','2022-02-05',9),
('Benitez','Violeta','508555255','2022-03-03','2022-03-10',10),
('Ottlieb','Sven ','024103912','2022-03-11','2022-03-18',11),
('Sommer','Martín ','915552282','2022-03-20','2022-03-27',12),
('Choi','Yu','212555195','2022-03-31','2022-04-06',13),
('Murphy','Leslie','203555954','2022-04-07','2022-04-14',14),
('Mendel','Roland ','767535557','2022-04-15','2022-04-22',15),
('Frick','Sue','408555365','2022-04-21','2022-04-28',16),
('Larsson','Martha','069534655','2022-04-20','2022-04-25',17),
('Lewis','Dan','203555440','2022-05-03','2022-05-08',18),
('Feuer','Alexander ','034255517','2022-05-12','2022-05-19',19),
('Hernandez','Maria','212555849','2022-05-20','2022-05-23',20),
('Donnermeyer','Michael','498961089','2022-05-24','2022-05-31',21),
('McRoy','Sarah','044999555','2022-06-01','2022-06-05',22),
('Müller','Rita ','071155536','2022-03-15','2022-03-19',23),
('Perrier','Dominique','475565552','2022-06-10','2022-06-20',24),
('Shimamura','Akiko','813358405','2022-06-22','2022-06-30',25),
('Moroni','Maurizio ','052255655','2022-07-01','2022-07-22',26),
('Cruz','Arnold','632555358','2022-07-02','2022-07-06',27),
('Pipps','Georg ','656295552','2022-07-20','2022-08-01',28),
('Cartrain','Pascale ','071236725','2022-08-20','2022-08-24',29);

-- I am inserting in four parts because I wanna have diffrent default values situation.
INSERT INTO renovation_company_data(renovation_company_name,ceo_name,ceo_surname,number_of_employees)
VALUES
('Raion','Mateusz','Kowalewski',12),
('Mikronika','Mariusz','Bonczyk',20),
('EIStat','Andrzej','Adnrzejewski',3);
INSERT INTO renovation_company_data(renovation_company_name,ceo_name,ceo_surname)
VALUES
('GoProAutomatyka','Drapikowski','Bak'),
('Mikrobest','Wiktor','Dragan');
INSERT INTO renovation_company_data(renovation_company_name,ceo_surname,number_of_employees)
VALUES
('AP Automatyka','Ksiezak',17),
('OMERATO','Alehin',8),
('SCD AUTOMATION','Kasparov',5),
('rob-tech','Kacper',9),
('ASC Technologie','Jaskolka',11);
 INSERT INTO renovation_company_data(renovation_company_name,ceo_surname)
VALUES
('B&R Automatyka Przemyslowa','Karpisz'),
('ProcessDiagnosticCompany','Wiktorowicz'),
('AFK Automatyka','Makar'),
('PLC','Molopon'),
('AutomotionCompression','Ginner');

-- -------- FINISH OF INSERT STATMENTS -------------------------

-- -------- CREATING VIEWS -------------------------------------
-- 1
CREATE VIEW manager_company_view AS
SELECT company_name, manager_name, manager_surname
FROM manager INNER JOIN industrial_hall_data
ON manager.industrial_hall_token = industrial_hall_data.industrial_hall_token
INNER JOIN car_company_data
ON industrial_hall_data.car_company_id = car_company_data.car_company_id
WHERE company_name = 'BMW';

-- 2
CREATE VIEW deputy_manager_harder_task AS
SELECT deputy_manager_name, deputy_manager_surname, num_of_employees, city
FROM deputy_manager INNER JOIN  manager 
ON deputy_manager.manager_id = manager.manager_id 
INNER JOIN industrial_hall_data 
ON manager.industrial_hall_token = industrial_hall_data.industrial_hall_token
INNER JOIN car_company_data 
ON industrial_hall_data.car_company_id = car_company_data.car_company_id 
WHERE post_code LIKE '%00%' AND area BETWEEN 10 AND 35
GROUP BY num_of_employees 
LIMIT 5;

-- 3
CREATE VIEW InformationVolkswagen AS
SELECT SUM(industrial_hall_data.num_of_employees) AS AllEmplyessVW,  SUM(industrial_hall_data.area) AS WholeAreaVW, COUNT(car_company_data.num_of_industrial_halls) AS NumberOfIndustrialHallsVW
FROM industrial_hall_data INNER JOIN car_company_data
ON industrial_hall_data.car_company_id = car_company_data.car_company_id
WHERE car_company_data.company_name LIKE '%V%';

-- 4
CREATE VIEW InformationBMW AS
SELECT SUM(industrial_hall_data.num_of_employees) AS AllEmplyessBMW,  SUM(industrial_hall_data.area) AS WholeAreaBMW, COUNT(car_company_data.num_of_industrial_halls) AS NumberOfIndustrialHallsBMW
FROM industrial_hall_data INNER JOIN car_company_data
ON industrial_hall_data.car_company_id = car_company_data.car_company_id
WHERE car_company_data.company_name LIKE '%BM%';

-- 5
CREATE VIEW InformationMitsubishi AS
SELECT SUM(industrial_hall_data.num_of_employees) AS AllEmplyessMB,  SUM(industrial_hall_data.area) AS WholeAreaMB, COUNT(car_company_data.num_of_industrial_halls) AS NumberOfIndustrialHallsMB
FROM industrial_hall_data INNER JOIN car_company_data
ON industrial_hall_data.car_company_id = car_company_data.car_company_id
WHERE car_company_data.company_name LIKE '%Mi%';
