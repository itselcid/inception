FROM debian:bullseye

RUN apt-get update && apt-get install -y \
	curl \
	php \
	php-cli \
	php-mysql \
	&& rm -rf /var/lib/apt/lists/*


RUN curl  -L https://github.com/vrana/adminer/releases/download/v5.4.1/adminer-5.4.1.php -o index.php 

CMD ["php", "-S", "0.0.0.0:8081"]