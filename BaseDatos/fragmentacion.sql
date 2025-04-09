-- Script para fragmentación de la base de datos del Centro Acuático
-- Este script contiene la fragmentación de la base de datos del Centro Acuático en dos nodos:
-- 1. Nodo de Datos Administrativos
-- 2. Nodo de Datos Personales

USE `centroacuatico` ;

-- -----------------------------------------------------
-- Fragmentación Horizontal por Sucursal
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
-- Fragmentación Vertical para Nodo de Datos Personales
-- -----------------------------------------------------
CREATE TABLE alumno_PA1 AS
SELECT idalumno, alumnoNombre, alumnoApellidop, alumnoApellidom, alumnoTelefono, alumnoCorreo, alumnoFechaNac, contactoE_idcontactoE, direccion_idDireccion
FROM alumno_FA1;

CREATE TABLE alumno_PA2 AS
SELECT idalumno, alumnoNombre, alumnoApellidop, alumnoApellidom, alumnoTelefono, alumnoCorreo, alumnoFechaNac, contactoE_idcontactoE, direccion_idDireccion
FROM alumno_FA2;

CREATE TABLE alumno_PA3 AS
SELECT idalumno, alumnoNombre, alumnoApellidop, alumnoApellidom, alumnoTelefono, alumnoCorreo, alumnoFechaNac, contactoE_idcontactoE, direccion_idDireccion
FROM alumno_FA3;

CREATE TABLE alumno_PA4 AS
SELECT idalumno, alumnoNombre, alumnoApellidop, alumnoApellidom, alumnoTelefono, alumnoCorreo, alumnoFechaNac, contactoE_idcontactoE, direccion_idDireccion
FROM alumno_FA4;

CREATE TABLE alumno_PA5 AS
SELECT idalumno, alumnoNombre, alumnoApellidop, alumnoApellidom, alumnoTelefono, alumnoCorreo, alumnoFechaNac, contactoE_idcontactoE, direccion_idDireccion
FROM alumno_FA5;

-- -----------------------------------------------------
-- Fragmentación Vertical para Nodo de Datos Administrativos
-- -----------------------------------------------------
CREATE TABLE alumno_AA1 AS
SELECT idalumno, alumnoFechaInscripcion, tipoAlumno_idtipoAlumno, nivelAlumno_idnivelAlumno, sucursal_idSucursal
FROM alumno_FA1;

CREATE TABLE alumno_AA2 AS
SELECT idalumno, alumnoFechaInscripcion, tipoAlumno_idtipoAlumno, nivelAlumno_idnivelAlumno, sucursal_idSucursal
FROM alumno_FA2;

CREATE TABLE alumno_AA3 AS
SELECT idalumno, alumnoFechaInscripcion, tipoAlumno_idtipoAlumno, nivelAlumno_idnivelAlumno, sucursal_idSucursal
FROM alumno_FA3;

CREATE TABLE alumno_AA4 AS
SELECT idalumno, alumnoFechaInscripcion, tipoAlumno_idtipoAlumno, nivelAlumno_idnivelAlumno, sucursal_idSucursal
FROM alumno_FA4;

CREATE TABLE alumno_AA5 AS
SELECT idalumno, alumnoFechaInscripcion, tipoAlumno_idtipoAlumno, nivelAlumno_idnivelAlumno, sucursal_idSucursal
FROM alumno_FA5;

-- -----------------------------------------------------
-- Fragmentación Horizontal Derivada para la tabla Pago
-- -----------------------------------------------------
CREATE TABLE pago_FA1 AS
SELECT * FROM pago
WHERE alumno_idalumno IN (SELECT idalumno FROM alumno_FA1);

CREATE TABLE pago_FA2 AS
SELECT * FROM pago
WHERE alumno_idalumno IN (SELECT idalumno FROM alumno_FA2);

CREATE TABLE pago_FA3 AS
SELECT * FROM pago
WHERE alumno_idalumno IN (SELECT idalumno FROM alumno_FA3);

CREATE TABLE pago_FA4 AS
SELECT * FROM pago
WHERE alumno_idalumno IN (SELECT idalumno FROM alumno_FA4);

CREATE TABLE pago_FA5 AS
SELECT * FROM pago
WHERE alumno_idalumno IN (SELECT idalumno FROM alumno_FA5);

-- -----------------------------------------------------
-- Fragmentación Horizontal Derivada para la tabla Horario
-- -----------------------------------------------------
CREATE TABLE horario_FA1 AS
SELECT * FROM horario
WHERE sucursal_idSucursal = 1;

CREATE TABLE horario_FA2 AS
SELECT * FROM horario
WHERE sucursal_idSucursal = 2;

CREATE TABLE horario_FA3 AS
SELECT * FROM horario
WHERE sucursal_idSucursal = 3;

CREATE TABLE horario_FA4 AS
SELECT * FROM horario
WHERE sucursal_idSucursal = 4;

CREATE TABLE horario_FA5 AS
SELECT * FROM horario
WHERE sucursal_idSucursal = 5;