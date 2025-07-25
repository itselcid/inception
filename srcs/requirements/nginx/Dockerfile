FROM alpine:3.19


RUN apk update && apk add --no-cache nginx openssl curl


RUN mkdir -p /etc/nginx/ssl


RUN openssl req -x509 -days 365 -newkey rsa:2048 -nodes \
    -out /etc/nginx/ssl/nginx.crt \
    -keyout /etc/nginx/ssl/nginx.key \
    -subj "/C=MA/L=BG/O=1337/CN=oessaadi.42.fr"


COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]