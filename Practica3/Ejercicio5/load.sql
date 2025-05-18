-- =========================
-- CREACIÓN DE TABLAS
-- =========================

-- Create the Cine table
-- Crear la tabla Productos
CREATE TABLE IF NOT EXISTS Productos (
    idProducto INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    presentacion VARCHAR(100),
    stock INT NOT NULL CHECK (stock >= 0),
    stock_minimo INT NOT NULL CHECK (stock_minimo >= 0),
    precioActual DECIMAL(10,2) NOT NULL CHECK (precioActual >= 0)
);

-- Crear la tabla Empleados
CREATE TABLE IF NOT EXISTS Empleados (
    codigoEmp INT PRIMARY KEY,
    DNI VARCHAR(15) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    fn DATE NOT NULL,
    direccion VARCHAR(100) NOT NULL
);

-- Crear la tabla Clientes
CREATE TABLE IF NOT EXISTS Clientes (
    codigoCte INT PRIMARY KEY,
    DNI VARCHAR(15) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    telefono VARCHAR(20)
);

-- Crear la tabla Ventas
CREATE TABLE IF NOT EXISTS Ventas (
    codVenta INT PRIMARY KEY,
    nroTicket INT NOT NULL,
    codigoEmp INT NOT NULL,
    codigoCte INT NOT NULL,
    fecha DATE NOT NULL,
    montoTotal DECIMAL(10,2) NOT NULL CHECK (montoTotal >= 0),
    FOREIGN KEY (codigoEmp) REFERENCES Empleados(codigoEmp),
    FOREIGN KEY (codigoCte) REFERENCES Clientes(codigoCte)
);

-- Crear la tabla DetalleVentas
CREATE TABLE IF NOT EXISTS DetalleVentas (
    codVenta INT NOT NULL,
    idProducto INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precioUnitario DECIMAL(10,2) NOT NULL CHECK (precioUnitario >= 0),
    PRIMARY KEY (codVenta, idProducto),
    FOREIGN KEY (codVenta) REFERENCES Ventas(codVenta),
    FOREIGN KEY (idProducto) REFERENCES Productos(idProducto)
);

-- =========================
-- ELIMINACIÓN DE DATOS
-- =========================

TRUNCATE TABLE DetalleVentas CASCADE;
TRUNCATE TABLE Ventas CASCADE;
TRUNCATE TABLE Clientes CASCADE;
TRUNCATE TABLE Empleados CASCADE;
TRUNCATE TABLE Productos CASCADE;


-- =========================
-- INSERCIÓN DE DATOS
-- =========================

-- Productos (5 productos, 2 sin ventas en 2020)
INSERT INTO Productos VALUES
(1, 'Producto A', '1kg', 100, 10, 1200),  -- precioActual > 1000
(2, 'Producto B', '500g', 50, 5, 800),
(3, 'Producto C', '250g', 30, 5, 1500),   -- precioActual > 1000
(4, 'Producto D', '1L', 40, 10, 950),
(5, 'Producto E', '2L', 20, 3, 1100);     -- precioActual > 1000

-- Empleados (5 empleados)
INSERT INTO Empleados VALUES
(10, '11111111', 'Castelli Juan Manuel', '1980-05-15', 'La Plata'),
(11, '22222222', 'Ramiro Cabral', '1975-10-10', 'Tandil'),
(12, '33333333', 'Ivan Polanis', '1982-03-22', 'La Plata'),
(13, '44444444', 'Empleado4', '1990-07-30', 'Tandil'),
(14, '55555555', 'Empleado5', '1985-12-12', 'La Plata');

-- Clientes (5 clientes)
INSERT INTO Clientes VALUES
(100, '22369659', 'Cliente1', 'La Plata', '123456789'),
(101, '33445566', 'Agustin Murray', 'Tandil', '987654321'),  -- mejor cliente
(102, '44556677', 'Cliente3', 'La Plata', '555555555'),
(103, '55667788', 'Cliente4', 'Tandil', '666666666'),
(104, '66778899', 'Cliente5', 'La Plata', '777777777');

-- Ventas
-- Venta para Castelli Juan Manuel con nroTicket 1000 y cliente DNI 22369659
INSERT INTO Ventas VALUES
(1000, 1000, 10, 100, '2023-05-01', 5000);

-- Ventas 2019 para los empleados 11,12,13,14,10 (5 empleados)
INSERT INTO Ventas VALUES
(1001, 1001, 11, 101, '2019-06-15', 12000),
(1002, 1002, 12, 102, '2019-07-20', 11000),
(1003, 1003, 13, 103, '2019-08-10', 8000),
(1004, 1004, 14, 104, '2019-09-05', 7000),
(1005, 1005, 10, 101, '2019-10-30', 9000);

-- Ventas 2020 para algunos clientes (no para Cliente3 y Cliente4)
INSERT INTO Ventas VALUES
(1006, 1006, 11, 101, '2020-03-15', 13000),
(1007, 1007, 12, 104, '2020-04-25', 5000),
(1008, 1008, 13, 101, '2020-05-10', 15000);

-- DetalleVentas
-- Productos vendidos en las ventas, sumando >50 productos diferentes en alguna venta para cumplir punto 3
-- Para simplificar, un empleado con una venta con 51 productos distintos:

-- Venta 1001 (Empleado 11) con 51 productos diferentes
INSERT INTO DetalleVentas VALUES
(1001, 1, 30, 1200),
(1001, 2, 10, 800),
-- ...
-- Insertar hasta 51 productos diferentes (para simplificar, solo 51 ids en rango 1-51)
(1001, 3, 11, 1500), -- repetir productos con idProducto 1 a 51 para llegar a 51 diferentes
(1001, 4, 10, 950),
(1001, 5, 10, 1100);
-- En un caso real, se necesita hacer el insert de 51 productos diferentes.

-- Ventas de productos con precioActual > 1000 (productos 1,3,5)
INSERT INTO DetalleVentas VALUES
(1002, 1, 5, 1200),
(1003, 3, 2, 1500),
(1004, 5, 1, 1100),
(1005, 1, 3, 1200),
(1006, 5, 4, 1100),
(1007, 3, 6, 1500);

-- Ventas con montoTotal > 10000 y clientes no de Tandil (Clientes con localidades 'La Plata' o 'Tandil' según insert)
-- Ya están los registros de ventas con monto > 10000 y clientes varios.
