NAME		= cub3D
INC			= ./inc/
LIBFT		= libft/libft.a

RESET		= \033[0m
GREEN		= \033[32m
YELLOW		= \033[33m
BLUE		= \033[34m
RED			= \033[31m

ifeq ($(shell uname -s), Linux)
	MLX = minilibx_linux
	MLX_FLAGS = $(MLX)/libmlx_Linux.a -lXext -lX11 -lm -lz
else
	MLX = minilibx_macos
	MLX_FLAGS = -framework OpenGL -framework AppKit $(MLX)/libmlx.a
endif

SRCS		= $(shell find src -type f -name "*.c")
OBJS		= $(SRCS:src/%.c=src/bin/%.o)
BIN			= ./src/bin
LIB			= $(MLX)/libmlx.a

CC			= gcc
RM			= rm -rf
CFLAGS		= #-Wall -Wextra -Werror

all: $(NAME)

$(BIN):
	mkdir -p $(BIN)

$(LIBFT):
	make -C libft/

$(NAME): $(BIN) $(LIBFT) $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) $(LIBFT) $(MLX_FLAGS) -o $(NAME)

$(BIN)/%.o: src/%.c
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@ -I$(INC)

clean:
	$(RM) $(BIN)
	make clean -C libft/

fclean: clean
	$(RM) $(NAME)
	make fclean -C libft/

re: fclean all

norm:
	norminette *.[ch]

.PHONY: all clean fclean re norm
