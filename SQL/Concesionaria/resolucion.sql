--Primera resolucion, contiene errores o cosas para mejorar

--1--
DECLARE @idRojo AS INT;
DECLARE @idFord AS INT;
SET @idRojo = (SELECT nIDColor FROM Color WHERE UPPER(sDescripcion) = 'ROJO');
SET @idFord = (SELECT nIDMarca FROM Marca WHERE UPPER(sDescripcion) = 'FORD');

SELECT c.sNombre, iFact.nCantidad, iFact.nImporteItem, fact.dFecha

FROM 
  cliente AS c
  RIGHT JOIN Factura AS fact ON c.nIdCliente = fact.nIdcliente
  RIGHT JOIN ItemFactura AS iFact ON fact.nIDFactura = iFact.nIdFactura

WHERE 
  nIDAuto IN (SELECT nIdAuto FROM Auto WHERE nIDMarca = @idFord AND nIdcolor = @idRojo AND SIDPatente >= 'AAA001')
AND
  dFecha BETWEEN 20000301 AND 20010531;
  
  
  
  

--2--
SELECT Cliente.sNombre, SUM(nCantidad) AS Cantidad, SUM(nImporteItem * nCantidad) AS Total

FROM 
  Cliente 
    INNER JOIN 
  Factura ON Cliente.nIdCliente = Factura.nIdcliente
    INNER JOIN 
  ItemFactura ON Factura.nIdFactura = ItemFactura.nIdFactura
  
WHERE 
  Factura.dFecha >= CONVERT(VARCHAR(8), CAST(DATEADD(MONTH, -3, GETDATE()) AS DATE),112) AND Factura.dFecha < CONVERT(VARCHAR(8), CAST(GETDATE() AS DATE),112);

GROUP BY 
  Cliente.nIdcliente

HAVING
  SUM(nImporteItem * nCantidad) > 10000;
  
  
--3--
UPDATE Valor
SET nValor = nValor * 1,15
WHERE nIDAuto IN (
  SELECT Auto.nIDAuto
  FROM 
    Auto INNER JOIN Marca ON Auto.nIDMarca = Marca.nIDMarca
  WHERE
    UPPER(Marca.sDescripcion) = 'FORD'
  AND
    Auto.nIDAño = '2001')
AND 
  nIdMoneda = SELECT nIDMoneda from Monedas WHERE UPPER(sDescripcion = 'Pesos');