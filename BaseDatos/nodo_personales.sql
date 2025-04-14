-- Script para Nodo de Datos Personales
-- Este nodo contendrá información relacionada con los alumnos y sus contactos de emergencia.
-- DROP database IF EXISTS nodo_personales;

-- IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'nodo_personales')
-- BEGIN
--     CREATE DATABASE nodo_personales;
-- END;

USE nodo_personales;

/* -- -----------------------------------------------------
-- Table nodo_personales.sucursal
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS nodo_personales.sucursal (
  idSucursal INT NOT NULL AUTO_INCREMENT,
  sucursalNombre VARCHAR(100) NOT NULL,
  sucursalDireccion VARCHAR(255) NOT NULL,
  sucursalTelefono VARCHAR(20) NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (idSucursal)
) ; */

-- -----------------------------------------------------
-- Table nodo_personales.direccion
-- -----------------------------------------------------
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='direccion' AND xtype='U')
BEGIN
  CREATE TABLE direccion (
    idDireccion INT IDENTITY(1,1) NOT NULL,
    direccionCalle VARCHAR(150) NULL,
    direccionNumero INT NULL,
    codigoPostal INT NULL,
    PRIMARY KEY (idDireccion)
  );
END;

-- -----------------------------------------------------
-- Table nodo_personales.parentesco
-- -----------------------------------------------------
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='parentesco' AND xtype='U')
BEGIN
  CREATE TABLE parentesco (
    idParentesco INT IDENTITY(1,1) NOT NULL,
    parentescoNombre VARCHAR(45) NULL,
    parentescoDescripcion VARCHAR(45) NULL,
    PRIMARY KEY (idParentesco)
  );
END;

-- -----------------------------------------------------
-- Table nodo_personales.contactoE
-- -----------------------------------------------------
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='contactoE' AND xtype='U')
BEGIN
  CREATE TABLE contactoE (
    idcontactoE INT IDENTITY(1,1) NOT NULL,
    contactoENombre VARCHAR(45) NULL,
    contactoETelefono VARCHAR(45) NULL,
    parentesco_idParentesco INT NOT NULL,
    direccion_idDireccion INT NOT NULL,
    PRIMARY KEY (idcontactoE),
    INDEX fk_contactoE_Parentesco_idx (parentesco_idParentesco ASC),
    INDEX fk_contactoE_direccion1_idx (direccion_idDireccion ASC),
      CONSTRAINT fk_contactoE_Parentesco
          FOREIGN KEY (parentesco_idParentesco)
          REFERENCES parentesco (idParentesco)
          ON DELETE NO ACTION
          ON UPDATE NO ACTION,
      CONSTRAINT fk_contactoE_direccion1
          FOREIGN KEY (direccion_idDireccion)
          REFERENCES direccion (idDireccion)
          ON DELETE NO ACTION
          ON UPDATE NO ACTION
  );
END;

-- -----------------------------------------------------
-- Table nodo_personales.alumno
-- -----------------------------------------------------
IF OBJECT_ID('nodo_personales.alumno', 'U') IS NULL
BEGIN
    CREATE TABLE alumno (
        idalumno INT NOT NULL IDENTITY(1,1),
        alumnoNombre VARCHAR(45) NULL,
        alumnoApellidop VARCHAR(45) NULL,
        alumnoApellidom VARCHAR(45) NULL,
        alumnoTelefono VARCHAR(45) NULL,
        alumnoCorreo VARCHAR(45) NULL,
        alumnoFechaNac DATE,
        contactoE_idcontactoE INT NOT NULL,
        direccion_idDireccion INT NOT NULL,
        created_at DATETIME NOT NULL DEFAULT GETDATE(),
        updated_at DATETIME NOT NULL DEFAULT GETDATE(),
        PRIMARY KEY (idalumno),
        INDEX fk_alumno_contactoE1_idx (contactoE_idcontactoE ASC),
        INDEX fk_alumno_direccion1_idx (direccion_idDireccion ASC),
        CONSTRAINT fk_alumno_contactoE1
            FOREIGN KEY (contactoE_idcontactoE)
            REFERENCES contactoE (idcontactoE)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
        CONSTRAINT fk_alumno_direccion1
            FOREIGN KEY (direccion_idDireccion)
            REFERENCES direccion (idDireccion)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
    );
END;

