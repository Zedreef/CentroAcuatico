-- Script para Nodo de Datos Administrativos
-- Este nodo contendrá información administrativa como inscripciones, pagos, horarios y niveles de los alumnos. 
-- DROP database IF EXISTS nodo_administrativos ;

-- CREATE DATABASE IF NOT EXISTS nodo_administrativos DEFAULT CHARACTER SET utf8;
USE nodo_administrativos;

-- -----------------------------------------------------
-- Tabla sucursal
-- -----------------------------------------------------
IF OBJECT_ID('sucursal', 'U') IS NULL
BEGIN
    CREATE TABLE sucursal (
        idSucursal INT NOT NULL IDENTITY(1,1),
        sucursalNombre VARCHAR(100) NOT NULL,
        sucursalDireccion VARCHAR(255) NOT NULL,
        sucursalTelefono VARCHAR(20) NULL,
        created_at DATETIME NOT NULL DEFAULT GETDATE(),
        updated_at DATETIME NOT NULL DEFAULT GETDATE(),
        PRIMARY KEY (idSucursal)
    );
END;

-- -----------------------------------------------------
-- Tabla tipoAlumno
-- -----------------------------------------------------
IF OBJECT_ID('tipoAlumno', 'U') IS NULL
BEGIN
    CREATE TABLE tipoAlumno (
        idtipoAlumno INT NOT NULL IDENTITY(1,1),
        tipoAlumnoNombre VARCHAR(45) NULL,
        tipoAlumnoDescripcion VARCHAR(150) NULL,
        PRIMARY KEY (idtipoAlumno)
    );
END;

-- -----------------------------------------------------
-- Tabla nivelAlumno
-- -----------------------------------------------------
IF OBJECT_ID('nivelAlumno', 'U') IS NULL
BEGIN
    CREATE TABLE nivelAlumno (
        idnivelAlumno INT NOT NULL IDENTITY(1,1),
        nivelAlumnoNombre VARCHAR(45) NULL,
        nivelAlumnoDescripcion VARCHAR(255) NULL,
        PRIMARY KEY (idnivelAlumno)
    );
END;

-- -----------------------------------------------------
-- Tabla tipoPago
-- -----------------------------------------------------
IF OBJECT_ID('tipoPago', 'U') IS NULL
BEGIN
    CREATE TABLE tipoPago (
        idTipoPago INT NOT NULL IDENTITY(1,1),
        tipoPagoNombre VARCHAR(45) NULL,
        tipoPagoDescripcion VARCHAR(45) NULL,
        PRIMARY KEY (idTipoPago)
    );
END;

-- -----------------------------------------------------
-- Tabla tipoHorario
-- -----------------------------------------------------
IF OBJECT_ID('tipoHorario', 'U') IS NULL
BEGIN
    CREATE TABLE tipoHorario (
        idtipoHorario INT NOT NULL IDENTITY(1,1),
        tipoHorarioNombre VARCHAR(45),
        PRIMARY KEY (idtipoHorario)
    );
END;

-- -----------------------------------------------------
-- Table centroacuatico.día
-- -----------------------------------------------------
IF OBJECT_ID('dia', 'U') IS NULL
BEGIN
    CREATE TABLE dia (
        idDia INT NOT NULL IDENTITY(1,1),
        diaNombre VARCHAR(45) NULL,
        diaDescripcion VARCHAR(45) NULL,
        PRIMARY KEY (idDia)
    );
END;

-- -----------------------------------------------------
-- Table centroacuatico.hora
-- -----------------------------------------------------
IF OBJECT_ID('hora', 'U') IS NULL
BEGIN
    CREATE TABLE hora (
        idHora INT NOT NULL IDENTITY(1,1),
        hora VARCHAR(45) NULL,
        PRIMARY KEY (idHora)
    );
END;

