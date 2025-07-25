all:
	@echo "Starting Inception..."
	@docker compose -f srcs/docker-compose.yml up -d --build

stop:
	@echo "Stopping containers..."
	@docker compose -f srcs/docker-compose.yml stop

clean: stop
	@echo "Cleaning up..."
	@docker compose -f srcs/docker-compose.yml down -v

fclean: clean
	@echo "Full cleanup..."
	@ docker system prune -af --volumes

re: clean all
