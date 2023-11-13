-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: futbolasir
-- ------------------------------------------------------
-- Server version	8.0.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `equipos`
--

DROP TABLE IF EXISTS `equipos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipos` (
  `id_equipo` int NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `estadio` varchar(50) DEFAULT NULL,
  `aforo` int DEFAULT NULL,
  `fundacion` int DEFAULT NULL,
  `ciudad` varchar(50) DEFAULT NULL,
  `anagrama` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id_equipo`),
  UNIQUE KEY `indice_equipos` (`id_equipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipos`
--

LOCK TABLES `equipos` WRITE;
/*!40000 ALTER TABLE `equipos` DISABLE KEYS */;
INSERT INTO `equipos` VALUES (1,'Real Madrid','Santiago Bernabeu',80000,1950,'Madrid',NULL),(2,'F.C. Barcelona','Camp Nou',70000,1948,'Barcelona',NULL),(3,'Valencia C.F','Mestalla',90000,1952,'Valencia',NULL),(4,'Atlético de Madrid','Vicente Calderón',55000,1945,'Madrid',NULL);
/*!40000 ALTER TABLE `equipos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goles`
--

DROP TABLE IF EXISTS `goles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `goles` (
  `id_equipo_casa` int DEFAULT NULL,
  `id_equipo_fuera` int DEFAULT NULL,
  `minuto` int DEFAULT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `id_jugador` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goles`
--

LOCK TABLES `goles` WRITE;
/*!40000 ALTER TABLE `goles` DISABLE KEYS */;
INSERT INTO `goles` VALUES (1,2,35,'De falta',2),(1,2,70,NULL,2),(1,2,88,NULL,4),(1,3,5,NULL,3),(1,3,10,'De penalti',2);
/*!40000 ALTER TABLE `goles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jugadores`
--

DROP TABLE IF EXISTS `jugadores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jugadores` (
  `id_jugador` int NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `fecha_nac` date DEFAULT NULL,
  `demarcacion` varchar(50) DEFAULT NULL,
  `internacional` int DEFAULT NULL,
  `id_equipo` int DEFAULT NULL,
  PRIMARY KEY (`id_jugador`),
  UNIQUE KEY `indice_jugadores` (`id_jugador`),
  KEY `id_equipo` (`id_equipo`),
  CONSTRAINT `id_equipo` FOREIGN KEY (`id_equipo`) REFERENCES `equipos` (`id_equipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jugadores`
--

LOCK TABLES `jugadores` WRITE;
/*!40000 ALTER TABLE `jugadores` DISABLE KEYS */;
INSERT INTO `jugadores` VALUES (1,'Iker','1980-05-09','Portero',50,1);
/*!40000 ALTER TABLE `jugadores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partidos`
--

DROP TABLE IF EXISTS `partidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `partidos` (
  `id_equipo_casa` int DEFAULT NULL,
  `id_equipo_fuera` int DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `goles_casa` int DEFAULT NULL,
  `goles_fuera` int DEFAULT NULL,
  `observaciones` varchar(200) DEFAULT NULL,
  `hora_partido` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partidos`
--

LOCK TABLES `partidos` WRITE;
/*!40000 ALTER TABLE `partidos` DISABLE KEYS */;
INSERT INTO `partidos` VALUES (1,2,'0003-03-14',2,1,NULL,NULL),(1,3,'0004-04-14',3,1,NULL,NULL),(2,3,'0003-04-14',0,4,NULL,NULL);
/*!40000 ALTER TABLE `partidos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-09-27 20:56:51