-- -----------------------------------------------------
-- Tabla diaHora
-- -----------------------------------------------------
IF OBJECT_ID('diaHora', 'U') IS NULL
BEGIN
    CREATE TABLE diaHora (
        idDiaHora INT NOT NULL IDENTITY(1,1),
        dia_idDia INT NOT NULL,
        diaHora_idHoraInicio INT NOT NULL,
        diaHora_idHoraFin INT NOT NULL,
        PRIMARY KEY (idDiaHora),
        FOREIGN KEY (dia_idDia) REFERENCES dia (idDia),
        FOREIGN KEY (diaHora_idHoraInicio) REFERENCES hora (idHora),
        FOREIGN KEY (diaHora_idHoraFin) REFERENCES hora (idHora)
    );
END;

-- -----------------------------------------------------
-- Tabla alumno (fragmento de datos administrativos)
-- -----------------------------------------------------
IF OBJECT_ID('alumno', 'U') IS NULL
BEGIN
    CREATE TABLE alumno (
        idalumno INT NOT NULL IDENTITY(1,1),
        alumnoFechaInscripcion DATE NOT NULL,
        tipoAlumno_idtipoAlumno INT NOT NULL,
        nivelAlumno_idnivelAlumno INT NOT NULL,
        sucursal_idSucursal INT NOT NULL,
        created_at DATETIME NOT NULL DEFAULT GETDATE(),
        updated_at DATETIME NOT NULL DEFAULT GETDATE(),
        PRIMARY KEY (idalumno),
        FOREIGN KEY (tipoAlumno_idtipoAlumno) REFERENCES tipoAlumno (idtipoAlumno),
        FOREIGN KEY (nivelAlumno_idnivelAlumno) REFERENCES nivelAlumno (idnivelAlumno),
        FOREIGN KEY (sucursal_idSucursal) REFERENCES sucursal (idSucursal)
    );
END;

-- -----------------------------------------------------
-- Tabla pago
-- -----------------------------------------------------
IF OBJECT_ID('pago', 'U') IS NULL
BEGIN
    CREATE TABLE pago (
        idMensualidad INT NOT NULL IDENTITY(1,1),
        mensualidadFecha DATE NOT NULL,
        tipoPago_idTipoPago INT NOT NULL,
        alumno_idalumno INT NOT NULL,
        numRecibo VARCHAR(45) NOT NULL,
        sucursal_idSucursal INT NOT NULL,
        created_at DATETIME NOT NULL DEFAULT GETDATE(),
        updated_at DATETIME NOT NULL DEFAULT GETDATE(),
        PRIMARY KEY (idMensualidad),
        FOREIGN KEY (tipoPago_idTipoPago) REFERENCES tipoPago (idTipoPago),
        FOREIGN KEY (alumno_idalumno) REFERENCES alumno (idalumno),
        FOREIGN KEY (sucursal_idSucursal) REFERENCES sucursal (idSucursal)
    );
END;


-- -----------------------------------------------------
-- Tabla horario
-- -----------------------------------------------------
IF OBJECT_ID('horario', 'U') IS NULL
BEGIN
    CREATE TABLE horario (
        idHorario INT NOT NULL IDENTITY(1,1),
        tipoHorario_idtipoHorario INT NOT NULL,
        diaHora_idDiaHora INT NOT NULL,
        sucursal_idSucursal INT NOT NULL,
        created_at DATETIME NOT NULL DEFAULT GETDATE(),
        updated_at DATETIME NOT NULL DEFAULT GETDATE(),
        PRIMARY KEY (idHorario),
        FOREIGN KEY (tipoHorario_idtipoHorario) REFERENCES tipoHorario (idtipoHorario),
        FOREIGN KEY (diaHora_idDiaHora) REFERENCES diaHora (idDiaHora),
        FOREIGN KEY (sucursal_idSucursal) REFERENCES sucursal (idSucursal)
    );
END;

-- -----------------------------------------------------
-- Inserciones de días
-- -----------------------------------------------------
INSERT INTO dia (diaNombre, diaDescripcion)
VALUES 
('Lunes', 'Día de la semana'),
('Martes', 'Día de la semana'),
('Miércoles', 'Día de la semana'),
('Jueves', 'Día de la semana'),
('Viernes', 'Día de la semana'),
('Sábado', 'Día de la semana'),
('Domingo', 'Día de la semana');

