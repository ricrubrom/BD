-- Inciso 1

SELECT P.Nombre, P.Descripcion, P.Genero
FROM Pelicula P
WHERE EXISTS(SELECT 1
			 FROM Funcion F
					  JOIN Sala S ON F.Cods = S.Cods
					  JOIN Cine C ON S.Codc = C.Codc
			 WHERE ( P.Codp = F.Codp )
			   AND ( C.Direccion LIKE '%La Plata' ))
  AND EXISTS (SELECT 1
			  FROM Funcion F2
					   JOIN Sala S2 ON F2.Cods = S2.Cods
					   JOIN Cine C2 ON S2.Codc = C2.Codc
			  WHERE ( P.Codp = F2.Codp )
				AND ( C2.Direccion LIKE '%Avellaneda' ));
-- Inciso 2

SELECT DISTINCT P.Nombre
FROM Pelicula P
		 JOIN Funcion F ON P.Codp = F.Codp
WHERE F.Ocupacion < 30
ORDER BY P.Nombre;
-- Inciso 3

SELECT C.Nombre, C.Direccion
FROM Cine C
WHERE NOT EXISTS(SELECT 1
				 FROM Pelicula P
				 WHERE NOT EXISTS(SELECT 1
								  FROM Funcion F
										   JOIN Sala S ON F.Cods = S.Cods
								  WHERE S.Codc = C.Codc
									AND F.Codp = P.Codp));
-- Inciso 4

UPDATE Sala S
SET Nombres='Sala Darin'
WHERE Cods = 10;

-- Inciso 5
SELECT DISTINCT C.Nombre, C.Direccion
FROM Cine C
		 JOIN Sala S ON C.Codc = S.Codc
WHERE EXISTS(SELECT 1
			 FROM Pelicula P
					  JOIN Funcion F ON P.Codp = F.Codp
			 WHERE F.Cods = S.Cods
			   AND P.Nombre = '007 Bond: Sin tiempo para morir')
   OR EXISTS(SELECT 1
			 FROM Funcion F
			 WHERE F.Cods = S.Cods
			   AND F.Ocupacion > 0
			   AND EXTRACT( YEAR FROM F.Fecha ) = 2020);

-- Inciso 6
SELECT P.Nombre, P.Descripcion, P.Genero
FROM Pelicula P
WHERE EXISTS(SELECT 1
			 FROM Funcion F
					  JOIN Sala S ON F.Cods = S.Cods
					  JOIN Cine C ON S.Codc = C.Codc
			 WHERE F.Codp = P.Codp
			   AND C.Nombre = 'Cinemark Hoyts')
  AND NOT EXISTS(SELECT 1
				 FROM Funcion F
						  JOIN Sala S ON F.Cods = S.Cods
						  JOIN Cine C ON S.Codc = C.Codc
				 WHERE F.Codp = P.Codp
				   AND C.Nombre = 'Cinemark Hoyts'
				   AND F.Fecha = CURRENT_DATE);


-- Inciso 7

SELECT C.Nombre, P.Nombre, SUM( F.Ocupacion ) AS Tickets_Vendidos
FROM Cine C
		 JOIN Sala S ON C.Codc = S.Codc
		 JOIN Funcion F ON S.Cods = F.Cods
		 JOIN Pelicula P ON F.Codp = P.Codp
WHERE F.Fecha BETWEEN '2020-01-01' AND '2020-12-31'
GROUP BY C.Nombre, P.Nombre
ORDER BY C.Nombre, P.Nombre
;
-- Inciso 8

BEGIN;
DELETE
FROM Sala
	USING Cine
WHERE Sala.Codc = Cine.Codc
  AND Cine.Nombre = 'Cine China Zorrilla';

DELETE
FROM Cine
WHERE Nombre = 'Cine China Zorrilla';
COMMIT;

-- Inciso 9

SELECT DISTINCT P.Nombre, COUNT( F.Codp ) AS Funciones_Reproducidas
FROM Pelicula P
		 JOIN Funcion F ON P.Codp = F.Codp
WHERE F.Fecha BETWEEN '2020-01-01' AND '2020-12-31'
GROUP BY P.Nombre
;
-- Inciso 10
SELECT DISTINCT P.Nombre
FROM Pelicula P
		 JOIN Funcion F ON F.Codp = P.Codp
WHERE F.Fecha NOT BETWEEN '2020-01-01' AND '2020-12-31'

EXCEPT

SELECT DISTINCT P.Nombre
FROM Pelicula P
		 JOIN Funcion F ON F.Codp = P.Codp
		 JOIN Sala S ON S.Cods = F.Cods
		 JOIN Cine C ON C.Codc = S.Codc
WHERE C.Direccion LIKE '%La Plata%';