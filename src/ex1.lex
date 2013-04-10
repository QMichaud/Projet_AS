%{
#include "ex1.tab.h"

char *tab_var[];
%}

FLOAT ([0-9]+(\.[0-9]*)?|\.[0-9]+)

%x VAR
 
%%

[a-zA-Z0-9_]*\= {BEGIN VAR; }

<VAR>.*\; {

\+ return PLUS;
\- return MOINS;
\* return FOIS;
\/ return DIV;

\( return LPAR;
\) return RPAR;
\, return VIRG;

draw return DRAW;
fill return FILL;
cycle return CYCLE;
\-\- return LINETO;

{FLOAT} { yylval.scalaire = atof(yytext); return NUM; }




a = 5
a = 3

(3,3)--(3,2)--cycle
