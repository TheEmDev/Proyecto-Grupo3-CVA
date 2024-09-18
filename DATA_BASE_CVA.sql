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

--Inserciones en las tablas

-- Inserción de datos en tbl_usuario
INSERT INTO tbl_usuario (fecha_nacimiento, correo, contrasena, nombres, apellidos)
VALUES
('1990-01-15', 'juan.perez@example.com', 'password1', 'Juan', 'Pérez'),
('1985-02-20', 'maria.gomez@example.com', 'password2', 'María', 'Gómez'),
('1992-03-30', 'pedro.martinez@example.com', 'password3', 'Pedro', 'Martínez'),
('1988-04-10', 'luisa.fernandez@example.com', 'password4', 'Luisa', 'Fernández'),
('1995-05-25', 'ana.rodriguez@example.com', 'password5', 'Ana', 'Rodríguez'),
('1982-06-05', 'carlos.lopez@example.com', 'password6', 'Carlos', 'López'),
('1993-07-18', 'sofia.garcia@example.com', 'password7', 'Sofía', 'García');

-- Inserción de datos en tbl_administrador
INSERT INTO tbl_administrador (id_usuario)
VALUES 
(1), (2), (3), (4), (5), (6), (7);

-- Inserción de datos en tbl_solicitante
INSERT INTO tbl_solicitante (id_usuario)
VALUES 
(3), (4), (5), (6), (7), (1), (2);

-- Inserción de datos en tbl_asesor
INSERT INTO tbl_asesor (id_usuario)
VALUES 
(1), (2), (3), (4), (5), (6), (7);

-- Inserción de datos en tbl_form_eligibilidadCVA
INSERT INTO tbl_form_eligibilidadCVA (motivo_viaje, codigo_pasaporte, pais_residencia, familiares_canada, relacion_familiares_can, estado_civil, provincia_destino, trabajo_actual, negocios_actuales, co_deudor, viajes_recientes, acompanante_canada, antecedente_judiciales, examenes_medicos, aplicacion_familiares, acceso_aplicacion, biometricos_canada, pago_tasas, metodo_pago, id_solicitante)
VALUES
('Turismo', 'AB12345', 'México', 'No', '', 'Soltero', 'Ontario', 'Ingeniero', '', 'No', 'Sí', 'No', 'No', 'No', 'No', 'No', 'No', 'Crédito', 3),
('Trabajo', 'BC23456', 'España', 'Sí', 'Hermano', 'Casado', 'Quebec', 'Profesor', '', 'No', 'No', 'No', 'No', 'No', 'No', 'No', 'Sí', 'Paypal', 4),
('Estudios', 'CD34567', 'Argentina', 'No', '', 'Soltero', 'Manitoba', 'Estudiante', '', 'No', 'Sí', 'No', 'No', 'No', 'No', 'No', 'No', 'Efectivo', 5),
('Residencia', 'DE45678', 'Perú', 'No', '', 'Divorciado', 'British Columbia', 'Empresario', '', 'No', 'No', 'No', 'No', 'No', 'No', 'No', 'No', 'Transferencia', 6),
('Inmigración', 'EF56789', 'Colombia', 'Sí', 'Padre', 'Casado', 'Alberta', 'Médico', '', 'No', 'No', 'No', 'No', 'No', 'No', 'No', 'Sí', 'Débito', 7),
('Visita familiar', 'FG67890', 'Chile', 'No', '', 'Viudo', 'Nova Scotia', 'Artista', '', 'No', 'No', 'No', 'No', 'No', 'No', 'No', 'No', 'Paypal', 1),
('Conferencia', 'GH78901', 'Brasil', 'Sí', 'Tía', 'Soltero', 'Saskatchewan', 'Conferencista', '', 'Sí', 'Sí', 'No', 'No', 'No', 'No', 'No', 'No', 'Tarjeta', 2);

