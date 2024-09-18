-- Creación de la base de datos si no existe y uso de la misma
CREATE DATABASE IF NOT EXISTS CVA;
USE CVA;

-- Tabla para usuarios
CREATE TABLE tbl_usuario (
    id_usuario INT(11) PRIMARY KEY AUTO_INCREMENT,
    fecha_nacimiento DATE,
    correo VARCHAR(50),
    contrasena VARCHAR(255),
    nombres VARCHAR(50),
    apellidos VARCHAR(50)
);

-- Tabla para administradores
CREATE TABLE tbl_administrador (
    id_administrador INT(11) PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT(11) UNIQUE,
    FOREIGN KEY (id_usuario) REFERENCES tbl_usuario(id_usuario)
);

-- Tabla para solicitantes
CREATE TABLE tbl_solicitante (
    id_solicitante INT(11) PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT(11) UNIQUE,
    FOREIGN KEY (id_usuario) REFERENCES tbl_usuario(id_usuario)
);

-- Tabla para asesores
CREATE TABLE tbl_asesor (
    id_asesor INT(11) PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT(11) UNIQUE,
    FOREIGN KEY (id_usuario) REFERENCES tbl_usuario(id_usuario)
);

-- Tabla para formularios de elegibilidad CVA
CREATE TABLE tbl_form_eligibilidadCVA (
    id_formElegibilidad INT(11) PRIMARY KEY AUTO_INCREMENT,
    motivo_viaje VARCHAR(50),
    codigo_pasaporte VARCHAR(20),
    pais_residencia VARCHAR(50),
    familiares_canada VARCHAR(3),
    relacion_familiares_can VARCHAR(50),
    estado_civil VARCHAR(20),
    provincia_destino VARCHAR(50),
    trabajo_actual VARCHAR(100),
    negocios_actuales VARCHAR(100),
    co_deudor VARCHAR(3),
    viajes_recientes VARCHAR(3),
    acompanante_canada VARCHAR(3),
    antecedente_judiciales VARCHAR(3),
    examenes_medicos VARCHAR(3),
    aplicacion_familiares VARCHAR(3),
    acceso_aplicacion VARCHAR(3),
    biometricos_canada VARCHAR(3),
    pago_tasas VARCHAR(3),
    metodo_pago VARCHAR(20),
    id_solicitante INT(11),
    FOREIGN KEY (id_solicitante) REFERENCES tbl_solicitante(id_solicitante)
);

-- Tabla para formularios familiares CVA
CREATE TABLE tbl_form_familiarCVA (
    id_formFamiliar INT(11) PRIMARY KEY AUTO_INCREMENT,
    aplicante VARCHAR(100),
    conyugue VARCHAR(100),
    madre VARCHAR(100),
    padre VARCHAR(100),
    hijos TEXT,
    hermanos TEXT,
    id_formElegibilidad INT(11),
    FOREIGN KEY (id_formElegibilidad) REFERENCES tbl_form_eligibilidadCVA(id_formElegibilidad)
);

-- Tabla para documentos adjuntos
CREATE TABLE tbl_documentos_adjuntos (
    id_documento INT(11) PRIMARY KEY AUTO_INCREMENT,
    historial_viajes VARCHAR(255),
    pasaporte VARCHAR(255),
    comprobante_recursos_financieros VARCHAR(255),
    comprobante_mediosApoyo VARCHAR(255),
    foto_digital VARCHAR(255),
    proposito_viaje VARCHAR(255),
    prueba_estadoCivil VARCHAR(255),
    informacion_familiar VARCHAR(255),
    aplicacion_IMM5257 VARCHAR(255),
    informacion_cliente VARCHAR(255),
    id_formElegibilidad INT(11),
    FOREIGN KEY (id_formElegibilidad) REFERENCES tbl_form_eligibilidadCVA(id_formElegibilidad)
);

