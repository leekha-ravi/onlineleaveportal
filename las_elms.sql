-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Mar 29, 2024 at 06:29 AM
-- Server version: 8.2.0
-- PHP Version: 8.2.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `las_elms`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
CREATE TABLE IF NOT EXISTS `admin` (
  `id` int NOT NULL AUTO_INCREMENT,
  `UserName` varchar(100) NOT NULL,
  `Password` varchar(100) NOT NULL,
  `updationDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `UserName`, `Password`, `updationDate`) VALUES
(1, 'admin', '21232f297a57a5a743894a0e4a801fc3', '2024-03-25 15:20:13');

-- --------------------------------------------------------

--
-- Table structure for table `tblallowedleaves`
--

DROP TABLE IF EXISTS `tblallowedleaves`;
CREATE TABLE IF NOT EXISTS `tblallowedleaves` (
  `relation_id` int NOT NULL AUTO_INCREMENT,
  `leavetype_id` int NOT NULL,
  `allowed_leaves` int NOT NULL,
  `employee_id` int NOT NULL,
  PRIMARY KEY (`relation_id`)
) ENGINE=MyISAM AUTO_INCREMENT=124 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `tblallowedleaves`
--

INSERT INTO `tblallowedleaves` (`relation_id`, `leavetype_id`, `allowed_leaves`, `employee_id`) VALUES
(123, 9, 8, 40),
(122, 6, 8, 40),
(121, 5, 15, 40),
(120, 9, 8, 39),
(119, 6, 8, 39),
(118, 5, 20, 39),
(117, 9, 8, 38),
(116, 6, 8, 38),
(115, 5, 20, 38);

-- --------------------------------------------------------

--
-- Table structure for table `tbldepartments`
--

DROP TABLE IF EXISTS `tbldepartments`;
CREATE TABLE IF NOT EXISTS `tbldepartments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `DepartmentName` varchar(150) DEFAULT NULL,
  `DepartmentShortName` varchar(100) DEFAULT NULL,
  `DepartmentCode` varchar(50) DEFAULT NULL,
  `CreationDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbldepartments`
--

INSERT INTO `tbldepartments` (`id`, `DepartmentName`, `DepartmentShortName`, `DepartmentCode`, `CreationDate`) VALUES
(1, 'Computer', 'Computer', 'Computer', '2023-08-31 14:50:20'),
(2, 'Commerce', 'Commerce', 'Commerce', '2023-08-31 14:50:56'),
(3, 'Physics', 'Physics', 'Physics', '2023-08-31 14:51:26'),
(4, 'Commerce', 'Commerce', 'Commerce', '2023-09-01 11:35:50');

-- --------------------------------------------------------

--
-- Table structure for table `tblemployees`
--

DROP TABLE IF EXISTS `tblemployees`;
CREATE TABLE IF NOT EXISTS `tblemployees` (
  `id` int NOT NULL AUTO_INCREMENT,
  `EmpId` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `FirstName` varchar(150) DEFAULT NULL,
  `LastName` varchar(150) DEFAULT NULL,
  `EmailId` varchar(200) DEFAULT NULL,
  `Password` varchar(180) DEFAULT NULL,
  `Gender` varchar(100) DEFAULT NULL,
  `Doj` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `Department` varchar(255) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `City` varchar(200) DEFAULT NULL,
  `Country` varchar(150) DEFAULT NULL,
  `Phonenumber` char(11) DEFAULT NULL,
  `Status` int DEFAULT NULL,
  `RegDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `designation` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblemployees`
--

INSERT INTO `tblemployees` (`id`, `EmpId`, `FirstName`, `LastName`, `EmailId`, `Password`, `Gender`, `Doj`, `Department`, `Address`, `City`, `Country`, `Phonenumber`, `Status`, `RegDate`, `designation`) VALUES
(38, '101', 'shaina', 'jindal', 'shaina@gmail.com', '174d43714e3e034559217732eacb63b0', 'Male', '', 'Computer', 'jalandhar', 'Jalandhar', 'India', '9464338997', 1, '2024-03-26 04:28:42', 'Assistant Professor'),
(39, '102', 'leekha', 'jindal', 'leekha@gmail.com', '174d43714e3e034559217732eacb63b0', 'Female', '2013-02-26', 'Computer', 'jalandhar', 'Jalandhar', 'India', '9464338997', 1, '2024-03-26 04:31:29', 'Assistant Professor'),
(40, 'e106', 'Kappish', 'Jindal', 'kappish@gmail.com', '174d43714e3e034559217732eacb63b0', 'Male', '2019-03-26', 'Commerce', 'Jalandhar', 'jalandhar', 'india', '9464338997', 0, '2024-03-26 08:31:33', 'Associate Professor');

-- --------------------------------------------------------

--
-- Table structure for table `tblleaves`
--

DROP TABLE IF EXISTS `tblleaves`;
CREATE TABLE IF NOT EXISTS `tblleaves` (
  `id` int NOT NULL AUTO_INCREMENT,
  `LeaveType` int DEFAULT NULL,
  `ToDate` datetime DEFAULT NULL,
  `FromDate` datetime DEFAULT NULL,
  `Description` mediumtext,
  `PostingDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `AdminRemark` mediumtext,
  `AdminRemarkDate` varchar(120) DEFAULT NULL,
  `Status` int DEFAULT NULL,
  `IsRead` int DEFAULT NULL,
  `empid` int DEFAULT NULL,
  `nod` decimal(10,1) NOT NULL,
  `session` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `UserEmail` (`empid`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblleaves`
--

INSERT INTO `tblleaves` (`id`, `LeaveType`, `ToDate`, `FromDate`, `Description`, `PostingDate`, `AdminRemark`, `AdminRemarkDate`, `Status`, `IsRead`, `empid`, `nod`, `session`) VALUES
(32, 5, '2024-04-04 00:00:00', '2024-04-03 00:00:00', 'urgent work', '2024-03-26 10:07:03', NULL, NULL, 0, 0, 39, 2.0, '2023-2024'),
(33, 5, '2024-04-07 00:00:00', '2024-04-06 00:00:00', 'urgent work', '2024-03-26 10:07:50', NULL, NULL, 1, 0, 39, 2.0, '2023-2024'),
(34, 5, '2024-06-07 00:00:00', '2024-06-06 00:00:00', 'urgent work', '2024-03-26 10:10:20', NULL, NULL, 1, 0, 39, 2.0, '2023-2024'),
(35, 5, '2024-04-06 00:00:00', '2024-04-05 00:00:00', 'urgent', '2024-03-26 10:11:25', NULL, NULL, 1, 0, 39, 2.0, '2023-2024'),
(36, 5, '2024-05-05 00:00:00', '2024-05-04 00:00:00', 'urgent work', '2024-03-26 10:13:07', NULL, NULL, 1, 0, 39, 2.0, '2023-2024'),
(40, 5, '2024-03-29 00:00:00', '2024-03-28 00:00:00', 'urgent work', '2024-03-26 10:22:42', NULL, NULL, 1, 0, 38, 2.0, '2023-2024'),
(46, 5, '2024-03-31 00:00:00', '2024-03-30 00:00:00', 'urgent work', '2024-03-26 13:38:00', NULL, NULL, 1, 0, 39, 2.0, '2023-2024'),
(47, 5, '2024-03-31 00:00:00', '2024-03-30 00:00:00', 'urgent work', '2024-03-26 13:39:43', NULL, NULL, 1, 1, 38, 2.0, '2023-2024'),
(48, 5, '2024-03-31 00:00:00', '2024-03-30 00:00:00', 'urgent work', '2024-03-27 22:02:58', 'your leave has been approved', '2024-03-27 22:04:31 ', 1, 1, 39, 2.0, '2023-2024'),
(49, 5, '2024-03-31 00:00:00', '2024-03-30 00:00:00', 'urgent work', '2024-03-28 17:05:58', NULL, '2024-03-28 17:14:15 ', 1, 1, 39, 2.0, '2023-2024');

-- --------------------------------------------------------

--
-- Table structure for table `tblleavetype`
--

DROP TABLE IF EXISTS `tblleavetype`;
CREATE TABLE IF NOT EXISTS `tblleavetype` (
  `id` int NOT NULL AUTO_INCREMENT,
  `LeaveType` varchar(200) DEFAULT NULL,
  `Description` mediumtext,
  `CreationDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `inner_name` varchar(250) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblleavetype`
--

INSERT INTO `tblleavetype` (`id`, `LeaveType`, `Description`, `CreationDate`, `inner_name`) VALUES
(5, 'Casual', 'Casual', '2024-03-02 07:22:35', 'casual'),
(6, 'P-Leave', 'P-Leave', '2024-03-02 07:22:59', 'pleave'),
(7, 'First Half', 'First Half', '2024-03-02 07:23:23', 'firsthalf'),
(8, 'Second Half', 'Second Half', '2024-03-02 07:23:49', 'secondhalf'),
(9, 'Medical', 'Medical', '2024-03-02 07:24:07', 'medical');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
