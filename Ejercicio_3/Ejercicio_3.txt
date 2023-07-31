CREATE DATABASE  IF NOT EXISTS `actividades`;
USE `actividades`;

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