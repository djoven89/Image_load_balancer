FROM library/debian:jessie

LABEL mainteiner 'djoven89' 

RUN \
       apt-get update && \
       apt-get install nginx -y --no-install-recommends && \
       apt-get clean -y && \
       apt-get autoclean -y && \
       rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

COPY config.sh /usr/local/bin/

COPY default /etc/nginx/sites-available/default

RUN \
       ln -sf /dev/stdout /var/log/nginx/access.log && \
       ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80

ENTRYPOINT ["config.sh"]