-- -----------------------------------------------------
-- Llenado de la tabla hora
-- -----------------------------------------------------
INSERT INTO hora (hora)
VALUES 
('07:00'),
('08:00'),
('09:00'),
('10:00'),
('10:30'),
('11:00'),
('11:30'),
('12:00'),
('15:00'),
('15:30'),
('16:00'),
('16:30'),
('17:00'),
('17:30'),
('18:00'),
('18:30'),
('19:00'),
('19:30'),
('20:00');

-- -----------------------------------------------------
-- llenado de datos de la tabla sucursal:
-- -----------------------------------------------------
INSERT INTO sucursal (sucursalNombre, sucursalDireccion, sucursalTelefono, created_at, updated_at)
VALUES 
('Sucursal Centro', 'Calle Principal 123, Centro', '555-1234', GETDATE(), GETDATE()),
('Sucursal Norte', 'Avenida Norte 456, Norte', '555-5678', GETDATE(), GETDATE()),
('Sucursal Sur', 'Boulevard Sur 789, Sur', '555-9012', GETDATE(), GETDATE()),
('Sucursal Este', 'Calle Este 101, Este', '555-3456', GETDATE(), GETDATE()),
('Sucursal Oeste', 'Avenida Oeste 202, Oeste', '555-7890', GETDATE(), GETDATE());

-- -----------------------------------------------------
-- Inserciones en la tabla tipoAlumno
-- -----------------------------------------------------
INSERT INTO tipoAlumno (tipoAlumnoNombre, tipoAlumnoDescripcion)
VALUES 
('Regular', 'Alumno sin beca de algún tipo con clase grupal'),
('Horario Libre', 'Alumno de Horario libre de Lunes a Viernes con clase grupal'),
('Nado Libre', 'Alumno sin profesor en un horario fijo con clase individual'),
('Personalizada', 'Alumno con clase personalizada con clase individual'),
('Grupal Infantil', 'Alumno menor de 7 años y mayor de 4 años con clase grupal'),
('Equipo', 'Alumno que forma parte del equipo competitivo del centro acuático con clase grupal'),
('Zaragoza', 'Alumno con beca del Zaragoza con clase grupal'),
('UAM', 'Alumno con beca de la UAM con clase grupal'),
('DIF', 'Alumno con beca del DIF con clase grupal'),
('Primaria', 'Alumno con beca de escuela pública con clase grupal'),
('Secundaria', 'Alumno con beca de escuela pública con clase grupal'),
('Preparatoria', 'Alumno con beca de escuela pública con clase grupal'),
('Universidad', 'Alumno con beca de escuela pública con clase grupal'),
('Adultos Mayores', 'Alumno con beca de adultos mayores con clase grupal'),
('Monte de Piedad', 'Alumno perteneciente al Monte de Piedad con clase grupal');

-- -----------------------------------------------------
--Inserción de los niveles
-- -----------------------------------------------------
INSERT INTO nivelAlumno (nivelAlumnoNombre, nivelAlumnoDescripcion)
VALUES 
('Principiante A', 'Son los principiantes que no tienen ningún tipo de conocimiento'),
('Principiante B', 'Son los principiantes que ya han tenido algún contacto con natación'),
('Intermedio A', 'Son nadadores que tienen experiencia'),
('Intermedio B', 'Son nadadores cerca de convertirse en expertos'),
('Avanzado', 'Son nadadores expertos');

-- -----------------------------------------------------
--Llenado de la tabla tipoPago
-- -----------------------------------------------------
INSERT INTO tipoPago (tipoPagoNombre, tipoPagoDescripcion)
VALUES 
('Mensual', 'Pago mensual: cubre días y horario elegidos.'),
('Anual', 'Pago anual: cubre mantenimiento y membresía');

