-- Script para Nodo de Datos Administrativos
-- Este nodo contendrá información administrativa como inscripciones, pagos, horarios y niveles de los alumnos. 
DROP database IF EXISTS `nodo_administrativos` ;

CREATE DATABASE IF NOT EXISTS `nodo_administrativos` DEFAULT CHARACTER SET utf8;
USE `nodo_administrativos`;

-- -----------------------------------------------------
-- Tabla `sucursal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nodo_administrativos`.`sucursal` (
  `idSucursal` INT NOT NULL AUTO_INCREMENT,
  `sucursalNombre` VARCHAR(100) NOT NULL,
  `sucursalDireccion` VARCHAR(255) NOT NULL,
  `sucursalTelefono` VARCHAR(20) NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idSucursal`)
);

-- -----------------------------------------------------
-- Tabla `tipoAlumno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nodo_administrativos`.`tipoAlumno` (
  `idtipoAlumno` INT NOT NULL AUTO_INCREMENT,
  `tipoAlumnoNombre` VARCHAR(45) NULL,
  `tipoAlumnoDescripcion` VARCHAR(150) NULL,
  PRIMARY KEY (`idtipoAlumno`)
);

-- -----------------------------------------------------
-- Tabla `nivelAlumno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nodo_administrativos`.`nivelAlumno` (
  `idnivelAlumno` INT NOT NULL AUTO_INCREMENT,
  `nivelAlumnoNombre` VARCHAR(45) NULL,
  `nivelAlumnoDescripcion` VARCHAR(255) NULL,
  PRIMARY KEY (`idnivelAlumno`)
);

-- -----------------------------------------------------
-- Tabla `tipoPago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nodo_administrativos`.`tipoPago` (
  `idTipoPago` INT NOT NULL AUTO_INCREMENT,
  `tipoPagoNombre` VARCHAR(45) NULL,
  `tipoPagoDescripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`idTipoPago`)
);

-- -----------------------------------------------------
-- Tabla `tipoHorario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nodo_administrativos`.`tipoHorario` (
  `idtipoHorario` INT NOT NULL AUTO_INCREMENT,
  `tipoHorarioNombre` VARCHAR(45) NULL,
  PRIMARY KEY (`idtipoHorario`)
);

