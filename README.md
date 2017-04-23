# Creación de una imagen NGINX como load_balancer

1. Lo primero que habrá que hacer será bajar los archivos 'defaults' y 'Dockerfile'

2. Habrá que ejecutar el siguiente comando para crear la imagen:


      docker build -t mis_imagenes/nginx:latest .

3. Por último, sólo quedará probar su funcionamiento:


    docker run -d --name nginx -h nginx mis_imagenes/nginx:latest