-- -----------------------------------------------------
-- Llenado de la tabla tipoHorario
-- -----------------------------------------------------
INSERT INTO tipoHorario (tipoHorarioNombre)
VALUES 
('Matutino'),
('Vespertino');

-- -----------------------------------------------------
-- llenado de datos de la tabla alumno:
-- -----------------------------------------------------
INSERT INTO alumno (alumnoFechaInscripcion, tipoAlumno_idtipoAlumno, nivelAlumno_idnivelAlumno, sucursal_idSucursal, created_at, updated_at)
VALUES 
('2025-01-01', 1, 1, 1, GETDATE(), GETDATE()),
('2025-02-01', 2, 2, 2, GETDATE(), GETDATE()),
('2025-03-01', 3, 3, 3, GETDATE(), GETDATE()),
('2025-04-01', 4, 4, 4, GETDATE(), GETDATE()),
('2025-05-01', 5, 5, 5, GETDATE(), GETDATE()),
('2025-06-01', 6, 4, 2, GETDATE(), GETDATE()),
('2025-07-01', 7, 3, 4, GETDATE(), GETDATE()),
('2025-08-01', 8, 4, 2, GETDATE(), GETDATE()),
('2025-09-01', 9, 5, 1, GETDATE(), GETDATE()),
('2025-10-01', 10, 1, 1, GETDATE(), GETDATE());

-- -----------------------------------------------------
-- llenado de datos de la tabla pago:
-- -----------------------------------------------------
INSERT INTO pago (mensualidadFecha, tipoPago_idtipoPago, alumno_idalumno, numRecibo, sucursal_idSucursal, created_at, updated_at)
VALUES 
( '2025-03-01', 1, 1, 'REC-001', 1, GETDATE(), GETDATE()),
( '2025-03-02', 1, 2, 'REC-002', 2, GETDATE(), GETDATE()),
( '2025-03-03', 1, 3, 'REC-003', 3, GETDATE(), GETDATE()),
( '2025-03-04', 1, 4, 'REC-004', 4, GETDATE(), GETDATE()),
( '2025-03-05', 1, 5, 'REC-005', 5, GETDATE(), GETDATE()),
( '2025-03-06', 1, 6, 'REC-006', 1, GETDATE(), GETDATE()),
( '2025-03-07', 1, 7, 'REC-007', 2, GETDATE(), GETDATE()),
( '2025-03-08', 1, 8, 'REC-008', 4, GETDATE(), GETDATE()),
( '2025-03-09', 1, 9, 'REC-009', 1, GETDATE(), GETDATE()),
( '2025-03-10', 1, 10, 'REC-010', 1, GETDATE(), GETDATE());

