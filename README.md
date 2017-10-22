# Creación de una imagen NGINX como load_balancer

La imagen tendrá una configuración predefinida para que nginx actué como balanceador de carga. Además, también ejecutará el script **'config.sh'** que modificará el archivo de configuración de Nginx para añadir las direcciones IP de los servidores WEB que se le pasen como argumentos al **docker run ...** .

**Para crear la imagen habrá que realizar los siguientes pasos:**

      wget -O /tmp/loadbalancer.zip https://github.com/djoven89/Image_load_balancer/archive/master.zip
      cd /tmp/ && unzip loadbalancer.zip
      cd Image_load_balancer-master && chmod 755 config.sh
      docker build -t mis_img/loadbalancer:latest .
 
**Después ya sólo quedará probar su funcionamiento:**

      docker run -d --name nginx -h nginx -e WEB1=172.17.0.50 -e WEB2=172.17.0.51 -e WEB3=172.17.0.52 mis_img/loadbalancer:latest

### Comentarios

1. Por defecto, el rango de red es '172.17.0.0'.
2. Hay configurados 5 servidores web aunque sólo el '172.17.0.20' está activo, el resto, están comentados.

## Mejoras pendientes
- Añadir una comprobación de las direcciones IP.
