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