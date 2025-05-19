-- Inciso 1

SELECT C.Nombreyape, C.Direccion, C.Telefono, COUNT( * )
FROM Cartero C
		 JOIN Envio E ON C.Dni = E.Dni

GROUP BY C.Nombreyape, C.Direccion, C.Telefono
ORDER BY COUNT( * ) DESC
LIMIT 1
;
-- Inciso 2

SELECT S.Nombres, COUNT( E.Direccionentrega )
FROM Sucursal S
		 LEFT JOIN Envio E ON S.Idsuc = E.Idsuc AND E.Direccionentrega LIKE '%Ju%'
GROUP BY S.Nombres
ORDER BY S.Nombres
;
-- Inciso 3

SELECT C.*
FROM Cartero C
		 JOIN Envio E ON C.Dni = E.Dni
		 JOIN Sucursal S ON E.Idsuc = S.Idsuc
GROUP BY C.Dni
HAVING COUNT( DISTINCT S.Idsuc ) = (SELECT COUNT( * ) FROM Sucursal) - 1
;
-- Inciso 4

SELECT COUNT( * )
FROM Envio E
WHERE E.Recibido = FALSE
  AND E.Fecha BETWEEN '2019-05-01' AND '2019-05-30'
;
-- Inciso 5

DELETE
FROM Cliente C
WHERE C.Idcliente = 334
;
-- Inciso 6

SELECT C.*
FROM Cartero C
		 JOIN Envio E ON C.Dni = E.Dni
		 JOIN Cliente Cl ON E.Idclienteenvia = Cl.Idcliente
WHERE E.Recibido = TRUE
  AND Cl.Direccion LIKE '%Wilde%'

INTERSECT

SELECT C2.*
FROM Cartero C2
		 JOIN Envio E2 ON C2.Dni = E2.Dni
		 JOIN Cliente Cl2 ON E2.Idclienterecibe = Cl2.Idcliente
WHERE E2.Recibido = FALSE
  AND Cl2.Direccion LIKE '%La Plata%'
;
-- Inciso 7

SELECT S.*
FROM Sucursal S
WHERE EXISTS(SELECT 1
			 FROM Envio E
			 WHERE E.Idsuc = S.Idsuc
			   AND E.Fecha BETWEEN '2020-01-01' AND '2020-12-31'
			   AND E.Recibido = TRUE)
   OR S.Direccions LIKE '%Tucuman%'
;
-- Inciso 8

SELECT Cl.*
FROM Cliente Cl
WHERE NOT EXISTS(SELECT 1
				 FROM Envio E
						  JOIN Sucursal S ON E.Idsuc = S.Idsuc
				 WHERE S.Nombres = 'La Amistad'
				   AND Cl.Idcliente = E.Idclienteenvia)
;
-- Inciso 9

SELECT DISTINCT C.*
FROM Cartero C
		 JOIN Envio E ON C.Dni = E.Dni
		 JOIN Cliente Cl ON E.Idclienterecibe = Cl.Idcliente
WHERE E.Recibido = TRUE
  AND E.Fecha BETWEEN '2019-01-01' AND '2019-12-31'
  AND Cl.Dni < '27329882'
;
-- Inciso 10

SELECT C.*
FROM Cartero C
WHERE NOT EXISTS(SELECT 1
				 FROM Envio E
				 WHERE E.Dni = C.Dni
				   AND E.Recibido = TRUE)
;