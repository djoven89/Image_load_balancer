FROM library/debian:jessie
LABEL mainteiner 'djoven89' 

RUN apt-get update && apt-get install nginx -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*;

COPY docker-entrypoint.sh /usr/local/bin/

COPY default /etc/nginx/sites-available/default

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
