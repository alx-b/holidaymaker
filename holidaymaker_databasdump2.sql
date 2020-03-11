-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.7.29-log - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             10.3.0.5771
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table holidaymaker_database.access_to
CREATE TABLE IF NOT EXISTS `access_to` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `price` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Dumping data for table holidaymaker_database.access_to: ~4 rows (approximately)
/*!40000 ALTER TABLE `access_to` DISABLE KEYS */;
INSERT INTO `access_to` (`id`, `name`, `price`) VALUES
	(1, 'Pool', 10),
	(2, 'Evening Entertainment', 15.5),
	(3, 'Kid Club', 5.99),
	(4, 'Restaurant', 22);
/*!40000 ALTER TABLE `access_to` ENABLE KEYS */;

-- Dumping structure for table holidaymaker_database.addons
CREATE TABLE IF NOT EXISTS `addons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `price` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Dumping data for table holidaymaker_database.addons: ~3 rows (approximately)
/*!40000 ALTER TABLE `addons` DISABLE KEYS */;
INSERT INTO `addons` (`id`, `name`, `price`) VALUES
	(1, 'Extra Bed', 15),
	(2, 'Half-Board', 20),
	(3, 'Full-Board', 50);
/*!40000 ALTER TABLE `addons` ENABLE KEYS */;

-- Dumping structure for table holidaymaker_database.addresses
CREATE TABLE IF NOT EXISTS `addresses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `street` varchar(200) NOT NULL,
  `number` varchar(10) NOT NULL,
  `post_number` varchar(10) NOT NULL,
  `city` varchar(200) NOT NULL,
  `country` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Dumping data for table holidaymaker_database.addresses: ~5 rows (approximately)
/*!40000 ALTER TABLE `addresses` DISABLE KEYS */;
INSERT INTO `addresses` (`id`, `street`, `number`, `post_number`, `city`, `country`) VALUES
	(1, 'Becker', '2971', '351 06', 'Växjö', 'Sweden'),
	(2, 'Commercial', '805', '249716', 'Komsomol’skiy', 'Russia'),
	(3, 'Moose', '529', '5001', 'Balibagan Oeste', 'Philippines'),
	(4, 'Nancy', '603', '4939', 'Ardino', 'Bulgaria'),
	(5, 'Mariners Cove', '90', '691 06', 'Velké Pavlovice', 'Czech Republic');
/*!40000 ALTER TABLE `addresses` ENABLE KEYS */;

-- Dumping structure for table holidaymaker_database.bookings
CREATE TABLE IF NOT EXISTS `bookings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `begin_date` date NOT NULL,
  `end_date` date NOT NULL,
  `customer_id` int(10) unsigned NOT NULL,
  `room_id` int(10) unsigned NOT NULL,
  `place_id` int(10) unsigned NOT NULL,
  `total_guests` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk3_customer_id` (`customer_id`),
  KEY `fk4_place_id` (`place_id`),
  KEY `fk1_room_id` (`room_id`),
  CONSTRAINT `fk1_room_id` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk4_place_id` FOREIGN KEY (`place_id`) REFERENCES `places` (`id`) ON DELETE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;

-- Dumping data for table holidaymaker_database.bookings: ~30 rows (approximately)
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
INSERT INTO `bookings` (`id`, `begin_date`, `end_date`, `customer_id`, `room_id`, `place_id`, `total_guests`) VALUES
	(1, '2020-06-22', '2020-06-27', 1, 21, 5, 1),
	(2, '2020-07-14', '2020-07-18', 2, 17, 4, 3),
	(3, '2020-07-16', '2020-07-22', 3, 12, 3, 2),
	(4, '2020-06-28', '2020-07-02', 4, 2, 1, 2),
	(5, '2020-07-12', '2020-07-17', 5, 18, 4, 4),
	(6, '2020-07-28', '2020-07-31', 6, 10, 2, 3),
	(7, '2020-06-09', '2020-06-13', 7, 24, 5, 1),
	(8, '2020-06-09', '2020-06-15', 8, 22, 5, 1),
	(9, '2020-06-18', '2020-06-21', 9, 16, 4, 2),
	(10, '2020-07-01', '2020-07-07', 10, 22, 5, 1),
	(11, '2020-07-09', '2020-07-14', 11, 20, 4, 3),
	(12, '2020-07-04', '2020-07-08', 12, 2, 1, 4),
	(13, '2020-06-03', '2020-06-05', 13, 3, 1, 2),
	(14, '2020-07-09', '2020-07-12', 14, 2, 1, 2),
	(15, '2020-07-23', '2020-07-24', 15, 10, 2, 3),
	(16, '2020-07-27', '2020-07-29', 16, 27, 5, 2),
	(17, '2020-07-02', '2020-07-06', 17, 12, 3, 2),
	(18, '2020-07-04', '2020-07-05', 18, 9, 2, 3),
	(19, '2020-06-09', '2020-06-14', 19, 2, 1, 2),
	(20, '2020-07-05', '2020-07-12', 20, 4, 1, 3),
	(21, '2020-07-16', '2020-07-18', 21, 8, 2, 1),
	(22, '2020-06-04', '2020-06-11', 22, 19, 4, 3),
	(23, '2020-07-05', '2020-07-07', 23, 14, 4, 2),
	(24, '2020-06-27', '2020-06-29', 24, 26, 5, 2),
	(25, '2020-07-25', '2020-07-31', 25, 13, 3, 2),
	(26, '2020-07-08', '2020-07-11', 26, 11, 3, 1),
	(27, '2020-07-07', '2020-07-14', 27, 5, 1, 1),
	(28, '2020-06-14', '2020-06-18', 28, 3, 1, 2),
	(29, '2020-06-22', '2020-06-28', 29, 25, 5, 2),
	(30, '2020-06-02', '2020-06-06', 31, 9, 2, 3);
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;

-- Dumping structure for table holidaymaker_database.bookings_and_addons
CREATE TABLE IF NOT EXISTS `bookings_and_addons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `booking_id` int(10) unsigned NOT NULL,
  `addon_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk2_addon_id` (`addon_id`),
  KEY `fk1_booking_id` (`booking_id`),
  CONSTRAINT `fk1_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk2_addon_id` FOREIGN KEY (`addon_id`) REFERENCES `addons` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=latin1;

