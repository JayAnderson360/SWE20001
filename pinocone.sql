-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 19, 2022 at 04:38 PM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 8.0.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pinocone`
--

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `custID` int(10) NOT NULL,
  `cust_fname` varchar(30) DEFAULT NULL,
  `cust_lname` varchar(30) DEFAULT NULL,
  `cust_username` varchar(25) DEFAULT NULL,
  `cust_password` varchar(25) DEFAULT NULL,
  `gender` char(1) DEFAULT NULL CHECK (`gender` in ('M','F','U')),
  `hpNo` varchar(13) DEFAULT NULL,
  `cust_email` varchar(75) DEFAULT NULL,
  `cust_address` varchar(100) DEFAULT NULL,
  `membershipStatus` varchar(25) DEFAULT NULL,
  `regDate` datetime DEFAULT NULL,
  `expDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `foodcombo`
--

CREATE TABLE `foodcombo` (
  `comboID` int(2) NOT NULL,
  `comboPrice` decimal(4,2) DEFAULT NULL,
  `Remarks` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `fooditem`
--

CREATE TABLE `fooditem` (
  `itemID` int(3) NOT NULL,
  `itemName` varchar(25) NOT NULL,
  `itemPrice` decimal(4,2) DEFAULT NULL,
  `Description` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `menu`
--

CREATE TABLE `menu` (
  `itemID` int(3) DEFAULT NULL,
  `comboID` int(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `ordercombo`
--

CREATE TABLE `ordercombo` (
  `orderID` int(10) NOT NULL,
  `comboID` int(2) DEFAULT NULL,
  `quantity` int(3) DEFAULT NULL,
  `prepMethod` char(1) DEFAULT NULL CHECK (`prepMethod` in ('H','C'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `orderitem`
--

CREATE TABLE `orderitem` (
  `itemID` int(3) NOT NULL,
  `orderID` int(10) DEFAULT NULL,
  `quantity` int(3) DEFAULT NULL,
  `prepMethod` char(1) DEFAULT NULL CHECK (`prepMethod` in ('H','C'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `orderID` int(10) NOT NULL,
  `custID` int(10) DEFAULT NULL,
  `invoiceID` int(10) DEFAULT NULL,
  `orderTime` datetime DEFAULT NULL,
  `deliveryTime` datetime DEFAULT NULL,
  `orderStatus` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `invoiceID` int(10) NOT NULL,
  `orderID` int(10) DEFAULT NULL,
  `paymentDate` datetime DEFAULT NULL,
  `amountPaid` decimal(4,2) DEFAULT NULL,
  `paymethod` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`custID`);

--
-- Indexes for table `foodcombo`
--
ALTER TABLE `foodcombo`
  ADD PRIMARY KEY (`comboID`);

--
-- Indexes for table `fooditem`
--
ALTER TABLE `fooditem`
  ADD PRIMARY KEY (`itemID`);

--
-- Indexes for table `menu`
--
ALTER TABLE `menu`
  ADD KEY `FK2_menu` (`comboID`),
  ADD KEY `FK1_menu` (`itemID`);

--
-- Indexes for table `ordercombo`
--
ALTER TABLE `ordercombo`
  ADD KEY `FK1_ordercombo` (`comboID`),
  ADD KEY `FK2_ordercombo` (`orderID`);

--
-- Indexes for table `orderitem`
--
ALTER TABLE `orderitem`
  ADD KEY `FK2_orderitem` (`orderID`),
  ADD KEY `FK1_orderitem` (`itemID`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`orderID`),
  ADD KEY `FK1_orders` (`custID`),
  ADD KEY `FK2_orders` (`invoiceID`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`invoiceID`),
  ADD KEY `FK1_pay` (`orderID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `menu`
--
ALTER TABLE `menu`
  ADD CONSTRAINT `FK1_menu` FOREIGN KEY (`itemID`) REFERENCES `fooditem` (`itemID`),
  ADD CONSTRAINT `FK2_menu` FOREIGN KEY (`comboID`) REFERENCES `foodcombo` (`comboID`);

--
-- Constraints for table `ordercombo`
--
ALTER TABLE `ordercombo`
  ADD CONSTRAINT `FK1_ordercombo` FOREIGN KEY (`comboID`) REFERENCES `foodcombo` (`comboID`),
  ADD CONSTRAINT `FK2_ordercombo` FOREIGN KEY (`orderID`) REFERENCES `orders` (`orderID`);

--
-- Constraints for table `orderitem`
--
ALTER TABLE `orderitem`
  ADD CONSTRAINT `FK1_orderitem` FOREIGN KEY (`itemID`) REFERENCES `fooditem` (`itemID`),
  ADD CONSTRAINT `FK2_orderitem` FOREIGN KEY (`orderID`) REFERENCES `orders` (`orderID`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `FK1_orders` FOREIGN KEY (`custID`) REFERENCES `customers` (`custID`),
  ADD CONSTRAINT `FK2_orders` FOREIGN KEY (`invoiceID`) REFERENCES `payment` (`invoiceID`);

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `FK1_pay` FOREIGN KEY (`orderID`) REFERENCES `orders` (`orderID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
