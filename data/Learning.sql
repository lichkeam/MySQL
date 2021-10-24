-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- 主機： localhost:3306
-- 產生時間： 2021 年 10 月 24 日 00:34
-- 伺服器版本： 8.0.26-0ubuntu0.20.04.3
-- PHP 版本： 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 資料庫： `Learning`
--

-- --------------------------------------------------------

--
-- 資料表結構 `Course`
--

CREATE TABLE `Course` (
  `CId` varchar(10) DEFAULT NULL,
  `Cname` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `TId` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- 傾印資料表的資料 `Course`
--

INSERT INTO `Course` (`CId`, `Cname`, `TId`) VALUES
('01', '語文', '02'),
('02', '數學', '01'),
('03', '英語', '03');

-- --------------------------------------------------------

--
-- 資料表結構 `SC`
--

CREATE TABLE `SC` (
  `SId` varchar(10) DEFAULT NULL,
  `CId` varchar(10) DEFAULT NULL,
  `score` decimal(18,1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- 傾印資料表的資料 `SC`
--

INSERT INTO `SC` (`SId`, `CId`, `score`) VALUES
('01', '01', '80.0'),
('01', '02', '90.0'),
('01', '03', '99.0'),
('02', '01', '70.0'),
('02', '02', '60.0'),
('02', '03', '80.0'),
('03', '01', '80.0'),
('03', '02', '80.0'),
('03', '03', '80.0'),
('04', '01', '50.0'),
('04', '02', '30.0'),
('04', '03', '20.0'),
('05', '01', '76.0'),
('05', '02', '87.0'),
('06', '01', '31.0'),
('06', '03', '34.0'),
('07', '02', '89.0'),
('07', '03', '98.0');

-- --------------------------------------------------------

--
-- 資料表結構 `Student`
--

CREATE TABLE `Student` (
  `SId` varchar(10) DEFAULT NULL,
  `Sname` varchar(10) DEFAULT NULL,
  `Sage` datetime DEFAULT NULL,
  `Ssex` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- 傾印資料表的資料 `Student`
--

INSERT INTO `Student` (`SId`, `Sname`, `Sage`, `Ssex`) VALUES
('01', '趙雷', '1990-01-01 00:00:00', '男'),
('02', '錢電', '1990-12-21 00:00:00', '男'),
('03', '孫風', '1990-12-20 00:00:00', '男'),
('04', '李雲', '1990-12-06 00:00:00', '男'),
('05', '周梅', '1991-12-01 00:00:00', '女'),
('06', '吳蘭', '1992-01-01 00:00:00', '女'),
('07', '鄭竹', '1989-01-01 00:00:00', '女'),
('09', '張三', '2017-12-20 00:00:00', '女'),
('10', '李四', '2017-12-25 00:00:00', '女'),
('12', '趙六', '2013-06-13 00:00:00', '女'),
('13', '孫七', '2014-06-01 00:00:00', '女');

-- --------------------------------------------------------

--
-- 資料表結構 `Teacher`
--

CREATE TABLE `Teacher` (
  `TId` varchar(10) DEFAULT NULL,
  `Tname` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- 傾印資料表的資料 `Teacher`
--

INSERT INTO `Teacher` (`TId`, `Tname`) VALUES
('01', '張三'),
('02', '李四'),
('03', '王五');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
