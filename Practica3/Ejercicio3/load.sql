-- =========================
-- CREACIÓN DE TABLAS
-- =========================

CREATE TABLE IF NOT EXISTS Ciudad
(
	Codciudad Int PRIMARY KEY,
	Nombre    Varchar(50),
	Pais      Varchar(50)
);
CREATE TABLE IF NOT EXISTS Aerolinea
(
	Codaerolinea Int PRIMARY KEY,
	Nombre       Varchar(100),
	Origen       Varchar(50)
);
CREATE TABLE IF NOT EXISTS Cliente
(
	Codcliente   Int PRIMARY KEY,
	Nombre       Varchar(50),
	Apellido     Varchar(50),
	Pasaporte    Varchar(20),
	Nacionalidad Varchar(50)
);
CREATE TABLE IF NOT EXISTS Vuelo
(
	Codvuelo           Varchar(10) PRIMARY KEY,
	Fecha              Date,
	Hora               Time,
	Cod_Ciudad_Origen  Int REFERENCES Ciudad ( Codciudad ),
	Cod_Ciudad_Destino Int REFERENCES Ciudad ( Codciudad ),
	Cantidad_Pasajes   Int,
	Codaerolinea       Int REFERENCES Aerolinea ( Codaerolinea )
);
CREATE TABLE IF NOT EXISTS Pasaje
(
	Codreserva Int PRIMARY KEY,
	Asiento    Varchar(5),
	Codvuelo   Varchar(10) REFERENCES Vuelo ( Codvuelo ),
	Codcliente Int REFERENCES Cliente ( Codcliente ),
	Precio     Decimal(10, 2)
);
-- =========================
-- ELIMINACIÓN DE DATOS
-- =========================

TRUNCATE TABLE Pasaje CASCADE;
TRUNCATE TABLE Vuelo CASCADE;
TRUNCATE TABLE Aerolinea CASCADE;
TRUNCATE TABLE Cliente CASCADE;
TRUNCATE TABLE Ciudad CASCADE;
-- =========================
-- CARGA DE DATOS
-- =========================

-- Tabla Ciudad
INSERT INTO Ciudad (Codciudad, Nombre, Pais)
VALUES (1, 'Buenos Aires', 'Argentina'),
	   (2, 'Salta', 'Argentina'),
	   (3, 'Jujuy', 'Argentina'),
	   (4, 'Cancún', 'México'),
	   (5, 'Kyiv', 'Ucrania'),
	   (6, 'Madrid', 'España'),
	   (7, 'Córdoba', 'Argentina');

-- Tabla Aerolinea
INSERT INTO Aerolinea (Codaerolinea, Nombre, Origen)
VALUES (1, 'Aerolíneas Argentinas', 'Argentina'),
	   (2, 'LATAM', 'Chile'),
	   (3, 'Iberia', 'España'),
	   (4, 'Volaris', 'México');

-- Tabla Cliente
INSERT INTO Cliente (Codcliente, Nombre, Apellido, Pasaporte, Nacionalidad)
VALUES (1, 'Juan', 'Pérez', 'A12345', 'Argentina'),
	   (2, 'María', 'Gómez', 'B67890', 'Argentina'),
	   (3, 'Luis', 'Martínez', 'C54321', 'Argentina'),
	   (4, 'Olena', 'Shevchenko', 'UA9999', 'Ucrania'),
	   (5, 'Carlos', 'Ruiz', 'D88888', 'Argentina'),
	   (6, 'Lucía', 'Fernández', 'E77777', 'Argentina'),
	   (7, 'Pedro', 'Torres', 'F66666', 'Argentina'),
	   (8, 'Ana', 'Méndez', 'G55555', 'Argentina'),
	   (9, 'Marta', 'López', 'H44444', 'Argentina'),
	   (10, 'Sofía', 'Núñez', 'I33333', 'Argentina');

