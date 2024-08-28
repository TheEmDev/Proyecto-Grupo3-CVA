-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 28-08-2024 a las 18:56:05
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `base_cva`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_correo_asesor` (IN `p_id_asesor` INT, IN `p_nuevo_correo` VARCHAR(50))   BEGIN
    UPDATE tbl_asesor 
    SET as_correo = p_nuevo_correo
    WHERE as_id_asesor = p_id_asesor;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consulta_pagos_metodos` ()   BEGIN
    SELECT 
        p.pa_num_factura, 
        p.pa_total_pago, 
        p.pa_metodo_pago, 
        s.so_nombres, 
        s.so_apellidos
    FROM tbl_pago p
    INNER JOIN tbl_solicitante s ON p.pa_id_solicitante = s.so_id_solicitante;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consulta_solicitantes_asesorias` ()   BEGIN
    SELECT 
        s.so_id_solicitante, 
        s.so_nombres, 
        s.so_apellidos, 
        a.as_fecha_asesoria, 
        a.as_asesor_asignado
    FROM tbl_solicitante s
    INNER JOIN tbl_asesoria a ON s.so_id_solicitante = a.as_id_solicitante;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_eliminar_solicitante` (IN `p_id_solicitante` INT)   BEGIN
    DELETE FROM tbl_solicitante 
    WHERE so_id_solicitante = p_id_solicitante;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_administrador` (IN `p_nombres` VARCHAR(50), IN `p_apellidos` VARCHAR(50), IN `p_correo` VARCHAR(50), IN `p_contraseña` VARCHAR(20), IN `p_id_usuario` INT)   BEGIN
    INSERT INTO tbl_administrador (ad_nombres, ad_apellidos, ad_correo, ad_contraseña, ad_id_usuario) 
    VALUES (p_nombres, p_apellidos, p_correo, p_contraseña, p_id_usuario);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_administrador`
--

