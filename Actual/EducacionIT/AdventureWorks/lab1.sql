-- Unidad 1 

-- Operadores
SELECT VacationHours, BusinessEntityID
FROM HumanResources.Employee
WHERE VacationHours > 90;

SELECT Name, ListPrice, ListPrice * 1.21 AS FinalPrice
FROM Production.Product 
WHERE ListPrice <> 0; 

SELECT ProductID, Name, ListPrice
FROM Production.Product
WHERE ProductID IN (776,777,778);

SELECT FirstName + ' ' + LastName AS Nombre
FROM Person.Person
WHERE LOWER(LastName) = 'johnson';

SELECT ListPrice, Color
FROM Production.Product
WHERE ListPrice < 150 OR (ListPrice > 500 AND LOWER(Color) = 'black');

SELECT BusinessEntityID, HireDate, VacationHours
FROM HumanResources.Employee
WHERE YEAR(HireDate) >= 2000;

SELECT Name, ProductNumber, ListPrice * 1.10 AS ListPrice, SellEndDate
FROM Production.Product
WHERE SellEndDate < GETDATE();
-- Y no selecciona los NULLs! 

SELECT TerritoryID, BusinessEntityID
FROM Sales.SalesPerson
WHERE TerritoryID IS NULL;

SELECT
	CASE
	WHEN Weight IS NULL THEN '0'
	ELSE Weight END
	AS Weight, Name
/* Otra forma
	Weight = CASE 
	WHEN Weight IS NULL THEN '0'
	ELSE Weight END, Name
*/
FROM Production.Product;


-- Criterios de seleccion
SELECT Name, ListPrice, Color
FROM Production.Product
WHERE ListPrice > 100;

SELECT Name
FROM Production.Product
WHERE Name LIKE '%mountain bike%';

SELECT FirstName
FROM Person.Person
WHERE FirstName LIKE 'y%';

SELECT FirstName
FROM Person.Person	
WHERE FirstName LIKE '_s%';

SELECT FirstName + ' ' + LastName
FROM Person.Person
WHERE LastName LIKE '%ez';

SELECT Name
FROM Production.Product
WHERE Name LIKE '%[0-9]';

SELECT FirstName
FROM Person.Person
WHERE FirstName LIKE 'c_[^defg][j-w]%';

SELECT ListPrice
FROM Production.Product
WHERE ListPrice BETWEEN 200 AND 300;

SELECT BirthDate
FROM HumanResources.Employee
WHERE BirthDate BETWEEN '1970' AND '1985';

SELECT OrderDate, AccountNumber, SubTotal
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '2011' AND '2012';

SELECT OrderDate, AccountNumber, SubTotal
FROM Sales.SalesOrderHeader
WHERE Subtotal NOT BETWEEN 50 AND 70;

SELECT SalesOrderID, OrderQty, ProductID, UnitPrice
FROM Sales.SalesOrderDetail
WHERE ProductID IN (750, 753, 770);

SELECT Color
FROM Production.Product
WHERE Color IN ('green', 'white', 'blue');

-- Ordenamiento
SELECT FirstName, LastName
FROM Person.Person
ORDER BY LastName, FirstName;

SELECT TOP(5) Name, ListPrice
FROM Production.Product
ORDER BY ListPrice DESC, Name;