-- Tabla Vuelo
INSERT INTO Vuelo (Codvuelo, Fecha, Hora, Cod_Ciudad_Origen, Cod_Ciudad_Destino, Cantidad_Pasajes, Codaerolinea)
VALUES ('101', '2018-01-15', '08:00:00', 6, 1, 3, 1),
	   ('102', '2018-03-10', '10:30:00', 6, 2, 2, 2),
	   ('103', '2019-05-20', '12:00:00', 6, 3, 5, 3),
	   ('104', '2018-06-05', '09:15:00', 6, 4, 2, 4),
	   ('105', '2019-07-12', '14:45:00', 5, 1, 2, 2),
	   ('106', '2018-04-01', '16:00:00', 4, 1, 1, 1),
	   ('107', '2018-08-08', '11:00:00', 6, 1, 2, 2),
	   ('108', '2019-11-22', '13:00:00', 5, 3, 2, 3),
	   ('109', '2020-01-10', '15:00:00', 6, 2, 1, 4),
	   ('110', '2018-09-09', '17:00:00', 5, 2, 1, 1),
	   ('LOM3524', '2021-01-01', '06:30:00', 6, 1, 1, 3);

-- Tabla Pasaje
INSERT INTO Pasaje (Codreserva, Asiento, Codvuelo, Codcliente, Precio)
VALUES (1, '1A', '101', 1, 500.00),
	   (2, '2B', '102', 1, 600.00),
	   (3, '3C', '103', 1, 700.00),
	   (4, '4D', '104', 1, 800.00),
	   (5, '1A', '101', 2, 500.00),
	   (6, '2B', '102', 2, 600.00),
	   (7, '3C', '103', 2, 700.00),
	   (8, '4D', '104', 2, 800.00),
	   (9, '1A', '101', 3, 500.00),
	   (10, '2B', '102', 3, 600.00),
	   (11, '3C', '103', 3, 700.00),
	   (12, '4D', '104', 3, 800.00),
	   (13, '5E', '101', 4, 900.00),
	   (14, '6F', '105', 4, 750.00),
	   (15, '7G', '106', 4, 700.00),
	   (16, '8H', '107', 4, 850.00),
	   (17, '9I', '101', 4, 900.00),
	   (18, '5E', '101', 5, 900.00),
	   (19, '6F', '105', 5, 750.00),
	   (20, '7G', '106', 5, 700.00),
	   (21, '5E', '101', 6, 900.00),
	   (22, '6F', '105', 6, 750.00),
	   (23, '5E', '101', 7, 900.00),
	   (24, '1A', '102', 8, 600.00),
	   (25, '2B', '106', 8, 700.00),
	   (26, '3C', '110', 9, 650.00),
	   (27, '1A', '110', 10, 500.00),
	   (28, '2A', '110', 6, 500.00),
	   (29, '1A', '104', 9, 800.00),
	   (30, '3F', '105', 4, 750.00),
	   (31, '5G', '102', 5, 600.00),
	   (32, '6H', '103', 5, 700.00);

-- Insertar ciudad no relacionada
INSERT INTO Ciudad (Codciudad, Nombre, Pais)
VALUES (8, 'París', 'Francia');

-- Insertar cliente ucraniano no relacionado
INSERT INTO Cliente (Codcliente, Nombre, Apellido, Pasaporte, Nacionalidad)
VALUES (11, 'Andriy', 'Koval', 'UA123456', 'Ucrania');

-- Insertar vuelo desde Kyiv a París
INSERT INTO Vuelo (Codvuelo, Fecha, Hora, Cod_Ciudad_Origen, Cod_Ciudad_Destino, Cantidad_Pasajes, Codaerolinea)
VALUES ('PAR2025', '2025-06-01', '07:45:00', 5, 8, 1, 3);

-- Insertar pasaje para el cliente ucraniano en ese vuelo
INSERT INTO Pasaje (Codreserva, Asiento, Codvuelo, Codcliente, Precio)
VALUES (33, '1A', 'PAR2025', 11, 1000.00);