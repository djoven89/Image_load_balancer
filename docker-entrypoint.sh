#!/bin/bash
set -eo pipefail
shopt -s nullglob

ARCHIVO="/etc/nginx/sites-available/default"

# Compruebo existe el archivo de configuración de Nginx
if [ ! -f $ARCHIVO ]
  then
    echo 'No se ha creado el fichero todavía...' > /error.txt 
    exit 1
fi

# Variable para quedarse con las variables de entorno en orden
X=0

# Variable para filtrar por la IP por defecto del fichero de configuración
Y=0

# Guardo en un fichero temporal el número de servidores web
env | grep -i web > /tmp/ip.txt

# Me quedo con el número de servidores WEB
NUMSRV=`env | grep -i web | wc -l`

# Comprobando si se han añadido servidores
if [ $NUMSRV = 0 ]
  then
    echo 'No se han añadido servidores' > /error.txt
    exit 1
fi

for (( i=1; i<=$NUMSRV; i++ ))
   do
      # Cuenta atrás para quedarse con el servidor correcto
      X=`expr $X + 1`
      
      # Guarda la IP del servidor web 
      IPLOAD=$(cat /tmp/ip.txt | cut -d "=" -f2 | head -`echo $X` | tail -1)
      
      # Compruebo de que exista la dirección IP por defecto del archivo de configuración
      # en caso de coincidir, la modifico por el servidor que toque y descomento la línea
  		if [ `grep -o 172.17.0.2$Y $ARCHIVO` ]
    		then
      		grep -o 172.17.0.2$Y $ARCHIVO | xargs -I {} sed -i "s/{}/$IPLOAD/" $ARCHIVO
					sed -i "s/#  server $IPLOAD/server $IPLOAD/" $ARCHIVO
      		Y=`expr $Y + 1`
  		fi
	done

exec "$@"
