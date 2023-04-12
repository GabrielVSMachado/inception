COMMAND = docker-compose -f ./srcs/docker-compose.yml

all:
	$(COMMAND) up

clean:
	$(COMMAND) down

fclean:
	$(COMMAND) down --rmi all -v

re: fclean all

.PHONY: all clean re fclean
