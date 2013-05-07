#include "projet.h"
#include <stdio.h>
#include <stdlib.h>

liste create_liste(void) 
{
    liste l = malloc(sizeof(*l));
    l->head = NULL;
    l->current = NULL;
    return l;
}

void add_obj(void *object, liste l){
    l->current->next = malloc(sizeof(node));
    l->current->next->obj = object;
    l->current->next->next = NULL;
    l->current = l->current->next;
}

void find_var(liste l, char *nom)
{
    
    char *n = (struct var)(l->head->obj).nom;
}
    
    