-- -----------------------------------------------------
-- Inserciones en la tabla diaHora
-- -----------------------------------------------------
insert into diaHora
(
    dia_idDia,
    diaHora_idHoraInicio,
    diaHora_idHoraFin
)
values
-- Matutino
(1, 1, 2),
(1, 2, 3),
(1, 3, 4),
(1, 4, 6),
(1, 6, 8),
(2, 1, 2),
(2, 2, 3),
(2, 3, 4),
(3, 1, 2),
(3, 2, 3),
(3, 3, 4),
(3, 4, 6),
(3, 6, 8),
(4, 1, 2),
(4, 2, 3),
(4, 3, 4),
(5, 1, 2),
(5, 2, 3),
(5, 3, 4),
(5, 4, 6),
-- Vespertino
(1, 11, 13),
(1, 13, 15),
(1, 15, 17),
(1, 17, 19),
(2, 9, 11),
(2, 11, 13),
(2, 13, 15),
(2, 15, 17),
(2, 17, 19),
(3, 11, 13),
(3, 13, 15),
(3, 15, 17),
(3, 17, 19),
(4, 9, 11),
(4, 11, 13),
(4, 13, 15),
(4, 15, 17),
(4, 17, 19),
(5, 9, 11),
(5, 11, 13),
(5, 13, 15),
(5, 15, 17),
-- Fines de semana
(6, 1, 2),
(6, 2, 3),
(6, 3, 4),
(6, 4, 6),
(6, 6, 8),
(7, 1, 2),
(7, 2, 3),
(7, 3, 4),
(7, 4, 6),
-- Personalizadas infantil Findesemana
(6, 4, 5),
(6, 5, 6),
(6, 6, 7),
(6, 7, 8),
(7, 4, 5),
(7, 5, 6),
-- Personalizadas infantil Vespertino
(1, 11, 12),
(1, 12, 13),
(1, 13, 14),
(1, 14, 15),
(1, 15, 16),
(1, 16, 17),
(1, 17, 18),
(1, 18, 19),
(2, 9, 10),
(2, 10, 11),
(2, 11, 12),
(2, 12, 13),
(2, 13, 14),
(2, 14, 15),
(2, 15, 16),
(2, 16, 17),
(2, 17, 18),
(2, 18, 19),
(3, 11, 12),
(3, 12, 13),
(3, 13, 14),
(3, 14, 15),
(3, 15, 16),
(3, 16, 17),
(3, 17, 18),
(3, 18, 19),
(4, 9, 10),
(4, 10, 11),
(4, 11, 12),
(4, 12, 13),
(4, 13, 14),
(4, 14, 15),
(4, 15, 16),
(4, 16, 17),
(4, 17, 18),
(4, 18, 19),
(5, 9, 10),
(5, 10, 11),
(5, 11, 12),
(5, 12, 13),
(5, 13, 14),
(5, 14, 15),
(5, 15, 16),
(5, 16, 17);


