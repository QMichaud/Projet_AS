#include <stdio.h>
#include <stdlib.h>

typedef struct node_t *node;

struct node_t{
    void *obj;
    node *next;
};

typedef struct liste_t *liste;

struct liste_t{
    node *head;
    node *current;
};


struct var {
    char *nom;
    union {
	float val;
	liste *chemin;
    }u;
};

typedef struct point_t *point;

struct point_t{
    float x;
    float y;
};


extern liste create_liste(void);
extern void add_obj(void *object, liste l);
extern void find_var(liste l, char *nom);
extern int type_var(void *object); // return 0 val, 1 chemin
extern point *pop_liste_chemin(liste *l); //
extern int is_empty(liste l); // 0 true, 1 false

struct stack;

typedef struct stack *stack;

/* create an empty stack */
extern stack stack_create(void);

/* push an object on a stack */
extern void stack_push(stack s, void *object);

/* return true if and only if the stack is empty */
extern int stack_empty(stack s);

/* return the top element of the stack.
   The stack must not be empty (as reported by stack_empty()) */
extern void * stack_top(stack s);

/* pop an element off of the stack.
   The stack must not be empty (as reported by stack_empty()) */
extern void stack_pop(stack s);
