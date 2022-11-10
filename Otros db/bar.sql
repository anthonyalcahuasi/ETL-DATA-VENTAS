-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 10-11-2022 a las 04:55:39
-- Versión del servidor: 10.4.24-MariaDB
-- Versión de PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bar`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `Cat_id` int(11) NOT NULL,
  `Nom_cat` varchar(100) NOT NULL,
  `Fam_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`Cat_id`, `Nom_cat`, `Fam_id`) VALUES
(1, 'Cervezas de fermentación alta', 1),
(2, 'Cervezas de fermentación baja o lagers', 1),
(3, 'Cervezas de fermentación espontánea o Lámbicas', 1),
(4, 'Vodka', 2),
(5, 'Ron', 2),
(6, 'Gin', 2),
(7, 'Whisky', 2),
(8, 'Tequila', 2),
(9, 'Aperitivos', 3),
(10, 'Digestivos', 3),
(11, 'Refrescantes', 3),
(12, 'Reconstruyentes', 3),
(13, 'Estimulantes', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `Cli_id` int(11) NOT NULL,
  `Nom_cli` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`Cli_id`, `Nom_cli`) VALUES
(1, 'Consumidor');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `familia`
--

CREATE TABLE `familia` (
  `Fam_id` int(11) NOT NULL,
  `Nom_fam` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `familia`
--

INSERT INTO `familia` (`Fam_id`, `Nom_fam`) VALUES
(1, 'Cerveza'),
(2, 'Trago'),
(3, 'Coctel');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `Prod_id` int(11) NOT NULL,
  `Cod_prod` varchar(100) NOT NULL,
  `Nom_prod` varchar(100) NOT NULL,
  `Concent` varchar(100) DEFAULT NULL,
  `Presentac` varchar(100) DEFAULT NULL,
  `Fracciones` varchar(100) DEFAULT NULL,
  `Prec_compra` decimal(9,2) DEFAULT NULL,
  `Prec_venta` decimal(9,2) DEFAULT NULL,
  `Cat_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`Prod_id`, `Cod_prod`, `Nom_prod`, `Concent`, `Presentac`, `Fracciones`, `Prec_compra`, `Prec_venta`, `Cat_id`) VALUES
(1, '3', 'Backus', '1lt', 'caja plastico x12 unidades', '20', '6.00', '12.00', 2),
(2, '5', 'Backus', '1lt', 'caja plastico x12 unidades', '20', '6.00', '12.00', 2),
(3, '6', 'Backus', '600ml', 'paquete x6 unidades', '30', '5.00', '12.00', 2),
(4, '95', 'Backus', '500ml', 'paquete x6 unidades', '30', '3.00', '6.00', 2),
(5, '96', 'BM Licores', '330ml', 'paquete x4 unidades', '20', '5.00', '10.00', 4),
(6, '102', 'BM Licores', '1lt', 'caja x12 unidades', '5', '26.00', '37.00', 4),
(7, '108', 'BM Licores', '1lt', 'caja x12 unidades', '5', '17.00', '26.00', 4),
(8, '138', 'BM Licores', '1lt', 'caja x12 unidades', '5', '50.00', '67.00', 4),
(9, '151', 'BM Licores', '750ml', 'caja x6 unidades', '5', '47.00', '65.00', 4),
(10, '165', 'BM Licores', '750ml', 'caja x6 unidades', '5', '45.00', '60.00', 4),
(11, '166', 'Zenith', '355ml', 'caja x18 unidades', '3', '11.00', '17.00', 1),
(12, '176', 'Barbarian', '330ml', 'caja x18 unidades', '3', '11.00', '17.00', 1),
(13, '180', 'Viuda', '330ml', 'caja x18 unidades', '3', '11.00', '17.00', 1),
(14, '190', 'Sierra Andina', '330ml', 'caja x18 unidades', '3', '11.00', '17.00', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vendedor`
--

CREATE TABLE `vendedor` (
  `Vend_id` int(11) NOT NULL,
  `Nom_vend` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `vendedor`
--

INSERT INTO `vendedor` (`Vend_id`, `Nom_vend`) VALUES
(1, 'Jhens Cutipa'),
(2, 'Anthony Alcahuasi');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

CREATE TABLE `venta` (
  `Ped_id` int(11) NOT NULL,
  `Fecha_crea` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Fecha_confirm` timestamp NULL DEFAULT NULL,
  `Fecha_envio` timestamp NULL DEFAULT NULL,
  `Fecha_entrega` timestamp NULL DEFAULT NULL,
  `Fecha_pago` timestamp NULL DEFAULT NULL,
  `Estado` varchar(20) DEFAULT NULL,
  `Cli_id` int(11) NOT NULL,
  `Direccion` varchar(92) DEFAULT NULL,
  `Vend_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `venta`
--

INSERT INTO `venta` (`Ped_id`, `Fecha_crea`, `Fecha_confirm`, `Fecha_envio`, `Fecha_entrega`, `Fecha_pago`, `Estado`, `Cli_id`, `Direccion`, `Vend_id`) VALUES
(1, '2021-09-10 13:09:00', '2021-09-10 14:20:00', '2021-09-10 15:20:00', '2021-09-11 13:29:00', '2021-09-14 19:09:00', 'Pagado', 1, 'Cusco#28', 1),
(2, '2021-11-05 13:29:00', '2021-11-05 15:05:00', '2021-11-05 17:19:00', '2021-11-06 12:09:00', '2021-11-18 23:09:00', 'Pagado', 1, 'Cusco#30', 1),
(3, '2021-12-15 12:29:00', '2021-12-15 14:38:00', '2021-12-15 16:25:00', '2021-12-16 13:10:00', '2021-12-16 20:46:00', 'Pagado', 1, 'Cusco#31', 2),
(4, '2021-12-23 15:19:00', '2021-12-23 17:45:00', '2021-12-23 19:39:00', '2021-12-24 12:09:00', '2021-12-28 15:09:00', 'Pagado', 1, 'Cusco#32', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta_det`
--

CREATE TABLE `venta_det` (
  `Ped_id` int(11) NOT NULL,
  `Prod_id` int(11) NOT NULL,
  `Cantidad` decimal(9,2) NOT NULL,
  `Prec_compra_un` decimal(9,2) DEFAULT NULL,
  `Prec_venta_un` decimal(9,2) NOT NULL,
  `Total_desc_un` decimal(9,2) DEFAULT NULL,
  `Igv_un` decimal(9,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `venta_det`
--

INSERT INTO `venta_det` (`Ped_id`, `Prod_id`, `Cantidad`, `Prec_compra_un`, `Prec_venta_un`, `Total_desc_un`, `Igv_un`) VALUES
(1, 1, '10.00', '6.00', '12.00', '1.00', '1.98'),
(1, 2, '10.00', '6.00', '12.00', '0.50', '2.07'),
(1, 3, '5.00', '5.00', '12.00', '0.00', '2.16'),
(1, 5, '3.00', '5.00', '10.00', '1.00', '1.62'),
(1, 7, '2.00', '17.00', '26.00', '0.00', '4.68'),
(1, 13, '15.00', '11.00', '17.00', '0.00', '3.06'),
(2, 2, '15.00', '6.00', '12.00', '1.00', '1.98'),
(2, 3, '13.00', '5.00', '12.00', '2.00', '1.80'),
(2, 5, '4.00', '5.00', '10.00', '6.00', '0.72'),
(2, 8, '2.00', '50.00', '67.00', '5.00', '11.16'),
(2, 11, '7.00', '11.00', '17.00', '4.00', '2.34'),
(2, 12, '8.00', '11.00', '17.00', '3.00', '2.52');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`Cat_id`),
  ADD KEY `Fam_id` (`Fam_id`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`Cli_id`);

--
-- Indices de la tabla `familia`
--
ALTER TABLE `familia`
  ADD PRIMARY KEY (`Fam_id`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`Prod_id`),
  ADD KEY `Cat_id` (`Cat_id`);

--
-- Indices de la tabla `vendedor`
--
ALTER TABLE `vendedor`
  ADD PRIMARY KEY (`Vend_id`);

--
-- Indices de la tabla `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`Ped_id`),
  ADD KEY `Cli_id` (`Cli_id`),
  ADD KEY `Vend_id` (`Vend_id`);

--
-- Indices de la tabla `venta_det`
--
ALTER TABLE `venta_det`
  ADD PRIMARY KEY (`Ped_id`,`Prod_id`),
  ADD KEY `Prod_id` (`Prod_id`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD CONSTRAINT `categoria_ibfk_1` FOREIGN KEY (`Fam_id`) REFERENCES `familia` (`Fam_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`Cat_id`) REFERENCES `categoria` (`Cat_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `venta`
--
ALTER TABLE `venta`
  ADD CONSTRAINT `venta_ibfk_1` FOREIGN KEY (`Cli_id`) REFERENCES `cliente` (`Cli_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `venta_ibfk_2` FOREIGN KEY (`Vend_id`) REFERENCES `vendedor` (`Vend_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `venta_det`
--
ALTER TABLE `venta_det`
  ADD CONSTRAINT `venta_det_ibfk_1` FOREIGN KEY (`Ped_id`) REFERENCES `venta` (`Ped_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `venta_det_ibfk_2` FOREIGN KEY (`Prod_id`) REFERENCES `producto` (`Prod_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
