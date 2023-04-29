COMMAND = docker-compose -f ./srcs/docker-compose.yml
USER_DIR = /home/gvitor-s
VOLUME_PATH_WORDPRESS = $(USER_DIR)/data/wordpress
VOLUME_PATH_MARIADB = $(USER_DIR)/data/mariadb
override RM = rm -rf

all: | $(USER_DIR)
	sudo $(COMMAND) up --build

$(USER_DIR):
	sudo mkdir -p $(USER_DIR)
	sudo chown -R user42:user42 $(USER_DIR)
	mkdir -p $(VOLUME_PATH_MARIADB)
	mkdir -p $(VOLUME_PATH_WORDPRESS)

clean:
	$(COMMAND) down

fclean:
	$(COMMAND) down --rmi all

re: fclean all

.PHONY: all clean re fclean
