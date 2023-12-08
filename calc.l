%{
#include "calc.tab.h"
#include <math.h>
%}

%%
[0-9]+                  { yylval = atoi(yytext); return NUM; }
[-+*%^=/\(\)|\n]            { return *yytext; }
"sqrt"					{return RAIZ;}
"<<"					{return LEFT_SHIFT;}
">>"					{return RIGHT_SHIFT;}
[ \t]                   ; /* ignore whitespace */
.                       {}

%%

int yywrap() {
    return 1;
}