-- Tabla para asesorías
CREATE TABLE tbl_asesoria (
    codigo_asesoria INT(11) PRIMARY KEY AUTO_INCREMENT,
    fecha_asesoria DATETIME,
    asesor_asignado VARCHAR(100),
    id_solicitante INT(11),
    id_asesor INT(11),
    FOREIGN KEY (id_solicitante) REFERENCES tbl_solicitante(id_solicitante),
    FOREIGN KEY (id_asesor) REFERENCES tbl_asesor(id_asesor)
);

-- Tabla para pagos
CREATE TABLE tbl_pago (
    num_factura INT(11) PRIMARY KEY AUTO_INCREMENT,
    metodo_pago VARCHAR(20),
    total_pago DECIMAL(10, 2),
    id_solicitante INT(11),
    FOREIGN KEY (id_solicitante) REFERENCES tbl_solicitante(id_solicitante)
);

-- Insertar datos en tbl_usuario
INSERT INTO tbl_usuario (fecha_nacimiento, correo, contrasena, nombres, apellidos) VALUES
('1990-05-15', 'usuario1@email.com', 'pass123', 'Juan', 'Pérez'),
('1985-10-22', 'usuario2@email.com', 'pass456', 'María', 'González'),
('1992-03-30', 'usuario3@email.com', 'pass789', 'Carlos', 'Rodríguez'),
('1988-07-18', 'usuario4@email.com', 'passabc', 'Ana', 'Martínez'),
('1995-12-05', 'usuario5@email.com', 'passdef', 'Luis', 'Sánchez'),
('1993-09-10', 'usuario6@email.com', 'passghi', 'Laura', 'Díaz'),
('1987-04-25', 'usuario7@email.com', 'passjkl', 'Pedro', 'López');

-- Insertar datos en tbl_administrador
INSERT INTO tbl_administrador (id_usuario) VALUES
(1), (2), (3), (4), (5), (6), (7);

-- Insertar datos en tbl_solicitante
INSERT INTO tbl_solicitante (id_usuario) VALUES
(1), (2), (3), (4), (5), (6), (7);

-- Insertar datos en tbl_asesor
INSERT INTO tbl_asesor (id_usuario) VALUES
(1), (2), (3), (4), (5), (6), (7);

-- Insertar datos en tbl_form_eligibilidadCVA
INSERT INTO tbl_form_eligibilidadCVA (motivo_viaje, codigo_pasaporte, pais_residencia, familiares_canada, relacion_familiares_can, estado_civil, provincia_destino, trabajo_actual, negocios_actuales, co_deudor, viajes_recientes, acompanante_canada, antecedente_judiciales, examenes_medicos, aplicacion_familiares, acceso_aplicacion, biometricos_canada, pago_tasas, metodo_pago, id_solicitante) VALUES
('Turismo', 'AB123456', 'Colombia', 'No', 'N/A', 'Soltero', 'Ontario', 'Ingeniero', 'Ninguno', 'No', 'No', 'No', 'No', 'No', 'No', 'Sí', 'No', 'Sí', 'Tarjeta de crédito', 1),
('Trabajo', 'CD789012', 'México', 'Sí', 'Hermano', 'Casado', 'Quebec', 'Profesor', 'Consultoría', 'Sí', 'Sí', 'Sí', 'No', 'Sí', 'No', 'Sí', 'Sí', 'Sí', 'Transferencia', 2),
('Estudios', 'EF345678', 'Argentina', 'No', 'N/A', 'Soltero', 'British Columbia', 'Estudiante', 'Ninguno', 'No', 'No', 'No', 'No', 'Sí', 'No', 'Sí', 'No', 'Sí', 'Efectivo', 3),
('Negocios', 'GH901234', 'Perú', 'Sí', 'Primo', 'Divorciado', 'Alberta', 'Empresario', 'Startup', 'Sí', 'Sí', 'No', 'No', 'Sí', 'Sí', 'Sí', 'Sí', 'Sí', 'Tarjeta de débito', 4),
('Turismo', 'IJ567890', 'Chile', 'No', 'N/A', 'Casado', 'Nova Scotia', 'Médico', 'Ninguno', 'No', 'Sí', 'Sí', 'No', 'Sí', 'No', 'Sí', 'No', 'Sí', 'PayPal', 5),
('Trabajo', 'KL123456', 'Ecuador', 'No', 'N/A', 'Soltero', 'Manitoba', 'Ingeniero', 'Freelance', 'No', 'No', 'No', 'No', 'Sí', 'No', 'Sí', 'Sí', 'Sí', 'Transferencia', 6),
('Estudios', 'MN789012', 'Uruguay', 'Sí', 'Tío', 'Soltero', 'Saskatchewan', 'Estudiante', 'Ninguno', 'Sí', 'No', 'No', 'No', 'Sí', 'Sí', 'Sí', 'No', 'Sí', 'Tarjeta de crédito', 7);

