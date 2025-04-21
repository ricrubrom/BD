
Ej4

Compañia      (Nombre, cuit, direccion completa, telefono, mail, comision)

cliente       (Numero cliente, direccion, telefono)
Fisica        (DNI, apellido, nombre)
Juridica      (CUIT, razon social)

Poliza        (Numero relativo a compañia, monto asegurado, vigencia(desde hasta), franquicia(opt), costo por mes, tipo, Anterior(Opt)) -> tarjeta
Tarjeta       (Numero, Fecha vencimiento, CVS, Banco, Entidad)

Cobertura     (Nombre, descripcion cobertura, descripcion de las clausulas)
Cupon de pago (Monto, fecha de vencimiento) ->(al pagar fecha)
Siniestro     (Poliza, Fecha, texto descriptivo, info contacto terceros(opt))
