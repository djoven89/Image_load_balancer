# Creación de una imagen NGINX como load_balancer

La imagen tendrá una configuración predefinida para que nginx actué como balanceador de carga. Además, también ejecutará el script **'docker-entrypoint.sh'** que modificará el archivo de configuración de Nginx para añadir las direcciones IP de los servidores WEB que se le pasen como argumentos al **docker run ...** .

**1. Lo primero que habrá que hacer será bajar los archivos 'Dockerfile', 'defaults' y docker-entrypoint.sh**

**2. Habrá que ejecutar el siguiente comando para crear la imagen:**

      docker build -t mis_imagenes/loadbalancer:v1 .

**3. Por último, sólo quedará probar su funcionamiento:**

      docker run -d --name nginx -h nginx -e WEB1=172.20.0.51 -e WEB2=172.20.0.62 -e WEB2=172.20.0.63 mis_imagenes/loadbalancer:v1

### Comentarios

1. Por defecto, el rango de red es '172.17.0.0'.
2. Hay configurados 5 servidores web aunque sólo el '172.17.0.20' está activo, el resto, están comentados.