-- Insertar datos en tbl_form_familiarCVA
INSERT INTO tbl_form_familiarCVA (aplicante, conyugue, madre, padre, hijos, hermanos, id_formElegibilidad) VALUES
('Juan Pérez', 'N/A', 'María Pérez', 'José Pérez', 'Ninguno', 'Ana Pérez, Carlos Pérez', 1),
('María González', 'Pedro Rodríguez', 'Laura González', 'Roberto González', 'Sofia Rodríguez', 'Luis González', 2),
('Carlos Rodríguez', 'N/A', 'Elena Rodríguez', 'Manuel Rodríguez', 'Ninguno', 'Diana Rodríguez', 3),
('Ana Martínez', 'José López', 'Carmen Martínez', 'Antonio Martínez', 'Juan López, María López', 'Pedro Martínez', 4),
('Luis Sánchez', 'Laura Gómez', 'Isabel Sánchez', 'Francisco Sánchez', 'Ninguno', 'Carlos Sánchez, Elena Sánchez', 5),
('Laura Díaz', 'N/A', 'Marta Díaz', 'Jorge Díaz', 'Ninguno', 'Roberto Díaz', 6),
('Pedro López', 'Ana Torres', 'Sofía López', 'Miguel López', 'Carlos López', 'María López, Juan López', 7);

-- Insertar datos en tbl_documentos_adjuntos
INSERT INTO tbl_documentos_adjuntos (historial_viajes, pasaporte, comprobante_recursos_financieros, comprobante_mediosApoyo, foto_digital, proposito_viaje, prueba_estadoCivil, informacion_familiar, aplicacion_IMM5257, informacion_cliente, id_formElegibilidad) VALUES
('viajes_juan.pdf', 'pasaporte_juan.pdf', 'recursos_juan.pdf', 'medios_juan.pdf', 'foto_juan.jpg', 'proposito_juan.pdf', 'estado_civil_juan.pdf', 'familia_juan.pdf', 'IMM5257_juan.pdf', 'info_juan.pdf', 1),
('viajes_maria.pdf', 'pasaporte_maria.pdf', 'recursos_maria.pdf', 'medios_maria.pdf', 'foto_maria.jpg', 'proposito_maria.pdf', 'estado_civil_maria.pdf', 'familia_maria.pdf', 'IMM5257_maria.pdf', 'info_maria.pdf', 2),
('viajes_carlos.pdf', 'pasaporte_carlos.pdf', 'recursos_carlos.pdf', 'medios_carlos.pdf', 'foto_carlos.jpg', 'proposito_carlos.pdf', 'estado_civil_carlos.pdf', 'familia_carlos.pdf', 'IMM5257_carlos.pdf', 'info_carlos.pdf', 3),
('viajes_ana.pdf', 'pasaporte_ana.pdf', 'recursos_ana.pdf', 'medios_ana.pdf', 'foto_ana.jpg', 'proposito_ana.pdf', 'estado_civil_ana.pdf', 'familia_ana.pdf', 'IMM5257_ana.pdf', 'info_ana.pdf', 4),
('viajes_luis.pdf', 'pasaporte_luis.pdf', 'recursos_luis.pdf', 'medios_luis.pdf', 'foto_luis.jpg', 'proposito_luis.pdf', 'estado_civil_luis.pdf', 'familia_luis.pdf', 'IMM5257_luis.pdf', 'info_luis.pdf', 5),
('viajes_laura.pdf', 'pasaporte_laura.pdf', 'recursos_laura.pdf', 'medios_laura.pdf', 'foto_laura.jpg', 'proposito_laura.pdf', 'estado_civil_laura.pdf', 'familia_laura.pdf', 'IMM5257_laura.pdf', 'info_laura.pdf', 6),
('viajes_pedro.pdf', 'pasaporte_pedro.pdf', 'recursos_pedro.pdf', 'medios_pedro.pdf', 'foto_pedro.jpg', 'proposito_pedro.pdf', 'estado_civil_pedro.pdf', 'familia_pedro.pdf', 'IMM5257_pedro.pdf', 'info_pedro.pdf', 7);

