-- 1. Pedidos del vendedor Suyana

-- Con JOIN
SELECT COUNT (*) as 'Pedidos Suyama 1996'  
FROM Employees as E
	INNER JOIN Orders as O
	ON E.EmployeeID = O.EmployeeID
WHERE E.LastName = 'Suyama' AND YEAR(O.RequiredDate) = '1996';

-- Con subqueries
SELECT COUNT (*) as 'Pedidos Suyama 1996'  
FROM Orders
WHERE EmployeeID = (SELECT EmployeeID FROM Employees WHERE LastName = 'Suyama')
  AND YEAR(RequiredDate) = 1996;


-- 2. 
-- Original
SELECT TOP 10 P.ProductName, COUNT(*) as Cantidad
FROM Orders as O
	RIGHT JOIN "Order Details" as OD on O.OrderID = OD.OrderID
	INNER JOIN Products as P ON P.ProductID = OD.ProductID
WHERE YEAR(O.RequiredDate) = '1997'
GROUP BY P.ProductName
ORDER BY Cantidad DESC

--Nueva version

SELECT TOP 10 P.ProductName, SUM(Quantity) as Cantidad
FROM "Order Details" AS OD
	INNER JOIN Orders AS O ON O.OrderID = OD.OrderID
	INNER JOIN Products AS P ON P.ProductID = OD.ProductID
WHERE YEAR(O.RequiredDate) = '1997'
GROUP BY P.ProductName
ORDER BY Cantidad DESC

/* Auxiliar
SELECT 
FROM Orders as O
	RIGHT JOIN "Order Details" as OD on O.OrderID = OD.OrderID
	INNER JOIN Products as P ON P.ProductID = OD.ProductID
WHERE YEAR(O.RequiredDate) = '1997' AND P.ProductName LIKE 'Guaran%'

SELECT ProductID, SUM(Quantity) FROM "Order Details"
WHERE ProductID = '24' 
GROUP BY ProductID
*/

-- 3. Mostrar los productos( id + nombre ) del proveedor ‘Tokyo Traders’
-- que hayan sido enviados por la cia ‘Federal Shipping

SELECT
	P.ProductID, P.ProductName
FROM
	Products as P
		INNER JOIN
	"Order Details" AS OD ON P.ProductID = OD.ProductID
		INNER JOIN
	Orders AS O ON O.OrderID = OD.OrderID
WHERE 
	P.SupplierID = (SELECT SupplierID FROM Suppliers WHERE CompanyName = 'Tokyo Traders')
	AND
	O.ShipVia = (SELECT ShipperID FROM Shippers WHERE CompanyName = 'Federal Shipping')


-- 4. Mostrar los clientes( nombre de compañia) en forma alfabetica
--    con sus importes totales x cada pedido.

SELECT 
	O.CustomerID, OD.OrderID, SUM(Quantity * UnitPrice) AS 'Importe Total' 
FROM Orders AS O
		INNER JOIN 
	"Order Details" AS OD ON O.OrderID = OD.OrderID
GROUP BY O.CustomerID, OD.OrderID
ORDER BY CustomerID;
