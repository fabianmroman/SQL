-- Clase 4 

-- Subconsultas 
SELECT 
	Name, ListPrice
FROM 
	Production.Product
WHERE
	ListPrice < (SELECT AVG(ListPrice) FROM Production.Product);



SELECT ProductID, ListPrice
FROM Production.Product
WHERE ListPrice = (SELECT MAX(ListPrice) FROM Production.Product);


SELECT 
	ProductSubcategoryID, ProductID, ListPrice
FROM
	Production.Product



-- EXISTS
SELECT
	ProductSubcategoryID, Name
FROM
	Production.Product
WHERE 
	ProductSubcategoryID = (SELECT ProductSubcategoryID FROM Production.ProductSubcategory WHERE Name LIKE '%wheel%')


SELECT 

FROM 
	





-- DML 
SELECT
	ProductID, Name, Color, ListPrice
INTO
	Produccion
FROM
	Production.Product;

UPDATE Produccion
SET ListPrice = ListPrice * 1.20; 


DELETE FROM Produccion
WHERE ListPrice = 0; 


INSERT INTO Produccion
	VALUES ('Bicicleta Mountain Bike', 'Red', 4000);
--El ProductID se genera automaticamente

UPDATE Produccion
SET ListPrice = ListPrice * 1.15
WHERE Name LIKE '%Pedal%';

DELETE FROM Produccion
WHERE Name LIKE 'm%';

TRUNCATE TABLE Produccion;

SELECT * FROM Produccion;

DROP TABLE Produccion; 





