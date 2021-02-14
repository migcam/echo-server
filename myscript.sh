#!/bin/bash

# Leer un pagina web publica
# cliente que hacer get de una pagina publica usando conexion bidireccional sobre tcp
exec 3<>/dev/tcp/es.wikipedia.org/80
echo -e "GET / HTTP/1.1\n\n" >&3
cat <&3



# Hacer un eco server

# ========================================================================================================================

# alternativa 1 servidor = ncat, cliente=nc

# comando para generar un echo server usando netcat-openbsd
ncat -l 8080 --keep-open --exec "/bin/cat"

# comando para hacer un cliente en otra consola (alternativa 1, funciona perfecto)
nc localhost 8080

#========================================================================================================================

# alternativa 2 servidor=nc, cliente=[exec, echo, read], es vidireccional pero no es un echo server por definicion

# commando para hacer server 
nc -l 8080

# establece conexion con el puerto de mi maquina local
exec 3<>/dev/tcp/localhost/8080

# envia un mensaje al servidor
echo -e "mensaje" >&3

# lee mensajes del puerto
while read LINE <&3
do
    echo $LINE >&1
done