CREATE TABLE `tbl_administrador` (
  `ad_id_administrador` int(11) NOT NULL,
  `ad_nombres` varchar(50) DEFAULT NULL,
  `ad_apellidos` varchar(50) DEFAULT NULL,
  `ad_correo` varchar(20) DEFAULT NULL,
  `ad_contraseña` varchar(20) DEFAULT NULL,
  `ad_id_usuario` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_administrador`
--

INSERT INTO `tbl_administrador` (`ad_id_administrador`, `ad_nombres`, `ad_apellidos`, `ad_correo`, `ad_contraseña`, `ad_id_usuario`) VALUES
(1, 'Pedro', 'Sánchez', 'admin1@mail.com', 'admin1234', 1),
(2, 'Lucía', 'Ortega', 'admin2@mail.com', 'admin2345', 2),
(3, 'Jorge', 'García', 'admin3@mail.com', 'admin3456', 3),
(4, 'Marta', 'Vega', 'admin4@mail.com', 'admin4567', 4),
(5, 'Alberto', 'Mendoza', 'admin5@mail.com', 'admin5678', 5),
(6, 'Elena', 'Torres', 'admin6@mail.com', 'admin6789', 6),
(7, 'Raúl', 'Rivas', 'admin7@mail.com', 'admin7890', 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_asesor`
--

CREATE TABLE `tbl_asesor` (
  `as_id_asesor` int(11) NOT NULL,
  `as_nombres` varchar(50) DEFAULT NULL,
  `as_apellidos` varchar(50) DEFAULT NULL,
  `as_correo` varchar(20) DEFAULT NULL,
  `as_contraseña` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_asesor`
--

INSERT INTO `tbl_asesor` (`as_id_asesor`, `as_nombres`, `as_apellidos`, `as_correo`, `as_contraseña`) VALUES
(1, 'Andrés', 'Paredes', 'asesor1@mail.com', 'asesor1234'),
(2, 'Beatriz', 'Gómez', 'asesor2@mail.com', 'asesor2345'),
(3, 'Cristina', 'Luna', 'asesor3@mail.com', 'asesor3456'),
(4, 'Daniel', 'Salinas', 'asesor4@mail.com', 'asesor4567'),
(5, 'Elisa', 'Fuentes', 'asesor5@mail.com', 'asesor5678'),
(6, 'Francisco', 'Romero', 'asesor6@mail.com', 'asesor6789'),
(7, 'Gloria', 'Álvarez', 'asesor7@mail.com', 'asesor7890');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_asesoria`
--

CREATE TABLE `tbl_asesoria` (
  `as_codigo_asesoria` int(11) NOT NULL,
  `as_fecha_asesoria` datetime DEFAULT NULL,
  `as_asesor_asignado` varchar(20) DEFAULT NULL,
  `as_id_solicitante` int(11) DEFAULT NULL,
  `as_id_asesor` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_asesoria`
--

INSERT INTO `tbl_asesoria` (`as_codigo_asesoria`, `as_fecha_asesoria`, `as_asesor_asignado`, `as_id_solicitante`, `as_id_asesor`) VALUES
(1, '2024-08-01 10:00:00', 'Andrés Paredes', 1, 1),
(2, '2024-08-02 11:30:00', 'Beatriz Gómez', 2, 2),
(3, '2024-08-03 14:00:00', 'Cristina Luna', 3, 3),
(4, '2024-08-04 09:00:00', 'Daniel Salinas', 4, 4),
(5, '2024-08-05 15:30:00', 'Elisa Fuentes', 5, 5),
(6, '2024-08-06 08:45:00', 'Francisco Romero', 6, 6),
(7, '2024-08-07 16:00:00', 'Gloria Álvarez', 7, 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_documentos_adjuntos`
--

CREATE TABLE `tbl_documentos_adjuntos` (
  `da_historial_viajes` varchar(255) DEFAULT NULL,
  `da_pasaporte` varchar(255) DEFAULT NULL,
  `da_comprobante_recursosFinancieros` varchar(255) DEFAULT NULL,
  `da_comprobante_medicoApoyo` varchar(255) DEFAULT NULL,
  `da_foto_digital` varchar(255) DEFAULT NULL,
  `da_proposito_viaje` varchar(255) DEFAULT NULL,
  `da_prueba_estadoCivil` varchar(255) DEFAULT NULL,
  `da_informacion_familiar` varchar(255) DEFAULT NULL,
  `da_aplicacion_IMM5257` varchar(255) DEFAULT NULL,
  `da_informacion_cliente` varchar(255) DEFAULT NULL,
  `da_id_formElegibilidad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_documentos_adjuntos`
--

INSERT INTO `tbl_documentos_adjuntos` (`da_historial_viajes`, `da_pasaporte`, `da_comprobante_recursosFinancieros`, `da_comprobante_medicoApoyo`, `da_foto_digital`, `da_proposito_viaje`, `da_prueba_estadoCivil`, `da_informacion_familiar`, `da_aplicacion_IMM5257`, `da_informacion_cliente`, `da_id_formElegibilidad`) VALUES
('historial1.pdf', 'pasaporte1.pdf', 'recursos1.pdf', 'medico1.pdf', 'foto1.jpg', 'proposito1.pdf', 'estadoCivil1.pdf', 'informacionFamiliar1.pdf', 'IMM5257_1.pdf', 'cliente1.pdf', 1),
('historial2.pdf', 'pasaporte2.pdf', 'recursos2.pdf', 'medico2.pdf', 'foto2.jpg', 'proposito2.pdf', 'estadoCivil2.pdf', 'informacionFamiliar2.pdf', 'IMM5257_2.pdf', 'cliente2.pdf', 2),
('historial3.pdf', 'pasaporte3.pdf', 'recursos3.pdf', 'medico3.pdf', 'foto3.jpg', 'proposito3.pdf', 'estadoCivil3.pdf', 'informacionFamiliar3.pdf', 'IMM5257_3.pdf', 'cliente3.pdf', 3),
('historial4.pdf', 'pasaporte4.pdf', 'recursos4.pdf', 'medico4.pdf', 'foto4.jpg', 'proposito4.pdf', 'estadoCivil4.pdf', 'informacionFamiliar4.pdf', 'IMM5257_4.pdf', 'cliente4.pdf', 4),
('historial5.pdf', 'pasaporte5.pdf', 'recursos5.pdf', 'medico5.pdf', 'foto5.jpg', 'proposito5.pdf', 'estadoCivil5.pdf', 'informacionFamiliar5.pdf', 'IMM5257_5.pdf', 'cliente5.pdf', 5),
('historial6.pdf', 'pasaporte6.pdf', 'recursos6.pdf', 'medico6.pdf', 'foto6.jpg', 'proposito6.pdf', 'estadoCivil6.pdf', 'informacionFamiliar6.pdf', 'IMM5257_6.pdf', 'cliente6.pdf', 6),
('historial7.pdf', 'pasaporte7.pdf', 'recursos7.pdf', 'medico7.pdf', 'foto7.jpg', 'proposito7.pdf', 'estadoCivil7.pdf', 'informacionFamiliar7.pdf', 'IMM5257_7.pdf', 'cliente7.pdf', 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_form_elegibilidadcva`
--

CREATE TABLE `tbl_form_elegibilidadcva` (
  `fe_id_formElegibilidad` int(11) NOT NULL,
  `fe_motivo_viaje` varchar(20) DEFAULT NULL,
  `fe_codigo_pasaporte` varchar(20) DEFAULT NULL,
  `fe_pais_residencia` varchar(20) DEFAULT NULL,
  `fe_familiares_canada` varchar(20) DEFAULT NULL,
  `fe_fecha_nacimiento` datetime DEFAULT NULL,
  `fe_relacion_familiares_can` varchar(20) DEFAULT NULL,
  `fe_estado_civil` varchar(20) DEFAULT NULL,
  `fe_provincia_destino` varchar(20) DEFAULT NULL,
  `fe_trabajo_actual` varchar(20) DEFAULT NULL,
  `fe_negocios_actuales` varchar(20) DEFAULT NULL,
  `fe_co_deudor` varchar(20) DEFAULT NULL,
  `fe_viajes_recientes` varchar(20) DEFAULT NULL,
  `fe_acompanante_canada` varchar(20) DEFAULT NULL,
  `fe_antecedente_judiciales` varchar(20) DEFAULT NULL,
  `fe_examenes_medicos` varchar(20) DEFAULT NULL,
  `fe_aplicacion_familiares` varchar(20) DEFAULT NULL,
  `fe_acceso_aplicacion` varchar(20) DEFAULT NULL,
  `fe_biometricos_canada` varchar(20) DEFAULT NULL,
  `fe_pago_tasas` varchar(20) DEFAULT NULL,
  `fe_metodo_pago` varchar(20) DEFAULT NULL,
  `fe_id_solicitante` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_form_elegibilidadcva`
--

INSERT INTO `tbl_form_elegibilidadcva` (`fe_id_formElegibilidad`, `fe_motivo_viaje`, `fe_codigo_pasaporte`, `fe_pais_residencia`, `fe_familiares_canada`, `fe_fecha_nacimiento`, `fe_relacion_familiares_can`, `fe_estado_civil`, `fe_provincia_destino`, `fe_trabajo_actual`, `fe_negocios_actuales`, `fe_co_deudor`, `fe_viajes_recientes`, `fe_acompanante_canada`, `fe_antecedente_judiciales`, `fe_examenes_medicos`, `fe_aplicacion_familiares`, `fe_acceso_aplicacion`, `fe_biometricos_canada`, `fe_pago_tasas`, `fe_metodo_pago`, `fe_id_solicitante`) VALUES
(1, 'Estudio', 'X123456', 'España', 'Sí', '1990-01-01 00:00:00', 'Hermano', 'Soltero', 'Ontario', 'Ingeniero', 'No', 'No', 'Francia', 'No', 'No', 'No', 'Sí', 'Sí', 'No', 'Sí', 'Tarjeta de Crédito', 1),
(2, 'Trabajo', 'Y654321', 'México', 'No', '1985-05-10 00:00:00', 'Ninguno', 'Casado', 'Quebec', 'Doctor', 'Sí', 'Sí', 'Italia', 'Sí', 'No', 'Sí', 'No', 'No', 'Sí', 'No', 'PayPal', 2),
(3, 'Turismo', 'Z987654', 'Colombia', 'Sí', '1992-08-15 00:00:00', 'Padre', 'Soltero', 'British Columbia', 'Arquitecto', 'No', 'No', 'Argentina', 'No', 'Sí', 'No', 'Sí', 'Sí', 'No', 'Sí', 'Transferencia Bancar', 3),
(4, 'Estudio', 'A135790', 'Chile', 'No', '1988-02-05 00:00:00', 'Ninguno', 'Soltero', 'Alberta', 'Maestro', 'No', 'No', 'Brasil', 'No', 'No', 'No', 'No', 'No', 'No', 'No', 'Tarjeta de Crédito', 4),
(5, 'Turismo', 'B246801', 'Argentina', 'No', '1995-07-25 00:00:00', 'Ninguno', 'Casado', 'Manitoba', 'Diseñador', 'No', 'No', 'Perú', 'Sí', 'Sí', 'No', 'Sí', 'No', 'No', 'Sí', 'Transferencia Bancar', 5),
(6, 'Trabajo', 'C357902', 'Perú', 'Sí', '1983-03-12 00:00:00', 'Madre', 'Divorciado', 'Saskatchewan', 'Médico', 'Sí', 'Sí', 'Bolivia', 'No', 'No', 'No', 'Sí', 'Sí', 'Sí', 'Sí', 'Tarjeta de Crédito', 6),
(7, 'Estudio', 'D468013', 'Uruguay', 'Sí', '1998-12-30 00:00:00', 'Tío', 'Soltero', 'Nova Scotia', 'Ingeniero', 'No', 'No', 'Chile', 'No', 'No', 'Sí', 'No', 'No', 'Sí', 'No', 'PayPal', 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_form_familiarcva`
--

CREATE TABLE `tbl_form_familiarcva` (
  `ff_aplicante` varchar(50) DEFAULT NULL,
  `ff_conyuge` varchar(50) DEFAULT NULL,
  `ff_madre` varchar(50) DEFAULT NULL,
  `ff_padre` varchar(50) DEFAULT NULL,
  `ff_hijos` varchar(50) DEFAULT NULL,
  `ff_hermanos` varchar(50) DEFAULT NULL,
  `ff_id_formElegibilidad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_form_familiarcva`
--

INSERT INTO `tbl_form_familiarcva` (`ff_aplicante`, `ff_conyuge`, `ff_madre`, `ff_padre`, `ff_hijos`, `ff_hermanos`, `ff_id_formElegibilidad`) VALUES
('Clara Ruiz', 'N/A', 'Madre Ruiz', 'Padre Ruiz', 'N/A', 'Hermano Ruiz', 1),
('Diego Navarro', 'Conyuge Navarro', 'Madre Navarro', 'Padre Navarro', 'Hijo Navarro', 'N/A', 2),
('Eva Castro', 'N/A', 'Madre Castro', 'Padre Castro', 'N/A', 'N/A', 3),
('Fernando Sosa', 'Conyuge Sosa', 'Madre Sosa', 'Padre Sosa', 'Hijo Sosa', 'Hermana Sosa', 4),
('Inés Vargas', 'Conyuge Vargas', 'Madre Vargas', 'Padre Vargas', 'Hijo Vargas', 'Hermano Vargas', 5),
('Hugo Moreno', 'N/A', 'Madre Moreno', 'Padre Moreno', 'N/A', 'Hermano Moreno', 6),
('Patricia Rojas', 'N/A', 'Madre Rojas', 'Padre Rojas', 'N/A', 'Hermana Rojas', 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_pago`
--

CREATE TABLE `tbl_pago` (
  `pa_num_factura` int(11) NOT NULL,
  `pa_metodo_pago` varchar(20) DEFAULT NULL,
  `pa_total_pago` varchar(100) DEFAULT NULL,
  `pa_id_solicitante` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_pago`
--

INSERT INTO `tbl_pago` (`pa_num_factura`, `pa_metodo_pago`, `pa_total_pago`, `pa_id_solicitante`) VALUES
(1, 'Tarjeta de Crédito', '1000.00', 1),
(2, 'PayPal', '1500.00', 2),
(3, 'Transferencia Bancar', '2000.00', 3),
(4, 'Tarjeta de Crédito', '1200.00', 4),
(5, 'PayPal', '1800.00', 5),
(6, 'Transferencia Bancar', '1400.00', 6),
(7, 'Tarjeta de Crédito', '1600.00', 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_solicitante`
--

CREATE TABLE `tbl_solicitante` (
  `so_id_solicitante` int(11) NOT NULL,
  `so_nombres` varchar(50) DEFAULT NULL,
  `so_apellidos` varchar(50) DEFAULT NULL,
  `so_correo` varchar(20) DEFAULT NULL,
  `so_contraseña` varchar(20) DEFAULT NULL,
  `so_id_usuario` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_solicitante`
--

INSERT INTO `tbl_solicitante` (`so_id_solicitante`, `so_nombres`, `so_apellidos`, `so_correo`, `so_contraseña`, `so_id_usuario`) VALUES
(1, 'Clara', 'Ruiz', 'solicitante1@mail.co', 'solic1234', 1),
(2, 'Diego', 'Navarro', 'solicitante2@mail.co', 'solic2345', 2),
(3, 'Eva', 'Castro', 'solicitante3@mail.co', 'solic3456', 3),
(4, 'Fernando', 'Sosa', 'solicitante4@mail.co', 'solic4567', 4),
(5, 'Inés', 'Vargas', 'solicitante5@mail.co', 'solic5678', 5),
(6, 'Hugo', 'Moreno', 'solicitante6@mail.co', 'solic6789', 6),
(7, 'Patricia', 'Rojas', 'solicitante7@mail.co', 'solic7890', 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_usuario`
--

CREATE TABLE `tbl_usuario` (
  `us_id_usuario` int(11) NOT NULL,
  `us_fecha_nacimiento` datetime DEFAULT NULL,
  `us_correo` varchar(20) DEFAULT NULL,
  `us_contraseña` varchar(20) DEFAULT NULL,
  `us_nombres` varchar(50) DEFAULT NULL,
  `us_apellidos` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_usuario`
--

INSERT INTO `tbl_usuario` (`us_id_usuario`, `us_fecha_nacimiento`, `us_correo`, `us_contraseña`, `us_nombres`, `us_apellidos`) VALUES
(1, '1985-05-10 00:00:00', 'usuario1@mail.com', 'pass1234', 'Juan', 'Pérez'),
(2, '1990-11-20 00:00:00', 'usuario2@mail.com', 'pass2345', 'María', 'González'),
(3, '1992-08-15 00:00:00', 'usuario3@mail.com', 'pass3456', 'Carlos', 'López'),
(4, '1988-02-05 00:00:00', 'usuario4@mail.com', 'pass4567', 'Ana', 'Martínez'),
(5, '1995-07-25 00:00:00', 'usuario5@mail.com', 'pass5678', 'José', 'Hernández'),
(6, '1983-03-12 00:00:00', 'usuario6@mail.com', 'pass6789', 'Laura', 'Díaz'),
(7, '1998-12-30 00:00:00', 'usuario7@mail.com', 'pass7890', 'David', 'Ramírez');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tbl_administrador`
--
ALTER TABLE `tbl_administrador`
  ADD PRIMARY KEY (`ad_id_administrador`),
  ADD KEY `ad_id_usuario` (`ad_id_usuario`);

--
-- Indices de la tabla `tbl_asesor`
--
ALTER TABLE `tbl_asesor`
  ADD PRIMARY KEY (`as_id_asesor`);

--
-- Indices de la tabla `tbl_asesoria`
--
ALTER TABLE `tbl_asesoria`
  ADD PRIMARY KEY (`as_codigo_asesoria`),
  ADD KEY `as_id_solicitante` (`as_id_solicitante`),
  ADD KEY `as_id_asesor` (`as_id_asesor`);

--
-- Indices de la tabla `tbl_documentos_adjuntos`
--
ALTER TABLE `tbl_documentos_adjuntos`
  ADD KEY `da_id_formElegibilidad` (`da_id_formElegibilidad`);

--
-- Indices de la tabla `tbl_form_elegibilidadcva`
--
ALTER TABLE `tbl_form_elegibilidadcva`
  ADD PRIMARY KEY (`fe_id_formElegibilidad`),
  ADD KEY `fe_id_solicitante` (`fe_id_solicitante`);

--
-- Indices de la tabla `tbl_form_familiarcva`
--
ALTER TABLE `tbl_form_familiarcva`
  ADD KEY `ff_id_formElegibilidad` (`ff_id_formElegibilidad`);

--
-- Indices de la tabla `tbl_pago`
--
ALTER TABLE `tbl_pago`
  ADD PRIMARY KEY (`pa_num_factura`),
  ADD KEY `pa_id_solicitante` (`pa_id_solicitante`);

--
-- Indices de la tabla `tbl_solicitante`
--
ALTER TABLE `tbl_solicitante`
  ADD PRIMARY KEY (`so_id_solicitante`),
  ADD KEY `so_id_usuario` (`so_id_usuario`);

--
-- Indices de la tabla `tbl_usuario`
--
ALTER TABLE `tbl_usuario`
  ADD PRIMARY KEY (`us_id_usuario`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tbl_administrador`
--
ALTER TABLE `tbl_administrador`
  ADD CONSTRAINT `tbl_administrador_ibfk_1` FOREIGN KEY (`ad_id_usuario`) REFERENCES `tbl_usuario` (`us_id_usuario`);

--
-- Filtros para la tabla `tbl_asesoria`
--
ALTER TABLE `tbl_asesoria`
  ADD CONSTRAINT `tbl_asesoria_ibfk_1` FOREIGN KEY (`as_id_solicitante`) REFERENCES `tbl_solicitante` (`so_id_solicitante`),
  ADD CONSTRAINT `tbl_asesoria_ibfk_2` FOREIGN KEY (`as_id_asesor`) REFERENCES `tbl_asesor` (`as_id_asesor`);

--
-- Filtros para la tabla `tbl_documentos_adjuntos`
--
ALTER TABLE `tbl_documentos_adjuntos`
  ADD CONSTRAINT `tbl_documentos_adjuntos_ibfk_1` FOREIGN KEY (`da_id_formElegibilidad`) REFERENCES `tbl_form_elegibilidadcva` (`fe_id_formElegibilidad`);

--
-- Filtros para la tabla `tbl_form_elegibilidadcva`
--
ALTER TABLE `tbl_form_elegibilidadcva`
  ADD CONSTRAINT `tbl_form_elegibilidadcva_ibfk_1` FOREIGN KEY (`fe_id_solicitante`) REFERENCES `tbl_solicitante` (`so_id_solicitante`);

--
-- Filtros para la tabla `tbl_form_familiarcva`
--
ALTER TABLE `tbl_form_familiarcva`
  ADD CONSTRAINT `tbl_form_familiarcva_ibfk_1` FOREIGN KEY (`ff_id_formElegibilidad`) REFERENCES `tbl_form_elegibilidadcva` (`fe_id_formElegibilidad`);

--
-- Filtros para la tabla `tbl_pago`
--
ALTER TABLE `tbl_pago`
  ADD CONSTRAINT `tbl_pago_ibfk_1` FOREIGN KEY (`pa_id_solicitante`) REFERENCES `tbl_solicitante` (`so_id_solicitante`);

--
-- Filtros para la tabla `tbl_solicitante`
--
ALTER TABLE `tbl_solicitante`
  ADD CONSTRAINT `tbl_solicitante_ibfk_1` FOREIGN KEY (`so_id_usuario`) REFERENCES `tbl_usuario` (`us_id_usuario`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
