-- =========================
-- CREACIÓN DE TABLAS
-- =========================

CREATE TABLE IF NOT EXISTS Persona (
    DNI VARCHAR(15) PRIMARY KEY,
    Apellido VARCHAR(100) NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    Fecha_Nacimiento DATE NOT NULL,
    Estado_Civil VARCHAR(50),
    Genero VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS Alumno (
    DNI VARCHAR(15) PRIMARY KEY,
    Legajo INT UNIQUE NOT NULL,
    Año_Ingreso INT NOT NULL,
    FOREIGN KEY (DNI) REFERENCES Persona(DNI)
);

CREATE TABLE IF NOT EXISTS Profesor (
    DNI VARCHAR(15) PRIMARY KEY,
    Matricula INT UNIQUE NOT NULL,
    Nro_Expediente VARCHAR(50),
    FOREIGN KEY (DNI) REFERENCES Persona(DNI)
);

CREATE TABLE IF NOT EXISTS Titulo (
    Cod_Titulo INT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripción TEXT
);

CREATE TABLE IF NOT EXISTS Titulo_Profesor (
    Cod_Titulo INT NOT NULL,
    DNI VARCHAR(15) NOT NULL,
    Fecha DATE NOT NULL,
    PRIMARY KEY (Cod_Titulo, DNI),
    FOREIGN KEY (Cod_Titulo) REFERENCES Titulo(Cod_Titulo),
    FOREIGN KEY (DNI) REFERENCES Profesor(DNI)
);

CREATE TABLE IF NOT EXISTS Curso (
    Cod_Curso INT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripción TEXT,
    Fecha_Creacion DATE NOT NULL,
    Cantidad_Horas INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Alumno_Curso (
    DNI VARCHAR(15) NOT NULL,
    Cod_Curso INT NOT NULL,
    Año INT NOT NULL,
    Desempeño VARCHAR(50),
    Calificación DECIMAL(4,2),
    PRIMARY KEY (DNI, Cod_Curso, Año),
    FOREIGN KEY (DNI) REFERENCES Alumno(DNI),
    FOREIGN KEY (Cod_Curso) REFERENCES Curso(Cod_Curso)
);

CREATE TABLE IF NOT EXISTS Profesor_Curso (
    DNI VARCHAR(15) NOT NULL,
    Cod_Curso INT NOT NULL,
    Fecha_Desde DATE NOT NULL,
    Fecha_Hasta DATE,
    PRIMARY KEY (DNI, Cod_Curso, Fecha_Desde),
    FOREIGN KEY (DNI) REFERENCES Profesor(DNI),
    FOREIGN KEY (Cod_Curso) REFERENCES Curso(Cod_Curso)
);

-- =========================
-- ELIMINACIÓN DE DATOS
-- =========================

TRUNCATE TABLE Profesor_Curso CASCADE;
TRUNCATE TABLE Alumno_Curso CASCADE;
TRUNCATE TABLE Curso CASCADE;
TRUNCATE TABLE Titulo_Profesor CASCADE;
TRUNCATE TABLE Titulo CASCADE;
TRUNCATE TABLE Profesor CASCADE;
TRUNCATE TABLE Alumno CASCADE;
TRUNCATE TABLE Persona CASCADE;

-- =========================
-- INSERCIÓN DE DATOS
-- =========================

-- Insertar alumnos
INSERT INTO alumno (dni, apellido, nombre, fecha_nac, genero, estado_civil, legajo) VALUES
(34567487, 'Perez', 'Juan', '1995-03-12', 'M', 'Soltero', 1089), -- alumno con legajo 1089
(38746662, 'Gomez', 'Ana', '1993-06-25', 'F', 'Soltera', 1090),  -- alumno a eliminar
(41111222, 'Torres', 'Luis', '1996-04-10', 'M', 'Soltero', 1091), -- tuning oracle <= 5
(41111223, 'Molina', 'Laura', '1997-02-18', 'F', 'Soltera', 1092), -- tuning oracle <= 5
(41111224, 'Castro', 'Rocio', '1994-07-23', 'F', 'Casada', 1093); -- solo cursó en 2018

-- Insertar profesores
INSERT INTO profesor (dni, apellido, nombre, fecha_nac, genero, estado_civil, matricula) VALUES
(20123456, 'Lopez', 'Carlos', '1970-08-10', 'M', 'Casado', 1001),
(20987654, 'Martinez', 'Elena', '1980-01-25', 'F', 'Soltera', 1002),
(20223344, 'Suarez', 'Miguel', '1985-05-15', 'M', 'Casado', 1003),
(30334455, 'Fernandez', 'Lucia', '1990-03-12', 'F', 'Soltera', 1004); -- tiene "Licenciado en Sistemas"

-- Insertar títulos
INSERT INTO titulo (dni_profesor, nombre_titulo) VALUES
(20123456, 'Ingeniero'),
(20987654, 'Magister'),
(20223344, 'Analista'),
(30334455, 'Licenciado en Sistemas'),
(30334455, 'Doctorado');

-- Insertar cursos
INSERT INTO curso (id, nombre, descripcion, fecha_creacion, activo) VALUES
(1, 'Algoritmos I', 'Curso de algoritmos básicos', '2016-01-01', false),
(2, 'Estructuras de Datos', 'Curso intermedio', '2017-03-10', false),
(3, 'Base de Datos', 'Teoría y práctica SQL', '2018-05-12', false),
(4, 'Tuning de Oracle', 'Optimización avanzada', '2019-06-15', false),
(5, 'Redes', 'Curso de redes', '2020-07-20', true),
(6, 'Seguridad Informática', 'Curso sobre hacking ético', '2020-08-01', true),
(7, 'Curso vacío 2016', 'Sin alumnos en 2016', '2016-04-01', false);

-- Insertar relaciones curso_profesor
INSERT INTO curso_profesor (id_curso, dni_profesor, horas) VALUES
(1, 20123456, 30),
(2, 20123456, 20),
(3, 20987654, 15),
(4, 20223344, 25),
(5, 30334455, 40), -- activa
(6, 20223344, 10), -- activa
(7, 20987654, 35);

-- Insertar relaciones curso_alumno
INSERT INTO curso_alumno (id_curso, dni_alumno, anio) VALUES
(1, 34567487, 2016),
(2, 34567487, 2017),
(3, 34567487, 2018),
(4, 34567487, 2019),
(5, 34567487, 2020),

(4, 41111222, 2019),
(4, 41111223, 2019),

(3, 38746662, 2018),
(2, 38746662, 2017),
(1, 38746662, 2016),

(3, 41111224, 2018),
(5, 41111222, 2020); -- solo este de 2020

-- Insertar calificaciones
INSERT INTO calificacion (id_curso, dni_alumno, nota) VALUES
(1, 34567487, 8),
(2, 34567487, 7),
(3, 34567487, 9),
(4, 34567487, 6),
(5, 34567487, 10),

(4, 41111222, 4),
(4, 41111223, 5),

(3, 41111222, 5),
(3, 41111223, 5),

(3, 38746662, 6),
(2, 38746662, 7),
(1, 38746662, 6),

(3, 41111224, 9),
(5, 41111222, 7);