-- =========================
-- CREACIÓN DE TABLAS
-- =========================

CREATE TABLE IF NOT EXISTS Cartero (
    DNI VARCHAR(15) PRIMARY KEY,
    nombreYApe VARCHAR(100) NOT NULL,
    direccion VARCHAR(150),
    telefono VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS Sucursal (
    IDSUC INT PRIMARY KEY,
    nombreS VARCHAR(100) NOT NULL,
    direccionS VARCHAR(150),
    telefonoS VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS Cliente (
    IDCLIENTE INT PRIMARY KEY,
    DNI VARCHAR(15) UNIQUE NOT NULL,
    nombreYApe VARCHAR(100) NOT NULL,
    direccion VARCHAR(150),
    telefono VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS Envio (
    NROENVIO INT PRIMARY KEY,
    DNI VARCHAR(15) NOT NULL,  -- DNI del cartero
    IDCLIENTEEnvia INT NOT NULL,
    IDCLIENTERecibe INT NOT NULL,
    IDSUC INT NOT NULL,
    fecha DATE NOT NULL,
    recibido BOOLEAN DEFAULT FALSE,
    fechaRecibe DATE,
    direccionEntrega VARCHAR(150),

    FOREIGN KEY (DNI) REFERENCES Cartero(DNI),
    FOREIGN KEY (IDCLIENTEEnvia) REFERENCES Cliente(IDCLIENTE),
    FOREIGN KEY (IDCLIENTERecibe) REFERENCES Cliente(IDCLIENTE),
    FOREIGN KEY (IDSUC) REFERENCES Sucursal(IDSUC)
);

-- =========================
-- ELIMINACIÓN DE DATOS
-- =========================

TRUNCATE TABLE Envio CASCADE;
TRUNCATE TABLE Cliente CASCADE;
TRUNCATE TABLE Cartero CASCADE;
TRUNCATE TABLE Sucursal CASCADE;



-- =========================
-- CARGA DE DATOS
-- =========================

-- CARTEROS
INSERT INTO Cartero (DNI, nombreYApe, direccion, telefono) VALUES
('12345678', 'Mateo Romero', 'Calle Falsa 123', '111-2222'),
('87654321', 'Manuel Savenia', 'Av Siempre Viva 742', '222-3333'),
('11223344', 'Agustin Murray', 'Calle Real 50', '333-4444'),
('55667788', 'Lucas Fernandez', 'Calle 9 de Julio 123', '444-5555'),
('99999999', 'Ivan Trolanis No Entrega', 'City Bell 342', '221-5555'); -- CARTERO SIN ENVIOS

-- SUCURSALES
INSERT INTO Sucursal (IDSUC, nombreS, direccionS, telefonoS) VALUES
(1, 'La Amistad', 'Calle Juarez 100', '555-1111'),
(2, 'El Progreso', 'Av Juana Manso 200', '555-2222'),
(3, 'Tucuman Central', 'Calle Tucuman 300', '555-3333'),
(4, 'Tucuman Norte', 'Av Tucuman 400', '555-4444'),
(5, 'Santa Rosa', 'Calle San Martin 500', '555-5555'); -- Sucursal sin envios

-- CLIENTES
INSERT INTO Cliente (IDCLIENTE, DNI, nombreYApe, direccion, telefono) VALUES
(334, '99999999', 'Cliente A', 'Calle Falsa 321', '666-7777'),          -- Cliente a borrar
(335, '27329881', 'Cliente B', 'Wilde 123', '666-8888'),                -- Cliente en Wilde
(336, '27329880', 'Cliente C', 'La Plata 456', '666-9999'),             -- Cliente en La Plata
(337, '11111111', 'Cliente D', 'La Plata 789', '666-0000'),
(338, '22222222', 'Cliente E', 'Otra Ciudad', '666-1111');

-- ENVIOS
-- ENVIOS DE MATEO ROMERO (DNI: 12345678)
INSERT INTO Envio (NROENVIO, DNI, IDCLIENTEEnvia, IDCLIENTERecibe, IDSUC, fecha, recibido, fechaRecibe, direccionEntrega) VALUES
(1, '12345678', 335, 336, 1, '2019-04-10', TRUE, '2019-04-11', 'La Plata 456'),  -- Envio a La Plata
(2, '12345678', 335, 337, 2, '2019-05-05', FALSE, NULL, 'Calle Juarez 789'),      -- NO ENTREGADO MAYO 2019 con 'Ju' en direccion
(3, '12345678', 335, 338, 3, '2020-06-15', TRUE, '2020-06-16', 'Tucuman 300'),    -- Envio en 2020 a Tucuman
(4, '12345678', 335, 338, 4, '2020-07-20', TRUE, '2020-07-21', 'Av Tucuman 400'), -- Envio en 2020 a Tucuman Norte
(5, '12345678', 335, 337, 1, '2019-05-10', FALSE, NULL, 'Calle Juarez 123'),      -- NO ENTREGADO MAYO 2019 con 'Ju' en direccion
(6, '12345678', 335, 338, 2, '2019-05-15', FALSE, NULL, 'Av Juana Manso 200'),    -- NO ENTREGADO MAYO 2019 con 'Ju' en direccion
(7, '12345678', 335, 336, 2, '2019-05-20', FALSE, NULL, 'Av Juana Manso 200');    -- NO ENTREGADO MAYO 2019 con 'Ju' en direccion

-- ENVIOS DE MANUEL SAVENIA (DNI: 87654321), entregó a todas las sucursales (1 a 4)
INSERT INTO Envio (NROENVIO, DNI, IDCLIENTEEnvia, IDCLIENTERecibe, IDSUC, fecha, recibido, fechaRecibe, direccionEntrega) VALUES
(8, '87654321', 337, 338, 1, '2019-01-10', TRUE, '2019-01-11', 'Santa Rosa 100'),
(9, '87654321', 337, 335, 2, '2019-02-10', TRUE, '2019-02-11', 'Av Juana Manso 200'),
(10,'87654321', 337, 336, 3, '2019-03-10', TRUE, '2019-03-11', 'Tucuman 300'),
(11,'87654321', 337, 338, 4, '2019-04-10', TRUE, '2019-04-11', 'Av Tucuman 400');

-- ENVIOS DE AGUSTIN MURRAY (DNI: 11223344), entregó a todas las sucursales (1 a 4) y cumple condicion residente Wilde y no La Plata
-- Envíos a clientes que viven en La Plata NO entregados
INSERT INTO Envio (NROENVIO, DNI, IDCLIENTEEnvia, IDCLIENTERecibe, IDSUC, fecha, recibido, fechaRecibe, direccionEntrega) VALUES
(12, '11223344', 335, 336, 1, '2019-06-10', FALSE, NULL, 'La Plata 456'),   -- No entregado a residente en La Plata
(13, '11223344', 335, 337, 2, '2019-07-10', TRUE, '2019-07-11', 'Calle Juarez 789'),
(14, '11223344', 335, 338, 3, '2019-08-10', TRUE, '2019-08-11', 'Av Tucuman 400'),
(15, '11223344', 335, 335, 4, '2019-09-10', TRUE, '2019-09-11', 'Wilde 123');  -- Cliente que envía vive en Wilde

-- ENVIOS DE OTROS CARTEROS PARA CLIENTES CON DNI < 27329882 en 2019
INSERT INTO Envio (NROENVIO, DNI, IDCLIENTEEnvia, IDCLIENTERecibe, IDSUC, fecha, recibido, fechaRecibe, direccionEntrega) VALUES
(16, '55667788', 335, 335, 3, '2019-10-10', TRUE, '2019-10-11', 'Wilde 123'),
(17, '55667788', 335, 336, 3, '2019-11-10', TRUE, '2019-11-11', 'La Plata 456');

-- CLIENTE QUE NO REALIZÓ ENVIOS A LA SUCURSAL 'La Amistad' (IDSUC=1)
-- Cliente 338 no realizó envíos a la sucursal 1
INSERT INTO Envio (NROENVIO, DNI, IDCLIENTEEnvia, IDCLIENTERecibe, IDSUC, fecha, recibido, fechaRecibe, direccionEntrega) VALUES
(18, '12345678', 335, 337, 2, '2020-01-01', TRUE, '2020-01-02', 'Av Juana Manso 200'),
(19, '87654321', 337, 335, 3, '2020-02-01', TRUE, '2020-02-02', 'Tucuman 300');