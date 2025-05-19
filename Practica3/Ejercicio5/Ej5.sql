-- Inciso 1

SELECT Cl.*
FROM Clientes Cl
WHERE NOT EXISTS(SELECT 1
				 FROM Empleados E
				 WHERE Cl.Direccion = E.Direccion
				   AND NOT EXISTS(SELECT 1
								  FROM Ventas V--
								  WHERE V.Codigocte = Cl.Codigocte
									AND V.Codigoemp = E.Codigoemp))
;
-- Inciso 2

SELECT E.Dni, E.Nombre, E.Fn, E.Direccion, COUNT( * )
FROM Empleados E
		 JOIN Ventas V ON E.Codigoemp = V.Codigoemp
WHERE V.Fecha BETWEEN '2019-01-01' AND '2019-12-31'
GROUP BY E.Dni, E.Nombre, E.Fn, E.Direccion
ORDER BY E.Nombre, E.Fn
;
-- Inciso 3

SELECT DISTINCT E.Dni, E.Nombre, E.Fn, E.Direccion
FROM Empleados E
		 JOIN Ventas V ON E.Codigoemp = V.Codigoemp
		 JOIN Detalleventas Dv ON V.Codventa = Dv.Codventa
GROUP BY E.Dni, E.Nombre, E.Fn, E.Direccion
HAVING COUNT( DISTINCT Dv.Idproducto ) > 50
;
-- Inciso 4

SELECT Cl.Dni, Cl.Nombre, Cl.Direccion, Cl.Telefono, SUM( V.Montototal )
FROM Clientes Cl
		 JOIN Ventas V ON Cl.Codigocte = V.Codigocte
GROUP BY Cl.Dni, Cl.Nombre, Cl.Direccion, Cl.Telefono
ORDER BY SUM( V.Montototal ) DESC
LIMIT 1
;
-- Inciso 5

INSERT INTO Ventas
VALUES (11111, 1000,
		(SELECT E.Codigoemp FROM Empleados E WHERE E.Nombre ILIKE 'CASTELLI JUAN MANUEL'),
		(SELECT Cl.Codigocte FROM Clientes Cl WHERE Cl.Dni = '22369659'), '2022-12-18', 1)
;
-- Inciso 6

SELECT E.*
FROM Empleados E
WHERE NOT EXISTS(SELECT 1
				 FROM Clientes Cl
				 WHERE NOT EXISTS(SELECT 1
								  FROM Ventas V
								  WHERE V.Codigoemp = E.Codigoemp
									AND V.Codigocte = Cl.Codigocte))
;
-- Inciso 7

SELECT V.Nroticket, E.Nombre, Cl.Nombre, V.Fecha, Montototal
FROM Ventas V
		 JOIN Empleados E ON V.Codigoemp = E.Codigoemp
		 JOIN Clientes Cl ON V.Codigocte = Cl.Codigocte
WHERE Montototal > 10000
  AND Cl.Direccion NOT ILIKE '%Tandil%'
;
-- Inciso 8

SELECT Cl.*
FROM Clientes Cl
		 JOIN Ventas V ON Cl.Codigocte = V.Codigocte
WHERE V.Fecha BETWEEN '2019-01-01' AND '2019-12-31'

EXCEPT

SELECT Cl.*
FROM Clientes Cl
		 JOIN Ventas V ON Cl.Codigocte = V.Codigocte
WHERE V.Fecha BETWEEN '2020-01-01' AND '2020-12-31'
;
-- Inciso 9

SELECT DISTINCT E.*
FROM Empleados E
		 JOIN Ventas V ON E.Codigoemp = V.Codigoemp
		 JOIN Detalleventas D ON V.Codventa = D.Codventa
		 JOIN Productos P ON D.Idproducto = P.Idproducto
WHERE P.Precioactual > 1000
;
-- Inciso 10

SELECT DISTINCT P.*
FROM Productos P
WHERE NOT EXISTS(SELECT 1
				 FROM Ventas V
						  JOIN Detalleventas D ON P.Idproducto = D.Idproducto
				 WHERE V.Codventa = D.Codventa
				   AND V.Fecha BETWEEN '2020-01-01' AND '2020-12-31')
;