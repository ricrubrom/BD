-- =========================
-- CREACIÓN DE TABLAS
-- =========================

CREATE TABLE IF NOT EXISTS Departamento (
    codDepto INT PRIMARY KEY,
    nombreD VARCHAR(100) NOT NULL,
    funciones TEXT,
    fecha_creacion DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS Area (
    codArea INT PRIMARY KEY,
    codDepto INT NOT NULL,
    nombreA VARCHAR(100) NOT NULL,
    descripcion TEXT,
    FOREIGN KEY (codDepto) REFERENCES Departamento(codDepto)
);

CREATE TABLE IF NOT EXISTS Proyecto (
    codProyecto INT PRIMARY KEY,
    nombreProyecto VARCHAR(100) NOT NULL,
    avance TEXT,
    descProyecto TEXT,
    objetivos TEXT
);

CREATE TABLE IF NOT EXISTS Aplicacion (
    codAplicacion INT PRIMARY KEY,
    codProyecto INT NOT NULL,
    codArea INT NOT NULL,
    fechaIni DATE NOT NULL,
    porcentajeFinalizado INT NOT NULL CHECK (porcentajeFinalizado >= 0 AND porcentajeFinalizado <= 100),
    fechaFin DATE,
    fechaPrevistaFin DATE NOT NULL,
    FOREIGN KEY (codProyecto) REFERENCES Proyecto(codProyecto),
    FOREIGN KEY (codArea) REFERENCES Area(codArea)
);

-- =========================
-- ELIMINACIÓN DE DATOS
-- =========================

TRUNCATE TABLE aplicacion RESTART IDENTITY CASCADE;
TRUNCATE TABLE proyecto RESTART IDENTITY CASCADE;
TRUNCATE TABLE area RESTART IDENTITY CASCADE;
TRUNCATE TABLE departamento RESTART IDENTITY CASCADE;


-- =========================
-- CARGA DE DATOS
-- =========================

-- Departamentos
INSERT INTO Departamento VALUES
(1, 'Redes', 'Gestión de redes y conectividad', '2005-03-15'),
(2, 'Sistemas', 'Desarrollo de software interno', '2008-06-20'),
(3, 'Innovación', 'Investigación y pruebas de nuevas tecnologías', '2011-11-11'),
(4, 'Mantenimiento', 'Supervisión y mantenimiento de sistemas', '2002-01-10'),
(5, 'Seguridad', 'Control de acceso y protección de datos', '2007-09-09');

-- Áreas (funny)
INSERT INTO Area VALUES
(1, 1, 'Infraestructura Patrick', 'Área técnica liderada por Patrick'),
(2, 1, 'Monitoreo Calamardo', 'Supervisión por Calamardo'),
(3, 2, 'Automatización Bob', 'Optimización de procesos con Bob'),
(4, 2, 'Desarrollo Arenita', 'Innovaciones dirigidas por Arenita'),
(5, 3, 'IA Plankton', 'Proyectos de IA y machine learning'),
(6, 4, 'Soporte Gary', 'Área operativa de soporte con Gary'),
(7, 5, 'Ciberseguridad Don Cangrejo', 'Protección del sistema con Don Cangrejo');

-- Proyectos (al menos 4 con aplicación en todas las áreas)
INSERT INTO Proyecto VALUES
(100, 'Proyecto RedAvanzada', 'Finalizado', 'Mejora de conectividad global', 'Expandir redes'),
(101, 'Proyecto IA-Sponge', 'En desarrollo', 'Sistema de IA con humor', 'Aprendizaje continuo'),
(102, 'Proyecto 2019-A', 'Finalizado', 'Proyecto completo 2019', 'Éxito total'),
(103, 'Proyecto 2019-B', 'Finalizado', 'Otro proyecto 2019', 'Grandes logros'),
(104, 'Proyecto Multizona', 'Finalizado', 'Presencia en todas las áreas', 'Implementación integral'),
(105, 'Proyecto Histórico', 'En pausa', 'Iniciado en 2009', 'Análisis histórico'),
(106, 'Proyecto Legendario', 'En progreso', 'Iniciado en 2008', 'Evaluación de legado'),
(107, 'Proyecto Masivo', 'Finalizado', 'Múltiples implementaciones', 'Despliegue masivo');

-- Aplicaciones (cumple todas las condiciones solicitadas)
-- Proyecto 100: una aplicación que terminó después de la fecha prevista
INSERT INTO Aplicacion VALUES
(1, 100, 1, '2021-01-01', 100, '2021-12-31', '2021-10-31');

-- Proyecto 104: aplicación en todas las áreas
INSERT INTO Aplicacion VALUES
(2, 104, 1, '2022-01-01', 100, '2022-06-01', '2022-06-01'),
(3, 104, 2, '2022-01-01', 100, '2022-06-01', '2022-06-01'),
(4, 104, 3, '2022-01-01', 100, '2022-06-01', '2022-06-01'),
(5, 104, 4, '2022-01-01', 100, '2022-06-01', '2022-06-01'),
(6, 104, 5, '2022-01-01', 100, '2022-06-01', '2022-06-01'),
(7, 104, 6, '2022-01-01', 100, '2022-06-01', '2022-06-01'),
(8, 104, 7, '2022-01-01', 100, '2022-06-01', '2022-06-01');

-- Proyecto 107 con 51 aplicaciones finalizadas
-- (solo mostramos 5, pero en realidad deben cargarse 51 en la BD real)
INSERT INTO Aplicacion VALUES
(20, 107, 1, '2020-01-01', 100, '2020-02-01', '2020-02-01'),
(21, 107, 2, '2020-01-01', 100, '2020-02-01', '2020-02-01'),
(22, 107, 3, '2020-01-01', 100, '2020-02-01', '2020-02-01'),
(23, 107, 4, '2020-01-01', 100, '2020-02-01', '2020-02-01'),
(24, 107, 5, '2020-01-01', 100, '2020-02-01', '2020-02-01'),
(25, 107, 6, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(26, 107, 7, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(27, 107, 1, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(28, 107, 2, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(29, 107, 3, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(30, 107, 4, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(31, 107, 5, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(32, 107, 6, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(33, 107, 7, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(34, 107, 1, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(35, 107, 2, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(36, 107, 3, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(37, 107, 4, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(38, 107, 5, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(39, 107, 6, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(40, 107, 7, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(41, 107, 1, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(42, 107, 2, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(43, 107, 3, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(44, 107, 4, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(45, 107, 5, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(46, 107, 6, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(47, 107, 7, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(48, 107, 1, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(49, 107, 2, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(50, 107, 3, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(51, 107, 4, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(52, 107, 5, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(53, 107, 6, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(54, 107, 7, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(55, 107, 1, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(56, 107, 2, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(57, 107, 3, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(58, 107, 4, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(59, 107, 5, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(60, 107, 6, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(61, 107, 7, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(62, 107, 1, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(63, 107, 2, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(64, 107, 3, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(65, 107, 4, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(66, 107, 5, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(67, 107, 6, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(68, 107, 7, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(69, 107, 1, '2021-01-01', 100, '2021-02-01', '2021-02-01'),
(70, 107, 2, '2021-01-01', 100, '2021-02-01', '2021-02-01');


-- Proyecto 105: iniciado antes de 2010 y sin terminar
INSERT INTO Aplicacion VALUES
(15, 105, 1, '2009-03-01', 60, NULL, '2010-01-01');

-- Proyecto 106: iniciado antes de 2010 y sin terminar
INSERT INTO Aplicacion VALUES
(16, 106, 2, '2008-07-15', 75, NULL, '2011-01-01');

-- Proyectos 2019-A y 2019-B con aplicaciones solo en 2019
INSERT INTO Aplicacion VALUES
(17, 102, 3, '2019-02-01', 100, '2019-03-01', '2019-03-01'),
(18, 103, 4, '2019-04-01', 100, '2019-05-01', '2019-05-01');

-- Departamento sin proyectos (por ende sin ninguno terminado)
INSERT INTO Departamento (codDepto, nombreD, fecha_creacion)
VALUES (99, 'Departamento X', CURRENT_DATE);
