-- creare tabel Aerodrome

DROP TABLE IF EXISTS `aerodrome`;

CREATE TABLE `aerodrome` (
  `ID_aerodrome` int NOT NULL,
  `Aerodrome_name` varchar(45) NOT NULL,
  `Aerodrome_city` varchar(45) NOT NULL,
  PRIMARY KEY (`ID_aerodrome`),
  UNIQUE KEY `Aerodrome_name_UNIQUE` (`Aerodrome_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `aerodrome` WRITE;

INSERT INTO `aerodrome` VALUES 
  (1001,'SuperWings','Tuzla'),
  (1002,'CoolWings','Bucuresti'),
  (1003,'CoolerWings','Bucuresti'),
  (1004,'AirTurbo','Toplita'),
  (1005,'Eagles','Buzau'),
  (1006,'NorthPower','Focsani'),
  (1007,'PlaneMax','Iasi'),
  (1008,'Courage','Cluj'),
  (1009,'WesternClouds','Timisoara'),
  (1010,'BoysFromArad','Arad'),
  (1011,'BeachBreeze','Constanta'),
  (1012,'CloudOcean','Constanta'),
  (1013,'Aladin','Arad');

UNLOCK TABLES;

-- creare tabel ranks

DROP TABLE IF EXISTS `ranks`;

CREATE TABLE `ranks` (
  `ID_rank` int NOT NULL,
  `number_jumps` int NOT NULL,
  `rank_name` varchar(45) NOT NULL,
  PRIMARY KEY (`ID_rank`),
  UNIQUE KEY `ID_rank_UNIQUE` (`ID_rank`),
  UNIQUE KEY `number_jumps_UNIQUE` (`number_jumps`),
  UNIQUE KEY `rank_name_UNIQUE` (`rank_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `ranks` WRITE;

INSERT INTO `ranks` VALUES 
  (1,5000,'Boss'),
  (2,4000,'General'),
  (3,2000,'Locotenent'),
  (4,1000,'Leader'),
  (5,10,'Student');

UNLOCK TABLES;

-- creare tabel skydiver

DROP TABLE IF EXISTS `skydiver`;

CREATE TABLE `skydiver` (
  `ID_skydiver` int NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `nr_jumps` int NOT NULL,
  `mail` varchar(45) NOT NULL,
  `ID_aerodrome` int NOT NULL,
  `ID_rank` int NOT NULL,
  `ID_boss` int DEFAULT NULL,
  PRIMARY KEY (`ID_skydiver`),
  UNIQUE KEY `ID_skydiver_UNIQUE` (`ID_skydiver`),
  UNIQUE KEY `mail_UNIQUE` (`mail`),
  KEY `ID_rank_skydiver_idx` (`ID_rank`),
  KEY `ID_aerodrome_skydiver_idx` (`ID_aerodrome`),
  KEY `ID_boss_skydiver_idx` (`ID_boss`),
  KEY `full_name` (`last_name`,`first_name`),
  CONSTRAINT `ID_aerodrome_skydiver` FOREIGN KEY (`ID_aerodrome`) REFERENCES `aerodrome` (`ID_aerodrome`),
  CONSTRAINT `ID_boss_skydiver` FOREIGN KEY (`ID_boss`) REFERENCES `skydiver` (`ID_skydiver`),
  CONSTRAINT `ID_rank_skydiver` FOREIGN KEY (`ID_rank`) REFERENCES `ranks` (`ID_rank`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `skydiver` WRITE;

INSERT INTO `skydiver` VALUES 
  (101,'Cosmin','Bejan',5422,'cosminlucain44@gmail.com',1004,1,NULL),
  (102,'Andrei','Raucescu',4855,'andrei2408@gmail.com',1001,2,101),
  (103,'Constantin','Maricic',4855,'const@gmail.com',1002,2,101),
  (104,'Lucian','Popescu',4767,'luc_pop@gmail.com',1003,2,101),
  (105,'Robert','Ionescu',3863,'robert77@gmail.com',1004,3,102),
  (106,'Bogdan','Raucescu',3502,'bogdan1112@gmail.com',1005,3,102),
  (107,'Lucian','Suto',3675,'sutoo@gmail.com',1006,3,102),
  (108,'Bogdan','Demsa',3128,'bogdand@gmail.com',1007,3,102),
  (109,'Lucian','Montenegro',2801,'montenulucian@gmail.com',1008,3,103),
  (110,'Matei','California',2569,'mateicali@gmail.com',1009,3,103),
  (111,'Matei','Summer',2345,'matei899@gmail.com',1010,3,103),
  (112,'Daniel','Popescu',2111,'dany@gmail.com',1011,3,103),
  (113,'Bogdan','Racheta',2050,'bogdd_rachet@gmail.com',1012,3,103),
  (114,'Stefan','Blacescu',1867,'stefanul@gmail.com',1011,4,112),
  (115,'Alexandru','Blagescu',1856,'alexx_bos@gmail.com',1011,4,112),
  (116,'Robert','Blagescu',1823,'robert456@gmail.com',1006,4,111),
  (117,'Stefan','Mortescu',1590,'stefanmort@gmail.com',1006,4,111),
  (118,'Robert','Ionescu',1304,'roby7@gmail.com',1006,4,110),
  (119,'Daniel','Dobrot',1245,'altdani@gmail.com',1005,4,110),
  (120,'Robert','Colac',505,'robertcolac@gmail.com',1005,5,NULL),
  (121,'Bogdan','Covrig',456,'bogdanul@gmail.com',1005,5,NULL),
  (122,'Matei','Martin',452,'marti@gmail.com',1005,5,NULL),
  (123,'Lucian','Moara',443,'lucian_maora@gmail.com',1006,5,NULL),
  (124,'Daniel','Popescu',365,'danie_55@gmail.com',1006,5,NULL),
  (125,'Bogdan','Mincinosu',334,'mincinosul@gmail.com',1006,5,NULL),
  (126,'Matei','Calendar',312,'callendar_matei@gmail.com',1011,5,NULL),
  (127,'Lucian','Popescu',289,'popesculucian@gmail.com',1011,5,NULL),
  (128,'Alexandru','Roca',278,'alexxx5@gmail.com',1011,5,NULL),
  (129,'Bogdan','Ionescu',221,'bogdan_ion7@gmail.com',1011,5,NULL),
  (130,'Robert','Piatra',150,'piatra_rob@gmail.com',1011,5,NULL),
  (131,'Florin','Mar',1800,'florin88@gmail.com',1013,4,NULL);

UNLOCK TABLES;

-- creare tabel plane 

DROP TABLE IF EXISTS `plane`;

CREATE TABLE `plane` (
  `ID_plane` int NOT NULL,
  `age` int NOT NULL,
  `Model` varchar(45) NOT NULL,
  `ID_aerodrome` int NOT NULL,
  `ID_camera` int DEFAULT NULL,
  PRIMARY KEY (`ID_plane`),
  UNIQUE KEY `ID_plane_UNIQUE` (`ID_plane`),
  KEY `ID_aerodrome_idx` (`ID_aerodrome`),
  KEY `ID_camera_plane_idx` (`ID_camera`),
  CONSTRAINT `ID_aerodrome_plane` FOREIGN KEY (`ID_aerodrome`) REFERENCES `aerodrome` (`ID_aerodrome`),
  CONSTRAINT `ID_camera_plane` FOREIGN KEY (`ID_camera`) REFERENCES `camera` (`ID_camera`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `plane` WRITE;

INSERT INTO `plane` VALUES 
  (1,10,'TeslaS',1001,10101),
  (2,15,'TeslaX',1002,10104),
  (3,15,'TeslaS',1012,10103),
  (4,15,'TeslaX',1003,10102),
  (5,10,'BlueAir',1004,10105),
  (6,12,'BlueAir',1009,10109),
  (7,13,'Cromozone',1006,10108),
  (8,12,'BlueAir',1007,10110),
  (9,12,'BlueAir',1005,NULL),
  (10,12,'Cromozone',1008,10106),
  (11,15,'TeslaS',1010,10107);

UNLOCK TABLES;

-- creare tabel camera 

DROP TABLE IF EXISTS `camera`;

CREATE TABLE `camera` (
  `ID_camera` int NOT NULL AUTO_INCREMENT,
  `frequency` int NOT NULL,
  `company` varchar(45) NOT NULL,
  PRIMARY KEY (`ID_camera`)
) ENGINE=InnoDB AUTO_INCREMENT=10120 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `camera` WRITE;

INSERT INTO `camera` VALUES 
  (10101,30,'Sony'),
  (10102,30,'Nokia'),
  (10103,40,'Nokia'),
  (10104,40,'Nokia'),
  (10105,30,'Nokia'),
  (10106,45,'GoPro'),
  (10107,45,'GoPro'),
  (10108,45,'Sony'),
  (10109,40,'GoPro'),
  (10110,40,'Nokia'),
  (10116,45,'Samsung'),
  (10118,45,'Samsung'),
  (10119,45,'Samsung');

UNLOCK TABLES;


-- creare tabel pilot 

DROP TABLE IF EXISTS `pilot`;

CREATE TABLE `pilot` (
  `ID_pilot` int NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `age` int NOT NULL,
  `hours_flight` int NOT NULL,
  `mail` varchar(45) NOT NULL,
  `ID_aerodrome` int NOT NULL,
  PRIMARY KEY (`ID_pilot`),
  UNIQUE KEY `ID_pilot_UNIQUE` (`ID_pilot`),
  UNIQUE KEY `mail_UNIQUE` (`mail`),
  KEY `ID_Aerodrome_idx` (`ID_aerodrome`),
  CONSTRAINT `ID_aerodrome` FOREIGN KEY (`ID_aerodrome`) REFERENCES `aerodrome` (`ID_aerodrome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `pilot` WRITE;

INSERT INTO `pilot` VALUES 
  (10,'Andrei','Marian',50,700,'a_marian@gmail.com',1002),
  (11,'Gabriel','Muresan',48,500,'f_mures@gmail.com',1001),
  (12,'Gabriel','Buzatu',48,520,'gabriel_buz@gmail.com',1007),
  (13,'Mircea','Tospe',49,580,'mirceatospe15@gmail.com',1012),
  (14,'Maricel','Gheorghe',55,800,'mariceeeel@gmail.com',1011),
  (15,'Andrei','Morariu',52,760,'andreimoarriu15@gmail.com',1008),
  (16,'Vlad','Munteanu',45,490,'vlac_mun99@gmail.com',1002),
  (17,'Mircea','Tomescu',60,700,'m_t@gmail.com',1002);

UNLOCK TABLES;

-- creare tabel parachute 

DROP TABLE IF EXISTS `parachute`;

CREATE TABLE `parachute` (
  `ID_parachute` int NOT NULL,
  `porosity` decimal(5,4) NOT NULL,
  `wingspan` decimal(5,1) NOT NULL,
  `loading` int NOT NULL,
  `company` varchar(45) NOT NULL,
  PRIMARY KEY (`ID_parachute`),
  UNIQUE KEY `ID_parachute_UNIQUE` (`ID_parachute`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `parachute` WRITE;

INSERT INTO `parachute` VALUES 
  (201,0.0005,2.8,120,'Curv'),
  (202,0.0007,2.8,110,'Curv'),
  (203,0.0006,2.8,120,'Vector'),
  (204,0.0007,3.0,150,'Vector'),
  (205,0.0006,3.0,155,'Vector'),
  (206,0.0007,3.0,155,'Curv'),
  (207,0.0006,3.0,155,'Vector'),
  (208,0.0007,3.0,155,'Curv'),
  (209,0.0007,2.8,125,'Robotx'),
  (210,0.0006,2.8,125,'Robotx'),
  (211,0.0007,2.8,125,'Robotx'),
  (212,0.0006,2.8,140,'Curv'),
  (213,0.0006,2.8,125,'Robotx'),
  (214,0.0005,3.0,155,'Robotx'),
  (215,0.0005,3.0,155,'Robotx'),
  (216,0.0006,3.0,150,'Robotx'),
  (217,0.0007,3.0,150,'Robotx'),
  (218,0.0005,3.0,155,'Wingair'),
  (219,0.0005,3.0,155,'Wingair'),
  (220,0.0006,2.8,140,'Wingair'),
  (221,0.0007,2.8,140,'Wingair'),
  (222,0.0006,2.8,140,'Wingair');

UNLOCK TABLES;

-- creare tabel testing 


DROP TABLE IF EXISTS `testing`;

CREATE TABLE `testing` (
  `ID_plane` int NOT NULL,
  `ID_pilot` int NOT NULL,
  `time` int NOT NULL,
  `review` varchar(45) NOT NULL,
  PRIMARY KEY (`ID_plane`,`ID_pilot`),
  KEY `ID_pilot_test_idx` (`ID_pilot`),
  CONSTRAINT `ID_pilot_test` FOREIGN KEY (`ID_pilot`) REFERENCES `pilot` (`ID_pilot`),
  CONSTRAINT `ID_plane_test` FOREIGN KEY (`ID_plane`) REFERENCES `plane` (`ID_plane`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `testing` WRITE;

INSERT INTO `testing` VALUES 
    (1,10,20,'acceptable'),
    (1,11,15,'acceptable'),
    (1,12,20,'good'),
    (1,13,20,'perfect'),
    (1,14,20,'perfect'),
    (1,15,20,'perfect'),
    (1,16,20,'perfect'),
    (1,17,20,'perfect'),
    (2,10,20,'perfect'),
    (2,11,15,'acceptable'),
    (2,12,15,'good'),
    (2,13,20,'good'),
    (2,14,20,'perfect'),
    (2,15,20,'perfect'),
    (2,16,20,'perfect'),
    (2,17,20,'perfect'),
    (3,10,20,'perfect'),
    (3,11,20,'perfect'),
    (3,12,15,'acceptable'),
    (3,13,20,'good'),
    (3,14,20,'good'),
    (3,15,20,'perfect'),
    (3,16,20,'perfect'),
    (3,17,20,'perfect'),
    (4,10,20,'perfect'),
    (4,11,20,'perfect'),
    (4,12,20,'perfect'),
    (4,13,20,'acceptable'),
    (4,14,15,'good'),
    (4,15,15,'acceptable'),
    (4,16,20,'perfect'),
    (4,17,20,'perfect'),
    (5,10,20,'perfect'),
    (5,11,20,'perfect'),
    (5,12,20,'perfect'),
    (5,13,20,'perfect'),
    (5,14,15,'acceptable'),
    (5,15,15,'good'),
    (5,16,18,'good'),
    (5,17,20,'perfect'),
    (6,10,18,'good'),
    (6,11,20,'perfect'),
    (6,12,20,'perfect'),
    (6,13,20,'perfect'),
    (6,14,20,'perfect'),
    (6,15,18,'good'),
    (6,16,18,'good'),
    (6,17,20,'perfect'),
    (7,10,18,'good'),
    (7,11,18,'good'),
    (7,12,20,'perfect'),
    (7,13,20,'perfect'),
    (7,14,20,'perfect'),
    (7,15,20,'perfect'),
    (7,16,18,'good'),
    (7,17,20,'perfect'),
    (8,10,18,'perfect'),
    (8,11,18,'good'),
    (8,12,20,'perfect'),
    (8,13,20,'perfect'),
    (8,14,20,'perfect'),
    (8,15,20,'perfect'),
    (8,16,20,'perfect'),
    (8,17,20,'perfect'),
    (9,10,20,'perfect'),
    (9,11,20,'good'),
    (9,12,18,'good'),
    (9,13,20,'acceptable'),
    (9,14,20,'perfect'),
    (9,15,20,'perfect'),
    (9,16,20,'perfect'),
    (9,17,20,'perfect'),
    (10,10,20,'perfect'),
    (10,11,20,'perfect'),
    (10,12,20,'good'),
    (10,13,18,'perfect'),
    (10,14,20,'good'),
    (10,15,20,'perfect'),
    (10,16,20,'perfect'),
    (10,17,20,'perfect'),
    (11,10,20,'perfect'),
    (11,11,20,'perfect'),
    (11,12,20,'perfect'),
    (11,13,18,'perfect'),
    (11,14,18,'good'),
    (11,15,20,'perfect'),
    (11,16,20,'perfect'),
    (11,17,20,'perfect');

UNLOCK TABLES;

-- creare tabel flights 


DROP TABLE IF EXISTS `flights`;

CREATE TABLE `flights` (
  `ID_flights` int NOT NULL,
  `altitude` int NOT NULL,
  `temperature` int NOT NULL,
  `date` datetime NOT NULL,
  `ID_plane` int NOT NULL,
  `ID_pilot` int NOT NULL,
  PRIMARY KEY (`ID_flights`),
  UNIQUE KEY `ID_flights_UNIQUE` (`ID_flights`),
  KEY `ID_plane_flight_idx` (`ID_plane`),
  KEY `ID_pilot_flight_idx` (`ID_pilot`),
  CONSTRAINT `ID_pilot_flight` FOREIGN KEY (`ID_pilot`) REFERENCES `pilot` (`ID_pilot`),
  CONSTRAINT `ID_plane_flight` FOREIGN KEY (`ID_plane`) REFERENCES `plane` (`ID_plane`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `flights` WRITE;

INSERT INTO `flights` VALUES 
  (1,1800,25,'2021-05-29 12:00:00',1,10),
  (2,1800,25,'2021-05-29 12:00:00',2,11),
  (3,1800,25,'2021-05-29 13:00:00',3,12),
  (4,1800,24,'2021-05-29 14:00:00',4,13),
  (5,1800,24,'2021-05-29 15:00:00',5,14),
  (6,1800,24,'2021-05-29 15:00:00',6,15),
  (7,1800,26,'2021-05-30 10:00:00',7,16),
  (8,1800,26,'2021-05-30 10:00:00',8,10),
  (9,2000,26,'2021-05-30 11:00:00',9,11),
  (10,2000,23,'2021-05-30 11:00:00',10,12),
  (11,2000,24,'2021-05-30 12:00:00',11,13),
  (12,2000,23,'2021-05-30 13:00:00',1,14),
  (13,2000,23,'2021-05-31 12:00:00',2,15),
  (14,2000,23,'2021-05-31 13:00:00',3,16),
  (15,2400,24,'2021-05-31 13:00:00',4,10),
  (16,2400,24,'2021-05-31 14:00:00',5,11),
  (17,2400,22,'2021-05-31 15:00:00',6,11);

UNLOCK TABLES;

-- creare tabel skydiver_flights


DROP TABLE IF EXISTS `skydiver_flights`;

CREATE TABLE `skydiver_flights` (
  `ID_skydiver` int NOT NULL,
  `ID_parachute` int NOT NULL,
  `ID_flight` int NOT NULL,
  `review` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID_skydiver`,`ID_parachute`,`ID_flight`),
  KEY `ID_flight_flights_idx` (`ID_flight`),
  KEY `ID_parachute_flights_idx` (`ID_parachute`),
  CONSTRAINT `ID_flight_flights` FOREIGN KEY (`ID_flight`) REFERENCES `flights` (`ID_flights`),
  CONSTRAINT `ID_parachute_flights` FOREIGN KEY (`ID_parachute`) REFERENCES `parachute` (`ID_parachute`),
  CONSTRAINT `ID_skydiver_flights` FOREIGN KEY (`ID_skydiver`) REFERENCES `skydiver` (`ID_skydiver`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `skydiver_flights` WRITE;

INSERT INTO `skydiver_flights` VALUES (101,213,17,NULL),(101,217,4,NULL),(101,218,11,NULL),(101,219,14,NULL),(101,219,16,NULL),(101,221,9,NULL),(101,222,5,'dangerouse'),(102,201,8,NULL),(102,205,3,NULL),(102,218,16,NULL),(102,219,12,NULL),(102,220,15,NULL),(102,221,5,NULL),(103,202,2,NULL),(103,214,8,NULL),(103,217,16,NULL),(103,220,5,NULL),(103,220,12,NULL),(103,221,15,NULL),(104,204,2,NULL),(104,215,6,'perfect'),(104,216,16,NULL),(104,217,14,NULL),(105,206,13,NULL),(105,207,1,NULL),(105,214,6,NULL),(105,215,17,NULL),(105,218,14,NULL),(105,222,9,NULL),(106,201,9,NULL),(106,206,3,NULL),(106,209,13,NULL),(106,213,6,NULL),(106,214,17,NULL),(107,201,6,NULL),(107,208,7,NULL),(107,208,13,NULL),(107,211,17,'extraordinary'),(108,207,7,NULL),(108,210,13,NULL),(108,210,17,NULL),(109,202,9,NULL),(109,206,7,NULL),(109,209,17,NULL),(109,211,13,NULL),(110,205,4,NULL),(110,212,13,NULL),(110,212,17,NULL),(111,203,9,NULL),(111,213,14,NULL),(111,214,11,NULL),(111,218,4,NULL),(112,201,4,'nice'),(112,213,11,NULL),(113,202,4,NULL),(113,211,10,NULL),(113,212,11,NULL),(114,203,4,NULL),(114,210,10,NULL),(114,211,6,NULL),(115,204,4,NULL),(115,209,10,NULL),(115,210,6,NULL),(116,206,1,NULL),(116,208,10,NULL),(116,209,6,NULL),(116,215,8,NULL),(116,216,3,NULL),(117,207,10,'nice'),(117,215,3,NULL),(117,220,16,NULL),(118,206,10,NULL),(118,206,16,NULL),(118,214,3,NULL),(119,205,10,NULL),(119,205,16,NULL),(119,213,3,NULL),(120,204,15,NULL),(120,207,3,NULL),(120,215,11,NULL),(120,220,9,'beautiful'),(121,213,2,NULL),(121,217,11,NULL),(121,219,8,NULL),(122,203,15,NULL),(122,211,2,NULL),(122,216,5,NULL),(122,216,11,NULL),(122,218,8,NULL),(123,202,12,NULL),(123,204,9,NULL),(123,210,2,NULL),(123,214,14,NULL),(123,217,5,NULL),(123,217,8,NULL),(124,203,12,NULL),(124,205,13,NULL),(124,209,2,NULL),(124,216,8,NULL),(124,218,5,NULL),(125,202,7,NULL),(125,204,12,NULL),(125,208,2,NULL),(125,215,14,NULL),(125,219,5,NULL),(126,205,1,NULL),(126,216,14,NULL),(127,204,1,NULL),(128,202,15,NULL),(128,203,1,NULL),(128,203,7,NULL),(129,201,12,NULL),(129,201,15,NULL),(129,202,1,NULL),(129,204,7,NULL),(130,201,1,'cool'),(130,205,7,NULL),(130,221,12,NULL),(130,222,15,NULL);

UNLOCK TABLES;




