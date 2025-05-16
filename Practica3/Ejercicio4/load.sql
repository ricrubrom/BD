-- =========================
-- CREACIÓN DE TABLAS
-- =========================

-- Create the Cine table
CREATE TABLE IF NOT EXISTS Cine (
    codC INT PRIMARY KEY, -- Assuming codC is an integer identifier
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(255)
);

-- Create the Pelicula table
CREATE TABLE IF NOT EXISTS Pelicula (
    codP INT PRIMARY KEY, -- Assuming codP is an integer identifier
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT, -- Using TEXT for potentially longer descriptions
    genero VARCHAR(50)
);

-- Create the Sala table
CREATE TABLE IF NOT EXISTS Sala (
    codS INT PRIMARY KEY, -- Assuming codS is an integer identifier
    nombreS VARCHAR(50) NOT NULL,
    descripcion VARCHAR(255),
    capacidad INT NOT NULL CHECK (capacidad >= 0), -- Capacity should be non-negative
    codC INT NOT NULL, -- Foreign key linking to Cine
    FOREIGN KEY (codC) REFERENCES Cine(codC)
    -- Consider adding a UNIQUE constraint on (codC, nombreS) if sala names are unique per cine
);

-- Create the Funcion table
CREATE TABLE IF NOT EXISTS Funcion (
    codE INT PRIMARY KEY, -- Assuming codE is an integer identifier for the screening/showtime
    codS INT NOT NULL, -- Foreign key linking to Sala
    codP INT NOT NULL, -- Foreign key linking to Pelicula
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    ocupacion INT DEFAULT 0 CHECK (ocupacion >= 0), -- Occupancy should be non-negative, default to 0
    FOREIGN KEY (codS) REFERENCES Sala(codS),
    FOREIGN KEY (codP) REFERENCES Pelicula(codP)
    -- Note: You might want to add a constraint or trigger later
    -- to ensure ocupacion does not exceed the Sala's capacidad.
);

-- =========================
-- ELIMINACIÓN DE DATOS
-- =========================

TRUNCATE TABLE Cine CASCADE;
TRUNCATE TABLE Pelicula CASCADE;
TRUNCATE TABLE Sala CASCADE;
TRUNCATE TABLE Funcion CASCADE;



INSERT INTO Cine (codC, nombre, direccion) VALUES
(1, 'Cinemark Hoyts', 'Av. 51 543, La Plata'),
(2, 'Multiplex Avellaneda', 'Calle Mitre 400, Avellaneda'),
(3, 'Showcase La Plata', 'Calle 44 2045, La Plata'),
(4, 'Cine Lomas', 'Calle España 123, Lomas de Zamora'),
(5, 'Cine China Zorrilla', 'Calle Uruguay 123, Montevideo');

INSERT INTO Pelicula (codP, nombre, descripcion, genero) VALUES
(1, 'Avengers: Endgame', 'Última batalla de los Vengadores', 'Acción'),
(2, 'Coco', 'Historia de un niño mexicano y su familia', 'Animación'),
(3, 'El Padrino', 'Saga de crimen organizado', 'Drama'),
(4, 'Frozen II', 'Aventura en tierras mágicas', 'Animación'),
(5, 'Tenet', 'Película de ciencia ficción y espionaje', 'Ciencia Ficción'),
(6, 'Parasite', 'Drama coreano sobre desigualdad', 'Thriller'),
(7, 'Soul', 'Viaje espiritual sobre la música', 'Animación'),
(8, '007 Bond: Sin tiempo para morir', 'Nueva misión del agente Bond', 'Acción'),
(9, 'Inside Out', 'Las emociones de una niña', 'Animación');

INSERT INTO Sala (codS, nombreS, descripcion, capacidad, codC) VALUES
(1, 'Sala 1', 'Sala principal', 100, 1),
(2, 'Sala 2', 'Sala secundaria', 80, 1),
(3, 'Sala VIP', 'Comodidad premium', 50, 2),
(4, 'Sala 3', 'Tercera sala', 100, 3),
(5, 'Sala 4', 'Cuarta sala', 120, 4),
(10, 'Sala Murray', 'Sala histórica', 90, 5); -- para inciso 4


-- Funciones para 'Avellaneda' (cine 2) y 'La Plata' (cines 1 y 3)
INSERT INTO Funcion (codE, codS, codP, fecha, hora, ocupacion) VALUES
(1, 3, 1, '2025-05-10', '18:00', 60), -- Avengers en Avellaneda
(2, 4, 1, '2025-05-12', '20:00', 40), -- Avengers en La Plata

-- Funciones con <30 espectadores
(3, 2, 2, '2024-12-25', '16:00', 20), -- Coco
(4, 2, 4, '2023-01-01', '14:00', 25), -- Frozen II

-- Funciones con ocupación = 30
(5, 2, 6, '2020-08-01', '18:00', 30), -- Parasite

-- Funciones con >30 espectadores
(6, 1, 5, '2020-09-15', '19:00', 45), -- Tenet
(7, 4, 3, '2020-07-04', '21:00', 100), -- El Padrino
(8, 4, 6, '2020-10-10', '20:00', 85), -- Parasite
(9, 5, 8, '2020-11-11', '20:00', 95), -- 007 Bond: Sin tiempo para morir

-- Funciones de hoy en Cinemark Hoyts (codC = 1)
(10, 1, 7, CURRENT_DATE, '18:30', 70), -- Soul
(11, 2, 8, CURRENT_DATE, '21:00', 80), -- 007 Bond: Sin tiempo para morir

-- Funciones de Cinemark Hoyts, pero NO hoy
(12, 1, 9, '2025-05-15', '15:00', 60); -- Inside Out

-- Películas exhibidas en 2020 (para inciso 7 y 9)
-- repetimos películas con distintas fechas para simular múltiples funciones
INSERT INTO Funcion (codE, codS, codP, fecha, hora, ocupacion) VALUES
(13, 1, 1, '2020-01-15', '18:00', 35),
(14, 1, 2, '2020-03-10', '20:00', 25),
(15, 1, 3, '2020-04-20', '22:00', 50),
(16, 2, 4, '2020-05-25', '14:00', 60),
(17, 3, 5, '2020-06-30', '17:00', 40),
(18, 3, 6, '2020-09-14', '18:00', 55),
(19, 3, 7, '2020-12-24', '20:00', 75);


INSERT INTO Pelicula (codP, nombre, descripcion, genero)
VALUES (10, 'Minari', 'Drama familiar sobre una familia coreano-estadounidense en los 80s', 'Drama');
INSERT INTO Funcion (codE, codS, codP, fecha, hora, ocupacion)
VALUES (90, 3, 10, '2022-08-15', '20:00', 0);