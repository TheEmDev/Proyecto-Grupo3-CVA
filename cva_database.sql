CREATE DATABASE IF NOT EXISTS cva_database;
USE cva_database;

-- Tabla Administrador
CREATE TABLE tbl_administrador (
    adm_id_administrador INT(12) PRIMARY KEY,
    adm_nombres VARCHAR(30),
    adm_apellidos VARCHAR(30),
    adm_contrasena VARCHAR(20),
    adm_permisos VARCHAR(50),
    adm_codigo_consulta VARCHAR(10)
);

-- Tabla Usuario Solicitante
CREATE TABLE tbl_usuario_solicitante (
    sol_id_usuario INT(12) PRIMARY KEY,
    sol_nombres VARCHAR(30),
    sol_apellidos VARCHAR(30),
    sol_email VARCHAR(50),
    sol_contrasena VARCHAR(20),
    sol_id_administrador INT(12),
    sol_numero_seguimiento VARCHAR(12),
    FOREIGN KEY (sol_id_administrador) REFERENCES tbl_administrador(adm_id_administrador)
);

-- Tabla Solicitud Visa
CREATE TABLE tbl_solicitud_visa (
    vis_id_solicitud INT(12) PRIMARY KEY,
    vis_id_usuario INT(12),
    vis_formulario_aplicacion VARCHAR(20),
    vis_fecha_solicitud VARCHAR(20),
    vis_tipo_visa VARCHAR(20),
    vis_numero_formulario INT(12),
    FOREIGN KEY (vis_id_usuario) REFERENCES tbl_usuario_solicitante(sol_id_usuario)
);

-- Tabla Asesor
CREATE TABLE tbl_asesor (
    ase_id_asesor INT(12) PRIMARY KEY,
    ase_apellidos VARCHAR(30),
    ase_telefono VARCHAR(15),
    ase_email VARCHAR(50),
    ase_nombres VARCHAR(30),
    ase_id_solicitud INT(12),
    FOREIGN KEY (ase_id_solicitud) REFERENCES tbl_solicitud_visa(vis_id_solicitud)
);

-- Tabla Consultas
CREATE TABLE tbl_consultas (
    con_codigo_consulta VARCHAR(10) PRIMARY KEY,
    con_solicitante VARCHAR(30),
    con_asesor_asignado VARCHAR(30),
    con_disponibilidad VARCHAR(50),
    con_id_asesor INT(12),
    FOREIGN KEY (con_id_asesor) REFERENCES tbl_asesor(ase_id_asesor)
);

-- Tabla Chat Bot
CREATE TABLE tbl_chat_bot (
    cha_codigo_chat_bot VARCHAR(10) PRIMARY KEY,
    cha_nombre VARCHAR(20),
    cha_id_usuario INT(12),
    FOREIGN KEY (cha_id_usuario) REFERENCES tbl_usuario_solicitante(sol_id_usuario)
);

-- Tabla Seguimiento Solicitud
CREATE TABLE tbl_seguimiento_solicitud (
    seg_id_solicitud INT(10),
    seg_id_usuario INT(10),
    seg_fecha_solicitud VARCHAR(20),
    seg_numero_seguimiento VARCHAR(12) PRIMARY KEY,
    FOREIGN KEY (seg_id_usuario) REFERENCES tbl_usuario_solicitante(sol_id_usuario)
);

-- Tabla Pago
CREATE TABLE tbl_pago (
    pag_id_solicitud INT(10) PRIMARY KEY,
    pag_metodo_pago VARCHAR(20),
    pag_estado VARCHAR(20),
    pag_id_usuario INT(12),
    pag_monto DECIMAL(10, 2),
    FOREIGN KEY (pag_id_usuario) REFERENCES tbl_usuario_solicitante(sol_id_usuario)
);

-- Tabla Formulario Solicitud
CREATE TABLE tbl_formulario_solicitud (
    for_numero_formulario INT(11) PRIMARY KEY,
    for_id_solicitud INT(12),
    for_id_usuario INT(12),
    for_info_personal VARCHAR(200),
    for_info_familiar VARCHAR(200),
    for_historial_laboral VARCHAR(200),
    for_historial_policial VARCHAR(200),
    for_historial_financiero VARCHAR(200),
    for_historial_viajes VARCHAR(200),
    FOREIGN KEY (for_id_solicitud) REFERENCES tbl_solicitud_visa(vis_id_solicitud),
    FOREIGN KEY (for_id_usuario) REFERENCES tbl_usuario_solicitante(sol_id_usuario)
);
