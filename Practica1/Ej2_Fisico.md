
# Modelo Físico

**Libro**(<u>isbn</u>, titulo, genero, editorial, anio_edicion, prologo, agradecimientos, precio_venta, precio_prestamo, stock_venta, stock_prestamo)

**Autor**(<u>num_pasaporte</u>, nombre_completo, nacionalidad)

**Autoria**(<u>isbn(fk), num_pasaporte_autor(fk)</u>)

**Copia**(<u>numero, isbn(fk)</u>)

**Copia_Prestamo**(<u>(numero, isbn)(fk)</u>, estado)

**Copia_Venta**(<u>(numero, isbn)(fk)</u>)

**Cliente**(<u>id_cliente</u>, dni, nombre, telefono, calle, numero, piso, dpto)

**Prestamo**(<u>id_cliente(fk), comienzo</u>, fecha_prob, fecha_devol)

**Venta**(<u>ticket</u>, fecha, hora)

**Copia_Vendida**(<u>ticket(fk), (numero, isbn)(fk)</u>)

**Copia_Prestada**(<u>(id_cliente, comienzo)(fk), (numero, isbn)(fk)</u>)

