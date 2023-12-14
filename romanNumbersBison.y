%{
	#include <stdio.h>
	#include <string.h>
	int yylex();
	int yyerror(char *s);
	int convertNumberRoman(char *roman);
	int numberRoman(char roman);
%}

%token ROMANS OTHER

%type <cad> ROMANS

%union{
	char cad[100];
}

%%

prog:	
	INSTRUCTIONS
;

INSTRUCTIONS:
			| INSTRUCTION INSTRUCTIONS
;

INSTRUCTION: 
		   | ROMANS {printf("%d", convertNumberRoman($1));}
		   | OTHER

;
%%

int yyerror(char *s){
	printf(" ->ErrorSintactico %s\n", s);
}

int convertNumberRoman(char *roman) {
	int decimal = 0;

	for(int i = 0; i < strlen(roman); i++) {
		if(!roman[i+1] || numberRoman(roman[i]) >= numberRoman(roman[i+1])) {
			decimal += numberRoman(roman[i]);
		} else {
			decimal += (numberRoman(roman[i]) * (-1));
		}
	}
	return decimal;
}

int numberRoman(char roman) {
	char caracter = roman;
	int number = 0;
	switch(caracter) {
		case 'I': number = 1; break;
		case 'V': number = 5; break;
		case 'X': number = 10; break;
		case 'L': number = 50; break;
		case 'C': number = 100; break;
		case 'D': number = 500; break;
		case 'M': number = 1000; break;
		default: number = 0; break;
	}
	return number;
}

int main(int argc, char **argv){
	yyparse();
	return 0;
}