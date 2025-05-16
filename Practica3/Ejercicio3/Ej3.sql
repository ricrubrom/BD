-- Inciso 1

SELECT C.Codcliente, C.Nombre, C.Apellido, C.Pasaporte, C.Nacionalidad
FROM Cliente C
WHERE NOT EXISTS (SELECT 1
				  FROM Aerolinea A
				  WHERE NOT EXISTS (SELECT 1
									FROM Pasaje P
											 JOIN Vuelo V ON P.Codvuelo = V.Codvuelo
									WHERE P.Codcliente = C.Codcliente
									  AND V.Codaerolinea = A.Codaerolinea));
-- Inciso 2

SELECT C.Codcliente, C.Nombre, C.Apellido, C.Pasaporte, C.Nacionalidad, COUNT( * ) AS Cantidad_Vuelos_Bsas
FROM Cliente C
		 JOIN Pasaje P ON C.Codcliente = P.Codcliente
		 JOIN Vuelo V ON P.Codvuelo = V.Codvuelo
		 JOIN Ciudad Ci ON V.Cod_Ciudad_Destino = Ci.Codciudad
WHERE Ci.Nombre = 'Buenos Aires'
GROUP BY C.Codcliente, C.Nombre, C.Apellido, C.Pasaporte, C.Nacionalidad;
-- Inciso 3

SELECT V.Codvuelo,
	   V.Fecha,
	   V.Hora,
	   Ciu_Ori.Nombre  AS Ciudad_Origen,
	   Ciu_Dest.Nombre AS Ciudad_Destino
FROM Vuelo V
		 JOIN Ciudad Ciu_Ori ON V.Cod_Ciudad_Origen = Ciu_Ori.Codciudad
		 JOIN Ciudad Ciu_Dest ON V.Cod_Ciudad_Destino = Ciu_Dest.Codciudad
		 JOIN Pasaje P ON V.Codvuelo = P.Codvuelo
GROUP BY V.Codvuelo, V.Fecha, V.Hora, Ciu_Ori.Nombre, Ciu_Dest.Nombre, V.Cantidad_Pasajes
HAVING COUNT( P.Codreserva ) > V.Cantidad_Pasajes;

-- Inciso 4

SELECT C.Nombre, C.Apellido, C.Pasaporte, C.Nacionalidad
FROM Cliente C
		 JOIN Pasaje P ON P.Codcliente = C.Codcliente
		 JOIN Vuelo V ON P.Codvuelo = V.Codvuelo
GROUP BY C.Nombre, C.Apellido, C.Pasaporte, C.Nacionalidad
HAVING MIN( DATE_PART( 'year', V.Fecha ) ) = 2018
   AND MAX( DATE_PART( 'year', V.Fecha ) ) = 2018
ORDER BY C.Apellido, C.Nombre;
-- Inciso 5

SELECT Ci.Nombre,
	   Ci.Pais,
	   COUNT( * ) AS Cant_Pasajeros
FROM Ciudad Ci
		 LEFT JOIN Vuelo V ON Ci.Codciudad = V.Cod_Ciudad_Destino
		 LEFT JOIN Pasaje P ON V.Codvuelo = P.Codvuelo
WHERE EXTRACT( YEAR FROM V.Fecha ) = 2018
GROUP BY Ci.Nombre, Ci.Pais
ORDER BY Cant_Pasajeros;
-- Inciso 6

DELETE
FROM Vuelo V
WHERE V.Codvuelo = 'LOM3524';

-- Inciso 7

SELECT C.Nombre, C.Apellido, C.Pasaporte, C.Nacionalidad
FROM Cliente C
WHERE EXISTS(SELECT 1
			 FROM Vuelo V
					  JOIN Pasaje P ON V.Codvuelo = P.Codvuelo
					  JOIN Ciudad Ci ON V.Cod_Ciudad_Destino = Ci.Codciudad
			 WHERE (C.Codcliente = P.Codcliente)
			   AND (EXTRACT( YEAR FROM V.Fecha ) = 2018)
			   AND (Ci.Nombre = 'Cancún'))
  AND NOT EXISTS(SELECT 1
				 FROM Vuelo V
						  JOIN Pasaje P ON V.Codvuelo = P.Codvuelo
				 WHERE (C.Codcliente = P.Codcliente)
				   AND (EXTRACT( YEAR FROM V.Fecha ) = 2019));

-- Inciso 8

SELECT V.Fecha,
	   V.Hora,
	   Cio.Nombre AS Ciudad_Origen,
	   Cid.Nombre AS Ciudad_Destino,
	   V.Cantidad_Pasajes,
	   A.Nombre   AS Aerolinea
FROM Vuelo V
		 JOIN Aerolinea A ON V.Codaerolinea = A.Codaerolinea
		 JOIN Ciudad Cid ON Cid.Codciudad = V.Cod_Ciudad_Destino
		 JOIN Ciudad Cio ON Cio.Codciudad = V.Cod_Ciudad_Origen
WHERE (Cid.Nombre = 'Buenos Aires')
   OR EXISTS(SELECT 1
			 FROM Pasaje P
					  JOIN Cliente C ON P.Codcliente = C.Codcliente
			 WHERE (P.Codvuelo = V.Codvuelo)
			   AND (C.Nacionalidad = 'Ucrania'));

-- Inciso 9

SELECT C.Nombre, C.Apellido, C.Pasaporte, C.Nacionalidad
FROM Cliente C
WHERE (EXISTS(SELECT 1
			  FROM Pasaje P
					   JOIN Vuelo V ON P.Codvuelo = V.Codvuelo
					   JOIN Ciudad Ci ON V.Cod_Ciudad_Destino = Ci.Codciudad
			  WHERE (C.Codcliente = P.Codcliente)
				AND (Ci.Nombre = 'Salta'))
	AND EXISTS(SELECT 1
			   FROM Pasaje P
						JOIN Vuelo V ON P.Codvuelo = V.Codvuelo
						JOIN Ciudad Ci ON V.Cod_Ciudad_Destino = Ci.Codciudad
			   WHERE (C.Codcliente = P.Codcliente)
				 AND (Ci.Nombre = 'Jujuy'))
		  );
-- Inciso 10

SELECT A.Nombre, A.Origen
FROM Aerolinea A
WHERE NOT EXISTS (SELECT 1
				  FROM Vuelo V
						   JOIN Ciudad C ON V.Cod_Ciudad_Destino = C.Codciudad
				  WHERE V.Codaerolinea = A.Codaerolinea
					AND C.Pais <> 'Argentina');

