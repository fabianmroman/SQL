-- Ejercicio 1.1: Tienda de informatica 
-- Escrito para ejecutarse en T-SQL

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
SELECT TOP(5) * from fabricante;
SELECT nombre FROM fabricante ORDER BY codigo OFFSET 3 ROWS FETCH FIRST 3 ROWS ONLY;
SELECT TOP(1) producto.nombre, precio, fabricante.nombre FROM producto LEFT JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo ORDER BY precio;
SELECT TOP(1) producto.nombre, precio, fabricante.nombre FROM producto LEFT JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo ORDER BY precio DESC;

-- Con subqueries en WHERE
SELECT MAX(precio) AS precio from producto; 

SELECT producto.nombre, precio, fabricante.nombre FROM producto LEFT JOIN
fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE
precio IN (SELECT MIN(precio) FROM producto);

SELECT producto.nombre, precio, fabricante.nombre FROM producto LEFT JOIN
fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE
precio IN (SELECT MAX(precio) FROM producto);
-- 

SELECT producto.nombre, precio, fabricante.nombre FROM producto LEFT JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = 'Lenovo';
SELECT producto.nombre, precio, fabricante.nombre FROM producto LEFT JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = 'Crucial' AND precio > '200';
SELECT producto.nombre, precio, fabricante.nombre FROM producto LEFT JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Asus' OR fabricante.nombre = 'Hewlett-Packard' OR fabricante.nombre = 'Seagate';

--9--
SELECT producto.nombre, precio, fabricante.nombre FROM producto LEFT JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre IN ('Asus', 'Hewlett-Packard', 'Seagate');

SELECT producto.nombre, precio FROM producto LEFT JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre LIKE '%e';

SELECT producto.nombre, precio FROM producto LEFT JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre LIKE '%w%';

SELECT producto.nombre, precio, fabricante.nombre FROM producto LEFT JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE precio >= '180' ORDER BY precio DESC;

SELECT producto.nombre, precio, fabricante.nombre FROM producto LEFT JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE precio >= '180' ORDER BY producto.nombre;

-- 13
SELECT DISTINCT fabricante.codigo, fabricante.nombre FROM producto INNER JOIN
  fabricante ON producto.codigo_fabricante = fabricante.codigo;
  
--1.1.5 Consultas multitabla 

SELECT fabricante.nombre, producto.nombre FROM producto RIGHT JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo;
SELECT fabricante.nombre, producto.nombre FROM producto RIGHT JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
  WHERE producto.nombre IS NULL;
--3: No, todo producto tiene un fabricante relacionado, porque siempre el codigo de producto referencia a una foreign key 
--   FOREIGN KEY (codigo_fabricante) REFERENCES fabricante(codigo)
                                      
-- Consulta propias de integracion 
SELECT fabricante.nombre as fabricante, COUNT(fabricante.nombre) AS 'numero de productos'FROM producto INNER JOIN
fabricante ON producto.codigo_fabricante = fabricante.codigo GROUP BY fabricante.nombre
ORDER BY 'numero de productos';

SELECT fabricante.nombre as fabricante, COUNT(fabricante.nombre) AS 'numero de productos' FROM producto INNER JOIN
fabricante ON producto.codigo_fabricante = fabricante.codigo GROUP BY fabricante.nombre
HAVING COUNT(fabricante.nombre) = '2';

SELECT COUNT(*) FROM producto; 
                                      
                                      
                                      
-- 1.1.6 Consultas resumen

SELECT COUNT(*) AS 'Total Productos' FROM producto; 
SELECT COUNT(*) AS 'Total Fabricantes' FROM fabricante; 
                                      
SELECT COUNT(*) AS 'Fabricantes en stock' FROM (SELECT DISTINCT codigo_fabricante FROM producto) AS subquery1; 
-- Improved query syntax
SELECT COUNT(DISTINCT codigo_fabricante) AS 'Fabricantes en stock' FROM producto;
                                      
SELECT CAST(AVG(precio) AS DECIMAL(5,2)) AS 'Media precios' FROM producto;
SELECT MIN(precio) AS 'Precio mas barato' FROM producto;
SELECT MAX(precio) AS 'Precio mas caro' FROM producto; 
SELECT nombre, precio FROM producto WHERE precio = (SELECT MIN(precio)FROM producto); 
SELECT nombre, precio FROM producto WHERE precio = (SELECT MAX(precio)FROM producto); 
SELECT SUM(precio) AS Suma FROM producto;

-- Con subqueries
SELECT COUNT(*) AS 'Cantidad productos Asus' FROM producto 
  WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Asus');
-- con JOIN
SELECT COUNT(*) AS 'Cantidad productos Asus' FROM producto INNER JOIN fabricante
  ON codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = 'Asus';
  
SELECT AVG(precio) AS 'Media precios Asus' FROM producto INNER JOIN fabricante
  ON codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = 'Asus';
  
SELECT MIN(precio) AS 'Mas barato Asus' FROM producto INNER JOIN fabricante
  ON codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = 'Asus';
  
SELECT MAX(precio) AS 'Mas caro Asus' FROM producto INNER JOIN fabricante
  ON codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = 'Asus';
  
SELECT SUM(precio) AS 'Suma precios Asus' FROM producto INNER JOIN fabricante
  ON codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = 'Asus';
  
SELECT MAX(precio) AS MAX, MIN(precio) AS MIN, AVG(precio) AS AVG, COUNT(*) AS TOTAL FROM producto INNER JOIN fabricante
  ON codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = 'Crucial';                                      
