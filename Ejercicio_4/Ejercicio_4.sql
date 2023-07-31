CREATE DATABASE  IF NOT EXISTS `actividades`;
USE `actividades`;
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
