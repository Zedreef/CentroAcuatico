-- Esquema físico para la definición de la bd de una escuela de natación

-- -----------------------------------------------------
-- Schema centroacuatico
-- -----------------------------------------------------
DROP database IF EXISTS `centroacuatico` ;

-- -----------------------------------------------------
-- Schema centroacuatico
-- -----------------------------------------------------
CREATE database IF NOT EXISTS `centroacuatico` DEFAULT CHARACTER SET utf8 ;
/* Utiliza el juego de caracteres "utf8" como configuración predeterminada para la codificación de caracteres.
El conjunto de caracteres utf8 es ampliamente utilizado y es capaz de representar la mayoría de los caracteres 
y símbolos de diferentes idiomas. */
USE `centroacuatico` ;

-- -----------------------------------------------------
-- Table `centroacuatico`.`parentesco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `centroacuatico`.`parentesco` (
  `idParentesco` INT NOT NULL AUTO_INCREMENT,
  `parentescoNombre` VARCHAR(45) NULL,
  `parentescoDescripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`idParentesco`))
ENGINE = InnoDB; /* Especifica el motor de almacenamiento que se utilizará para esa tabla. En este caso, se está utilizando el motor de almacenamiento InnoDB.*/

-- -----------------------------------------------------
-- Table `centroacuatico`.`codigoPostal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `centroacuatico`.`codigoPostal` (
  `idCodigoPostal` INT NOT NULL AUTO_INCREMENT,
  `codigoPostal` VARCHAR(10) NULL,
  `codigoPoatalColonia` VARCHAR(150) NULL,
  `codigoPostalDelegacion` VARCHAR(150) NULL,
  `codigoCiudad` VARCHAR(150) NULL,
  PRIMARY KEY (`idCodigoPostal`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `centroacuatico`.`direccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `centroacuatico`.`direccion` (
  `idDireccion` INT NOT NULL AUTO_INCREMENT,
  `direccionCalle` VARCHAR(150) NULL,
  `direccionNumero` INT NULL,
  `codigoPostal_idCodigoPostal` INT NULL,
  PRIMARY KEY (`idDireccion`),
  INDEX `fk_direccion_codigoPostal_idx` (`codigoPostal_idCodigoPostal` ASC) , /* Estas líneas crean índices en los campos, 
																				ayudando a mejorar el rendimiento de las consultas al acelerar 
                                                                                la búsqueda de registros en función de los valores 
                                                                                de los campos indexados. */
  CONSTRAINT `fk_direccion_codigoPostal_` 	/* Establece una restricción de clave foránea. */
    FOREIGN KEY (`codigoPostal_idCodigoPostal`)
    REFERENCES `centroacuatico`.`codigoPostal` (`idCodigoPostal`)
    ON DELETE NO ACTION /* Significa que no se realizará ninguna acción en cascada al eliminar un registro en la tabla codigoPostal*/
    ON UPDATE NO ACTION) /* No se realizará ninguna acción en cascada al actualizar el valor de idCoigoPostal en la tabla codigoPostal. */
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `centroacuatico`.`contactoE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `centroacuatico`.`contactoE` (
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
    REFERENCES `centroacuatico`.`parentesco` (`idParentesco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contactoE_direccion1`
    FOREIGN KEY (`direccion_idDireccion`)
    REFERENCES `centroacuatico`.`direccion` (`idDireccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `centroacuatico`.`tipoAlumno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `centroacuatico`.`tipoAlumno` (
  `idtipoAlumno` INT NOT NULL AUTO_INCREMENT,
  `tipoAlumnoNombre` VARCHAR(45) NULL,
  `tipoAlumnoDescripcion` VARCHAR(150) NULL,
  PRIMARY KEY (`idtipoAlumno`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `centroacuatico`.`nivelAlumno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `centroacuatico`.`nivelAlumno` (
  `idnivelAlumno` INT NOT NULL AUTO_INCREMENT,
  `nivelAlumnoNombre` VARCHAR(45) NULL,
  `nivelAlumnoDesripcion` VARCHAR(255) NULL COMMENT 'El sistema llevará un registro del nivel de cada alumno. Los niveles disponibles son: Principiante A, Principiante B, Intermedio A, Intermedio B y Avanzado.',
  PRIMARY KEY (`idnivelAlumno`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `centroacuatico`.`alumno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `centroacuatico`.`alumno` (
  `idalumno` INT NOT NULL AUTO_INCREMENT,
  `alumnoNombre` VARCHAR(45) NULL,
  `alumnoApellidop` VARCHAR(45) NULL,
  `alumnoApellidom` VARCHAR(45) NULL,
  `alumnoTelefono` VARCHAR(45) NULL,
  `alumnoCorreo` VARCHAR(45) NULL,
  `alumnoFechaNac` DATE NULL,
  `contactoE_idcontactoE` INT NOT NULL,
  `alumnoFechaInscripcion` DATE NULL,
  `tipoAlumno_idtipoAlumno` INT NOT NULL,
  `nivelAlumno_idnivelAlumno` INT NOT NULL,
  `direccion_idDireccion` INT NOT NULL,
  PRIMARY KEY (`idalumno`),
  INDEX `fk_alumno_contactoE1_idx` (`contactoE_idcontactoE` ASC) ,
  INDEX `fk_alumno_tipoAlumno1_idx` (`tipoAlumno_idtipoAlumno` ASC) ,
  INDEX `fk_alumno_nivelAlumno1_idx` (`nivelAlumno_idnivelAlumno` ASC) ,
  INDEX `fk_alumno_direccion1_idx` (`direccion_idDireccion` ASC) ,
  CONSTRAINT `fk_alumno_contactoE1`
    FOREIGN KEY (`contactoE_idcontactoE`)
    REFERENCES `centroacuatico`.`contactoE` (`idcontactoE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_alumno_tipoAlumno1`
    FOREIGN KEY (`tipoAlumno_idtipoAlumno`)
    REFERENCES `centroacuatico`.`tipoAlumno` (`idtipoAlumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_alumno_nivelAlumno1`
    FOREIGN KEY (`nivelAlumno_idnivelAlumno`)
    REFERENCES `centroacuatico`.`nivelAlumno` (`idnivelAlumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_alumno_direccion1`
    FOREIGN KEY (`direccion_idDireccion`)
    REFERENCES `centroacuatico`.`direccion` (`idDireccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `centroacuatico`.`día`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `centroacuatico`.`dia` (
  `idDia` INT NOT NULL AUTO_INCREMENT,
  `diaNombre` VARCHAR(45) NULL COMMENT 'Deben ser los valores nominales de los días: Lunes, Martes, Miércoles, Juves y Viernes.',
  `diaDescripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`idDia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `centroacuatico`.`hora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `centroacuatico`.`hora` (
  `idHora` INT NOT NULL AUTO_INCREMENT,
  `hora` VARCHAR(45) NULL COMMENT 'El formato de la hora es \"00:00\"',
  PRIMARY KEY (`idHora`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `centroacuatico`.`diaHora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `centroacuatico`.`diaHora` (
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
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `centroacuatico`.`tipoPago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `centroacuatico`.`tipoPago` (
  `idTipoPago` INT NOT NULL auto_increment,
  `tipoPagoNombre` VARCHAR(45) NULL,
  `tipoPagoDescripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`idTipoPago`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `centroacuatico`.`tipoHorario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `centroacuatico`.`tipoHorario` (
  `idtipoHorario` INT NOT NULL AUTO_INCREMENT,
  `tipoHorarioNombre` VARCHAR(45) NULL,
  PRIMARY KEY (`idtipoHorario`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `centroacuatico`.`horario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `centroacuatico`.`horario` (
  `idHorario` INT NOT NULL AUTO_INCREMENT,
  `tipoHorario_idtipoHorario` INT NOT NULL,
  `diaHora_idDiaHora` INT NOT NULL,
  PRIMARY KEY (`idHorario`),
  INDEX `fk_alumno_has_horario_tipoHorario1_idx` (`tipoHorario_idtipoHorario` ASC) ,
  INDEX `fk_horario_diaHora1_idx` (`diaHora_idDiaHora` ASC) ,
  CONSTRAINT `fk_alumno_has_horario_tipoHorario1`
    FOREIGN KEY (`tipoHorario_idtipoHorario`)
    REFERENCES `centroacuatico`.`tipoHorario` (`idtipoHorario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_horario_diaHora1`
    FOREIGN KEY (`diaHora_idDiaHora`)
    REFERENCES `centroacuatico`.`diaHora` (`idDiaHora`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `centroacuatico`.`pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `centroacuatico`.`pago` (
  `idMensualidad` INT NOT NULL AUTO_INCREMENT,
  `mensualidadFecha` DATE NULL,
  `tipoPago_idTipoPago` INT NOT NULL,
  `alumno_idalumno` INT NOT NULL,
  `numRecibo` VARCHAR(45) NULL,
  PRIMARY KEY (`idMensualidad`),
  INDEX `fk_Mensualidad_Mes1_idx` (`tipoPago_idTipoPago` ASC) ,
  INDEX `fk_Mensualidad_alumno1_idx` (`alumno_idalumno` ASC) ,
  CONSTRAINT `fk_Mensualidad_Mes1`
    FOREIGN KEY (`tipoPago_idTipoPago`)
    REFERENCES `centroacuatico`.`tipoPago` (`idTipoPago`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mensualidad_alumno1`
    FOREIGN KEY (`alumno_idalumno`)
    REFERENCES `centroacuatico`.`alumno` (`idalumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `centroacuatico`.`alumno_has_horario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `centroacuatico`.`alumno_has_horario` (
  `alumno_idalumno` INT NOT NULL,
  `horario_idHorario` INT NOT NULL,
  `idAlumnoHasHorario` INT NOT NULL AUTO_INCREMENT,
  INDEX `fk_alumno_has_horario_horario1_idx` (`horario_idHorario` ASC) ,
  INDEX `fk_alumno_has_horario_alumno1_idx` (`alumno_idalumno` ASC) ,
  PRIMARY KEY (`idAlumnoHasHorario`),
  CONSTRAINT `fk_alumno_has_horario_alumno1`
    FOREIGN KEY (`alumno_idalumno`)
    REFERENCES `centroacuatico`.`alumno` (`idalumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_alumno_has_horario_horario1`
    FOREIGN KEY (`horario_idHorario`)
    REFERENCES `centroacuatico`.`horario` (`idHorario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -------------------------------------------------------------------------------------------------
# Generar una tabla llamada PAGO_LOG tenieno los mismos atributos de la tabla PAGO
# y agregar los dos campos extra, usuario VARCHAR(70) y Tipo(date)
-- -------------------------------------------------------------------------------------------------
-- Crear una copia de la tabla original, la sentencia " WHERE 1=0" 
-- se utiliza para obtener la estructura de una tabla existente sin copiar los datos.
CREATE TABLE pago_log AS SELECT * FROM pago WHERE 1=0 ;

-- Agregar campos a la nueva tabla
ALTER TABLE pago_log
ADD COLUMN usuario VARCHAR(70),
ADD COLUMN fecha DATE;

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Vistas
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------
# Crear la vista que muestra los horarios y el número de alumnos que han pagado la mensualidad del mes y año actual
-- ---------------------------------------------------------------------
CREATE VIEW horarios_con_alumnos_pagados AS
SELECT d.idDia as idDia, d.diaNombre AS Dia, hi.hora AS hora_inicio, hf.hora AS hora_fin, COUNT(*) AS numero_alumnos
FROM centroacuatico.horario ho
JOIN centroacuatico.diaHora dh ON ho.diaHora_idDiaHora = dh.idDiaHora
JOIN centroacuatico.dia d ON dh.dia_idDia = d.idDia
JOIN centroacuatico.hora hi ON dh.diaHora_idHoraInicio = hi.idHora
JOIN centroacuatico.hora hf ON dh.diaHora_idHoraFin = hf.idHora
JOIN centroacuatico.alumno_has_horario ahh ON ho.idHorario = ahh.horario_idHorario
JOIN centroacuatico.pago p ON ahh.alumno_idalumno = p.alumno_idalumno
WHERE YEAR(p.mensualidadFecha) = YEAR(CURDATE()) AND MONTH(p.mensualidadFecha) = MONTH(CURDATE())
GROUP BY ho.idHorario;

-- Llama a la vista horario con alumnos pagados
SELECT * FROM horarios_con_alumnos_pagados;
-- -----------------------------------------------------------------------------------------------------------
# Generar una vista para visualizar el nombre de cada alumno junto con las fechas de sus pagos
-- -----------------------------------------------------------------------------------------------------------
CREATE VIEW vista_pagos_alumnos AS
SELECT a.idalumno, a.alumnoNombre, alumnoApellidop, a.alumnoApellidom, p.mensualidadFecha
FROM alumno a
JOIN pago p ON a.idalumno = p.alumno_idalumno;

-- Llama a la vista horario con alumnos pagados
SELECT * FROM vista_pagos_alumnos;
-- -----------------------------------------------------------------------------------------------------------
# Crear la vista para visualizar el nombre y las fechas de pago de un alumno específico
-- -----------------------------------------------------------------------------------------------------------
CREATE VIEW vista_pagos_alumno_especifico AS
SELECT a.idalumno, a.alumnoNombre, a.alumnoApellidop, a.alumnoApellidom, p.mensualidadFecha
FROM alumno a
JOIN pago p ON a.idalumno = p.alumno_idalumno
WHERE a.idalumno = 1; -- Reemplaza <ID_DEL_ALUMNO> con el ID del alumno específico que deseas buscar

-- Llama a la vista para mostrar los pagos del alumno específico
SELECT * FROM vista_pagos_alumno_especifico;
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Triggers
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------------------------------
# Generar un trigger antes de insertar en la tabla "pago" para que la fecha siempre sea la fecha actual
-- -----------------------------------------------------------------------------------------------------------
DELIMITER //
CREATE TRIGGER before_insert_pago
BEFORE INSERT ON pago
FOR EACH ROW
BEGIN
    SET NEW.mensualidadFecha = CURDATE();
END //
DELIMITER ;vista_pagos_alumnos

-- -------------------------------------------------------------------------------------------------
# GENERE UN TRIGGER EN LA TABLA PAGO PARA EVITAR QUE SE ACTUALICEN REGISTROS.
-- -------------------------------------------------------------------------------------------------
DELIMITER $$
CREATE TRIGGER evitar_modificacion_pago
BEFORE UPDATE ON pago
FOR EACH ROW
BEGIN
  -- Guardar el intento de modificación en la tabla "pago_log"
  INSERT INTO pago_log VALUES (OLD.idMensualidad, OLD.mensualidadFecha, OLD.tipoPago_idTipoPago, OLD.alumno_idalumno, OLD.numRecibo, current_user(), current_date());
  
  -- Evitar la modificación del registro
  SET NEW.idMensualidad = OLD.idMensualidad;
  SET NEW.mensualidadFecha = OLD.mensualidadFecha;
  SET NEW.tipoPago_idTipoPago = OLD.tipoPago_idTipoPago;
  SET NEW.alumno_idalumno = OLD.alumno_idalumno;
  SET NEW.numRecibo = OLD.numRecibo;
END $$
DELIMITER ;

-- Se muestra la tabla
SELECT * FROM centroacuatico.pago_log;

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Funciones
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- -------------------------------------------------------------------------------------------------
# Función que devuelve el mes con más pagos realizados
-- -------------------------------------------------------------------------------------------------
DELIMITER $$
CREATE FUNCTION mesConMasPagos() RETURNS VARCHAR(20) DETERMINISTIC
BEGIN
	DECLARE mesNombre VARCHAR(20);
	DECLARE numeroPag INT;
	DECLARE maxM VARCHAR(20);
	DECLARE maxNP INT;
	DECLARE i INT;
	
	SET maxM = '';
	SET maxNP = 0;
	SET i = 1;

	loop1: LOOP
    -- Comprobamos si hemos alcanzado el mes 12
		IF i > 12 THEN
			LEAVE loop1;
		END IF;
		-- Obtenemos el nombre del mes y el número de pagos para el mes actual
		SELECT MONTHNAME(mensualidadFecha) AS mes, COUNT(*) AS numPagos INTO mesNombre, numeroPag FROM pago WHERE MONTH(mensualidadFecha) = i GROUP BY mes;
		-- Comparamos el número de pagos con el máximo actual
		IF numeroPag > maxNP THEN
			SET maxM = mesNombre; -- Actualizamos el nombre del mes con más pagos
			SET maxNP = numeroPag; -- Actualizamos la cantidad máxima de pagos
		END IF;
		SET i = i + 1;
	END LOOP;
	-- Devolvemos el nombre del mes con más pagos
	RETURN maxM;
END $$
DELIMITER ;

-- checamos el funcionamiento de la funcion
select mesConMasPagos();

-- -------------------------------------------------------------------------------------------------
# Función que devuelve el tipoAlumno más común en la BD
-- -------------------------------------------------------------------------------------------------
delimiter $$
create function tipoAlumnoMasComun() returns VARCHAR(255) deterministic
begin
	declare tA VARCHAR(255);
	declare numeroA int;
	-- Obtener el tipo de alumno más común y el número de alumnos por tipo
	select tipoAlumno_idtipoAlumno as tipoAlumno, count(*) as numAlumnosPorTipo 
    into tA, numeroA from alumno 
    group by tipoAlumno_idtipoAlumno order by numAlumnosPorTipo 
    desc limit 1;

    -- Obtener el nombre del tipo de alumno utilizando el tipoAlumnoID
    SELECT tipoAlumnoNombre INTO tA
    FROM tipoAlumno
    WHERE idtipoAlumno = tA;

	return tA;
end $$

delimiter ;

-- Ejecutar la función y obtener el resultado
select tipoAlumnoMasComun();

-- -------------------------------------------------------------------------------------------------
-- Función que devuelve el horario con más alumnos en él
-- -------------------------------------------------------------------------------------------------
-- Crea el procedimiento almacenado
DELIMITER //
CREATE PROCEDURE obtenerHorarioConMasAlumnos()
BEGIN
    DECLARE idHorario INT;
    DECLARE dia_semana VARCHAR(45);
    DECLARE hora_inicio VARCHAR(45);
    DECLARE hora_fin VARCHAR(45);
    DECLARE cantidad INT;
    
    -- Obtener el horario con más alumnos
    SELECT ho.idHorario, d.diaNombre, hi.hora, hf.hora, COUNT(*) AS numAlumnos
    INTO idHorario, dia_semana, hora_inicio, hora_fin, cantidad
    FROM alumno_has_horario ah
    JOIN horario ho ON ah.horario_idHorario = ho.idHorario
    JOIN diaHora dh ON ho.diaHora_idDiaHora = dh.idDiaHora
    JOIN dia d ON dh.dia_idDia = d.idDia
    JOIN hora hi ON dh.diaHora_idHoraInicio = hi.idHora
    JOIN hora hf ON dh.diaHora_idHoraFin = hf.idHora
    GROUP BY ho.idHorario
    ORDER BY numAlumnos DESC
    LIMIT 1;
    
    -- Crear una tabla temporal para almacenar el resultado
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_horario_con_mas_alumnos (
        dia VARCHAR(45),
        hora_inicio VARCHAR(45),
        hora_fin VARCHAR(45),
        cantidad_alumnos INT
    );
    
    -- Insertar el resultado en la tabla temporal
    INSERT INTO temp_horario_con_mas_alumnos (dia, hora_inicio, hora_fin, cantidad_alumnos)
    VALUES (dia_semana, hora_inicio, hora_fin, cantidad);
    
    -- Obtener el resultado de la tabla temporal
    SELECT * FROM temp_horario_con_mas_alumnos;
    
    -- Eliminar la tabla temporal
    DROP TEMPORARY TABLE IF EXISTS temp_horario_con_mas_alumnos;
END//
DELIMITER ;


-- Ejecutar la función y obtener el resultado
CALL obtenerHorarioConMasAlumnos();

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Llenado de las tablas con restriccion de datos
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SOURCE 'CentroAcuatico/BaseDatos/datos.sql';

-- -----------------------------------------------------
-- CAMBIOS PARA BD Distribuida
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Modificación de la Tabla tipoAlumno:
--
-- Se agrega una nueva entrada para la membresía "Black"
-- -----------------------------------------------------
INSERT INTO `centroacuatico`.`tipoAlumno` (`idtipoAlumno`, `tipoAlumnoNombre`, `tipoAlumnoDescripcion`)
VALUES (NULL, 'Black', 'Membresía que permite asistir a cualquier sucursal');

-- -----------------------------------------------------
-- Tabla Sucursal:
--
-- Para manejar múltiples sucursales, se agrega una tabla 'sucursal' que 
-- almacene la información de cada una.
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `centroacuatico`.`sucursal` (
  `idSucursal` INT NOT NULL AUTO_INCREMENT,
  `sucursalNombre` VARCHAR(100) NOT NULL,
  `sucursalDireccion` VARCHAR(255) NOT NULL,
  `sucursalTelefono` VARCHAR(20) NULL,
  PRIMARY KEY (`idSucursal`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Modificación de la Tabla alumno:
--
-- Agrega una columna sucursal_idSucursal a la tabla 
-- alumno y establece una clave foránea que referencia 
-- a la tabla sucursal.
-- -----------------------------------------------------
ALTER TABLE `centroacuatico`.`alumno`
ADD COLUMN `sucursal_idSucursal` INT NULL,
ADD FOREIGN KEY (`sucursal_idSucursal`) REFERENCES `centroacuatico`.`sucursal` (`idSucursal`);

-- -----------------------------------------------------
-- Modificación de la Tabla pago:
--
-- Para registrar en qué sucursal se realizó el pago, 
-- agrega una columna sucursal_idSucursal a la tabla pago.
-- -----------------------------------------------------
ALTER TABLE `centroacuatico`.`pago`
ADD COLUMN `sucursal_idSucursal` INT NULL,
ADD FOREIGN KEY (`sucursal_idSucursal`) REFERENCES `centroacuatico`.`sucursal` (`idSucursal`);

-- -----------------------------------------------------
-- Modificación de la Tabla horario:
--
-- Para registrar en qué sucursal se imparte el horario, 
-- agrega una columna sucursal_idSucursal a la tabla horario.
-- -----------------------------------------------------
ALTER TABLE `centroacuatico`.`horario`
ADD COLUMN `sucursal_idSucursal` INT NULL,
ADD FOREIGN KEY (`sucursal_idSucursal`) REFERENCES `centroacuatico`.`sucursal` (`idSucursal`);

-- -----------------------------------------------------
-- Columnas de Timestamp:
--
-- Ayuda a mantener un registro de cuándo se crearon y actualizaron los registros, 
-- lo cual es útil para la sincronización y replicación de datos.
-- -----------------------------------------------------
ALTER TABLE `centroacuatico`.`alumno`
ADD COLUMN `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE `centroacuatico`.`pago`
ADD COLUMN `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE `centroacuatico`.`horario`
ADD COLUMN `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE `centroacuatico`.`sucursal`
ADD COLUMN `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

-- -----------------------------------------------------
-- llenado de datos de la tabla sucursal:
-- -----------------------------------------------------
INSERT INTO `centroacuatico`.`sucursal` (`idSucursal`, `sucursalNombre`, `sucursalDireccion`, `sucursalTelefono`)
VALUES 
(NULL, 'Sucursal Centro', 'Calle Principal 123, Centro', '555-1234'),
(NULL, 'Sucursal Norte', 'Avenida Norte 456, Norte', '555-5678'),
(NULL, 'Sucursal Sur', 'Boulevard Sur 789, Sur', '555-9012'),
(NULL, 'Sucursal Este', 'Calle Este 101, Este', '555-3456'),
(NULL, 'Sucursal Oeste', 'Avenida Oeste 202, Oeste', '555-7890');


-- -----------------------------------------------------
-- llenado de datos de la tabla direccion:
-- -----------------------------------------------------
INSERT INTO `centroacuatico`.`direccion` (`idDireccion`, `direccionCalle`, `direccionNumero`, `codigoPostal_idCodigoPostal`)
VALUES 
(NULL, 'Calle Falsa', 123, 1),
(NULL, 'Avenida Siempre Viva', 742, 2),
(NULL, 'Boulevard de los Sueños Rotos', 456, 3),
(NULL, 'Calle de la Amargura', 789, 4),
(NULL, 'Avenida de la Felicidad', 101, 5),
(NULL, 'Boulevard de los Recuerdos', 202, 6),
(NULL, 'Calle de la Esperanza', 303, 7),
(NULL, 'Avenida de los Sueños', 404, 8),
(NULL, 'Boulevard de la Paz', 505, 9),
(NULL, 'Calle de la Alegría', 606, 10);

-- -----------------------------------------------------
-- llenado de datos de la tabla ContactoE:
-- -----------------------------------------------------
INSERT INTO `centroacuatico`.`contactoE` (`idcontactoE`, `contactoENombre`, `contactoETelefono`, `parentesco_idParentesco`, `direccion_idDireccion`)
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
INSERT INTO `centroacuatico`.`alumno` (`idalumno`, `alumnoNombre`, `alumnoApellidop`, `alumnoApellidom`, `alumnoTelefono`, `alumnoCorreo`, `alumnoFechaNac`, `contactoE_idcontactoE`, `alumnoFechaInscripcion`, `tipoAlumno_idtipoAlumno`, `nivelAlumno_idnivelAlumno`, `direccion_idDireccion`, `sucursal_idSucursal`, `created_at`, `updated_at`)
VALUES 
(NULL, 'Juan', 'Pérez', 'Gómez', '555-1111', 'juan@example.com', '2005-01-01', 1, '2025-01-01', 1, 1, 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, 'María', 'López', 'Martínez', '555-2222', 'maria@example.com', '2006-02-02', 2, '2025-02-01', 2, 2, 2, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, 'Carlos', 'Hernández', 'Rodríguez', '555-3333', 'carlos@example.com', '2007-03-03', 3, '2025-03-01', 3, 3, 3, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, 'Ana', 'Martínez', 'García', '555-4444', 'ana@example.com', '2008-04-04', 4, '2025-04-01', 4, 4, 4, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, 'Luis', 'Rodríguez', 'Sánchez', '555-5555', 'luis@example.com', '2009-05-05', 5, '2025-05-01', 5, 5, 5, 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, 'Sofía', 'Díaz', 'Fernández', '555-6666', 'sofia@example.com', '2010-06-06', 6, '2025-06-01', 6, 4, 6, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, 'Pedro', 'Gómez', 'Ruiz', '555-7777', 'pedro@example.com', '2011-07-07', 7, '2025-07-01', 7, 3, 7, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, 'Laura', 'Fernández', 'Díaz', '555-8888', 'laura@example.com', '2012-08-08', 8, '2025-08-01', 8, 4, 8, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, 'Jorge', 'Ruiz', 'Gómez', '555-9999', 'jorge@example.com', '2013-09-09', 9, '2025-09-01', 9, 5, 9, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(NULL, 'Marta', 'García', 'López', '555-0000', 'marta@example.com', '2014-10-10', 10, '2025-10-01', 10, 1, 10, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);


-- -----------------------------------------------------
-- llenado de datos de la tabla pago:
-- -----------------------------------------------------
INSERT INTO `centroacuatico`.`pago` (`idmensualidad`, `mensualidadFecha`, `tipoPago_idtipoPago`, `alumno_idalumno`, `numRecibo`, `sucursal_idSucursal`, `created_at`, `updated_at`)
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
-- llenado de datos de la tabla Horario:
-- -----------------------------------------------------
INSERT INTO `centroacuatico`.`horario`
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