
Ej3
                                                           
Disfraz (Nombre, descripcion, costo de alquiler, tela, colores)
Ejemplar (codigo, talle, estado(disp, alquilado, etc)) -> Disfraz

Cliente (id cliente, direccion, telefono)
Institucion (Nombre, descripcion)
Persona (DNI, nombre, apellido, email(0,1))

Alquiler (fecha, fecha tentativa devolucion, fecha devolucion(0,1), costo total)-> cliente, disfraz
