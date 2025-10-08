FROM debian:bullseye
RUN apt-get update && apt-get install -y nginx

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./tools/ /var/www/html


CMD [ "nginx", "-g" ,"daemon off;" ]