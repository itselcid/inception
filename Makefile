
all: up

setup-dirs:
	@mkdir -p /home/$(USER)/data/wordpress
	@mkdir -p /home/$(USER)/data/mariadb

build: setup-dirs
	@docker compose -f srcs/docker-compose.yml build

up: build
	@docker compose -f srcs/docker-compose.yml up -d

down:
	@docker compose -f srcs/docker-compose.yml down

restart: down up


clean: down
	@docker compose -f srcs/docker-compose.yml down -v --rmi all
	@docker rmi -f $$(docker images -q) 


fclean: clean
	@sudo rm -rf /home/$(USER)/data

re: fclean all