-- Esquema físico para la definición de la bd de una escuela de natación

-- -----------------------------------------------------
-- Schema centroacuatico
-- -----------------------------------------------------
DROP database IF EXISTS `centroacuatico` ;

-- -----------------------------------------------------
-- Schema centroacuatico
-- -----------------------------------------------------
CREATE database IF NOT EXISTS `centroacuatico` DEFAULT CHARACTER SET utf8 ;
USE `centroacuatico` ;

-- -----------------------------------------------------
-- Table `centroacuatico`.`parentesco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `centroacuatico`.`parentesco` (
  `idParentesco` INT NOT NULL AUTO_INCREMENT,
  `parentescoNombre` VARCHAR(45) NULL,
  `parentescoDescripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`idParentesco`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `centroacuatico`.`direccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `centroacuatico`.`direccion` (
  `idDireccion` INT NOT NULL AUTO_INCREMENT,
  `direccionCalle` VARCHAR(150) NULL,
  `direccionNumero` INT NULL,
  `direccionCodigoPostal` VARCHAR(10) NULL,
  PRIMARY KEY (`idDireccion`))
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
  `tipoAlumnoDescripcion` VARCHAR(45) NULL COMMENT 'Existen dos tipos de alumnos: Bcados y Regulares',
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
  `tipoPagoMonto` FLOAT NULL,
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
-- Table `centroacuatico`.`categoriaHorario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `centroacuatico`.`categoriaHorario` (
  `idCategoriaHorario` INT NOT NULL AUTO_INCREMENT,
  `categoriaHorarioNombre` VARCHAR(45) NULL,
  `tipoHorario_idtipoHorario` INT NOT NULL,
  PRIMARY KEY (`idCategoriaHorario`),
  INDEX `fk_categoriaHorario_tipoHorario1_idx` (`tipoHorario_idtipoHorario` ASC) ,
  CONSTRAINT `fk_categoriaHorario_tipoHorario1`
    FOREIGN KEY (`tipoHorario_idtipoHorario`)
    REFERENCES `centroacuatico`.`tipoHorario` (`idtipoHorario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `centroacuatico`.`horario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `centroacuatico`.`horario` (
  `idHorario` INT NOT NULL AUTO_INCREMENT,
  `categoriaHorario_idCategoriaHorario` INT NOT NULL,
  `diaHora_idDiaHora` INT NOT NULL,
  PRIMARY KEY (`idHorario`),
  INDEX `fk_alumno_has_horario_tipoHorario1_idx` (`categoriaHorario_idCategoriaHorario` ASC) ,
  INDEX `fk_horario_diaHora1_idx` (`diaHora_idDiaHora` ASC) ,
  CONSTRAINT `fk_alumno_has_horario_tipoHorario1`
    FOREIGN KEY (`categoriaHorario_idCategoriaHorario`)
    REFERENCES `centroacuatico`.`categoriaHorario` (`idCategoriaHorario`)
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
