-- Script para Nodo de Datos Personales
-- Este nodo contendrá información relacionada con los alumnos y sus contactos de emergencia.

USE `centroacuatico` ;

-- Fragmentos de Datos Personales
CREATE TABLE alumno_PA1 AS
SELECT idalumno, alumnoNombre, alumnoApellidop, alumnoApellidom, alumnoTelefono, alumnoCorreo, alumnoFechaNac, contactoE_idcontactoE, direccion_idDireccion
FROM centroacuatico.alumno_FA1;

CREATE TABLE alumno_PA2 AS
SELECT idalumno, alumnoNombre, alumnoApellidop, alumnoApellidom, alumnoTelefono, alumnoCorreo, alumnoFechaNac, contactoE_idcontactoE, direccion_idDireccion
FROM centroacuatico.alumno_FA2;

CREATE TABLE alumno_PA3 AS
SELECT idalumno, alumnoNombre, alumnoApellidop, alumnoApellidom, alumnoTelefono, alumnoCorreo, alumnoFechaNac, contactoE_idcontactoE, direccion_idDireccion
FROM centroacuatico.alumno_FA3;

CREATE TABLE alumno_PA4 AS
SELECT idalumno, alumnoNombre, alumnoApellidop, alumnoApellidom, alumnoTelefono, alumnoCorreo, alumnoFechaNac, contactoE_idcontactoE, direccion_idDireccion
FROM centroacuatico.alumno_FA4;

CREATE TABLE alumno_PA5 AS
SELECT idalumno, alumnoNombre, alumnoApellidop, alumnoApellidom, alumnoTelefono, alumnoCorreo, alumnoFechaNac, contactoE_idcontactoE, direccion_idDireccion
FROM centroacuatico.alumno_FA5;