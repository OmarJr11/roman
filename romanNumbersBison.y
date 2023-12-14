%{
	#include <stdio.h>
	#include <string.h>
	int yylex();
	int yyerror(char *s);
%}

%token ROMANS OTHER

%type <cad> ROMANS

%union{
	char cad[20];
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

int numberRoman(char *roman) {
	char caracter = roman;
	int number = 0;
	switch(caracter) {
		case 'i': number = 1; break;
		case 'I': number = 1; break;
		case 'v': number = 5; break;
		case 'V': number = 5; break;
		case 'x': number = 10; break;
		case 'X': number = 10; break;
		case 'l': number = 50; break;
		case 'L': number = 50; break;
		case 'c': number = 100; break;
		case 'C': number = 100; break;
		case 'd': number = 500; break;
		case 'D': number = 500; break;
		case 'm': number = 1000; break;
		case 'M': number = 1000; break;
		default: number = 0; break;
	}
	return number;
}

int main(int argc, char **argv){
	yyparse();
	return 0;
}