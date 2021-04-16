-- Clase 3

-- Lab Joins
SELECT HR.BusinessEntityID, P.LastName, P.FirstName
FROM HumanResources.Employee AS HR
	INNER JOIN
	 Sales.SalesPerson AS SP
	ON HR.BusinessEntityID = SP.BusinessEntityID
	INNER JOIN 
	 Person.Person AS P
	ON P.BusinessEntityID = HR.BusinessEntityID;
	 
SELECT HR.BusinessEntityID, P.LastName, P.FirstName
FROM HumanResources.Employee AS HR
	INNER JOIN 
	 Person.Person AS P
	ON P.BusinessEntityID = HR.BusinessEntityID
ORDER BY P.LastName, P.FirstName;


SELECT
	HR.BusinessEntityID,
	P.LastName + ', ' + P. FirstName AS Name,
	HR.LoginID, SP.TerritoryID, SP.Bonus

FROM 
	HumanResources.Employee AS HR
	INNER JOIN 
	Sales.SalesPerson AS SP
		ON HR.BusinessEntityID = SP.BusinessEntityID
	INNER JOIN
	Person.Person AS P 
		ON HR.BusinessEntityID = P.BusinessEntityID;


SELECT 
	P.Name, P.ProductSubcategoryID
FROM
	Production.Product AS P
	INNER JOIN
	Production.ProductSubcategory AS PS
		ON P.ProductSubcategoryID = PS.ProductSubcategoryID
WHERE
	PS.Name LIKE '%road%';


SELECT 
	P.Name, P.ProductSubcategoryID
FROM
	Production.Product AS P
	INNER JOIN
	Production.ProductSubcategory AS PS
		ON P.ProductSubcategoryID = PS.ProductSubcategoryID
WHERE
	PS.Name NOT LIKE '%bike%';


SELECT
	SOD.ProductID, P.Name, P.ListPrice, SOD.UnitPrice
FROM
	Sales.SalesOrderDetail AS SOD
	INNER JOIN
	Production.Product AS P
		ON SOD.ProductID = P.ProductID
WHERE
	SOD.UnitPrice < P.ListPrice;

SELECT DISTINCT
	P1.ProductID, P1.ListPrice, P1.Name
--	P2.ProductID, P2.ListPrice, P2.Name
FROM
	Production.Product as P1 
	LEFT JOIN 
	Production.Product as P2 
		ON P1.ProductID <> P2.ProductID AND P1.ListPrice <> 0
WHERE 
	P1.ListPrice = P2.ListPrice
ORDER BY P1.ListPrice


SELECT 
	PP.Name, PP.ProductID, PPV.BusinessEntityID, PP.ProductSubcategoryID
FROM
	Production.Product AS PP
	INNER JOIN 
	Purchasing.ProductVendor AS PPV
		ON PP.ProductID = PPV.ProductID
	INNER JOIN 
	Purchasing.Vendor AS PV
		ON PPV.BusinessEntityID = PV.BusinessEntityID
WHERE
	PP.ProductSubcategoryID = 15;


SELECT 
	P.FirstName + ' ' + P.LastName AS Name, 
	HR.LoginID, HR.BusinessEntityID
FROM
	Person.Person AS P
	LEFT JOIN 
	HumanResources.Employee AS HR
		ON P.BusinessEntityID = HR.BusinessEntityID



-- CTE
-- Tabla temporal que no es física 

SELECT Name, ListPrice, Color
INTO #Productos
FROM Production.Product; 

SELECT BusinessEntityID, FirstName, LastName
INTO #Personas
FROM Person.Person;

DROP TABLE #Productos;
DROP TABLE #Personas;

WITH OrdenesVenta_CTE (SalesPersonID, SalesOrderID, OrderDate) 
AS
(
	SELECT SalesPersonID, SalesOrderID, OrderDate
	FROM Sales.SalesOrderHeader
)

SELECT * FROM OrdenesVenta_CTE; 
-- Tiene que estar siempre! 