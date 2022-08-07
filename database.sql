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
DROP PROCEDURE IF EXISTS renovation_managment_system.AddingValueArea;
DROP PROCEDURE IF EXISTS renovation_managment_system.AddingValueManager;


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
    deputy_manager_phone VARCHAR(100) NOT NULL,
    deputy_manager_start_holiday DATE DEFAULT '1000-01-01',
    deputy_manager_end_holiday DATE DEFAULT '1000-01-01',
    manager_id INT UNSIGNED NOT NULL,
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

-- PROCEDURY -- 

DELIMITER //
CREATE PROCEDURE renovation_managment_system.AddingValues_if1 ()
BEGIN
INSERT INTO industrial_hall_data(car_company_id,industrial_hall_token)
SELECT car_company_id,CONCAT(LEFT(company_name,1) ,LEFT(city,3), RIGHT(post_code,2),'-1') as Wynik
FROM car_company_data;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE renovation_managment_system.AddingValues_if2 ()
BEGIN
INSERT INTO industrial_hall_data(car_company_id,industrial_hall_token)
SELECT car_company_id,CONCAT(LEFT(company_name,1) ,LEFT(city,3), RIGHT(post_code,2),'-2') as Wynik
FROM car_company_data
WHERE num_of_industrial_halls > 1;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE renovation_managment_system.AddingValues_if3 ()
BEGIN
INSERT INTO industrial_hall_data(car_company_id,industrial_hall_token)
SELECT car_company_id,CONCAT(LEFT(company_name,1) ,LEFT(city,3), RIGHT(post_code,2),'-3') as Wynik
FROM car_company_data
WHERE num_of_industrial_halls > 2;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE renovation_managment_system.AddingValues_if4 ()
BEGIN
INSERT INTO industrial_hall_data(car_company_id,industrial_hall_token)
SELECT car_company_id, CONCAT(LEFT(company_name,1) ,LEFT(city,3), RIGHT(post_code,2),'-4') as Wynik
FROM car_company_data
WHERE num_of_industrial_halls > 3;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE renovation_managment_system.AddingValueArea (IN id INT, IN size INT, IN n_of_emp INT)
BEGIN
UPDATE industrial_hall_data
SET 
area = size,
num_of_employees = n_of_emp
WHERE industrial_hall_id = id;
END//
DELIMITER ;

-- KONIEC PROCEDUR ----------------------------------------------------------------------------------------

Call renovation_managment_system.AddingValues_if1();
ALTER TABLE renovation_managment_system.industrial_hall_data AUTO_INCREMENT = 1;
Call renovation_managment_system.AddingValues_if2();
ALTER TABLE renovation_managment_system.industrial_hall_data AUTO_INCREMENT = 1;
Call renovation_managment_system.AddingValues_if3();
ALTER TABLE renovation_managment_system.industrial_hall_data AUTO_INCREMENT = 1;
Call renovation_managment_system.AddingValues_if4();

UPDATE renovation_managment_system.industrial_hall_data
SET industrial_hall_token = UPPER(industrial_hall_token);


Call renovation_managment_system.AddingValueArea(1,50,8000);
Call renovation_managment_system.AddingValueArea(2,39,7000);
Call renovation_managment_system.AddingValueArea(3,20,3000);
Call renovation_managment_system.AddingValueArea(4,15,2000);
Call renovation_managment_system.AddingValueArea(5,16,15000);
Call renovation_managment_system.AddingValueArea(6,18,5000);
Call renovation_managment_system.AddingValueArea(7,21,800);
Call renovation_managment_system.AddingValueArea(8,10,300);
Call renovation_managment_system.AddingValueArea(9,8,600);
Call renovation_managment_system.AddingValueArea(10,13,300);
Call renovation_managment_system.AddingValueArea(11,14,700);
Call renovation_managment_system.AddingValueArea(12,16,1500);
Call renovation_managment_system.AddingValueArea(13,19,2000);
Call renovation_managment_system.AddingValueArea(14,22,2300);
Call renovation_managment_system.AddingValueArea(15,27,3400);
Call renovation_managment_system.AddingValueArea(16,26,8000);
Call renovation_managment_system.AddingValueArea(17,24,9100);
Call renovation_managment_system.AddingValueArea(18,22,11000);
Call renovation_managment_system.AddingValueArea(19,20,2300);
Call renovation_managment_system.AddingValueArea(20,16,10300);
Call renovation_managment_system.AddingValueArea(21,17,500);
Call renovation_managment_system.AddingValueArea(22,19,300);
Call renovation_managment_system.AddingValueArea(23,30,1000);
Call renovation_managment_system.AddingValueArea(24,21,4800);
Call renovation_managment_system.AddingValueArea(25,35,2200);
Call renovation_managment_system.AddingValueArea(26,43,700);
Call renovation_managment_system.AddingValueArea(27,40,950);
Call renovation_managment_system.AddingValueArea(28,45,13400);
Call renovation_managment_system.AddingValueArea(29,60,5300);


