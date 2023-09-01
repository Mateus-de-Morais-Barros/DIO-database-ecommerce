-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: ifood
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `id` int NOT NULL AUTO_INCREMENT,
  `postal_code` varchar(45) DEFAULT NULL,
  `state` varchar(45) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `street` varchar(45) DEFAULT NULL,
  `number` varchar(45) DEFAULT NULL,
  `country` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,'82736432','RJ','Rio de Janeiro','Rua 1','1281','Brasil'),(2,'8272332','MG','Belo Horizonte','Rua 53','3725','Brasil'),(3,'92971583','SP','São Paulo','Rua 578','5222','Brasil'),(4,'33333333','AC','Rio Branco','Rua 01','0001','Brasil'),(5,'12345-678','SP','São Paulo','Rua das Flores','123','Brasil'),(6,'78900-123','RO','Porto Velho','Avenida Amazônia','456','Brasil'),(7,'90000-789','RS','Porto Alegre','Rua da Liberdade','789','Brasil'),(8,'89000-456','RS','Porto Alegre','Avenida Central','4567','Brasil'),(9,'67000-123','PA','Belém','Rua da Amazônia','789','Brasil');
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria` (
  `id` int NOT NULL AUTO_INCREMENT,
  `categoria` enum('PF','PJ') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'PF'),(2,'PJ');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(20) NOT NULL COMMENT 'adicionar constraint de unicidade para nome completo',
  `middle_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `email` varchar(255) NOT NULL,
  `birthdate` date NOT NULL,
  `categoria_id` int NOT NULL,
  PRIMARY KEY (`id`,`categoria_id`),
  UNIQUE KEY `idCliente_UNIQUE` (`id`),
  UNIQUE KEY `Email_UNIQUE` (`email`),
  KEY `fk_customer_categoria1_idx` (`categoria_id`),
  CONSTRAINT `fk_customer_categoria1` FOREIGN KEY (`categoria_id`) REFERENCES `categoria` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Elise','Gamas','Roof','ultimacliente@gmail.com','2003-07-10',1),(2,'Mateus','Silva','Santos','mateussantos123@gmail.com','2001-01-18',1),(3,'Jerson','Mendes','Matos','matossantos12223@gmail.com','2010-12-08',1),(4,'Claudio','Jadir','Minotauro','minomino@gmail.com','1980-10-23',2),(5,'Tolueno','Batista','Campos','tolucampos@gmail.com','2003-05-13',2);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_address`
--

