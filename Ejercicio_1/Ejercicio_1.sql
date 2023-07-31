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