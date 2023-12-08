%{
#include <stdio.h>
#include <math.h>
#include <stdlib.h>
extern FILE *yyin;
int yylex();
extern char *yytext;
void yyerror(const char *s);
int result;
%}

%token NUM
%token LEFT_SHIFT
%token RIGHT_SHIFT
%token RAIZ
%token ABSOLUTE

%left '+' '-'
%left '*' '/'
%left '%' '^'
%left LEFT_SHIFT RIGHT_SHIFT RAIZ ABSOLUTE

%%

calc:   /* empty */
    | calc expr '=''\n'   {
		printf("%d \n",$2);
	}
    ;

expr:   NUM             { $$ = $1; }
	| '-' expr			{ $$ = -$2; }
	| '(' expr ')'     { $$ = $2; }
	| '|' expr '|'		{ $$ = abs($2);}
    | expr '+' expr    { $$ = $1 + $3;}
    | expr '-' expr    { $$ = $1 - $3; }
    | expr '*' expr    { $$ = $1 * $3; }
    | expr '/' expr    { 
        if ($3 != 0)
            $$ = $1 / $3; 
        else {
            yyerror("Division by zero");
            $$ = 0;
        }
    }
	| expr '%' expr		{ $$ = $1 % $3; }
	| expr '^' expr	{ $$ = pow($1, $3); }
	| RAIZ expr		{
		if($2 >= 0)
			$$ = sqrt($2);
		else
			yyerror("No se aceptan raizes negativas");
	}
	| expr LEFT_SHIFT expr {$$ = $1 << $3;}
	| expr RIGHT_SHIFT expr {$$ = $1 >> $3;}
    ;

%%


int main() {
	char linea[100];
	FILE *Input;
    Input = fopen("oper.txt", "r");
	while (fgets(linea, sizeof(linea), Input) != NULL) {
		printf("%s",linea);
		yy_scan_string(linea);
		yyparse();
	}
	
	fclose(Input); 
	printf("\n Lectura de Archivo con exito!!!!\n");
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
