-- Inciso 1

SELECT P.Nombreproyecto, A.Nombrea, D.Nombred, Ap.Fechaini, Ap.Fechafin, Ap.Fechaprevistafin
FROM Aplicacion Ap
		 JOIN Proyecto P ON Ap.Codproyecto = P.Codproyecto
		 JOIN Area A ON Ap.Codarea = A.Codarea
		 JOIN Departamento D ON A.Coddepto = D.Coddepto
WHERE Ap.Fechafin > Ap.Fechaprevistafin
;
-- Inciso 2

SELECT A.Nombrea, COUNT( P.Codproyecto ) AS Cantproyectos
FROM Area A
		 LEFT JOIN Aplicacion Ap ON A.Codarea = Ap.Codarea
		 LEFT JOIN Proyecto P ON Ap.Codproyecto = P.Codproyecto
	AND Ap.Fechafin BETWEEN '2020-01-01' AND '2020-12-31'
GROUP BY A.Nombrea;
;
-- Inciso 3

SELECT DISTINCT D.Nombred, D.Funciones, D.Fecha_Creacion
FROM Departamento D
		 LEFT JOIN Area A ON D.Coddepto = A.Coddepto
		 LEFT JOIN Aplicacion Ap ON A.Codarea = Ap.Codarea
WHERE D.Coddepto NOT IN (SELECT DISTINCT D2.Coddepto
						 FROM Departamento D2
								  JOIN Area A2 ON D2.Coddepto = A2.Coddepto
								  JOIN Aplicacion Ap2 ON A2.Codarea = Ap2.Codarea
						 WHERE Ap2.Fechafin IS NOT NULL);
;
-- Inciso 4

SELECT P.Nombreproyecto, P.Avance, P.Descproyecto, P.Objetivos, COUNT( Ap.Codaplicacion ) AS Cantidad_Aplicaciones
FROM Proyecto P
		 JOIN Aplicacion Ap ON P.Codproyecto = Ap.Codproyecto
GROUP BY P.Nombreproyecto, P.Avance, P.Descproyecto, P.Objetivos
HAVING 50 < COUNT( Ap.Codaplicacion )
ORDER BY Cantidad_Aplicaciones
;
-- Inciso 5

INSERT INTO Proyecto
VALUES (123456, 'Prueba', 'Viene bien', 'Esto es una prueba!', 'El objetivo es probar la insercion')
;
-- Inciso 6
SELECT P.Nombreproyecto, P.Avance, P.Descproyecto, P.Objetivos
FROM Proyecto P
WHERE NOT EXISTS(SELECT 1
				 FROM Area A
				 WHERE NOT EXISTS(SELECT 1
								  FROM Aplicacion Ap
								  WHERE A.Codarea = Ap.Codarea
									AND Ap.Codproyecto = P.Codproyecto))
;
-- Inciso 7

SELECT DISTINCT D.*
FROM Departamento D
WHERE NOT EXISTS(SELECT 1
				 FROM Area A
						  JOIN Aplicacion Ap ON A.Codarea = Ap.Codarea
				 WHERE A.Coddepto = D.Coddepto)
;
-- Inciso 8

SELECT P.*
FROM Proyecto P
		 JOIN Aplicacion A ON P.Codproyecto = A.Codproyecto
WHERE A.Fechaini < '2010-01-01'
  AND A.Fechafin IS NULL
;
-- Inciso 9

SELECT A.*
FROM Area A
		 JOIN Departamento D ON A.Coddepto = D.Coddepto
WHERE D.Nombred LIKE '%Redes%'
;
-- Inciso 10

SELECT P.*
FROM Proyecto P
		 JOIN Aplicacion Ap ON P.Codproyecto = Ap.Codproyecto
WHERE Ap.Fechafin BETWEEN '2019-01-01' AND '2019-12-31'

EXCEPT

SELECT P2.*
FROM Proyecto P2
		 JOIN Aplicacion Ap2 ON P2.Codproyecto = Ap2.Codproyecto
WHERE Ap2.Fechafin NOT BETWEEN '2019-01-01' AND '2019-12-31'
;