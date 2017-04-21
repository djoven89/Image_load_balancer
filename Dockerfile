FROM library/debian:jessie
LABEL mainteiner 'djoven89' 

## Instalando los paquetes:
RUN apt-get update && apt-get install nginx vim -y && apt-get autoremove -y && apt-get autoclean -y \
      && sed -i 's/# server/server/' /etc/nginx/nginx.conf

COPY default /etc/nginx/sites-available/default
