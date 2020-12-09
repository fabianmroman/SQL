--Resolucion final

--1--
SELECT Cliente.sNombre, ItemFactura.nCantidad, ItemFactura.nImporteItem, 

Factura.dFecha

FROM 
  Cliente INNER JOIN Factura ON Cliente.nIdCliente = Factura.nIdcliente
          INNER JOIN ItemFactura ON Factura.nIdFactura = ItemFactura.nIdFactura
	  INNER JOIN Auto ON ItemFactura.nidAuto = Auto.nIDAuto
	  INNER JOIN Marca ON Auto.nIDMarca = Marca.nIDMarca
	  INNER JOIN Color ON Auto.nIDColor = Color.nIDColor

WHERE 
    UPPER(Color.sDescripcion) = 'ROJO'
  AND
    UPPER(Marca.sDescripcion) = 'FORD'
  AND 
    Auto.SIDPatente >= 'AAA001'
  AND 
    Factura.dFecha BETWEEN '20000301' AND '20010531'; 

  
  

--2--
SELECT Cliente.sNombre, SUM(nCantidad) AS Cantidad, SUM(nImporteItem) AS Total

FROM 
  Cliente 
    INNER JOIN 
  Factura ON Cliente.nIdCliente = Factura.nIdcliente
    INNER JOIN 
  ItemFactura ON Factura.nIdFactura = ItemFactura.nIdFactura
  
WHERE 
  Factura.dFecha >= CAST(DATEADD(MONTH, -3, GETDATE()) AS DATE AND Factura.dFecha < CAST(GETDATE() AS DATE)

GROUP BY 
  Cliente.nIdcliente

HAVING
  SUM(nImporteItem) > '10000';
  
  
  
  
--3--
--Puede ser hecho con INNER JOIN tambien
UPDATE Valor
SET nValor = nValor * 1.15
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