-- Insertar datos en tbl_asesoria
INSERT INTO tbl_asesoria (fecha_asesoria, asesor_asignado, id_solicitante, id_asesor) VALUES
('2024-09-20 10:00:00', 'Juan Pérez', 1, 1),
('2024-09-21 14:30:00', 'María González', 2, 2),
('2024-09-22 11:15:00', 'Carlos Rodríguez', 3, 3),
('2024-09-23 09:45:00', 'Ana Martínez', 4, 4),
('2024-09-24 16:00:00', 'Luis Sánchez', 5, 5),
('2024-09-25 13:30:00', 'Laura Díaz', 6, 6),
('2024-09-26 10:45:00', 'Pedro López', 7, 7);

-- Insertar datos en tbl_pago
INSERT INTO tbl_pago (metodo_pago, total_pago, id_solicitante) VALUES
('Tarjeta de crédito', 500.00, 1),
('Transferencia', 750.00, 2),
('Efectivo', 600.00, 3),
('Tarjeta de débito', 550.00, 4),
('PayPal', 680.00, 5),
('Transferencia', 720.00, 6),
('Tarjeta de crédito', 590.00, 7);

-- Procedimiento para consultar datos de tbl_solicitante y tbl_form_eligibilidadCVA usando INNER JOIN
DELIMITER $$
CREATE PROCEDURE GetSolicitanteElegibilidad()
BEGIN
    SELECT 
        s.nombres AS NombreSolicitante, 
        s.apellidos AS ApellidoSolicitante, 
        fe.motivo_viaje, 
        fe.codigo_pasaporte 
    FROM tbl_solicitante s
    INNER JOIN tbl_form_eligibilidadCVA fe ON s.id_solicitante = fe.id_solicitante;
END $$
DELIMITER ;

-- Procedimiento para consultar datos de tbl_administrador y tbl_usuario usando INNER JOIN
DELIMITER $$
CREATE PROCEDURE GetAdministradorUsuario()
BEGIN
    SELECT 
        a.nombres AS NombreAdmin, 
        a.apellidos AS ApellidoAdmin, 
        u.correo AS CorreoUsuario 
    FROM tbl_administrador a
    INNER JOIN tbl_usuario u ON a.id_usuario = u.id_usuario;
END $$
DELIMITER ;

-- Procedimiento para actualizar datos en tbl_usuario
DELIMITER $$
CREATE PROCEDURE UpdateUsuario(
    IN userID INT, 
    IN newEmail VARCHAR(20), 
    IN newPassword VARCHAR(20)
)
BEGIN
    UPDATE tbl_usuario
    SET correo = newEmail, contrasena = newPassword
    WHERE id_usuario = userID;
