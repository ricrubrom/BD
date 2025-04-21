# Modelo Físico

**Persona**(<u>DNI</u>, nombre, apellido, fecha_nacimiento, estado_civil, direccion)

**Telefono**(<u>numero, DNI(fk)</u>)

**Socio**(<u>id, DNI(fk)</u>, fecha_alta)

**Asistente**(<u>DNI</u>, fecha_ult_acceso)

**Vinculo**(<u>id_socio(fk)</u>, DNI_asistente(fk)) //Por ser el id_socio autoincremental

**Actividad**(<u>nombre</u>, descripcion, fecha_inicio, fecha_fin)

**Inscripcion**(<u>id_socio(fk), nombre_actividad(fk)</u>)

**Casillero**(<u>cod</u>, ubicacion, tamanio)

**Casillero_Jockey**(<u>cod(fk)</u>, division)

**Jugador**(<u>DNI</u>, fecha_nacimiento, direccion, pos_habitual, division, desc_enferm)

**Jugador_Casillero**(<u>cod(fk), DNI(fk)</u>, fecha_inicio, fecha_fin)