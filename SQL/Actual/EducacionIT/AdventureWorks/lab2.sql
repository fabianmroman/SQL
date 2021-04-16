-- Clase 2
USE AdventureWorks2014;

-- Select avanzado
SELECT DISTINCT ProductID
FROM Sales.SalesOrderDetail;

SELECT ProductID
FROM Sales.SalesOrderDetail
UNION ALL
SELECT ProductID
FROM Production.WorkOrder
ORDER BY ProductID;

SELECT ProductID
FROM Sales.SalesOrderDetail
UNION
SELECT ProductID
FROM Production.WorkOrder
ORDER BY ProductID;

SELECT BusinessEntityID, 
	   CASE Gender
	   WHEN 'M' THEN 'Masculino'
	   WHEN 'F' THEN 'Femenino'
	   END AS Sexo
FROM HumanResources.Employee; 

SELECT BusinessEntityID
FROM HumanResources.Employee
ORDER BY
	CASE WHEN SalariedFlag = 1 THEN BusinessEntityID END DESC, 
	CASE WHEN SalariedFlag = 0 THEN BusinessEntityID END ASC; 


-- Funciones de agregado
SELECT MAX(OrderDate) AS 'Most recent'
FROM Sales.SalesOrderHeader;

SELECT MIN(ListPrice) AS Min
FROM Production.Product

SELECT MAX(BirthDate) AS Younger
FROM HumanResources.Employee;

SELECT AVG(ListPrice) AS 'Promedio de precios'
FROM Production.Product;

SELECT 
	COUNT(LineTotal) AS Cantidad, 
	SUM(LineTotal) AS 'Total vendido'
FROM Sales.SalesOrderDetail;


-- Funciones de agrupamiento 
SELECT ProductSubcategoryID, MIN(ListPrice) AS Minimo
FROM Production.Product
GROUP BY ProductSubcategoryID;
-- (ver los otros ejercicios de GROUP BY que hacia)

SELECT ProductID, SUM(OrderQty) AS 'Total vendido'
FROM Sales.SalesOrderDetail
GROUP BY ProductID;

SELECT ProductID, SUM(LineTotal) AS 'Total vendido'
FROM Sales.SalesOrderDetail
GROUP BY ProductID
ORDER BY "Total vendido";

SELECT SalesOrderID, AVG(LineTotal) AS Promedio
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID;

-- Having
SELECT SalesOrderID, SUM(LineTotal) AS Total
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
HAVING SUM(LineTotal) > 10000
ORDER BY SalesOrderID

SELECT SalesOrderID, SUM(OrderQty)
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
HAVING SUM(OrderQty) > 20;

SELECT ProductSubcategoryID, COUNT(ListPrice)
FROM Production.Product
WHERE ListPrice < 150
GROUP BY ProductSubcategoryID
HAVING COUNT(ListPrice) >= 2;

SELECT ProductSubcategoryID, AVG(ListPrice) AS Promedio
FROM Production.Product
WHERE ListPrice > 70
GROUP BY ProductSubcategoryID
HAVING AVG(ListPrice) > 300

SELECT SalesOrderID, SUM(UnitPrice*OrderQty) AS Total
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID WITH ROLLUP;