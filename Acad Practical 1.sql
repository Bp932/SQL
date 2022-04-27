
DROP DATABASE IF EXISTS `sql_dbmsprac_db`;
CREATE DATABASE `sql_dbmsprac_db`; 
USE `sql_dbmsprac_db`;

SET NAMES utf8 ;
SET character_set_client = utf8mb4 ;

CREATE TABLE `instructor` (
  `id` int(5) NOT NULL,
  `name` varchar(50) NOT NULL,
  `dept_name` varchar(50) NOT NULL,
  `salary` int(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `instructor` VALUES (10101,'Srinivasan','Comp.Sci.',65000);
INSERT INTO `instructor` VALUES (12121,'Wu','Finance',90000);
INSERT INTO `instructor` VALUES (15151,'Mozart','Music',40000);
INSERT INTO `instructor` VALUES (22222,'Einstein','Physics',95000);
INSERT INTO `instructor` VALUES (32343,'El Said','History',60000);
INSERT INTO `instructor` VALUES (33456,'Gold','Physics',87000);
INSERT INTO `instructor` VALUES (45565,'Katz','Comp.Sci.',75000);
INSERT INTO `instructor` VALUES (58583,'Califieri','History',62000);
INSERT INTO `instructor` VALUES (76543,'Singh','Finance',80000);
INSERT INTO `instructor` VALUES (76766,'Crick','Biology',72000);
INSERT INTO `instructor` VALUES (83821,'Brandt','Comp.Sci.',92000);
INSERT INTO `instructor` VALUES (98345,'Kim','Elec.Eng.',80000);


CREATE TABLE `teaches` (
  `id` int(5) NOT NULL,
  `course_id` varchar(10) NOT NULL,
  `sec_id` int(1) NOT NULL,
  `semester` varchar(10) NOT NULL,
  `year` date NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `teaches` VALUES (10101,'CS-101',1,'Fall','2017');
INSERT INTO `teaches` VALUES (10101,'CS-315',1,'Spring','2018');
INSERT INTO `teaches` VALUES (10101,'CS-347',1,'Fall','2017');
INSERT INTO `teaches` VALUES (12121,'FIN-201',1,'Spring','2018');
INSERT INTO `teaches` VALUES (15151,'MU-199',1,'Spring','2018');
INSERT INTO `teaches` VALUES (22222,'PHY-101',1,'Fall','2017');
INSERT INTO `teaches` VALUES (32343,'HIS-351',1,'Spring','2018');
INSERT INTO `teaches` VALUES (45565,'CS-101',1,'Spring','2018');
INSERT INTO `teaches` VALUES (45565,'CS-319',1,'Spring','2018');
INSERT INTO `teaches` VALUES (76766,'BIO-101',1,'Summer','2017');
INSERT INTO `teaches` VALUES (76766,'BIO-301',1,'Summer','2018');
INSERT INTO `teaches` VALUES (83821,'CS-190',1,'Spring','2017');
INSERT INTO `teaches` VALUES (83821,'CS-190',2,'Spring','2017');
INSERT INTO `teaches` VALUES (83821,'CS-319',2,'Spring','2018');
INSERT INTO `teaches` VALUES (98345,'EE-181',1,'Spring','2017');




ALTER TABLE `sql_dbmsprac_db`.`teaches` 
CHANGE COLUMN `year` `year` YEAR NOT NULL ;
