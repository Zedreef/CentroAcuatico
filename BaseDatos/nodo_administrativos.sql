-- Script para Nodo de Datos Administrativos
-- Este nodo contendrá información administrativa como inscripciones, pagos, horarios y niveles de los alumnos. 

USE `centroacuatico` ;

-- Fragmentos de Datos Administrativos
CREATE TABLE alumno_AA1 AS
SELECT idalumno, alumnoFechaInscripcion, tipoAlumno_idtipoAlumno, nivelAlumno_idnivelAlumno, sucursal_idSucursal
FROM centroacuatico.alumno_FA1;

CREATE TABLE alumno_AA2 AS
SELECT idalumno, alumnoFechaInscripcion, tipoAlumno_idtipoAlumno, nivelAlumno_idnivelAlumno, sucursal_idSucursal
FROM centroacuatico.alumno_FA2;

CREATE TABLE alumno_AA3 AS
SELECT idalumno, alumnoFechaInscripcion, tipoAlumno_idtipoAlumno, nivelAlumno_idnivelAlumno, sucursal_idSucursal
FROM centroacuatico.alumno_FA3;

CREATE TABLE alumno_AA4 AS
SELECT idalumno, alumnoFechaInscripcion, tipoAlumno_idtipoAlumno, nivelAlumno_idnivelAlumno, sucursal_idSucursal
FROM centroacuatico.alumno_FA4;

CREATE TABLE alumno_AA5 AS
SELECT idalumno, alumnoFechaInscripcion, tipoAlumno_idtipoAlumno, nivelAlumno_idnivelAlumno, sucursal_idSucursal
FROM centroacuatico.alumno_FA5;

-- Fragmentos de Pagos
CREATE TABLE pago_FA1 AS
SELECT * FROM centroacuatico.pago
WHERE alumno_idalumno IN (SELECT idalumno FROM centroacuatico.alumno_FA1);

CREATE TABLE pago_FA2 AS
SELECT * FROM centroacuatico.pago
WHERE alumno_idalumno IN (SELECT idalumno FROM centroacuatico.alumno_FA2);

CREATE TABLE pago_FA3 AS
SELECT * FROM centroacuatico.pago
WHERE alumno_idalumno IN (SELECT idalumno FROM centroacuatico.alumno_FA3);

CREATE TABLE pago_FA4 AS
SELECT * FROM centroacuatico.pago
WHERE alumno_idalumno IN (SELECT idalumno FROM centroacuatico.alumno_FA4);

CREATE TABLE pago_FA5 AS
SELECT * FROM centroacuatico.pago
WHERE alumno_idalumno IN (SELECT idalumno FROM centroacuatico.alumno_FA5);

-- Fragmentos de Horarios
CREATE TABLE horario_FA1 AS
SELECT * FROM centroacuatico.horario
WHERE sucursal_idSucursal = 1;

CREATE TABLE horario_FA2 AS
SELECT * FROM centroacuatico.horario
WHERE sucursal_idSucursal = 2;

CREATE TABLE horario_FA3 AS
SELECT * FROM centroacuatico.horario
WHERE sucursal_idSucursal = 3;

CREATE TABLE horario_FA4 AS
SELECT * FROM centroacuatico.horario
WHERE sucursal_idSucursal = 4;

CREATE TABLE horario_FA5 AS
SELECT * FROM centroacuatico.horario
WHERE sucursal_idSucursal = 5;