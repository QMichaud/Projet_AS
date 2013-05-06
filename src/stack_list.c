#include "projet.h"
#include <stdio.h>
#include <stdlib.h>

typedef struct node_t{
	struct node_t* next;
	void *object;
}*node;

struct stack_t
{
	node head;
};


typedef struct stack_t *stack;

stack stack_create(void)
{
	stack s = malloc(sizeof(*s));
	s -> head = NULL;
	return s;
}

void stack_push(stack s, void *object);
{ 
	node nod = malloc(sizeof(*nod));	
	nod -> next = s -> head;
	s -> head = nod;
}

int stack_empty(stack s)
{
	return s -> head == NULL;
}

void * stack_top(stack s)
{
		return s -> head -> object;
}

void stack_pop(stack s)
{
		node tmp = s -> head;
		s -> head = s -> head -> next;
		free(tmp);
}
