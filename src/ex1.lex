%{
#include "ex1.tab.h"
%}

FLOAT ([0-9]+(\.[0-9]*)?|\.[0-9]+)
aaa
%%
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


