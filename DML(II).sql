CREATE DATABASE  IF NOT EXISTS `actividades`;
USE `actividades`;
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------EJERCICIO 1--------------------------------------------------------------------------------------------------------
-- SQL CODE Ejercicio 1
DROP TABLE IF EXISTS `fabricantes`;
CREATE TABLE `fabricantes` (
  `CODIGO` int NOT NULL,
  `NOMBRE` varchar(255) NOT NULL,
  PRIMARY KEY (`CODIGO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `fabricantes` VALUES (1,'Sony'),(2,'Creative Labs'),(3,'Hewlett-Packard'),(4,'Iomega'),(5,'Fujitsu'),(6,'Winchester');
DROP TABLE IF EXISTS `articulos`;
CREATE TABLE `articulos` (
  `CODIGO` int NOT NULL,
  `NOMBRE` varchar(255) NOT NULL,
  `PRECIO` decimal(10,0) NOT NULL,
  `FABRICANTE` int NOT NULL,
  PRIMARY KEY (`CODIGO`),
  KEY `FABRICANTE` (`FABRICANTE`),
  CONSTRAINT `articulos_ibfk_1` FOREIGN KEY (`FABRICANTE`) REFERENCES `fabricantes` (`CODIGO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `articulos` VALUES (1,'Hard drive',240,5),(2,'Memory',120,6),(3,'ZIP drive',150,4),(4,'Floppy disk',5,6),(5,'Monitor',240,1),(6,'DVD drive',180,2),(7,'CD drive',90,2),(8,'Printer',270,3),(9,'Toner cartridge',66,3),(10,'DVD burner',180,2);


-- PREGUNTAS Ejercicio 1
-- Inserta 10 tuplas validas por cada tabla creada
INSERT INTO `fabricantes` VALUES
(7, 'Samsung'),
(8, 'LG'),
(9, 'Apple'),
(10, 'Microsoft'),
(11, 'Lenovo'),
(12, 'ASUS'),
(13, 'Dell'),
(14, 'Acer'),
(15, 'HP'),
(16, 'Toshiba');

INSERT INTO `articulos` VALUES
(11, 'Keyboard', 30, 7),
(12, 'Mouse', 15, 8),
(13, 'Headphones', 50, 9),
(14, 'Monitor Stand', 20, 10),
(15, 'Laptop Charger', 40, 11),
(16, 'External Hard Drive', 100, 12),
(17, 'Printer Ink', 25, 13),
(18, 'Webcam', 35, 14),
(19, 'Graphic Card', 200, 15),
(20, 'Tablet', 150, 16);

-- 1.1 Obtener los nombres de los productos de la tienda
SELECT NOMBRE FROM articulos;

-- 1.2 Obtener los nombres y los precios de los productos de la tienda
SELECT NOMBRE, PRECIO FROM articulos;

-- 1.3 Obtener el nombre de los productos cuyo precio sea menor o igual a 200
SELECT NOMBRE FROM articulos WHERE PRECIO <= 200;

-- 1.4 Obtener todos los datos de los artículos cuyo precio este entre los 60 y los 120 (ambas cantidades incluidas)
SELECT * FROM articulos WHERE PRECIO BETWEEN 60 AND 120;

-- 1.5 Obtener el nombre y el precio en pesetas (es decir el precio multiplicado por 166,386)
SELECT NOMBRE, PRECIO * 166.386 AS PRECIO_Pesetas FROM articulos;

-- 1.6 Seleccionar el precio medio de todos los productos
SELECT AVG(PRECIO) AS PrecioPromedio FROM articulos;

-- 1.7 Obtener el precio medio de los articulos cuyo codigo de fabricante sea 2
SELECT AVG(PRECIO) AS PrecioPromedio FROM articulos WHERE FABRICANTE = 2;

-- 1.8 Obtener el numero de artículos cuyo precio sea mayor o igual a 180
SELECT COUNT(*) AS NumeroArticulos FROM articulos WHERE PRECIO >= 180;

-- 1.9 Obtener el nombre y precio de los articulos cuyo precio sea mayor o igual a 180 y ordenarlos descendentemente por precio y luego ascendentemente por nombre 
SELECT NOMBRE, PRECIO FROM articulos WHERE PRECIO >= 180 ORDER BY PRECIO DESC, NOMBRE ASC;

-- 1.10 Obtener un listado completo de artículos, incluyendo por cada articulo los datos del articulo y de su fabricante
SELECT a.CODIGO AS CodigoArticulo, a.NOMBRE AS NombreArticulo, a.PRECIO AS PrecioArticulo, f.CODIGO AS CodigoFabricante, f.NOMBRE AS NombreFabricante FROM articulos AS a INNER JOIN fabricantes AS f ON a.FABRICANTE = f.CODIGO;

-- 1.11 Obtener un listado de artículos, incluyendo el nombre del articulo, su precio y el nombre de su fabricante
SELECT a.NOMBRE AS NombreArticulo, a.PRECIO AS PrecioArticulo, f.NOMBRE AS NombreFabricante FROM articulos AS a INNER JOIN fabricantes AS f ON a.FABRICANTE = f.CODIGO;

-- 1.12 Obtener el precio medio de los productos de cada fabricante, mostrando solo los códigos de fabricante 
SELECT FABRICANTE AS CodigoFabricante, AVG(PRECIO) AS PrecioMedio FROM articulos GROUP BY FABRICANTE;

-- 1.13 Obtener el precio medio de los productos de cada fabricante, mostrando el nombre del fabricante 
SELECT f.NOMBRE AS NombreFabricante, AVG(a.PRECIO) AS PrecioMedio FROM articulos AS a INNER JOIN fabricantes AS f ON a.FABRICANTE = f.CODIGO GROUP BY f.NOMBRE;

-- 1.14 Obtener los nombres de los fabricantes que ofrezcan productos cuyo precio medio sea mayor o igual a 150
SELECT f.NOMBRE AS NombreFabricante FROM articulos AS a INNER JOIN fabricantes AS f ON a.FABRICANTE = f.CODIGO GROUP BY f.CODIGO, f.NOMBRE HAVING AVG(a.PRECIO) >= 150;

-- 1.15 Obtener el nombre y precio del articulo mas barato
SELECT NOMBRE, PRECIO FROM articulos ORDER BY PRECIO ASC LIMIT 1;

-- 1.16 Obtener una lista con el nombre y precio de los articulos mas caros de cada proveedor (incluyendo el nombre del proveedor)
SELECT f.NOMBRE AS NombreProveedor, a.NOMBRE AS NombreArticulo, a.PRECIO AS PrecioArticulo FROM articulos AS a INNER JOIN fabricantes AS f ON a.FABRICANTE = f.CODIGO WHERE (a.FABRICANTE, a.PRECIO) IN ( SELECT FABRICANTE, MAX(PRECIO) AS MaxPrecio FROM articulos GROUP BY FABRICANTE) ORDER BY f.NOMBRE;

-- 1.17 Añadir un nuevo producto: Altavoces de 70 (del fabricante 2)
INSERT INTO articulos (CODIGO, NOMBRE, PRECIO, FABRICANTE) VALUES (21, 'Altavoces', 70, 2);

-- 1.18 Cambiar el nombre del producto 8 a 'Impresora Laser'
UPDATE articulos SET NOMBRE = 'Impresora Laser' WHERE CODIGO = 8;

-- 1.19 Aplicar un descuento del 10% (multiplicar el precio por 0,9) a todos los productos
UPDATE articulos SET PRECIO = PRECIO * 0.9;

-- 1.20 Aplicar un descuento de 10 a todos los productos cuyo precio sea mayor o igual a 120
UPDATE articulos SET PRECIO = PRECIO - 10 WHERE PRECIO >= 120;

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- -------------------------------------------------------------------------------------------------------------EJERCICIO 2---------------------------------------------------------------------------------------------------------------
-- SQL CODE Ejercicio 2
DROP TABLE IF EXISTS `departamentos`;
CREATE TABLE `departamentos` (
  `CODIGO` int NOT NULL,
  `NOMBRE` varchar(255) NOT NULL,
  `PRESUPUESTO` decimal(10,0) NOT NULL,
  PRIMARY KEY (`CODIGO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `departamentos` VALUES (14,'IT',65000),(37,'Accounting',15000),(59,'Human Resources',240000),(77,'Research',55000);
DROP TABLE IF EXISTS `empleados`;
CREATE TABLE `empleados` (
  `DNI` int NOT NULL,
  `NOMBRE` varchar(255) NOT NULL,
  `APELLIDOS` varchar(255) NOT NULL,
  `DEPARTAMENTO` int NOT NULL,
  PRIMARY KEY (`DNI`),
  KEY `DEPARTAMENTO` (`DEPARTAMENTO`),
  CONSTRAINT `empleados_ibfk_1` FOREIGN KEY (`DEPARTAMENTO`) REFERENCES `departamentos` (`CODIGO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `empleados` VALUES (123234877,'Michael','Rogers',14),(152934485,'Anand','Manikutty',14),(222364883,'Carol','Smith',37),(326587417,'Joe','Stevens',37),(332154719,'Mary-Anne','Foster',14),(332569843,'George','O\Donnell',77),(546523478,'John','Doe',59),(631231482,'David','Smith',77),(654873219,'Zacary','Efron',59),(745685214,'Eric','Goldsmith',59),(845657233,'Luis','López',14),(845657245,'Elizabeth','Doe',14),(845657246,'Kumar','Swamy',14),(845657266,'Jose','Pérez',77);

-- PREGUNTAS Ejercicio 2
-- Inserta 10 tuplas validas por cada tabla creada
INSERT INTO empleados (DNI, NOMBRE, APELLIDOS, DEPARTAMENTO)
VALUES
  (123456789, 'Juan', 'Perez', 14),
  (234567890, 'Maria', 'Lopez', 37),
  (345678901, 'Pedro', 'Gonzalez', 14),
  (456789012, 'Laura', 'Martinez', 59),
  (567890123, 'Carlos', 'Sanchez', 77),
  (678901234, 'Ana', 'Fernandez', 37),
  (789012345, 'David', 'Gomez', 59),
  (890123456, 'Elena', 'Rodriguez', 14),
  (901234567, 'Pablo', 'Hernandez', 77),
  (012345678, 'Sara', 'Ramirez', 59);
  
INSERT INTO departamentos (CODIGO, NOMBRE, PRESUPUESTO)
VALUES
  (101, 'Ventas', 100000),
  (102, 'Recursos Humanos', 75000),
  (103, 'Contabilidad', 90000),
  (104, 'Producción', 120000),
  (105, 'Marketing', 80000),
  (106, 'Tecnología', 150000),
  (107, 'Logística', 110000),
  (108, 'Investigación', 100000),
  (109, 'Servicio al Cliente', 85000),
  (110, 'Desarrollo de Producto', 130000);
  
-- 2.1 Obtener los apellidos de los empleados 
SELECT APELLIDOS FROM empleados;

-- 2.2 Obtener los apellidos de los empleados sin repeticiones 
SELECT DISTINCT APELLIDOS FROM empleados;

-- 2.3 Obtener todos los datos de los empleados que se apellidan 'Smith'
SELECT * FROM empleados WHERE APELLIDOS = 'Smith';

-- 2.4 Obtener todos los datos de los empleados que se apellidan 'Smith' y los que se apellidan 'Rogers'
SELECT * FROM empleados WHERE APELLIDOS = 'Smith' OR APELLIDOS = 'Rogers';

-- 2.5 Obtener todos los datos de los empleados que trabajan para el departamento 37 y para el departamento 77
SELECT * FROM empleados WHERE DEPARTAMENTO = 14;

-- 2.6 Obtener todos los datos de los empleados que trabajan para el departamento 37 y para el departamento 77
SELECT * FROM empleados WHERE DEPARTAMENTO = 37 OR DEPARTAMENTO = 77;

-- 2.7 Obtener todos los datos de los empleados cuyo apellido comience por 'P'
SELECT * FROM empleados WHERE APELLIDOS LIKE 'P%';

-- 2.8 Obtener el presupuesto total de todos los departamentos 
SELECT SUM(PRESUPUESTO) AS PresupuestoTotal FROM departamentos;

-- 2.9 Obtener el numero de empleados en cada departamento 
SELECT DEPARTAMENTO, COUNT(*) AS NumeroEmpleados FROM empleados GROUP BY DEPARTAMENTO;

-- 2.10 Obtener un listado completo de empleados, incluyendo por cada empleado los datos del empleado y de su departamento
SELECT e.DNI, e.NOMBRE, e.APELLIDOS, e.DEPARTAMENTO, d.NOMBRE AS NombreDepartamento, d.PRESUPUESTO FROM empleados AS e JOIN departamentos AS d ON e.DEPARTAMENTO = d.CODIGO;

-- 2.11 Obtener un listado completo de empleados, incluyendo el nombre y apellidos del empleado junto al nombre y presupuesto de su departamento 
SELECT e.NOMBRE, e.APELLIDOS, d.NOMBRE AS NombreDepartamento, d.PRESUPUESTO FROM empleados AS e JOIN departamentos AS d ON e.DEPARTAMENTO = d.CODIGO;

-- 2.12 Obtener los nombres y apellidos de los empleados que trabajen en departamentos cuyo presupuesto sea mayor de 60000
SELECT e.NOMBRE, e.APELLIDOS FROM empleados AS e JOIN departamentos AS d ON e.DEPARTAMENTO = d.CODIGO WHERE d.PRESUPUESTO > 60000;

-- 2.13 Obtener los datos de los departamentos cuyo presupuesto es superior al presupuesto medio de todos los departamentos
SELECT * FROM departamentos WHERE PRESUPUESTO > (SELECT AVG(PRESUPUESTO) FROM departamentos);

-- 2.14 Obtener los nombres (unicamente los nombres) de los departamentos que tienen mas de dos empleados 
SELECT d.NOMBRE AS NombreDepartamento FROM empleados AS e JOIN departamentos AS d ON e.DEPARTAMENTO = d.CODIGO GROUP BY d.NOMBRE HAVING COUNT(*) > 2;

-- 2.15 Añadir un nuevo departamento: 'Calidad', con presupuesto de 40000 y codigo 11.Añadir un empleado vinculado al departamento recien creado: Esther Vazquez, DNI:89267109
INSERT INTO departamentos (CODIGO, NOMBRE, PRESUPUESTO) VALUES (11, 'Calidad', 40000);
INSERT INTO empleados (DNI, NOMBRE, APELLIDOS, DEPARTAMENTO) VALUES (89267109, 'Esther', 'Vazquez', 11);

-- 2.16 Aplicar un recorte presupuestario del 10% a todos los departamentos
UPDATE departamentos SET PRESUPUESTO = PRESUPUESTO * 0.9;

-- 2.17 Reasignar a los empleados del departamento de investigacion (codigo 77) al departamento de informatica (codigo 14)
UPDATE empleados SET DEPARTAMENTO = 14 WHERE DEPARTAMENTO = 77;

-- Despedir a todos los empleados que trabajan para el departamento de informatica (codigo 14)
DELETE FROM empleados WHERE DEPARTAMENTO = 14;

-- 1.19 Despedir a todos los empleados que trabajen para departamentos cuyo presupuesto sea superior a los 60000
DELETE FROM empleados WHERE DEPARTAMENTO IN (SELECT CODIGO FROM departamentos WHERE PRESUPUESTO > 60000);

-- 2.20 Despedir a todos los empleados 
DELETE FROM empleados;

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- -------------------------------------------------------------------------------------------------------------EJERCICIO 3------------------------------------------------------------------------------------------------------------
-- SQL CODE Ejercicio 3
DROP TABLE IF EXISTS `almacenes`;
CREATE TABLE `almacenes` (
  `CODIGO` int NOT NULL,
  `LUGAR` varchar(255) NOT NULL,
  `CAPACIDAD` int NOT NULL,
  PRIMARY KEY (`CODIGO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `almacenes` VALUES (1,'Valencia',3),(2,'Barcelona',4),(3,'Bilbao',7),(4,'Los Angeles',2),(5,'San Francisco',8);
DROP TABLE IF EXISTS `cajas`;
CREATE TABLE `cajas` (
  `NUMREFERENCIA` varchar(255) NOT NULL,
  `CONTENIDO` varchar(255) NOT NULL,
  `VALOR` double NOT NULL,
  `ALMACEN` int NOT NULL,
  PRIMARY KEY (`NUMREFERENCIA`),
  KEY `ALMACEN` (`ALMACEN`),
  CONSTRAINT `cajas_ibfk_1` FOREIGN KEY (`ALMACEN`) REFERENCES `almacenes` (`CODIGO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `cajas` VALUES ('0MN7','Rocks',180,3),('4H8P','Rocks',250,1),('4RT3','Scissors',190,4),('7G3H','Rocks',200,1),('8JN6','Papers',75,1),('8Y6U','Papers',50,3),('9J6F','Papers',175,2),('LL08','Rocks',140,4),('P0H6','Scissors',125,1),('P2T6','Scissors',150,2),('TU55','Papers',90,5);

-- PREGUNTAS Ejercicio 3
-- Inserta 10 tuplas validas por cada tabla creada
INSERT INTO almacenes (CODIGO, LUGAR, CAPACIDAD) VALUES
(11, 'Londres', 9),
(12, 'Ámsterdam', 6),
(13, 'Zurich', 5),
(14, 'Bruselas', 8),
(15, 'Viena', 7),
(16, 'Múnich', 4),
(17, 'Helsinki', 3),
(18, 'Dublín', 6),
(19, 'Estocolmo', 5),
(20, 'Copenhague', 4);

INSERT INTO cajas (NUMREFERENCIA, CONTENIDO, VALOR, ALMACEN) VALUES
('F678', 'Electrodomésticos', 250, 11),
('G901', 'Cosméticos', 120, 11),
('H234', 'Joyas', 180, 12),
('I567', 'Alimentos', 90, 12),
('J890', 'Vinos', 70, 13),
('K123', 'Muebles', 300, 13),
('L456', 'Joyería', 200, 14),
('M789', 'Perfumes', 150, 14),
('N012', 'Ropa', 80, 15),
('O345', 'Electrónicos', 120, 15);


-- 3.1 Obtener todos los almacenes 
SELECT * FROM almacenes;

-- 3.2 Obtener todas las cajas cuyo contenido tenga un valor superior a 150
SELECT * FROM cajas WHERE VALOR > 150;

-- 3.3 Obtener los tipos de contenidos de las cajas 
SELECT DISTINCT CONTENIDO FROM cajas;

-- 3.4 Obtener el valor medio de todas las cajas 
SELECT AVG(VALOR) AS ValorMedio FROM cajas;

-- 3.5 Obtener el valor medio de las cajas de cada almacen 
SELECT ALMACEN, AVG(VALOR) AS ValorMedioCajas FROM cajas GROUP BY ALMACEN;

-- 3.6 Obtener los codigos de los almacenes en los cuales el valor medio de las cajas sea superior a 150
SELECT ALMACEN FROM cajas GROUP BY ALMACEN HAVING AVG(VALOR) > 150;

-- 3.7 Obtener el numero de referencia de cada caja junto con el nombre de la ciudad en el que se encuentra
SELECT c.NUMREFERENCIA, a.LUGAR AS Ciudad FROM cajas c JOIN almacenes a ON c.ALMACEN = a.CODIGO;

-- 3.8 Obtener el numero de cajas que hay en cada almacen
SELECT ALMACEN, COUNT(*) AS NumeroDeCajas FROM cajas GROUP BY ALMACEN;

-- 3.9 Obtener los codigos de los almacenes que estan saturados (los almacenes donde el numero de cajas es superior a la capacidad)
SELECT CODIGO FROM almacenes WHERE CODIGO IN ( SELECT ALMACEN FROM cajas GROUP BY ALMACEN HAVING COUNT(*) > CAPACIDAD );

-- 3.10 Obtener los numeros de referencia de las cajas que estan en Bilbao
SELECT c.NUMREFERENCIA FROM cajas c JOIN almacenes a ON c.ALMACEN = a.CODIGO WHERE a.LUGAR = 'Bilbao';

-- 3.11 Insertar un nuevo almacen en Barcelona con capacidad para 3 cajas 
INSERT INTO almacenes (CODIGO, LUGAR, CAPACIDAD) VALUES (21, 'Barcelona', 3);

-- 3.12 Insertar una nueva caja, con numero de referencia 'H5RT', con contenido 'Papel', valor 200, y situada en el almacen 2
INSERT INTO cajas (NUMREFERENCIA, CONTENIDO, VALOR, ALMACEN) VALUES ('H5RT', 'Papel', 200, 2);

-- 3.13 Rebajar el valor de todas las cajas un 15%
UPDATE cajas SET VALOR = VALOR * 0.85;

-- 3.14 Rebajar un 20% el valor de todas las cajas cuyo valor sea superior al valor medio de todas las cajas
UPDATE cajas SET VALOR = VALOR * 0.8 WHERE VALOR > (SELECT AVG(VALOR) FROM cajas);

-- 3.15 Eliminar todas las cajas cuyo valor sea inferior a 100
DELETE FROM cajas WHERE VALOR < 100;

-- 3.16 Vaciar el contenido de los almacenes que estan saturados
DELETE FROM cajas WHERE ALMACEN IN ( SELECT ALMACEN FROM cajas GROUP BY ALMACEN HAVING COUNT(*) > ( SELECT CAPACIDAD FROM almacenes WHERE CODIGO = cajas.ALMACEN ));

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- -------------------------------------------------------------------------------------------------------------EJERCICIO 4------------------------------------------------------------------------------------------------------------
-- SQL CODE Ejercicio 4
DROP TABLE IF EXISTS `peliculas`;
CREATE TABLE `peliculas` (
  `CODIGO` int NOT NULL,
  `NOMBRE` varchar(255) NOT NULL,
  `CALIFICACIONEDAD` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`CODIGO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `peliculas` VALUES (1,'Citizen Kane','PG'),(2,'Singin in the Rain','G'),(3,'The Wizard of Oz','G'),(4,'The Quiet Man',NULL),(5,'North by Northwest',NULL),(6,'The Last Tango in Paris','NC-17'),(7,'Some Like it Hot','PG-13'),(8,'A Night at the Opera',NULL),(9,'Citizen King','G');
DROP TABLE IF EXISTS `salas`;
CREATE TABLE `salas` (
  `CODIGO` int NOT NULL,
  `NOMBRE` varchar(255) NOT NULL,
  `PELICULA` int DEFAULT NULL,
  PRIMARY KEY (`CODIGO`),
  KEY `PELICULA` (`PELICULA`),
  CONSTRAINT `salas_ibfk_1` FOREIGN KEY (`PELICULA`) REFERENCES `peliculas` (`CODIGO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `salas` VALUES (1,'Odeon',5),(2,'Imperial',1),(3,'Majestic',NULL),(4,'Royale',6),(5,'Paraiso',3),(6,'Nickelodeon',NULL);

-- PREGUNTAS Ejercicio 4
-- Inserta 10 tuplas validas por cada tabla creada
INSERT INTO salas (CODIGO, NOMBRE, PELICULA) VALUES
(10, 'Cineplex', 1),
(11, 'CineWorld', 2),
(12, 'TheatreMax', 3),
(13, 'MovieZone', 4),
(14, 'CineCity', 5),
(15, 'ScreenMasters', 6),
(16, 'SilverScreen', NULL),
(17, 'MegaCine', NULL),
(18, 'DreamTheatre', NULL),
(19, 'BigScreen', NULL);

INSERT INTO peliculas (CODIGO, NOMBRE, CALIFICACIONEDAD) VALUES
(10, 'The Shawshank Redemption', 'R'),
(11, 'The Godfather', 'R'),
(12, 'The Dark Knight', 'PG-13'),
(13, 'Pulp Fiction', 'R'),
(14, 'Inception', 'PG-13'),
(15, 'Forrest Gump', 'PG-13'),
(16, 'The Matrix', 'R'),
(17, 'The Lord of the Rings: The Fellowship of the Ring', 'PG-13'),
(18, 'Gladiator', 'R'),
(19, 'The Lion King', 'G');

-- 4.1 Mostrar el nombre de todas las peliculas 
SELECT NOMBRE FROM peliculas;

-- 4.2 Mostrar las distintas calificaciones de edad que existen
SELECT DISTINCT CALIFICACIONEDAD FROM peliculas;

-- 4.3 Mostrar todas las peliculas que no han sido calificadas 
SELECT * FROM peliculas WHERE CALIFICACIONEDAD IS NULL;

-- 4.4 Mostrar todas las salas que no proyectan ninguna pelicula 
SELECT s.* FROM salas s LEFT JOIN peliculas p ON s.CODIGO = p.PELICULA WHERE p.PELICULA IS NULL;

-- 4.5 Mostrar la informacion de todas las salas y, si se proyecta alguna pelicula en la sala, mostrar tambien la informacion de la pelicula
SELECT s.*, p.NOMBRE AS PELICULA, p.CALIFICACIONEDAD FROM salas s LEFT JOIN peliculas p ON s.PELICULA = p.CODIGO;

-- 4.6 Mostrar la informacion de todas las peliculas y, si se proyecta en alguna sala, mostrar tambien la informacion de la sala
SELECT p.*, s.NOMBRE AS SALA, s.CODIGO AS CODIGO_SALA FROM peliculas p LEFT JOIN salas s ON p.CODIGO = s.PELICULA;

-- 4.7 Mostrar los nombres de las peliculas que no se proyectan en ninguna sala 
SELECT p.NOMBRE FROM peliculas p LEFT JOIN salas s ON p.CODIGO = s.PELICULA WHERE s.CODIGO IS NULL;

-- 4.8 Añadir una nueva pelicula 'Uno, Dos, Tres', para mayores de 7 años
INSERT INTO peliculas (CODIGO, NOMBRE, CALIFICACIONEDAD)
VALUES (20, 'Uno, Dos, Tres', 'PG');

-- 4.9 Hacer constar que todas las peliculas no calificadas han sido calificadas 'no recomnedables para menores de 13 años'
UPDATE peliculas SET CALIFICACIONEDAD = 'no recomendable para menores de 13 años' WHERE CALIFICACIONEDAD IS NULL;

-- 4.10 Eliminar todas las salas que proyectan peliculas recomendadas para todos los públicos
DELETE FROM salas WHERE PELICULA IN ( SELECT CODIGO FROM peliculas WHERE CALIFICACIONEDAD = 'G');







