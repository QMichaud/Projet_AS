%{
#include <stdio.h>
#include <cairo/cairo.h>
#include <cairo/cairo-pdf.h>

int yylex(void);
cairo_surface_t *surface;
cairo_t *cr;
struct coord {
     float point1;
     float point2;
};

struct liste *tab_var;

typedef struct liste {
	struct noeud debut;
	struct noeud current;
};

struct noeud {
	union{
		struct coord elem;
		int cycle;
	}point;
	noeud *suivant;
};

struct liste liste_finale = malloc(sizeof(struct liste));

struct coord *first_point;
int first_point_init = 0;

%}

%union{
    float scalaire;
    struct coord * point;
}

%right PLUS MOINS 
%left FOIS DIV
%token <scalaire> NUM
%token LPAR RPAR VIRG LINETO VAR
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
| point { printf("\npoint - cairo_move_to : (%f,%f)\n",$1->point1,$1->point2);cairo_move_to(cr,$1->point1,$1->point2) }
;

noeud:
point { printf("\npoint - cairo_line_to : (%f,%f)\n",$1->point1,$1->point2);  }
| CYCLE { printf("\ncycle - cairo_line_to : (%f,%f)\n",first_point->point1,first_point->point2);cairo_line_to(cr,first_point->point1,first_point->point2) }
| PLUS point { printf("\ncairo_line_to : (%f,%f)\n",first_point->point1 + $2->point1, first_point->point2 + $2->point2);cairo_line_to(cr,first_point->point1 + $2->point1,first_point->point2 + $2->point2) }
| VAR {}
;

point:
 LPAR expr VIRG expr RPAR {

	if(first_point_init == 0)
	{
		first_point = (struct coord *)malloc(sizeof(struct coord));
    	first_point->point1 = $2;
   		first_point->point2 = $4;

		first_point_init = 1;
	}

    $$ = (struct coord *)malloc(sizeof(struct coord));
    $$->point1 = $2;
    $$->point2 = $4;
	printf("\nLe point (x,y) : (%f,%f)\n",$2,$4);
 }
;

expr:
expr PLUS expr {$$ = $1 + $3; }
 |expr MOINS expr {$$ = $1 - $3; }
 |expr FOIS expr {$$ = $1 * $3; }
 |expr DIV expr {$$ = $1 / $3; }
 |LPAR expr RPAR {$$ = $2;}
 |NUM {$$=$1; }
 |VAR {}
 ;

declaration:
VAR EQ chemin[c] {
	if(longueur(c)==1){}
	else{}
}
| VAR EQ expr {}
;


%%

yyerror(char *message)
{
    printf("%s\nazeazez", message);
}

int main(int argc, char *argv[])
{

  
  	//Creation de la surface pdf associee au fichier ex1.pdf
  	cairo_surface_t* pdf_surface = 
    cairo_pdf_surface_create("ex1.pdf",200,200);
	cr=cairo_create(pdf_surface);

    yyparse();


  //Tracer la ligne
  cairo_stroke(cr);
  //Liberation du contexte
  cairo_destroy(cr);
  //Liberation de la surface
  cairo_surface_destroy(pdf_surface);
    return(0);
}

void ajouter_point(struct liste l, void* point) {
	if (!debut) {
		l->debut = malloc(sizeof(struct noeud));
		l->debut->point.elem = (struct coord) point;
		l->current = l->debut;
	} else {
		l->current->suivant = malloc(sizeof(struct noeud));
		if (point == 1) {
			l->current->suivant->point.cycle = 1;
		} else {
			l->current->suivant->point.elem = (struct coord) point;
		}
		l->current = l->current->suivant;
	}
} 