-- -----------------------------------------------------
-- llenado de datos de la tabla sucursal:
-- -----------------------------------------------------
/* INSERT INTO nodo_personales.sucursal (idSucursal, sucursalNombre, sucursalDireccion, sucursalTelefono,created_at, updated_at)
VALUES 
(NULL, 'Sucursal Centro', 'Calle Principal 123, Centro', '555-1234',CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, 'Sucursal Norte', 'Avenida Norte 456, Norte', '555-5678',CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, 'Sucursal Sur', 'Boulevard Sur 789, Sur', '555-9012',CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, 'Sucursal Este', 'Calle Este 101, Este', '555-3456',CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, 'Sucursal Oeste', 'Avenida Oeste 202, Oeste', '555-7890',CURRENT_TIMESTAMP, CURRENT_TIMESTAMP); */

-- -----------------------------------------------------
-- llenado de datos de la tabla direccion:
-- -----------------------------------------------------
INSERT INTO direccion (direccionCalle, direccionNumero, codigoPostal)
VALUES 
('Calle Falsa', 123, 03300),
('Avenida Siempre Viva', 742, 017847),
('Boulevard de los Sueños Rotos', 456, 004785),
('Calle de la Amargura', 789, 000047),
('Avenida de la Felicidad', 101, 0140674),
('Boulevard de los Recuerdos', 202, 001597),
('Calle de la Esperanza', 303, 001472),
('Avenida de los Sueños', 404, 003684),
('Boulevard de la Paz', 505, 0015974),
('Calle de la Alegría', 606, 010753);

-- -----------------------------------------------------
-- Llenado de la tabla Parentesco
-- -----------------------------------------------------
INSERT INTO parentesco (idParentesco, parentescoNombre, parentescoDescripcion)
VALUES 
(NULL, 'Hermano/a', 'familiar directo'),
(NULL, 'Padre', 'familiar directo'),
(NULL, 'Madre', 'familiar directo'),
(NULL, 'Hijo/a', 'familiar directo'),
(NULL, 'Esposo/a', 'familiar directo'),
(NULL, 'Abuelo/a', 'familiar directo'),
(NULL, 'Nieto/a', 'familiar directo'),
(NULL, 'Tio/a', 'familiar directo'),
(NULL, 'Sobrino/a', 'familiar directo'),
(NULL, 'Pareja', 'familiar directo'),
(NULL, 'Primo/a', 'familiar directo'),
(NULL, 'Doctor/a', 'personal médico'),
(NULL, 'Vecino', 'no es familiar'),
(NULL, 'Amigo/a', 'no es familiar'),
(NULL, 'Otro', 'relación no especificada');

-- -----------------------------------------------------
-- llenado de datos de la tabla ContactoE:
-- -----------------------------------------------------
INSERT INTO contactoE (contactoENombre, contactoETelefono, parentesco_idParentesco, direccion_idDireccion)
VALUES 
('Pedro Pérez', '555-4444', 1, 1),
('Ana López', '555-5555', 2, 2),
('Luis Hernández', '555-6666', 3, 3),
('Marta García', '555-7777', 4, 4),
('Jorge Martínez', '555-8888', 5, 5),
('Laura Rodríguez', '555-9999', 6, 6),
('Carlos Gómez', '555-0000', 7, 7),
('Sofía Díaz', '555-1111', 8, 8),
('Miguel Fernández', '555-2222', 9, 9),
('Lucía Ruiz', '555-3333', 10, 10);

-- -----------------------------------------------------
-- llenado de datos de la tabla alumno:
-- -----------------------------------------------------
INSERT INTO alumno ( alumnoNombre, alumnoApellidop, alumnoApellidom, alumnoTelefono, alumnoCorreo, alumnoFechaNac, contactoE_idcontactoE, direccion_idDireccion, created_at, updated_at)
VALUES 
('Juan', 'Pérez', 'Gómez', '555-1111', 'juan@example.com', '2005-01-01', 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('María', 'López', 'Martínez', '555-2222', 'maria@example.com', '2006-02-02', 2, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Carlos', 'Hernández', 'Rodríguez', '555-3333', 'carlos@example.com', '2007-03-03', 3, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Ana', 'Martínez', 'García', '555-4444', 'ana@example.com', '2008-04-04', 4, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Luis', 'Rodríguez', 'Sánchez', '555-5555', 'luis@example.com', '2009-05-05', 5, 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Sofía', 'Díaz', 'Fernández', '555-6666', 'sofia@example.com', '2010-06-06', 6, 6, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Pedro', 'Gómez', 'Ruiz', '555-7777', 'pedro@example.com', '2011-07-07', 7, 7, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Laura', 'Fernández', 'Díaz', '555-8888', 'laura@example.com', '2012-08-08', 8, 8, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Jorge', 'Ruiz', 'Gómez', '555-9999', 'jorge@example.com', '2013-09-09', 9, 9, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Marta', 'García', 'López', '555-0000', 'marta@example.com', '2014-10-10', 10, 10, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);