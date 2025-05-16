-- Inciso 1

SELECT E.Nombre, E.Apellido, E.Dni, E.Fecha_Nac, E.Especialidad
FROM Esteticista E
WHERE E.Codest IN (SELECT A.Codest
				   FROM Aplicacion A
				   GROUP BY A.Codest
				   HAVING MIN( DATE_PART( 'year', A.Fecha ) ) = 2019
					  AND MAX( DATE_PART( 'year', A.Fecha ) ) = 2019)
ORDER BY E.Nombre, E.Apellido, E.Dni;

-- Inciso 2

SELECT AVG( C.Edad ) AS Promedio_Edad
FROM Cliente C
		 JOIN Aplicacion A ON C.Codcliente = A.Codcliente
		 JOIN Productoaplicado Pa ON A.Nroaplicacion = Pa.Nroaplicacion
		 JOIN Producto P ON Pa.Codprod = P.Codprod
WHERE P.Nombrep LIKE '%ura';

-- Inciso 3

SELECT P.Nombrep, COUNT( DISTINCT Pa.Nroaplicacion ) AS Cantidad_Aplicaciones, P.Descripcion, P.Stock, P.Precio
FROM Producto P
		 JOIN Productoaplicado Pa ON P.Codprod = Pa.Codprod
GROUP BY P.Codprod, P.Nombrep, P.Descripcion, P.Stock, P.Precio
ORDER BY Cantidad_Aplicaciones;

-- Inciso 4

SELECT E.Nombre, E.Apellido, E.Dni, E.Fecha_Nac, E.Especialidad
FROM Esteticista E
WHERE NOT EXISTS (SELECT 1
				  FROM Aplicacion A
						   JOIN Cliente C ON A.Codcliente = C.Codcliente
				  WHERE A.Codest = E.Codest
					AND C.Edad < 25);

-- Inciso 5

UPDATE Producto
SET Precio=Precio * 1.2
WHERE Nombrep = 'Tintura';

-- Inciso 6

SELECT C.Nombreyap, C.Dni, C.Telefono, C.Direccion, C.Sexo, C.Edad
FROM Cliente C
WHERE C.Codcliente IN (SELECT Codcliente
					   FROM Aplicacion
					   WHERE EXTRACT( YEAR FROM Fecha ) = 2018)
  AND C.Codcliente NOT IN (SELECT Codcliente
						   FROM Aplicacion
						   WHERE EXTRACT( YEAR FROM Fecha ) = 2019);

-- Inciso 7

SELECT DISTINCT P.Nombrep, P.Descripcion, P.Stock, P.Precio
FROM Producto P
		 JOIN Productoaplicado Pa ON P.Codprod = Pa.Codprod
		 JOIN Aplicacion A ON Pa.Nroaplicacion = A.Nroaplicacion
		 JOIN Cliente C ON A.Codcliente = C.Codcliente
WHERE (Pa.Precio < 500)
  AND (C.Sexo = 'F');

-- Inciso 8

SELECT *
FROM Producto P
		 JOIN Productoaplicado P2 ON P.Codprod = P2.Codprod
		 JOIN Aplicacion A ON P2.Nroaplicacion = A.Nroaplicacion
		 JOIN Cliente C ON A.Codcliente = C.Codcliente
WHERE (C.Dni = '38329663');

-- Inciso 9

SELECT P.Codprod, P.Nombrep, P.Descripcion, P.Stock, P.Precio
FROM Producto P
WHERE NOT EXISTS (SELECT 1
				  FROM Esteticista E
				  WHERE NOT EXISTS (SELECT 1
									FROM Productoaplicado Pa
											 JOIN Aplicacion A ON Pa.Nroaplicacion = A.Nroaplicacion
									WHERE Pa.Codprod = P.Codprod
									  AND A.Codest = E.Codest));

-- Inciso 10

SELECT C.Codcliente,
	   C.Nombreyap,
	   C.Dni,
	   C.Telefono,
	   C.Direccion,
	   C.Sexo,
	   C.Edad,
	   SUM( A.Costototal ) AS Totalgastado
FROM Cliente C
		 JOIN Public.Aplicacion A ON C.Codcliente = A.Codcliente
GROUP BY C.Codcliente, C.Nombreyap, C.Dni, C.Telefono, C.Direccion, C.Sexo, C.Edad
HAVING SUM( A.Costototal ) = (SELECT MAX( Total )
							  FROM (SELECT SUM( A2.Costototal ) AS Total
									FROM Aplicacion A2
									GROUP BY A2.Codcliente) AS Totales);