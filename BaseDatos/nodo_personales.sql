-- Script para Nodo de Datos Personales
-- Este nodo contendrá información relacionada con los alumnos y sus contactos de emergencia.
DROP database IF EXISTS `nodo_personales` ;

CREATE DATABASE IF NOT EXISTS `nodo_personales` DEFAULT CHARACTER SET utf8;
USE `nodo_personales`;

-- -----------------------------------------------------
-- Table `nodo_personales`.`sucursal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nodo_personales`.`sucursal` (
  `idSucursal` INT NOT NULL AUTO_INCREMENT,
  `sucursalNombre` VARCHAR(100) NOT NULL,
  `sucursalDireccion` VARCHAR(255) NOT NULL,
  `sucursalTelefono` VARCHAR(20) NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idSucursal`)
) ;

-- -----------------------------------------------------
-- Table `nodo_personales`.`direccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nodo_personales`.`direccion` (
  `idDireccion` INT NOT NULL AUTO_INCREMENT,
  `direccionCalle` VARCHAR(150) NULL,
  `direccionNumero` INT NULL,
  `codigoPostal` INT NULL,
  PRIMARY KEY (`idDireccion`)
);

-- -----------------------------------------------------
-- Table `nodo_personales`.`parentesco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nodo_personales`.`parentesco` (
  `idParentesco` INT NOT NULL AUTO_INCREMENT,
  `parentescoNombre` VARCHAR(45) NULL,
  `parentescoDescripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`idParentesco`)
);