-- Dumping data for table holidaymaker_database.bookings_and_addons: ~33 rows (approximately)
/*!40000 ALTER TABLE `bookings_and_addons` DISABLE KEYS */;
INSERT INTO `bookings_and_addons` (`id`, `booking_id`, `addon_id`) VALUES
	(1, 1, NULL),
	(2, 2, NULL),
	(3, 3, 3),
	(4, 4, NULL),
	(5, 5, 2),
	(6, 6, NULL),
	(7, 7, 3),
	(8, 8, 3),
	(9, 9, 2),
	(10, 10, 2),
	(11, 11, 3),
	(12, 12, NULL),
	(13, 13, NULL),
	(14, 14, 3),
	(15, 15, 3),
	(16, 16, 3),
	(17, 17, NULL),
	(18, 18, 3),
	(19, 19, 2),
	(20, 20, 2),
	(21, 21, NULL),
	(22, 22, NULL),
	(23, 23, 2),
	(24, 24, NULL),
	(25, 25, 2),
	(26, 26, 3),
	(27, 27, 3),
	(28, 28, NULL),
	(29, 29, 3),
	(30, 5, 1),
	(31, 25, 1),
	(32, 12, 1),
	(33, 30, 3);
/*!40000 ALTER TABLE `bookings_and_addons` ENABLE KEYS */;

-- Dumping structure for table holidaymaker_database.customers
CREATE TABLE IF NOT EXISTS `customers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `nhs_number` varchar(10) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;

-- Dumping data for table holidaymaker_database.customers: ~31 rows (approximately)
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` (`id`, `name`, `last_name`, `nhs_number`) VALUES
	(1, 'Hersh', 'Ower', '0717243052'),
	(2, 'Claudell', 'Mc Faul', '3203077965'),
	(3, 'Kipper', 'Lenthall', '9185556394'),
	(4, 'Stacie', 'Fobidge', '0975599925'),
	(5, 'Renault', 'Crossgrove', '0714992402'),
	(6, 'Shanie', 'Seward', '0585464871'),
	(7, 'Jacklin', 'Shipcott', '9482908546'),
	(8, 'Terri', 'Piggott', '9869996477'),
	(9, 'Alix', 'Creamer', '1301280240'),
	(10, 'Arel', 'Depport', '4681536636'),
	(11, 'Nye', 'Ulrik', '6104292542'),
	(12, 'Garrot', 'Reichhardt', '1165795876'),
	(13, 'Hillel', 'Di Angelo', '3562196253'),
	(14, 'Mikel', 'Grishanov', '7600451638'),
	(15, 'Jodi', 'Ravenhill', '3044571219'),
	(16, 'Meara', 'Feldberg', '7117490519'),
	(17, 'Evelin', 'Biaggioli', '4002358135'),
	(18, 'Manda', 'Stearne', '1769520686'),
	(19, 'Kendra', 'Cicchinelli', '1618939041'),
	(20, 'Bel', 'Habershon', '8647339282'),
	(21, 'Lauren', 'Gilby', '9853965143'),
	(22, 'Mureil', 'Quick', '7735448783'),
	(23, 'Fredelia', 'Mynott', '0066926211'),
	(24, 'Ax', 'Colling', '7346183983'),
	(25, 'Fredra', 'Grimwad', '0972683437'),
	(26, 'Osmund', 'Brixey', '9322931841'),
	(27, 'Alexia', 'Franzen', '3278529499'),
	(28, 'Halsy', 'Cancott', '7175864132'),
	(29, 'Milicent', 'Bettleson', '4471515756'),
	(30, 'Agathe', 'Mesant', '8733478872'),
	(31, 'Barry', 'Boyle', '0120102301');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;