-- -----------------------------------------------------
-- llenado de datos de la tabla Horario:
-- -----------------------------------------------------
INSERT INTO horario
(
    tipoHorario_idtipoHorario,
    diaHora_idDiaHora,
    sucursal_idSucursal,
    created_at,
    updated_at
)
VALUES
(1, 1, 1, GETDATE(), GETDATE()),
(1, 2, 2, GETDATE(), GETDATE()),
(1, 3, 3, GETDATE(), GETDATE()),
(1, 4, 4, GETDATE(), GETDATE()),
(1, 5, 5, GETDATE(), GETDATE()),
(1, 6, 1, GETDATE(), GETDATE()),
(1, 7, 2, GETDATE(), GETDATE()),
(1, 8, 3, GETDATE(), GETDATE()),
(1, 9, 4, GETDATE(), GETDATE()),
(1, 10, 5, GETDATE(), GETDATE()),
(1, 11, 1, GETDATE(), GETDATE()),
(1, 12, 2, GETDATE(), GETDATE()),
(1, 13, 3, GETDATE(), GETDATE()),
(1, 14, 4, GETDATE(), GETDATE()),
(1, 15, 5, GETDATE(), GETDATE()),
(1, 16, 1, GETDATE(), GETDATE()),
(1, 17, 2, GETDATE(), GETDATE()),
(1, 18, 3, GETDATE(), GETDATE()),
(1, 19, 4, GETDATE(), GETDATE()),
(1, 20, 5, GETDATE(), GETDATE()),
(1, 43, 1, GETDATE(), GETDATE()),
(1, 44, 2, GETDATE(), GETDATE()),
(1, 45, 3, GETDATE(), GETDATE()),
(1, 46, 4, GETDATE(), GETDATE()),
(1, 47, 5, GETDATE(), GETDATE()),
(1, 52, 1, GETDATE(), GETDATE()),
(1, 53, 2, GETDATE(), GETDATE()),
(1, 54, 3, GETDATE(), GETDATE()),
(1, 55, 4, GETDATE(), GETDATE()),
(1, 48, 5, GETDATE(), GETDATE()),
(1, 49, 1, GETDATE(), GETDATE()),
(1, 50, 2, GETDATE(), GETDATE()),
(1, 51, 3, GETDATE(), GETDATE()),
(1, 56, 4, GETDATE(), GETDATE()),
(1, 57, 5, GETDATE(), GETDATE()),
(2, 21, 1, GETDATE(), GETDATE()),
(2, 22, 2, GETDATE(), GETDATE()),
(2, 23, 3, GETDATE(), GETDATE()),
(2, 24, 4, GETDATE(), GETDATE()),
(2, 25, 5, GETDATE(), GETDATE()),
(2, 26, 1, GETDATE(), GETDATE()),
(2, 27, 2, GETDATE(), GETDATE()),
(2, 28, 3, GETDATE(), GETDATE()),
(2, 29, 4, GETDATE(), GETDATE()),
(2, 30, 5, GETDATE(), GETDATE()),
(2, 31, 1, GETDATE(), GETDATE()),
(2, 32, 2, GETDATE(), GETDATE()),
(2, 33, 3, GETDATE(), GETDATE()),
(2, 34, 4, GETDATE(), GETDATE()),
(2, 35, 5, GETDATE(), GETDATE()),
(2, 36, 1, GETDATE(), GETDATE()),
(2, 37, 2, GETDATE(), GETDATE()),
(2, 38, 3, GETDATE(), GETDATE()),
(2, 39, 4, GETDATE(), GETDATE()),
(2, 40, 5, GETDATE(), GETDATE()),
(2, 41, 1, GETDATE(), GETDATE()),
(2, 42, 2, GETDATE(), GETDATE()),
(2, 58, 3, GETDATE(), GETDATE()),
(2, 59, 4, GETDATE(), GETDATE()),
(2, 60, 5, GETDATE(), GETDATE()),
(2, 61, 1, GETDATE(), GETDATE()),
(2, 62, 2, GETDATE(), GETDATE()),
(2, 63, 3, GETDATE(), GETDATE()),
(2, 64, 4, GETDATE(), GETDATE()),
(2, 65, 5, GETDATE(), GETDATE()),
(2, 66, 1, GETDATE(), GETDATE()),
(2, 67, 2, GETDATE(), GETDATE()),
(2, 68, 3, GETDATE(), GETDATE()),
(2, 69, 4, GETDATE(), GETDATE()),
(2, 70, 5, GETDATE(), GETDATE()),
(2, 71, 1, GETDATE(), GETDATE()),
(2, 72, 2, GETDATE(), GETDATE()),
(2, 73, 3, GETDATE(), GETDATE()),
(2, 74, 4, GETDATE(), GETDATE()),
(2, 75, 5, GETDATE(), GETDATE()),
(2, 76, 1, GETDATE(), GETDATE()),
(2, 77, 2, GETDATE(), GETDATE()),
(2, 78, 3, GETDATE(), GETDATE()),
(2, 79, 4, GETDATE(), GETDATE()),
(2, 80, 5, GETDATE(), GETDATE()),
(2, 81, 1, GETDATE(), GETDATE()),
(2, 82, 2, GETDATE(), GETDATE()),
(2, 83, 3, GETDATE(), GETDATE()),
(2, 84, 4, GETDATE(), GETDATE()),
(2, 85, 5, GETDATE(), GETDATE()),
(2, 86, 1, GETDATE(), GETDATE()),
(2, 87, 2, GETDATE(), GETDATE()),
(2, 88, 3, GETDATE(), GETDATE()),
(2, 89, 4, GETDATE(), GETDATE()),
(2, 90, 5, GETDATE(), GETDATE()),
(2, 91, 1, GETDATE(), GETDATE()),
(2, 92, 2, GETDATE(), GETDATE()),
(2, 93, 3, GETDATE(), GETDATE()),
(2, 94, 4, GETDATE(), GETDATE()),
(2, 95, 5, GETDATE(), GETDATE()),
(2, 96, 1, GETDATE(), GETDATE()),
(2, 97, 2, GETDATE(), GETDATE()),
(2, 98, 3, GETDATE(), GETDATE()),
(2, 99, 4, GETDATE(), GETDATE()),
(2, 100, 5, GETDATE(), GETDATE()),
(2, 101, 1, GETDATE(), GETDATE());