-- -----------------------------------------------------
-- Table `nodo_personales`.`contactoE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nodo_personales`.`contactoE` (
  `idcontactoE` INT NOT NULL AUTO_INCREMENT,
  `contactoENombre` VARCHAR(45) NULL,
  `contactoETelefono` VARCHAR(45) NULL,
  `parentesco_idParentesco` INT NOT NULL,
  `direccion_idDireccion` INT NOT NULL,
  PRIMARY KEY (`idcontactoE`),
  INDEX `fk_contactoE_Parentesco_idx` (`parentesco_idParentesco` ASC) ,
  INDEX `fk_contactoE_direccion1_idx` (`direccion_idDireccion` ASC) ,
    CONSTRAINT `fk_contactoE_Parentesco`
        FOREIGN KEY (`parentesco_idParentesco`)
        REFERENCES `nodo_personales`.`parentesco` (`idParentesco`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT `fk_contactoE_direccion1`
        FOREIGN KEY (`direccion_idDireccion`)
        REFERENCES `nodo_personales`.`direccion` (`idDireccion`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- Table `nodo_personales`.`alumno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nodo_personales`.`alumno` (
  `idalumno` INT NOT NULL AUTO_INCREMENTalumno,
  `alumnoNombre` VARCHAR(45) NULL,
  `alumnoApellidop` VARCHAR(45) NULL,
  `alumnoApellidom` VARCHAR(45) NULL,
  `alumnoTelefono` VARCHAR(45) NULL,
  `alumnoCorreo` VARCHAR(45) NULL,
  `alumnoFechaNac` DATE,
  `contactoE_idcontactoE` INT NOT NULL,
  `direccion_idDireccion` INT NOT NULL,
  `sucursal_idSucursal` INT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idalumno`),
    INDEX `fk_alumno_contactoE1_idx` (`contactoE_idcontactoE` ASC) ,
    INDEX `fk_alumno_direccion1_idx` (`direccion_idDireccion` ASC) ,
    CONSTRAINT `fk_alumno_contactoE1`
      FOREIGN KEY (`contactoE_idcontactoE`)
      REFERENCES `nodo_personales`.`contactoE` (`idcontactoE`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
    CONSTRAINT `fk_alumno_direccion1`
      FOREIGN KEY (`direccion_idDireccion`)
      REFERENCES `nodo_personales`.`direccion` (`idDireccion`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
    CONSTRAINT `fk_alumno_sucursal1`
      FOREIGN KEY (`sucursal_idSucursal`)
      REFERENCES `nodo_personales`.`sucursal` (`idsucursal`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- llenado de datos de la tabla sucursal:
-- -----------------------------------------------------
INSERT INTO `nodo_personales`.`sucursal` (`idSucursal`, `sucursalNombre`, `sucursalDireccion`, `sucursalTelefono`,`created_at`, `updated_at`)
VALUES 
(NULL, 'Sucursal Centro', 'Calle Principal 123, Centro', '555-1234',CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, 'Sucursal Norte', 'Avenida Norte 456, Norte', '555-5678',CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, 'Sucursal Sur', 'Boulevard Sur 789, Sur', '555-9012',CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, 'Sucursal Este', 'Calle Este 101, Este', '555-3456',CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, 'Sucursal Oeste', 'Avenida Oeste 202, Oeste', '555-7890',CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- -----------------------------------------------------
-- llenado de datos de la tabla direccion:
-- -----------------------------------------------------
INSERT INTO `nodo_personales`.`direccion` (`idDireccion`, `direccionCalle`, `direccionNumero`, `codigoPostal`)
VALUES 
(NULL, 'Calle Falsa', 123, 03300),
(NULL, 'Avenida Siempre Viva', 742, 017847),
(NULL, 'Boulevard de los Sueños Rotos', 456, 004785),
(NULL, 'Calle de la Amargura', 789, 000047),
(NULL, 'Avenida de la Felicidad', 101, 0140674),
(NULL, 'Boulevard de los Recuerdos', 202, 001597),
(NULL, 'Calle de la Esperanza', 303, 001472),
(NULL, 'Avenida de los Sueños', 404, 003684),
(NULL, 'Boulevard de la Paz', 505, 0015974),
(NULL, 'Calle de la Alegría', 606, 010753);

-- -----------------------------------------------------
#Llenado de la tabla Parentesco
-- -----------------------------------------------------
insert into nodo_personales.parentesco values 
(null,"Hermano/a","familiar directo"),
(null, "Padre", "familiar directo"),
(null, "Madre", "familiar directo"),
(null, "Hijo/a", "familiar directo"),
(null, "Esposo/a", "familiar directo"),
(null, "Abuelo/a", "familiar directo"),
(null, "Nieto/a", "familiar directo"),
(null, "Tio/a", "familiar directo"),
(null, "Sobrino/a", "familiar directo"),
(null, "Pareja", "familiar directo"),
(null, "Primo/a", "familiar directo"),
(null, "Doctor/a", "personal médico"),
(null, "Vecino", "no es familiar"),
(null, "Amigo/a", "no es familiar"),
(null, "Otro", "relación no especificada");

-- -----------------------------------------------------
-- llenado de datos de la tabla ContactoE:
-- -----------------------------------------------------
INSERT INTO `nodo_personales`.`contactoE` (`idcontactoE`, `contactoENombre`, `contactoETelefono`, `parentesco_idParentesco`, `direccion_idDireccion`)
VALUES 
(NULL, 'Pedro Pérez', '555-4444', 1, 1),
(NULL, 'Ana López', '555-5555', 2, 2),
(NULL, 'Luis Hernández', '555-6666', 3, 3),
(NULL, 'Marta García', '555-7777', 4, 4),
(NULL, 'Jorge Martínez', '555-8888', 5, 5),
(NULL, 'Laura Rodríguez', '555-9999', 6, 6),
(NULL, 'Carlos Gómez', '555-0000', 7, 7),
(NULL, 'Sofía Díaz', '555-1111', 8, 8),
(NULL, 'Miguel Fernández', '555-2222', 9, 9),
(NULL, 'Lucía Ruiz', '555-3333', 10, 10);

-- -----------------------------------------------------
-- llenado de datos de la tabla alumno:
-- -----------------------------------------------------
INSERT INTO `nodo_personales`.`alumno` (`idalumno`, `alumnoNombre`, `alumnoApellidop`, `alumnoApellidom`, `alumnoTelefono`, `alumnoCorreo`, `alumnoFechaNac`, `contactoE_idcontactoE`, `direccion_idDireccion`, `sucursal_idSucursal`, `created_at`, `updated_at`)
VALUES 
(NULL, 'Juan', 'Pérez', 'Gómez', '555-1111', 'juan@example.com', '2005-01-01', 1, 1, 1,CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, 'María', 'López', 'Martínez', '555-2222', 'maria@example.com', '2006-02-02', 2, 2, 2,CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, 'Carlos', 'Hernández', 'Rodríguez', '555-3333', 'carlos@example.com', '2007-03-03', 3, 3, 3,CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, 'Ana', 'Martínez', 'García', '555-4444', 'ana@example.com', '2008-04-04', 4, 4, 4,CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, 'Luis', 'Rodríguez', 'Sánchez', '555-5555', 'luis@example.com', '2009-05-05', 5, 5, 5,CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, 'Sofía', 'Díaz', 'Fernández', '555-6666', 'sofia@example.com', '2010-06-06', 6, 6, 2,CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, 'Pedro', 'Gómez', 'Ruiz', '555-7777', 'pedro@example.com', '2011-07-07', 7, 7, 4,CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, 'Laura', 'Fernández', 'Díaz', '555-8888', 'laura@example.com', '2012-08-08', 8, 8, 2,CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, 'Jorge', 'Ruiz', 'Gómez', '555-9999', 'jorge@example.com', '2013-09-09', 9, 9, 1,CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, 'Marta', 'García', 'López', '555-0000', 'marta@example.com', '2014-10-10', 10, 10, 1,CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- -----------------------------------------------------
-- Fragmentación Horizontal por Sucursal
-- Fragmentos de Datos Personales
-- -----------------------------------------------------
CREATE TABLE alumno_FA1 AS
SELECT * FROM alumno
WHERE sucursal_idSucursal = 1;

CREATE TABLE alumno_FA2 AS
SELECT * FROM alumno
WHERE sucursal_idSucursal = 2;

CREATE TABLE alumno_FA3 AS
SELECT * FROM alumno
WHERE sucursal_idSucursal = 3;

CREATE TABLE alumno_FA4 AS
SELECT * FROM alumno
WHERE sucursal_idSucursal = 4;

CREATE TABLE alumno_FA5 AS
SELECT * FROM alumno
WHERE sucursal_idSucursal = 5;


-- -----------------------------------------------------
-- Fragmentos de Contacto Emergencia
-- -----------------------------------------------------
CREATE TABLE contactoE_PA1 AS
SELECT * FROM contactoE
WHERE idcontactoE IN (SELECT contactoE_idcontactoE FROM alumno_FA1);

CREATE TABLE contactoE_PA2 AS
SELECT * FROM contactoE
WHERE idcontactoE IN (SELECT contactoE_idcontactoE FROM alumno_FA2);

CREATE TABLE contactoE_PA3 AS
SELECT * FROM contactoE
WHERE idcontactoE IN (SELECT contactoE_idcontactoE FROM alumno_FA3);

CREATE TABLE contactoE_PA4 AS
SELECT * FROM contactoE
WHERE idcontactoE IN (SELECT contactoE_idcontactoE FROM alumno_FA4);

CREATE TABLE contactoE_PA5 AS
SELECT * FROM contactoE
WHERE idcontactoE IN (SELECT contactoE_idcontactoE FROM alumno_FA5);

-- -----------------------------------------------------
-- Fragmentos de direccion
-- -----------------------------------------------------
CREATE TABLE direccion_PA1 AS
SELECT * FROM direccion
WHERE idDireccion IN (SELECT direccion_idDireccion FROM alumno_FA1);

CREATE TABLE direccion_PA2 AS
SELECT * FROM direccion
WHERE idDireccion IN (SELECT direccion_idDireccion FROM alumno_FA2);

CREATE TABLE direccion_PA3 AS
SELECT * FROM direccion
WHERE idDireccion IN (SELECT direccion_idDireccion FROM alumno_FA3);

CREATE TABLE direccion_PA4 AS
SELECT * FROM direccion
WHERE idDireccion IN (SELECT direccion_idDireccion FROM alumno_FA4);

CREATE TABLE direccion_PA5 AS
SELECT * FROM direccion
WHERE idDireccion IN (SELECT direccion_idDireccion FROM alumno_FA5);