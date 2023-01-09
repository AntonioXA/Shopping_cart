-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 25-03-2020 a las 20:20:56
-- Versión del servidor: 5.7.29-0ubuntu0.18.04.1
-- Versión de PHP: 7.2.24-0ubuntu0.18.04.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `addbooks`
--
CREATE DATABASE IF NOT EXISTS `addbooks` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `addbooks`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `AuthorISBN`
--

CREATE TABLE `AuthorISBN` (
  `AuthorID` int(11) NOT NULL,
  `ISBN` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `AuthorISBN`
--

INSERT INTO `AuthorISBN` (`AuthorID`, `ISBN`) VALUES
(1, '0131869000'),
(2, '0131869000'),
(1, '0131525239'),
(2, '0131525239'),
(1, '0132222205'),
(2, '0132222205'),
(1, '0131857576'),
(2, '0131857576'),
(1, '0132404168'),
(2, '0132404168'),
(1, '0131450913'),
(2, '0131450913'),
(3, '0131450913'),
(1, '0131828274'),
(2, '0131828274'),
(4, '0131828274');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Authors`
--

CREATE TABLE `Authors` (
  `AuthorID` int(11) NOT NULL,
  `FirstName` varchar(30) NOT NULL,
  `LastName` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `Authors`
--

INSERT INTO `Authors` (`AuthorID`, `FirstName`, `LastName`) VALUES
(1, 'Harvey', 'Deitel'),
(2, 'Paul', 'Deitel'),
(3, 'Andrew', 'Goldberg'),
(4, 'David', 'Choffnes');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user` varchar(50) NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `orders`
--

INSERT INTO `orders` (`id`, `user`, `date`) VALUES
(1, 'Prueba', '2019-04-25'),
(2, 'Prueba', '2019-04-25'),
(3, 'Prueba', '2019-04-25'),
(4, 'Prueba', '2019-04-25'),
(5, 'Prueba', '2019-04-25'),
(6, 'Prueba', '2019-04-25'),
(7, 'Prueba', '2019-04-25'),
(8, 'Prueba', '2019-04-25'),
(9, 'Prueba', '2019-04-25'),
(10, 'Miguel', '2019-04-30'),
(11, 'Prueba', '2020-03-23');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `order_details`
--

CREATE TABLE `order_details` (
  `id_order` int(11) NOT NULL,
  `order_line` int(11) NOT NULL,
  `isbn` varchar(20) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `order_details`
--

INSERT INTO `order_details` (`id_order`, `order_line`, `isbn`, `quantity`) VALUES
(7, 1, '34343434', 1),
(8, 1, '34343434', 2),
(9, 1, '34343434', 1),
(10, 1, '3343422234', 2),
(11, 1, '0132404168', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Titles`
--

CREATE TABLE `Titles` (
  `ISBN` varchar(20) NOT NULL,
  `Title` varchar(100) NOT NULL,
  `EditionNumber` int(11) NOT NULL,
  `Copyright` varchar(4) NOT NULL,
  `Quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `Titles`
--

INSERT INTO `Titles` (`ISBN`, `Title`, `EditionNumber`, `Copyright`, `Quantity`) VALUES
('0131450913', 'Internet & World Wide Web How to Program', 3, '2004', 1),
('0131525239', 'Visual C# 2005 How to Program', 2, '2006', 1),
('0131828274', 'Operating Systems', 3, '2004', 1),
('0131857576', 'C++ How to Program', 5, '2005', 1),
('0131869000', 'Visual Basic 2005 How to Program', 3, '2006', 1),
('0132222205', 'Java How to Program', 7, '2007', 0),
('0132404168', 'C How to Program', 5, '2007', 1),
('3343422234', 'prueba title', 2019, '33', 1),
('34343434', 'prueba', 2019, '334', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `AuthorISBN`
--
ALTER TABLE `AuthorISBN`
  ADD KEY `AuthorID` (`AuthorID`),
  ADD KEY `ISBN` (`ISBN`);

--
-- Indices de la tabla `Authors`
--
ALTER TABLE `Authors`
  ADD PRIMARY KEY (`AuthorID`);

--
-- Indices de la tabla `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`id_order`,`order_line`),
  ADD KEY `isbn` (`isbn`);

--
-- Indices de la tabla `Titles`
--
ALTER TABLE `Titles`
  ADD PRIMARY KEY (`ISBN`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `Authors`
--
ALTER TABLE `Authors`
  MODIFY `AuthorID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `AuthorISBN`
--
ALTER TABLE `AuthorISBN`
  ADD CONSTRAINT `AuthorISBN_ibfk_1` FOREIGN KEY (`AuthorID`) REFERENCES `Authors` (`AuthorID`),
  ADD CONSTRAINT `AuthorISBN_ibfk_2` FOREIGN KEY (`ISBN`) REFERENCES `Titles` (`ISBN`);

--
-- Filtros para la tabla `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `order_details_ibfk_1` FOREIGN KEY (`id_order`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `order_details_ibfk_2` FOREIGN KEY (`isbn`) REFERENCES `Titles` (`ISBN`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
