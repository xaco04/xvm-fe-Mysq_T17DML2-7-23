CREATE DATABASE  IF NOT EXISTS `actividades`;
USE `actividades`;
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