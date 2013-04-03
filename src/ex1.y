%{
#include "cairo.h"
#include <stdio.h>

int yylex(void);

void yyerror(const char *s){
printf("%s\n",s);

struct coord {
     float point1;
     float point2;
}

struct coord first_point;

%}
%union {
    float scalaire;
    struct coord * point;
}
%token PLUS MOINS FOIS DIV
%token <scalaire> NUM
%token LPAR RPAR VIRG LINETO
%token DRAW FILL
%token CYCLE
%type <scalaire> expr
%type <point> point
%%

commande:
DRAW chemin
| FILL chemin
;

chemin:
chemin LINETO noeud
| point
;

noeud:
point {cairo_line_to($1->point1, $1->point2);}
 | CYCLE {cairo_to_line(first_point->point1, first_point->point2;)
 | PLUS point {cairo_to_line(first_point->point1 + $2->point1, first_point->point2 + $2->point2;)
;

point:
 LPAR expr VIRG expr RPAR {
     $$ = (struct point *)malloc(sizeof(struct point));
     $$->point1 = $2;
     $$->point2 = $4;
 }
;

expr:
expr PLUS expr {$$ = $1 + $3;}
 |expr MOINS expr {$$ = $1 - $3;}
 |expr FOIS expr {$$ = $1 * $3;}
 |expr DIV expr {$$ = $1 / $3;}
 |LPAR expr RPAR {$$ = $2;}
 | NUM {$$=$1;}
 ;
%%

yyerror(char *message)
{
    printf("%s\n", message);
}

int main(int argc, char *argv[])
{
    yyparse();
    return(0);
}
