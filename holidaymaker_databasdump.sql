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

-- Data exporting was unselected.

-- Dumping structure for table holidaymaker_database.addons
CREATE TABLE IF NOT EXISTS `addons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `price` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

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

-- Data exporting was unselected.

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

-- Data exporting was unselected.

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

-- Data exporting was unselected.

-- Dumping structure for table holidaymaker_database.customers
CREATE TABLE IF NOT EXISTS `customers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `nhs_number` varchar(10) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

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

-- Data exporting was unselected.

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

-- Data exporting was unselected.

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

-- Data exporting was unselected.

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

-- Data exporting was unselected.

-- Dumping structure for table holidaymaker_database.sizes
CREATE TABLE IF NOT EXISTS `sizes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `size_name` varchar(50) NOT NULL,
  `price` float NOT NULL,
  `max_guests` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