-- Dumping structure for table holidaymaker_database.places
CREATE TABLE IF NOT EXISTS `places` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `beach_distance_km` float DEFAULT NULL,
  `address_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk1_address_id` (`address_id`),
  CONSTRAINT `fk1_address_id` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Dumping data for table holidaymaker_database.places: ~5 rows (approximately)
/*!40000 ALTER TABLE `places` DISABLE KEYS */;
INSERT INTO `places` (`id`, `name`, `beach_distance_km`, `address_id`) VALUES
	(1, 'Park Meadow', 19.79, 1),
	(2, 'Thierer', 1.19, 2),
	(3, 'Buell', 13.43, 3),
	(4, 'Emmet', 10.14, 4),
	(5, 'Onsgard', 0.88, 5);
/*!40000 ALTER TABLE `places` ENABLE KEYS */;

-- Dumping structure for table holidaymaker_database.places_and_access
CREATE TABLE IF NOT EXISTS `places_and_access` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `place_id` int(10) unsigned NOT NULL,
  `access_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk1_access_id` (`access_id`),
  KEY `fk0_place_id` (`place_id`),
  CONSTRAINT `fk0_place_id` FOREIGN KEY (`place_id`) REFERENCES `places` (`id`),
  CONSTRAINT `fk1_access_id` FOREIGN KEY (`access_id`) REFERENCES `access_to` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

-- Dumping data for table holidaymaker_database.places_and_access: ~12 rows (approximately)
/*!40000 ALTER TABLE `places_and_access` DISABLE KEYS */;
INSERT INTO `places_and_access` (`id`, `place_id`, `access_id`) VALUES
	(1, 1, 1),
	(2, 2, 2),
	(3, 2, 4),
	(4, 3, 3),
	(5, 3, 1),
	(6, 4, 2),
	(7, 4, 3),
	(8, 4, 4),
	(9, 5, 1),
	(10, 5, 2),
	(11, 5, 3),
	(12, 5, 4);
/*!40000 ALTER TABLE `places_and_access` ENABLE KEYS */;

-- Dumping structure for table holidaymaker_database.reviews
CREATE TABLE IF NOT EXISTS `reviews` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `place_rating` int(10) unsigned NOT NULL,
  `review_text` text,
  `customer_id` int(10) unsigned NOT NULL,
  `place_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk1_place_id` (`place_id`),
  KEY `fk2_customer_id` (`customer_id`),
  CONSTRAINT `fk1_place_id` FOREIGN KEY (`place_id`) REFERENCES `places` (`id`),
  CONSTRAINT `fk2_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table holidaymaker_database.reviews: ~0 rows (approximately)
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;

-- Dumping structure for table holidaymaker_database.rooms
CREATE TABLE IF NOT EXISTS `rooms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `room_number` varchar(10) NOT NULL,
  `size_id` int(10) unsigned NOT NULL,
  `place_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk1_size_id` (`size_id`),
  KEY `fk2_place_id` (`place_id`),
  CONSTRAINT `fk1_size_id` FOREIGN KEY (`size_id`) REFERENCES `sizes` (`id`),
  CONSTRAINT `fk2_place_id` FOREIGN KEY (`place_id`) REFERENCES `places` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;

-- Dumping data for table holidaymaker_database.rooms: ~29 rows (approximately)
/*!40000 ALTER TABLE `rooms` DISABLE KEYS */;
INSERT INTO `rooms` (`id`, `room_number`, `size_id`, `place_id`) VALUES
	(1, '101', 1, 1),
	(2, '201', 2, 1),
	(3, '202', 2, 1),
	(4, '301', 3, 1),
	(5, '102', 1, 1),
	(6, '1101', 1, 2),
	(7, '1201', 2, 2),
	(8, '1202', 1, 2),
	(9, '1301', 3, 2),
	(10, '1302', 3, 2),
	(11, '01', 1, 3),
	(12, '02', 2, 3),
	(13, '03', 2, 3),
	(14, '2001', 2, 4),
	(15, '2002', 2, 4),
	(16, '2003', 2, 4),
	(17, '2101', 3, 4),
	(18, '2102', 3, 4),
	(19, '2201', 3, 4),
	(20, '2202', 3, 4),
	(21, '11', 1, 5),
	(22, '12', 1, 5),
	(23, '13', 1, 5),
	(24, '14', 1, 5),
	(25, '31', 2, 5),
	(26, '32', 2, 5),
	(27, '33', 2, 5),
	(28, '51', 3, 5),
	(29, '52', 3, 5);
/*!40000 ALTER TABLE `rooms` ENABLE KEYS */;

-- Dumping structure for table holidaymaker_database.sizes
CREATE TABLE IF NOT EXISTS `sizes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `size_name` varchar(50) NOT NULL,
  `price` float NOT NULL,
  `max_guests` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Dumping data for table holidaymaker_database.sizes: ~3 rows (approximately)
/*!40000 ALTER TABLE `sizes` DISABLE KEYS */;
INSERT INTO `sizes` (`id`, `size_name`, `price`, `max_guests`) VALUES
	(1, 'Single', 50, 1),
	(2, 'Double', 90, 2),
	(3, 'Suite', 200, 4);
/*!40000 ALTER TABLE `sizes` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
