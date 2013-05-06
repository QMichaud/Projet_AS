%{
#include "ex1.tab.h"

char *tab_var[];
char var[256];
%}

FLOAT ([0-9]+(\.[0-9]*)?|\.[0-9]+)

%x VAR
 
%%

[a-zA-Z0-9_]*\= {int i = 0; while(yytext[i] != '=') { var[i] = yytext[i]; i++;} yylval = var; return VAR; }

\+ return PLUS;
\- return MOINS;
\* return FOIS;
\/ return DIV;
&& return AND;
|| return OR;

\( return LPAR;
\) return RPAR;
\{ return LACC;
\} return RACC;
\< return INF;
\> return SUP;
\= return EQ;
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

