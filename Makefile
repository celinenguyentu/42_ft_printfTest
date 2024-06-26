# -------------------------------- VARIABLES --------------------------------- #

EXEC			=	output

CC				=	cc
RM				=	rm
RMFLAGS			=	-rf

PRINTF_H_DIR	=	../includes/
PRINTF_PATH		=	..
PRINTF			=	$(PRINTF_PATH)/libftprintf.a

MSRCS_FILES 	=	mandatory_tests.c
BSRCS_FILES		= 	bonus_tests.c
CSRCS_FILES		=	custom_tests.c
MOBJS			=	${MSRCS_FILES:.c=.o}
BOBJS			=	${BSRCS_FILES:.c=.o}
COBJS			=	${CSRCS_FILES:.c=.o}

#MSRCS_FILES		=	$(addsuffix .c, $(MSRCS))
#BSRCS_FILES		=	$(addsuffix .c, $(BSRCS))
#CSRCS_FILES		=	$(addsuffix .c, $(CSRCS))
#MOBJS			=	$(addsuffix .o, $(MSRCS))
#BOBJS			=	$(addsuffix .o, $(BSRCS))
#COBJS			=	$(addsuffix .o, $(CSRCS))

# ---------------------------------- RULES ----------------------------------- #

.c.o: 
				@$(CC) $(CFLAGS) -c -I $(PRINTF_H_DIR) $< -o $@

all:			a

a:				m b

m:				$(MSRCS_FILES) $(MOBJS)
ifneq ("$(wildcard $(PRINTF))","")
	@$(RM) $(RM_FLAGS) $(PRINTF)
endif
				@make -C >/dev/null $(PRINTF_PATH)
				@$(CC) $(MOBJS) -I $(PRINTF_H_DIR) $(PRINTF) -o $(EXEC) -g
				@./$(EXEC)

b:				$(BSRCS_FILES) $(BOBJS)
				@make -C >/dev/null $(PRINTF_PATH) bonus
				@$(CC) $(BOBJS) -I $(PRINTF_H_DIR) $(PRINTF) -o $(EXEC) -g
				@./$(EXEC)

custom:			$(CSRCS_FILES) $(COBJS)
				@make -C >/dev/null $(PRINTF_PATH) bonus
				@$(CC) $(COBJS) -I $(PRINTF_H_DIR) $(PRINTF) -o $(EXEC) -g
				@./$(EXEC)

clean:
				@make -C >/dev/null $(PRINTF_PATH) clean
				@$(RM) $(RMFLAGS) $(MOBJS) $(BOBJS) $(COBJS)

fclean:			clean
				@make -C >/dev/null $(PRINTF_PATH) fclean
				@$(RM) $(RMFLAGS) $(EXEC)

re:				fclean all

.PHONY:			all a m b custom clean fclean re