-- -----------------------------------------------------
-- Table `centroacuatico`.`día`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `centroacuatico`.`dia` (
  `idDia` INT NOT NULL AUTO_INCREMENT,
  `diaNombre` VARCHAR(45) NULL COMMENT 'Deben ser los valores nominales de los días: Lunes, Martes, Miércoles, Juves y Viernes.',
  `diaDescripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`idDia`));

-- -----------------------------------------------------
-- Table `centroacuatico`.`hora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `centroacuatico`.`hora` (
  `idHora` INT NOT NULL AUTO_INCREMENT,
  `hora` VARCHAR(45) NULL COMMENT 'El formato de la hora es \"00:00\"',
  PRIMARY KEY (`idHora`));

-- -----------------------------------------------------
-- Tabla `diaHora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nodo_administrativos`.`diaHora` (
  `idDiaHora` INT NOT NULL AUTO_INCREMENT,
  `dia_idDia` INT NOT NULL,
  `diaHora_idHoraInicio` INT NOT NULL,
  `diaHora_idHoraFin` INT NOT NULL,
  PRIMARY KEY (`idDiaHora`),
  INDEX `fk_Dia_Dia1_idx` (`dia_idDia` ASC) ,
  INDEX `fk_Dia_Hora1_idx` (`diaHora_idHoraInicio` ASC) ,
  INDEX `fk_Dia_Hora2_idx` (`diaHora_idHoraFin` ASC) ,
  CONSTRAINT `fk_Dia_Dia1`
    FOREIGN KEY (`dia_idDia`)
    REFERENCES `centroacuatico`.`dia` (`idDia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Dia_Hora1`
    FOREIGN KEY (`diaHora_idHoraInicio`)
    REFERENCES `centroacuatico`.`hora` (`idHora`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Dia_Hora2`
    FOREIGN KEY (`diaHora_idHoraFin`)
    REFERENCES `centroacuatico`.`hora` (`idHora`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Tabla `alumno` (fragmento de datos administrativos)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nodo_administrativos`.`alumno` (
  `idalumno` INT NOT NULL AUTO_INCREMENT,
  `alumnoFechaInscripcion` DATE NOT NULL,
  `tipoAlumno_idtipoAlumno` INT NOT NULL,
  `nivelAlumno_idnivelAlumno` INT NOT NULL,
  `sucursal_idSucursal` INT NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idalumno`),
  INDEX `fk_alumno_tipoAlumno_idx` (`tipoAlumno_idtipoAlumno` ASC),
  INDEX `fk_alumno_nivelAlumno_idx` (`nivelAlumno_idnivelAlumno` ASC),
  INDEX `fk_alumno_sucursal_idx` (`sucursal_idSucursal` ASC),
  CONSTRAINT `fk_alumno_tipoAlumno`
    FOREIGN KEY (`tipoAlumno_idtipoAlumno`)
    REFERENCES `tipoAlumno` (`idtipoAlumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_alumno_nivelAlumno`
    FOREIGN KEY (`nivelAlumno_idnivelAlumno`)
    REFERENCES `nivelAlumno` (`idnivelAlumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_alumno_sucursal`
    FOREIGN KEY (`sucursal_idSucursal`)
    REFERENCES `sucursal` (`idSucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- Tabla `pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nodo_administrativos`.`pago` (
  `idMensualidad` INT NOT NULL AUTO_INCREMENT,
  `mensualidadFecha` DATE NOT NULL,
  `tipoPago_idTipoPago` INT NOT NULL,
  `alumno_idalumno` INT NOT NULL,
  `numRecibo` VARCHAR(45) NOT NULL,
  `sucursal_idSucursal` INT NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idMensualidad`),
  INDEX `fk_pago_tipoPago_idx` (`tipoPago_idTipoPago` ASC),
  INDEX `fk_pago_alumno_idx` (`alumno_idalumno` ASC),
  INDEX `fk_pago_sucursal_idx` (`sucursal_idSucursal` ASC),
  CONSTRAINT `fk_pago_tipoPago`
    FOREIGN KEY (`tipoPago_idTipoPago`)
    REFERENCES `tipoPago` (`idTipoPago`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pago_alumno`
    FOREIGN KEY (`alumno_idalumno`)
    REFERENCES `alumno` (`idalumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pago_sucursal`
    FOREIGN KEY (`sucursal_idSucursal`)
    REFERENCES `sucursal` (`idSucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- Tabla `horario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nodo_administrativos`.`horario` (
  `idHorario` INT NOT NULL AUTO_INCREMENT,
  `tipoHorario_idtipoHorario` INT NOT NULL,
  `diaHora_idDiaHora` INT NOT NULL,
  `sucursal_idSucursal` INT NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idHorario`),
  INDEX `fk_horario_tipoHorario_idx` (`tipoHorario_idtipoHorario` ASC),
  INDEX `fk_horario_diaHora_idx` (`diaHora_idDiaHora` ASC),
  INDEX `fk_horario_sucursal_idx` (`sucursal_idSucursal` ASC),
  CONSTRAINT `fk_horario_tipoHorario`
    FOREIGN KEY (`tipoHorario_idtipoHorario`)
    REFERENCES `tipoHorario` (`idtipoHorario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_horario_diaHora`
    FOREIGN KEY (`diaHora_idDiaHora`)
    REFERENCES `diaHora` (`idDiaHora`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_horario_sucursal`
    FOREIGN KEY (`sucursal_idSucursal`)
    REFERENCES `sucursal` (`idSucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- Inserciones de días
-- -----------------------------------------------------
insert into centroacuatico.dia values 
(null, "Lunes",  "Día de la semana"),
(null, "Martes",  "Día de la semana"),
(null, "Miércoles",  "Día de la semana"),
(null, "Jueves",  "Día de la semana"),
(null, "Viernes",  "Día de la semana"),
(null, "Sábado ",  "Día de la semana"),
(null, "Domingo",  "Día de la semana");

-- -----------------------------------------------------
-- Llenado de la tabla hora
-- -----------------------------------------------------
INSERT INTO centroacuatico.hora VALUES 
(null,'07:00'),
(null,'08:00'),
(null,'09:00'),
(null,'10:00'),
(null,'10:30'),
(null,'11:00'),
(null,'11:30'),
(null,'12:00'),
(null,'15:00'),
(null,'15:30'),
(null,'16:00'),
(null,'16:30'),
(null,'17:00'),
(null,'17:30'),
(null,'18:00'),
(null,'18:30'),
(null,'19:00'),
(null,'19:30'),
(null,'20:00');

-- -----------------------------------------------------
-- llenado de datos de la tabla sucursal:
-- -----------------------------------------------------
INSERT INTO `nodo_administrativos`.`sucursal` (`idSucursal`, `sucursalNombre`, `sucursalDireccion`, `sucursalTelefono`,`created_at`, `updated_at`)
VALUES 
(NULL, 'Sucursal Centro', 'Calle Principal 123, Centro', '555-1234',CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, 'Sucursal Norte', 'Avenida Norte 456, Norte', '555-5678',CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, 'Sucursal Sur', 'Boulevard Sur 789, Sur', '555-9012',CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, 'Sucursal Este', 'Calle Este 101, Este', '555-3456',CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, 'Sucursal Oeste', 'Avenida Oeste 202, Oeste', '555-7890',CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- -----------------------------------------------------
-- Inserciones en la tabla tipoAlumno
-- -----------------------------------------------------
INSERT INTO `nodo_administrativos`.`tipoAlumno` (`idtipoAlumno`, `tipoAlumnoNombre`, `tipoAlumnoDescripcion`) 
VALUES 
(null, 'Regular', 'Alumno sin beca de algun tipo con clase grupal'),
(null, 'Horario Libre', 'Alumno de Horario libre de Lunes a Viernes con clase grupal'),
(null, 'Nado Libre', 'Alumno sin profesor en un horario fijo con clase individual'),
(null, 'Personalizada', 'Alumno con clase personalizada con clase individual'),
(null, 'Grupal Infantil', 'Alumno menor de 7 años y mayor de 4 años con clase grupal'),
(null, 'Equipo', 'Alumno que forma parte del equipo competitivo del centro acuatico con clase grupal'),
(null, 'Zaragoza', 'Alumno con beca del zaragoza con clase grupal'),
(null, 'UAM', 'Alumno con beca de la UAM con clase grupal'),
(null, 'DIF', 'Alumno con beca del DIF con clase grupal'),
(null, 'Primaria', 'Alumno con beca de escuela publica con clase grupal'),
(null, 'Secundaria', 'Alumno con beca de escuela publica con clase grupal'),
(null, 'Preparatoria', 'Alumno con beca de escuela publica con clase grupal'),
(null, 'Universidad', 'Alumno con beca de escuela publica con clase grupal'),
(null, 'Adultos Mayores', 'Alumno con beca de adultos mayores con clase grupal'),
(null, 'Monte de Piedad', 'Alumno perteneciente al Monte de Piedad con clase grupal');

-- -----------------------------------------------------
#Inserción de los niveles
-- -----------------------------------------------------
insert into nodo_administrativos.nivelAlumno values 
(null,"Principiante A", "Son los principiantes que no tienen ningún tipo de conocimiento"),
(null,"Principiante B", "Son los principaintes que ya han tenido algún contacto con natación"),
(null,"Intermedio A", "Son nadadores que tienen  experiencia"),
(null,"Intermedio B", "Son nadadores cera de convertirse en expertos"),
(null,"Avanzado", "Son nadadores expertos");

-- -----------------------------------------------------
#Llenado de la tabla tipoPago
-- -----------------------------------------------------
insert into nodo_administrativos.tipoPago values 
(null,"Mensual","Pago mensual: cubre días y horario eledigos."),
(null,"Anual","Pago anual: cubre mantenimiento y membresia");

-- -----------------------------------------------------
# Llenado de la tabla tipoHorario
-- -----------------------------------------------------
insert into nodo_administrativos.tipoHorario values 
(null,'Matutino'),
(null,'Vespertino');

-- -----------------------------------------------------
-- llenado de datos de la tabla alumno:
-- -----------------------------------------------------
INSERT INTO `nodo_administrativos`.`alumno` (`idalumno`, `alumnoFechaInscripcion`, `tipoAlumno_idtipoAlumno`, `nivelAlumno_idnivelAlumno`, `sucursal_idSucursal`, `created_at`, `updated_at`)
VALUES 
(NULL, '2025-01-01', 1, 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, '2025-02-01', 2, 2, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, '2025-03-01', 3, 3, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, '2025-04-01', 4, 4, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, '2025-05-01', 5, 5, 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, '2025-06-01', 6, 4, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, '2025-07-01', 7, 3, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, '2025-08-01', 8, 4, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, '2025-09-01', 9, 5, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, '2025-10-01', 10, 1,1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- -----------------------------------------------------
-- llenado de datos de la tabla pago:
-- -----------------------------------------------------
INSERT INTO `nodo_administrativos`.`pago` (`idmensualidad`, `mensualidadFecha`, `tipoPago_idtipoPago`, `alumno_idalumno`, `numRecibo`, `sucursal_idSucursal`, `created_at`, `updated_at`)
VALUES 
(NULL, '2025-03-01', 1, 1, 'REC-001', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, '2025-03-02', 1, 2, 'REC-002', 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, '2025-03-03', 1, 3, 'REC-003', 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, '2025-03-04', 1, 4, 'REC-004', 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, '2025-03-05', 1, 5, 'REC-005', 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, '2025-03-06', 1, 6, 'REC-006', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, '2025-03-07', 1, 7, 'REC-007', 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, '2025-03-08', 1, 8, 'REC-008', 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, '2025-03-09', 1, 9, 'REC-009', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, '2025-03-10', 1, 10, 'REC-010', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

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
INSERT INTO `nodo_administrativos`.`horario`
(
    `tipoHorario_idtipoHorario`,
    `diaHora_idDiaHora`,
    `sucursal_idSucursal`,
    `created_at`,
    `updated_at`
)
VALUES
(1, 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 2, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 3, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 4, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 5, 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 6, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 7, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 8, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 9, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 10, 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 11, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 12, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 13, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 14, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 15, 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 16, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 17, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 18, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 19, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 20, 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 43, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 44, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 45, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 46, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 47, 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 52, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 53, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 54, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 55, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 48, 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 49, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 50, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 51, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 56, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 57, 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 21, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 22, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 23, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 24, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 25, 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 26, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 27, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 28, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 29, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 30, 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 31, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 32, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 33, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 34, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 35, 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 36, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 37, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 38, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 39, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 40, 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 41, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 42, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 58, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 59, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 60, 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 61, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 62, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 63, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 64, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 65, 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 66, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 67, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 68, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 69, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 70, 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 71, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 72, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 73, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 74, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 75, 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 76, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 77, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 78, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 79, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 80, 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 81, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 82, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 83, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 84, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 85, 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 86, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 87, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 88, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 89, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 90, 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 91, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 92, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 93, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 94, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 95, 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 96, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 97, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 98, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 99, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 100, 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 101, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);