END $$
DELIMITER ;

-- Procedimiento para insertar datos en tbl_solicitante
DELIMITER $$
CREATE PROCEDURE InsertSolicitante(
    IN nombre VARCHAR(50), 
    IN apellido VARCHAR(50), 
    IN correo VARCHAR(20), 
    IN contrasena VARCHAR(20), 
    IN usuarioID INT
)
BEGIN
    INSERT INTO tbl_solicitante (nombres, apellidos, correo, contrasena, id_usuario)
    VALUES (nombre, apellido, correo, contrasena, usuarioID);
END $$
DELIMITER ;

-- Procedimiento para eliminar datos de tbl_solicitante
DELIMITER $$
CREATE PROCEDURE DeleteSolicitante(IN solicitanteID INT)
BEGIN
    DELETE FROM tbl_solicitante
    WHERE id_solicitante = solicitanteID;
END $$
DELIMITER ;

-- Vistas
-- Vista para consultar la información de tbl_administrador y sus usuarios relacionados
CREATE VIEW VistaAdminUsuario AS
SELECT 
    u.nombres AS NombreAdmin, 
    u.apellidos AS ApellidoAdmin, 
    u.correo AS CorreoUsuario,
    a.id_administrador
FROM tbl_administrador a
INNER JOIN tbl_usuario u ON a.id_usuario = u.id_usuario;

-- Vista para consultar la información de tbl_solicitante y sus formularios de elegibilidad relacionados
CREATE VIEW VistaSolicitanteElegibilidad AS
SELECT 
    u.nombres AS NombreSolicitante, 
    u.apellidos AS ApellidoSolicitante, 
    u.correo AS CorreoSolicitante,
    fe.motivo_viaje, 
    fe.codigo_pasaporte,
    fe.pais_residencia,
    fe.estado_civil,
    fe.provincia_destino
FROM tbl_solicitante s
INNER JOIN tbl_usuario u ON s.id_usuario = u.id_usuario
INNER JOIN tbl_form_eligibilidadCVA fe ON s.id_solicitante = fe.id_solicitante;



-- Tabla para registro de logs de solicitantes
CREATE TABLE tbl_log_solicitante (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    log_msg VARCHAR(255),
    fecha_log TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



-- Trigger para registrar una inserción en tbl_solicitante
DELIMITER $$
CREATE TRIGGER after_solicitante_insert
AFTER INSERT ON tbl_solicitante
FOR EACH ROW
BEGIN
    DECLARE nombre_completo VARCHAR(100);
    SELECT CONCAT(nombres, ' ', apellidos) INTO nombre_completo
    FROM tbl_usuario
    WHERE id_usuario = NEW.id_usuario;
    
    INSERT INTO tbl_log_solicitante (log_msg)
    VALUES (CONCAT('Nuevo solicitante añadido: ', nombre_completo));
END $$
DELIMITER ;

-- Trigger para registrar una eliminación en tbl_solicitante
DELIMITER $$
CREATE TRIGGER after_solicitante_delete
BEFORE DELETE ON tbl_solicitante
FOR EACH ROW
BEGIN
    DECLARE nombre_completo VARCHAR(100);
    SELECT CONCAT(nombres, ' ', apellidos) INTO nombre_completo
    FROM tbl_usuario
    WHERE id_usuario = OLD.id_usuario;
    
    INSERT INTO tbl_log_solicitante (log_msg)
    VALUES (CONCAT('Solicitante eliminado: ', nombre_completo));
END $$
DELIMITER ;

-- Índices
-- Índice en el campo correo de tbl_usuario
CREATE INDEX idx_correo_usuario ON tbl_usuario(correo);

-- Índice en el campo codigo_pasaporte de tbl_form_eligibilidadCVA
CREATE INDEX idx_codigo_pasaporte ON tbl_form_eligibilidadCVA(codigo_pasaporte);