-- Inserción de datos en tbl_form_familiarCVA
INSERT INTO tbl_form_familiarCVA (aplicante, conyugue, madre, padre, hijos, hermanos, id_formElegibilidad)
VALUES
('Juan Pérez', 'María González', 'Rosa Pérez', 'Carlos Pérez', '["Hijo1", "Hijo2"]', '["Hermano1"]', 1),
('Pedro Martínez', 'Ana López', 'Carmen Martínez', 'Miguel Martínez', '["Hijo1"]', '["Hermano1", "Hermano2"]', 2),
('Luisa Fernández', '', 'Juana Fernández', 'Luis Fernández', '[]', '["Hermano1"]', 3),
('Ana Rodríguez', '', 'Marta Rodríguez', 'Pedro Rodríguez', '[]', '[]', 4),
('Carlos López', 'Sofía Ramírez', 'Laura López', 'José López', '["Hijo1"]', '["Hermano1", "Hermano2"]', 5),
('Sofía García', '', 'Isabel García', 'Fernando García', '[]', '[]', 6),
('María Gómez', 'Juan Torres', 'Teresa Gómez', 'Luis Gómez', '["Hijo1", "Hijo2", "Hijo3"]', '["Hermano1"]', 7);

-- Inserción de datos en tbl_documentos_adjuntos
INSERT INTO tbl_documentos_adjuntos (historial_viajes, pasaporte, comprobante_recursos_financieros, comprobante_mediosApoyo, foto_digital, proposito_viaje, prueba_estadoCivil, informacion_familiar, aplicacion_IMM5257, informacion_cliente, id_formElegibilidad)
VALUES
('Historial viajes 1', 'Pasaporte 1', 'Comprobante recursos 1', 'Comprobante medios 1', 'Foto 1', 'Propósito viaje 1', 'Prueba estado civil 1', 'Información familiar 1', 'IMM5257_1', 'Info cliente 1', 1),
('Historial viajes 2', 'Pasaporte 2', 'Comprobante recursos 2', 'Comprobante medios 2', 'Foto 2', 'Propósito viaje 2', 'Prueba estado civil 2', 'Información familiar 2', 'IMM5257_2', 'Info cliente 2', 2),
('Historial viajes 3', 'Pasaporte 3', 'Comprobante recursos 3', 'Comprobante medios 3', 'Foto 3', 'Propósito viaje 3', 'Prueba estado civil 3', 'Información familiar 3', 'IMM5257_3', 'Info cliente 3', 3),
('Historial viajes 4', 'Pasaporte 4', 'Comprobante recursos 4', 'Comprobante medios 4', 'Foto 4', 'Propósito viaje 4', 'Prueba estado civil 4', 'Información familiar 4', 'IMM5257_4', 'Info cliente 4', 4),
('Historial viajes 5', 'Pasaporte 5', 'Comprobante recursos 5', 'Comprobante medios 5', 'Foto 5', 'Propósito viaje 5', 'Prueba estado civil 5', 'Información familiar 5', 'IMM5257_5', 'Info cliente 5', 5),
('Historial viajes 6', 'Pasaporte 6', 'Comprobante recursos 6', 'Comprobante medios 6', 'Foto 6', 'Propósito viaje 6', 'Prueba estado civil 6', 'Información familiar 6', 'IMM5257_6', 'Info cliente 6', 6),
('Historial viajes 7', 'Pasaporte 7', 'Comprobante recursos 7', 'Comprobante medios 7', 'Foto 7', 'Propósito viaje 7', 'Prueba estado civil 7', 'Información familiar 7', 'IMM5257_7', 'Info cliente 7', 7);

-- Inserción de datos en tbl_asesoria
INSERT INTO tbl_asesoria (fecha_asesoria, asesor_asignado, id_solicitante, id_asesor)
VALUES
('2023-01-15 10:00:00', 'Juan Pérez', 3, 1),
('2023-02-20 11:30:00', 'María Gómez', 4, 2),
('2023-03-30 09:45:00', 'Pedro Martínez', 5, 3),
('2023-04-10 14:00:00', 'Luisa Fernández', 6, 4),
('2023-05-25 16:15:00', 'Ana Rodríguez', 7, 5),
('2023-06-05 13:00:00', 'Carlos López', 1, 6),
('2023-07-18 08:30:00', 'Sofía García', 2, 7);

-- Inserción de datos en tbl_pago
INSERT INTO tbl_pago (metodo_pago, total_pago, id_solicitante)
VALUES
('Crédito', 500.00, 3),
('Paypal', 700.00, 4),
('Efectivo', 300.00, 5),
('Transferencia', 450.00, 6),
('Débito', 650.00, 7),
('Paypal', 550.00, 1),
('Tarjeta', 600.00, 2);


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
