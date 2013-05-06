#include "projet.h"
#include <stdio.h>
#include <stdlib.h>

struct node_t{
    void *obj;
    struct node_t *next;
}*node;

struct liste_t{
    node *head;
    node *current;
}*liste;


