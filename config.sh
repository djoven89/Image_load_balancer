#!/bin/bash -x

NGINXCONF="/etc/nginx/sites-available/default"

# Compruebo existe el archivo de configuración de Nginx
if [ ! -f $NGINXCONF ]
  then
     echo 'No se ha creado el fichero todavía...' >> /dev/stderr
     exit 1
fi

# Variable para quedarse con las variables de entorno en orden
X=1

# Variable para filtrar por la IP por defecto del fichero de configuración
Y=0

# Guardo en un fichero temporal el número de servidores web
env | grep WEB > /tmp/ips

# Me quedo con el número de servidores WEB
NUMSRV=`cat /tmp/ips | wc -l`

if [ $NUMSRV > 0 ]
  then
     for (( i=1; i<=$NUMSRV; i++ ))
	do			
	   # Guarda la IP del servidor web 
	   IPSRV=$(cat /tmp/ips | cut -d "=" -f2 | head -`echo $X` | tail -1)
					
	   # Compruebo de que exista la dirección IP por defecto del archivo de configuración
	   # en caso de coincidir, la modifico por el servidor que toque y descomento la línea
	   if [ `grep -o 172.17.0.2$Y $NGINXCONF` ]
	     then
		  grep -o 172.17.0.2$Y $NGINXCONF | xargs -I {} sed -i "s/{}/$IPSRV/; s/^#server $IPSRV/  server $IPSRV/" $NGINXCONF
		  (( Y++ ))
	   fi
	  (( X++ ))
	done
  else
     echo 'No se han especificado servidores web.' >> /dev/stderr
fi

/usr/sbin/nginx -g 'daemon off;' &
LBID=$!

wait $LBID
