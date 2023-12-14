%{
	#include <stdio.h>
	int yylex();
	int yyerror(char *s);
%}

%token ROMANS OTHER

%type <cad> ROMANS

%union{
	char cad[20];
}

%%

prog:	INSTRUCTIONS;

INSTRUCTIONS:
			| INSTRUCTION INSTRUCTIONS
;

INSTRUCTION: 
			| ROMANS {printf("(romanos): %s\n", $1);}
			| OTHER

;
%%

int yyerror(char *s){
	printf(" ->ErrorSintactico %s\n", s);
}

int main(int argc, char **argv){
	yyparse();
	return 0;
}