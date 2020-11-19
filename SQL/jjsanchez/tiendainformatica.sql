-- Ejercicio 1.1: Tienda de informatica 

CREATE TABLE fabricante (
  codigo INT IDENTITY(1,1) PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL
)

CREATE TABLE producto (
  codigo INT IDENTITY(1,1) PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  precio FLOAT NOT NULL,
  codigo_fabricante INT NOT NULL,
  FOREIGN KEY (codigo_fabricante) REFERENCES fabricante(codigo)
)


INSERT INTO fabricante VALUES('Asus')
INSERT INTO fabricante VALUES('Lenovo')
INSERT INTO fabricante VALUES('Hewlett-Packard')
INSERT INTO fabricante VALUES('Samsung')
INSERT INTO fabricante VALUES('Seagate')
INSERT INTO fabricante VALUES('Crucial')
INSERT INTO fabricante VALUES('Gigabyte')
INSERT INTO fabricante VALUES('Huawei')
INSERT INTO fabricante VALUES('Xiaomi')

INSERT INTO producto VALUES('Disco duro SATA3 1TB', 86.99, 5)
INSERT INTO producto VALUES('Memoria RAM DDR4 8GB', 120, 6)
INSERT INTO producto VALUES('Disco SSD 1 TB', 150.99, 4)
INSERT INTO producto VALUES('GeForce GTX 1050Ti', 185, 7)
INSERT INTO producto VALUES('GeForce GTX 1080 Xtreme', 755, 6)
INSERT INTO producto VALUES('Monitor 24 LED Full HD', 202, 1)
INSERT INTO producto VALUES('Monitor 27 LED Full HD', 245.99, 1)
INSERT INTO producto VALUES('Portátil Yoga 520', 559, 2)
INSERT INTO producto VALUES('Portátil Ideapd 320', 444, 2)
INSERT INTO producto VALUES('Impresora HP Deskjet 3720', 59.99, 3)
INSERT INTO producto VALUES('Impresora HP Laserjet Pro M26nw', 180, 3)

-- Consultas
SELECT nombre FROM producto;
SELECT nombre,precio FROM producto;
SELECT * FROM producto;
-- 4 y 9 --
SELECT nombre AS "nombre de producto",precio AS euros,CAST (precio*1.18 AS DECIMAL(5,2)) AS dolares FROM producto;
SELECT UPPER(nombre) AS "nombre de producto",precio AS euros, CAST(precio*1.18 AS DECIMAL(5,2)) AS dolares FROM producto;
SELECT LOWER(nombre) AS "nombre de producto",precio AS euros, CAST(precio*1.18 AS DECIMAL(5,2)) AS dolares FROM producto;
SELECT nombre, UPPER(SUBSTRING(nombre,1,2)) FROM fabricante
SELECT nombre, CAST(precio AS DECIMAL(5,0)) FROM producto;

-- Datos de la tabla
SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'producto';

--11--
SELECT DISTINCT codigo_fabricante from producto;
SELECT codigo_fabricante from producto ORDER BY codigo_fabricante;
SELECT codigo_fabricante from producto ORDER BY codigo_fabricante DESC;
SELECT nombre, precio from producto ORDER BY nombre;
SELECT nombre, precio from producto ORDER BY precio DESC;
SELECT TOP 5 * from fabricante;
--SELECT TOP 3 FROM (SELECT TOP 6 * from fabricante);
SELECT TOP 1 nombre, precio from producto ORDER BY precio;
SELECT TOP 1 nombre, precio from producto ORDER BY precio DESC;
SELECT nombre, precio from producto WHERE codigo_fabricante=2;
SELECT nombre, precio from producto WHERE precio <= 120;
SELECT nombre, precio from producto WHERE precio <= 300 AND precio >= 80