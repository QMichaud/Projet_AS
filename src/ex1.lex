%{
#include "ex1.tab.h"

%}

FLOAT ([0-9]+(\.[0-9]*)?|\.[0-9]+)
 
%%

\+ return PLUS;
\- return MOINS;
\* return FOIS;
\/ return DIV;
&& return AND;
\|\| return OR;

\( return LPAR;
\) return RPAR;
\{ return LACC;
\} return RACC;
\< return INF;
\> return SUP;
= { printf("eq\n"); return EQ; }
\! return NOT;
"if" return IF;
"else" return ELSE;
"for" return FOR;
\, return VIRG;
\; return POINTVIRG;
\: return DPTS;
image return IMG;
translation return TRANS;
rotation return ROT;
 
draw return DRAW;
fill return FILL;
cycle return CYCLE;
\-\- return LINETO;

{FLOAT} { yylval.scalaire = atof(yytext); return NUM; }

[a-zA-Z_]+ { yylval.variable = yytext; return VAR; }

<<EOF>> {return EXIT_SUCCESS;}
