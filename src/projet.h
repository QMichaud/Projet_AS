#include <stdio.h>
#include <stdlib.h>

struct point_t{
    float x;
    float y;
}*point;

typedef struct node_point_t node_point;

struct node_point_t{
    node_point next;
    point point;
};
typedef struct commande_t commande;

struct commande_t{
    
    node_point chemin;
typedef struct node_t *node;

struct node_t{
    char *nom_var;
    node next;
    union{
	float valeur;
	node_point chemin;
	liste_commande image;
    }contenu;
};

typedef struct liste_t * liste;

struct liste_t{
    node head;
    node current;
};


float find_val(char *nom, liste l);
liste find_chemin(char *nom, liste l);
liste *find_image(char *nom, liste l);
liste creer_liste();
void insert_val(char *nom, float val);
void insert_chemin(char *nom, liste chemin);
void insert_image(char *nom, liste *image);
void destroy_liste(liste l);
