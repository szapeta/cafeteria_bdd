-- Base de datos
use B2FyyIIKaj;

-- Tabla demo
create table info(
nombre varchar(100) not null,
version double not null,
fecha datetime not null
);

-- Valor inicial
insert into info (nombre, version, fecha) values ("Cafeteria 4ta Avenida", 0.01, now());



-- -----------------------------------------------------
-- Table `mydb`.`Persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Persona` (
  `idPersona` INT NOT NULL,
  `Nombre` VARCHAR(50) NOT NULL,
  `Apellidos` VARCHAR(50) NULL,
  `Personacol` VARCHAR(45) NULL,
  PRIMARY KEY (`idPersona`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Rol` (
  `idRol` INT NOT NULL,
  `Nombre` VARCHAR(50) NULL,
  `Descripcion` VARCHAR(200) NULL,
  `Estado` INT NULL,
  PRIMARY KEY (`idRol`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Categoria` (
  `idCategoria` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(100) NOT NULL,
  `Descripcion` VARCHAR(200) NOT NULL,
  `Estado` VARCHAR(45) NULL,
  PRIMARY KEY (`idCategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Producto` (
  `idProducto` INT NOT NULL,
  `Nombre` VARCHAR(50) NOT NULL,
  `Descripcion` VARCHAR(200) NOT NULL,
  `Precio` DECIMAL(3,2) NULL,
  `Estado` INT NULL,
  `Imagen` VARCHAR(150) NULL,
  `Categoria_idCategoria` INT NOT NULL,
  PRIMARY KEY (`idProducto`),
  INDEX `fk_Producto_Categoria_idx` (`Categoria_idCategoria` ASC) VISIBLE,
  CONSTRAINT `fk_Producto_Categoria`
    FOREIGN KEY (`Categoria_idCategoria`)
    REFERENCES `mydb`.`Categoria` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Usuario` (
  `idUsuario` INT NOT NULL,
  `Pass` VARCHAR(300) NULL,
  `Estado` INT NULL,
  `Reintentos` INT NULL,
  `Persona_idPersona` INT NOT NULL,
  PRIMARY KEY (`idUsuario`),
  INDEX `fk_Usuario_Persona1_idx` (`Persona_idPersona` ASC) VISIBLE,
  CONSTRAINT `fk_Usuario_Persona1`
    FOREIGN KEY (`Persona_idPersona`)
    REFERENCES `mydb`.`Persona` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Asignacion_Rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Asignacion_Rol` (
  `Usuario_idUsuario` INT NOT NULL,
  `Rol_idRol` INT NOT NULL,
  INDEX `fk_Asignacion_Rol_Usuario1_idx` (`Usuario_idUsuario` ASC) VISIBLE,
  INDEX `fk_Asignacion_Rol_Rol1_idx` (`Rol_idRol` ASC) VISIBLE,
  CONSTRAINT `fk_Asignacion_Rol_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `mydb`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Asignacion_Rol_Rol1`
    FOREIGN KEY (`Rol_idRol`)
    REFERENCES `mydb`.`Rol` (`idRol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Factura` (
  `idFactura` INT NOT NULL,
  `Usuario_idUsuario` INT NOT NULL,
  PRIMARY KEY (`idFactura`),
  INDEX `fk_Factura_Usuario1_idx` (`Usuario_idUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_Factura_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `mydb`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Detalle_Factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Detalle_Factura` (
  `Factura_idFactura` INT NOT NULL,
  `Producto_idProducto` INT NOT NULL,
  `idDetalleFactura` INT NOT NULL,
  `Cantidad` INT NOT NULL,
  `Total` DECIMAL(10,2) NOT NULL,
  INDEX `fk_Detalle_Factura_Factura1_idx` (`Factura_idFactura` ASC) VISIBLE,
  INDEX `fk_Detalle_Factura_Producto1_idx` (`Producto_idProducto` ASC) VISIBLE,
  PRIMARY KEY (`idDetalleFactura`, `Cantidad`, `Total`),
  CONSTRAINT `fk_Detalle_Factura_Factura1`
    FOREIGN KEY (`Factura_idFactura`)
    REFERENCES `mydb`.`Factura` (`idFactura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Detalle_Factura_Producto1`
    FOREIGN KEY (`Producto_idProducto`)
    REFERENCES `mydb`.`Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
