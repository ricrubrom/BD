# Ejercicio 1

- **_Vuelo_** = (<u>codVuelo</u>, fecha, hora, cod_ciudad_origen, cod_ciudad_destino, cantidad_pasajes, codAerolinea)
- **_Pasaje_** = (<u>codReserva</u>, asiento, codVuelo, codCliente, precio)
- **_Aerolinea_** = (<u>codAerolinea</u>, nombre, origen)
- **_Cliente_** = (<u>codCliente</u>, nombre, apellido, pasaporte, nacionalidad)
- **_Ciudad_** = (<u>codCiudad</u>, nombre, pais) // país string con el nombre del país correspondiente

## Inciso 1

**Listar datos personales de clientes que solo hayan viajado durante 2018.**

$$
  C_1\Leftarrow\pi_{(codCliente)}~~(\sigma_{(1/1/2018<=fecha~~\land~~fecha<=31/12/2018)}~~((Vuelo \bowtie Pasaje)))\\

  C_2\Leftarrow\pi_{(codCliente)}~~(\sigma_{(1/1/2018>=fecha~~\land~~fecha>=31/12/2018)}~~((Vuelo \bowtie Pasaje)))\\

  C\Leftarrow C_1 - C_2\\

  \pi_{(nombre,~apellido,~pasaporte,~nacionalidad)}(C \bowtie Cliente)
$$

## Inciso 2

**Borrar el vuelo con código de vuelo LOM3524.**

$$
  Vuelo\Leftarrow Vuelo-\sigma_{(codVuelo="LOM3524")}(Vuelo)
$$

## Inciso 3

**Listar datos personales de cliente que realizaron viajes con destino ‘Cancun’ durante 2018, pero no volaron durante 2019**

$$
    C_1\Leftarrow\pi_{(codCliente)}~~(\sigma_{(1/1/2018<=fecha~~\land~~fecha<=31/12/2018~~\land ~~ nombre="Cancun")}~~((Vuelo \bowtie Pasaje)\bowtie_{\text{(cod\_ciudad\_destino=codCiudad)}}Ciudad))\\

    C_2\Leftarrow\pi_{(codCliente)}~~(\sigma_{(1/1/2019<=fecha~~\land~~fecha<=31/12/2019)}~~((Vuelo \bowtie Pasaje)))\\

    C\Leftarrow C_1 - C_2\\

    \pi_{(nombre,~apellido,~pasaporte,~nacionalidad)}(C \bowtie Cliente)
$$

## Inciso 4

**Reportar información de vuelos con destino ‘Buenos Aires’ o que tengan pasajeros con nacionalidad ucraniana.**

$$
  C_1\Leftarrow \pi_{(codVuelo)}(\sigma_{(nacionalidad="Ucraniana")}(Cliente \bowtie Pasaje))\\
  C_2\Leftarrow \pi_{(codVuelo)}(\sigma_{(nombre="Buenos Aires")}(Vuelo\bowtie_{\text{(cod\_ciudad\_destino=codCiudad)}}Ciudad))\\
  \pi_{\text{(fecha, hora, cod\_ciudad\_origen, cod\_ciudad\_destino, cantidad\_pasajes, codAerolinea)}}((C_1\cup C_2)\bowtie Vuelo)
$$

## Inciso 5

**Listar datos personales de clientes que volaron con destino ‘Salta’ y también realizaron vuelos con destino ‘Jujuy’.**

$$
  C_1\Leftarrow \pi_{(codCliente)}(\sigma_{(nombre="Salta")}((Vuelo\bowtie Pasaje)\bowtie_{(cod\_ciudad\_destino=codCiudad)}Ciudad))\\

  C_2\Leftarrow \pi_{(codCliente)}(\sigma_{(nombre="Jujuy")}((Vuelo\bowtie Pasaje)\bowtie_{(cod\_ciudad\_destino=codCiudad)}Ciudad))\\

  C\Leftarrow C_1 \cap C_2 \\

  \pi_{\text{(nombre, apellido, pasaporte, nacionalidad)}}(C\bowtie Cliente)
$$

## Inciso 6

**Listar información de aerolíneas que solo tengan vuelos con destino ‘Argentina’. Informar nombre y origen.**

$$
  C_1\Leftarrow \pi_{(codAerolinea)}(\sigma_{(pais="Argentina")}((Vuelo\bowtie Pasaje)\bowtie_{(cod\_ciudad\_destino=codCiudad)}Ciudad))\\

  C_2\Leftarrow \pi_{(codAerolinea)}(\sigma_{(pais\ne"Argentina")}((Vuelo\bowtie Pasaje)\bowtie_{(cod\_ciudad\_destino=codCiudad)}Ciudad))\\

  C\Leftarrow C_1 - C_2 \\

  \pi_{\text{(nombre, origen)}}(C\bowtie Aerolinea)
$$

## Inciso 7

**Listar datos personales de clientes que viajaron con todas las aerolíneas.**

$$
  T\Leftarrow \pi_{\text{(codCliente, codAerolinea)}}(Pasaje\bowtie Vuelo)\\
  A\Leftarrow \pi_{(codAerolinea)}(Aerolinea)\\
  C\Leftarrow \pi_{(codCliente)}(Cliente)\\
  C_A\Leftarrow C\times A\\
  Diff\Leftarrow C_A-T\\
  Res\Leftarrow \pi_{(codCliente)}(C-\pi_{(codCliente)}(Diff))\\
  \pi_{\text{(nombre, apellido, pasaporte, nacionalidad)}}(Res\bowtie Cliente)
$$

## Inciso 8

**Lista la fecha, ciudad origen, ciudad destino, aerolínea y precio de los viajes del cliente con código 12345.**

$$
  C_1 \Leftarrow \pi_{(codVuelo,~precio)}(\sigma_{(codCliente=12345)}(Pasaje \bowtie Cliente))\\
  C_2 \Leftarrow C_1 \bowtie Vuelo\\
  C_3 \Leftarrow C_2 \bowtie_{(codAerolinea=codAerolinea)} Aerolinea\\
  C_4 \Leftarrow \rho_{(codCiudadOrigen,~nombreOrigen,~paisOrigen)}(Ciudad)\\
  C_5 \Leftarrow \rho_{(codCiudadDestino,~nombreDestino,~paisDestino)}(Ciudad)\\
  C_6 \Leftarrow C_3 \bowtie_{(cod\_ciudad\_origen=codCiudadOrigen)}  C_4\\
  C_7 \Leftarrow C_6 \bowtie_{(cod\_ciudad\_destino=codCiudadDestino)}  C_5\\
\pi_{(fecha,~nombreOrigen,~nombreDestino,~Aerolinea.nombre,~precio)}(C_7)
$$

## Inciso 9

**Listar las ciudades que no son destino de ningún vuelo.**

$$
  C_1\Leftarrow \pi_{(codCiudad)}(Ciudad)\\
  C_2\Leftarrow \pi_{(cod\_ciudad\_destino)}(Vuelo)\\
  Diff\Leftarrow C_1-C_2\\
  \pi_{(nombre)}(Ciudad \bowtie Diff)
$$
