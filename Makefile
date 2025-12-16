NAME = inception

all: up

up:
	@mkdir -p /home/$(USER)/data/wordpress
	@mkdir -p /home/$(USER)/data/mariadb
	@docker-compose -f srcs/docker-compose.yml up -d --build

down:
	@docker-compose -f srcs/docker-compose.yml down

stop:
	@docker-compose -f srcs/docker-compose.yml stop

start:
	@docker-compose -f srcs/docker-compose.yml start

status:
	@docker-compose -f srcs/docker-compose.yml ps

clean: down
	@docker system prune -af
	@docker volume rm -f srcs_mariadb srcs_wordpress 2>/dev/null || true

fclean: clean
	@sudo rm -rf /home/$(USER)/data/wordpress
	@sudo rm -rf /home/$(USER)/data/mariadb
	@docker volume prune -f

re: fclean all

logs:
	@docker-compose -f srcs/docker-compose.yml logs -f

.PHONY: all up down stop start status clean fclean re logs
