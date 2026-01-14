NAME = inception

all: up

up:
	@mkdir -p /home/$(USER)/data/wordpress
	@mkdir -p /home/$(USER)/data/mariadb
	@if [ ! -f secrets/db_root_password.txt ] || [ ! -f secrets/db_password.txt ] || \
	    [ ! -f secrets/wp_admin_password.txt ] || [ ! -f secrets/wp_user_password.txt ]; then \
		echo "Error: Secret files missing. Copy .example files and edit them:"; \
		echo "  cp secrets/*.example secrets/ (remove .example extension)"; \
		exit 1; \
	fi
	@docker-compose -f srcs/docker-compose.yml up -d

build:
	@mkdir -p /home/$(USER)/data/wordpress
	@mkdir -p /home/$(USER)/data/mariadb
	@docker-compose -f srcs/docker-compose.yml build

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

.PHONY: all up build down stop start status clean fclean re logs
