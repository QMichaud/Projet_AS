%{
#include <stdio.h>
#include <cairo/cairo.h>
#include <cairo/cairo-pdf.h>

int yylex(void);

cairo_surface_t *surface;
cairo_t *cr;
%}

%union{
    float scalaire;
    struct coord *point;
}

%right PLUS MOINS
%left FOIS DIV
%left AND OR
%token LPAR RPAR LACC RACC
%token INF SUP EQ NOT
%token IF ELSE FOR
%token VIRG POINTVIRG DPTS
%token LINETO
%token VAR IMG
%token DRAW FILL
%token TRANS ROT
%token CYCLE

%token <scalaire> NUM

%type <scalaire> expr expr_evdt
%type <point> point
%%

liste_commandes:
/*empty*/ {}
|liste_commandes commande POINTVIRG {}
;

commande:
| dessin {}
| declaration {}
| condition {}
| loop {}

dessin:
DRAW chemin {}
| DRAW image {}
| DRAW rotation {}
| DRAW translation {}
| FILL chemin {}
;

condition:
IF LPAR cond RPAR LACC liste_commandes RACC sinon {}
;

sinon:
/*empty*/ {}
| ELSE condition {}
| ELSE LACC liste_commandes RACC {}
;

cond:
cond OR cond {}
|LPAR cond OR cond RPAR {}
|cond AND cond {}
|LPAR cond AND cond RPAR {}
|NOT LPAR cond RPAR {}
|expr NOT EQ expr {}
|expr EQ EQ expr {}
|expr INF expr {}
|expr INF EQ expr {}
|expr SUP expr {}
|expr SUP EQ expr {}
;

loop:
FOR LPAR param1 POINTVIRG param2 POINTVIRG param3 RPAR LACC liste_commandes RACC {}
;

param1:
/* empty */ {}
|declaration {}
;

param2:
/* empty */ {}
|cond {}
;

param3:
/* empty */ {}
|expr {}
|VAR EQ expr {}
;


chemin_evdt:
chemin LINETO noeud {}
//| VAR LINETO noeud {}
| point {}
;

chemin:
chemin_evdt {}
| VAR {}
;

noeud:
point {}
| CYCLE {}
| PLUS point {}
| VAR {}
;

point:
LPAR expr VIRG expr RPAR {}
|LPAR expr DPTS expr RPAR {}
;

expr:
expr_evdt {}
| VAR {}
;

expr_evdt:
expr PLUS expr { $$ = $1 + $3; }
|expr MOINS expr { $$ = $1 - $3; }
|expr FOIS expr { $$ = $1 * $3; }
|expr DIV expr { $$ = $1 / $3; }
|LPAR expr RPAR { $$ = $2;}
|expr PLUS PLUS { $$ = $1 + 1; }
|expr MOINS MOINS { $$ = $1 - 1; }
|NUM { $$=$1; }
;

declaration:
 VAR EQ VAR {}
| VAR EQ chemin_evdt {}
| VAR EQ expr_evdt {}
| VAR EQ image {}
| VAR EQ translation {}
| VAR EQ rotation {}
;

rotation:
ROT LPAR chemin VIRG point VIRG NUM RPAR {}
|ROT LPAR image VIRG point VIRG NUM RPAR {}
;

translation:
TRANS LPAR chemin VIRG point RPAR {}
|TRANS LPAR image VIRG point RPAR {}
;

image:
IMG LACC liste_commandes RACC {}
;

%%
yyerror(char *message)
{
    printf("%s\n Erreur : ", message);
}

int main(int argc, char *argv[])
{
	yyparse();

	return(0);
}

