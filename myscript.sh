#!/bin/bash

# cliente que hacer get de una pagina publica usando conexion bidireccional sobre tcp
exec 3<>/dev/tcp/es.wikipedia.org/80
echo -e "GET / HTTP/1.1\n\n" >&3
cat <&3

# comando para generar un echo server usando netcat-openbsd
ncat -l 8080 --keep-open --exec "/bin/cat"

# comando para hacer un cliente en otra consola (alternativa 1)
nc localhost 8080

# scripts para hacer un cliente del echo server (alternativa 2)

# establecer conexion con el puerto de mi maquina local
exec 3<>/dev/tcp/localhost/8080

# para enviar un mensaje al servidor
echo -e "mensje" >&3