DELIMITER //
CREATE PROCEDURE renovation_managment_system.AddingValueManager()
BEGIN
INSERT INTO manager(industrial_hall_token,industrial_hall_id)
SELECT industrial_hall_token,industrial_hall_id 
FROM industrial_hall_data;
END//
DELIMITER ;

CALL renovation_managment_system.AddingValueManager();

DELIMITER //
CREATE PROCEDURE renovation_managment_system.AddingValueManagerData (IN id INT,IN nm VARCHAR(50), IN sn VARCHAR(50), IN ag INT, IN pn VARCHAR(50), IN sh DATE,IN eh DATE)
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

Call renovation_managment_system.AddingValueManagerData(1,'Schmitt','Carine ',20,'508555955','2022-10-01','2022-10-07');
Call renovation_managment_system.AddingValueManagerData(2,'King','Jean',30,'617555855','2022-10-08','2022-10-15');
Call renovation_managment_system.AddingValueManagerData(3,'Nelson','Susan',42,'412642550','2022-10-16','2022-10-23');
Call renovation_managment_system.AddingValueManagerData(4,'Bergulfsen','Jonas',31,'089703455','2022-10-24','2022-10-31');
Call renovation_managment_system.AddingValueManagerData(5,'Labrune','Janine',28,'422121555','2022-11-01','2022-11-08');
Call renovation_managment_system.AddingValueManagerData(6,'Keitel','Roland',25,'312049195','2022-11-09','2022-11-16');
Call renovation_managment_system.AddingValueManagerData(7,'Piestrzeniewicz','Zbyszek',26,'030007455','2022-11-17','2022-11-24');
Call renovation_managment_system.AddingValueManagerData(8,'Freyre','Diego',45,'702555183','2022-11-25','2022-11-30');
Call renovation_managment_system.AddingValueManagerData(9,'Murphy','Julie',55,'039520455','2022-12-01','2022-12-08');
Call renovation_managment_system.AddingValueManagerData(10,'Saveley','Mary',44,'415555145','2022-12-09','2022-12-15');
Call renovation_managment_system.AddingValueManagerData(11,'Rancé','Martin',23,'642755536','2022-12-20','2022-12-27');
Call renovation_managment_system.AddingValueManagerData(12,'Frick','Michael',33,'499669025','2022-12-02','2022-12-05');
Call renovation_managment_system.AddingValueManagerData(13,'Taylor','Leslie',44,'312049195','2022-05-01','2022-05-09');
Call renovation_managment_system.AddingValueManagerData(14,'Cassidy','Dean',55,'030007455','2022-05-10','2022-05-17');
Call renovation_managment_system.AddingValueManagerData(15,'Walker','Brydey',66,'981443655','2022-05-20','2022-05-27');
Call renovation_managment_system.AddingValueManagerData(16,'Michal','Kowalski',56,'508555955','2022-05-02','2022-05-20');
Call renovation_managment_system.AddingValueManagerData(17,'Citeaux','Frédérique',67, '650555138','2022-06-01','2022-06-20');
Call renovation_managment_system.AddingValueManagerData(18,'Gao','Mike',34,'649125555','2022-06-05','2022-06-12');
Call renovation_managment_system.AddingValueManagerData(19,'Saavedra','Eduardo ',23,'201555935','2022-06-21','2022-06-28');
Call renovation_managment_system.AddingValueManagerData(20,'Young','Mary',48,'358980455','2022-06-14','2022-06-21');
Call renovation_managment_system.AddingValueManagerData(21,'Kloss','Horst ',49,'215555469','2022-07-01','2022-07-10');
Call renovation_managment_system.AddingValueManagerData(22,'Ibsen','Palle',50,'215555436','2022-07-14','2022-07-21');
Call renovation_managment_system.AddingValueManagerData(23,'Camino','Alejandra',51,'296755458','2022-07-22','2022-07-29');
Call renovation_managment_system.AddingValueManagerData(24,'Fresnière','Jean ',20,'215503555','2022-07-23','2022-07-30');
Call renovation_managment_system.AddingValueManagerData(25,'Thompson','Valarie',36,'603555864','2022-08-01','2022-08-10');
Call renovation_managment_system.AddingValueManagerData(26,'Bennett','Helen ',38,'617555855','2022-08-15','2022-08-22');
Call renovation_managment_system.AddingValueManagerData(27,'Roulet','Annette' ,39,'656295556','2022-08-25','2022-08-31');
Call renovation_managment_system.AddingValueManagerData(28,'Messner','Renate ',43,'071155536','2022-09-01','2022-09-20');
Call renovation_managment_system.AddingValueManagerData(29,'Michal','Sidor',22,'567834212','2022-09-21','2022-09-30');

INSERT INTO renovation_managment_system.deputy_manager(deputy_manager_surname, deputy_manager_name, deputy_manager_phone, deputy_manager_start_holiday, deputy_manager_end_holiday, manager_id)
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