DROP TABLE IF EXISTS `customer_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_address` (
  `id` int NOT NULL AUTO_INCREMENT,
  `address_id` int NOT NULL,
  `customer_id` int NOT NULL,
  PRIMARY KEY (`id`,`address_id`,`customer_id`),
  KEY `fk_customer_address_address1_idx` (`address_id`),
  KEY `fk_customer_address_customer1_idx` (`customer_id`),
  CONSTRAINT `fk_customer_address_address1` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`),
  CONSTRAINT `fk_customer_address_customer1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_address`
--

LOCK TABLES `customer_address` WRITE;
/*!40000 ALTER TABLE `customer_address` DISABLE KEYS */;
INSERT INTO `customer_address` VALUES (7,1,5),(5,2,4),(1,3,1),(4,4,3),(2,5,2),(6,6,5),(3,7,1);
/*!40000 ALTER TABLE `customer_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `food_order`
--

DROP TABLE IF EXISTS `food_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `food_order` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `restaurant_id` int NOT NULL,
  `customer_address_id` int NOT NULL,
  `order_status_id` int NOT NULL,
  `payment_method_id` int NOT NULL,
  `order_description` varchar(255) DEFAULT NULL,
  `delivery_fee` varchar(45) DEFAULT NULL,
  `order_request_datetime` datetime NOT NULL,
  `total_amount` varchar(45) NOT NULL,
  `tracking_code` varchar(45) NOT NULL,
  PRIMARY KEY (`id`,`customer_id`,`restaurant_id`,`customer_address_id`,`order_status_id`,`payment_method_id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_Pedido_Cliente1_idx` (`customer_id`),
  KEY `fk_Food_Order_Restaurant1_idx` (`restaurant_id`),
  KEY `fk_food_order_customer_address1_idx` (`customer_address_id`),
  KEY `fk_food_order_order_status1_idx` (`order_status_id`),
  KEY `fk_food_order_payment_method1_idx` (`payment_method_id`),
  CONSTRAINT `fk_food_order_customer_address1` FOREIGN KEY (`customer_address_id`) REFERENCES `customer_address` (`id`),
  CONSTRAINT `fk_food_order_order_status1` FOREIGN KEY (`order_status_id`) REFERENCES `order_status` (`id`),
  CONSTRAINT `fk_food_order_payment_method1` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_method` (`id`),
  CONSTRAINT `fk_Food_Order_Restaurant1` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurant` (`id`),
  CONSTRAINT `fk_Pedido_Cliente1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `food_order`
--

LOCK TABLES `food_order` WRITE;
/*!40000 ALTER TABLE `food_order` DISABLE KEYS */;
INSERT INTO `food_order` VALUES (1,1,1,7,4,1,NULL,'5.99','2023-09-01 12:30:00','30,89','TRK001'),(2,1,1,7,4,1,NULL,'5.99','2023-09-01 12:30:00','25,89','TRK001'),(3,2,1,5,1,2,NULL,'4.25','2023-09-01 14:20:00','34,05','TRK002'),(4,3,2,4,2,1,NULL,'6.99','2023-09-01 15:10:00','28,89','TRK003'),(5,3,2,4,2,1,NULL,'6.99','2023-09-01 15:10:00','42,79','TRK003'),(6,4,1,2,3,3,NULL,'4.50','2023-09-01 17:30:00','24,40','TRK004'),(7,5,1,1,4,2,NULL,'7.25','2023-09-01 18:15:00','51,95','TRK005'),(8,5,2,6,1,1,NULL,'3.99','2023-09-01 19:20:00','47,79','TRK006'),(9,5,2,6,1,1,NULL,'3.99','2023-09-01 19:20:00','17,89','TRK006');
/*!40000 ALTER TABLE `food_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_item`
--

DROP TABLE IF EXISTS `menu_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_item` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `price` float NOT NULL,
  `status` enum('Available','Unavailable') NOT NULL DEFAULT 'Available',
  `restaurant_id` int NOT NULL,
  PRIMARY KEY (`id`,`restaurant_id`),
  UNIQUE KEY `Items_UNIQUE` (`name`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_Menu_Item_Restaurant1_idx` (`restaurant_id`),
  CONSTRAINT `fk_Menu_Item_Restaurant1` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurant` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_item`
--

LOCK TABLES `menu_item` WRITE;
/*!40000 ALTER TABLE `menu_item` DISABLE KEYS */;
INSERT INTO `menu_item` VALUES (1,'Avassalador',19.9,'Available',1),(2,'XTudo',24.9,'Available',1),(3,'XQuase-Tudo',14.9,'Available',1),(4,'Queijão',21.9,'Available',2),(5,'Chocolate',17.9,'Available',2),(6,'Carne-seca',13.9,'Available',2);
/*!40000 ALTER TABLE `menu_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_menu_item`
--

DROP TABLE IF EXISTS `order_menu_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_menu_item` (
  `id` int NOT NULL AUTO_INCREMENT,
  `menu_item_id` int NOT NULL,
  `food_order_id` int NOT NULL,
  `quantity_ordered` varchar(45) NOT NULL,
  PRIMARY KEY (`id`,`menu_item_id`,`food_order_id`),
  KEY `fk_order_menu_item_Menu_Item1_idx` (`menu_item_id`),
  KEY `fk_order_menu_item_Food_Order1_idx` (`food_order_id`),
  CONSTRAINT `fk_order_menu_item_Food_Order1` FOREIGN KEY (`food_order_id`) REFERENCES `food_order` (`id`),
  CONSTRAINT `fk_order_menu_item_Menu_Item1` FOREIGN KEY (`menu_item_id`) REFERENCES `menu_item` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_menu_item`
--

LOCK TABLES `order_menu_item` WRITE;
/*!40000 ALTER TABLE `order_menu_item` DISABLE KEYS */;
INSERT INTO `order_menu_item` VALUES (1,2,1,'1'),(2,1,2,'1'),(3,3,3,'2'),(4,4,4,'1'),(5,5,5,'2'),(6,1,6,'1'),(7,3,7,'3'),(8,4,8,'2'),(9,6,9,'1');
/*!40000 ALTER TABLE `order_menu_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_status`
--

DROP TABLE IF EXISTS `order_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` enum('Processando','Preparando','À caminho','Entregue') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_status`
--

LOCK TABLES `order_status` WRITE;
/*!40000 ALTER TABLE `order_status` DISABLE KEYS */;
INSERT INTO `order_status` VALUES (1,'Processando'),(2,'Preparando'),(3,'À caminho'),(4,'Entregue');
/*!40000 ALTER TABLE `order_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_method`
--

DROP TABLE IF EXISTS `payment_method`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_method` (
  `id` int NOT NULL AUTO_INCREMENT,
  `payment_method` enum('credit','money','debit') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_method`
--

LOCK TABLES `payment_method` WRITE;
/*!40000 ALTER TABLE `payment_method` DISABLE KEYS */;
INSERT INTO `payment_method` VALUES (1,'credit'),(2,'money'),(3,'debit');
/*!40000 ALTER TABLE `payment_method` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurant`
--

DROP TABLE IF EXISTS `restaurant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurant` (
  `id` int NOT NULL,
  `res_name` varchar(45) DEFAULT NULL,
  `address_id` int NOT NULL,
  PRIMARY KEY (`id`,`address_id`),
  KEY `fk_Restaurant_Address1_idx` (`address_id`),
  CONSTRAINT `fk_Restaurant_Address1` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant`
--

LOCK TABLES `restaurant` WRITE;
/*!40000 ALTER TABLE `restaurant` DISABLE KEYS */;
INSERT INTO `restaurant` VALUES (1,'Hamburgueria Rezende',8),(2,'Pastel Arthurito',9);
/*!40000 ALTER TABLE `restaurant` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-09-01 17:40:34
