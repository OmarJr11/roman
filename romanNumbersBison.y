%{
	#include <stdio.h>
	#include <string.h>
	#include <stdlib.h>
	int yylex();
	void yy_scan_string(char *s);
	int yyerror(char *s);
	int convertNumberRoman(char *roman);
	int numberRoman(char roman);
%}

%token ROMANS OTHER

%type <cad> ROMANS

%union{
	char *cad; 
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
	printf("\n->Error Sintactico %s\n", s);
}

/*
	Recibe un numero romano como una cadena y 
	lo convierte en un numero en notacion decimal
  	roman {char} A la cadena en numero romano
  	return {int} 
*/
int convertNumberRoman(char *roman) {
	int decimal = 0;
	char *algo = yylval.cad;
	//Se recorre la cadena caracter por caracter
	for(int i = 0; i < strlen(roman); i++) {
		/*
			Si la ultima posicion de la cadena + 1 no existe 
			o si el caracter tiene una notacion mayor o igual al siguiente
			caracter se suma su equivalente a numero decimal
			Sino se resta
		*/
		if(
			!roman[i+1] || 
			numberRoman(roman[i]) >= numberRoman(roman[i+1])
		) {
			decimal += numberRoman(roman[i]);
		} else {
			decimal += (numberRoman(roman[i]) * (-1));
		}
	}
	return decimal;
}

/*
	Recibe un numero romano como un caracter y 
	devuelve su equivalente en notacion decimal
  	roman {char} Caracter en numero romano
  	return {int} 
*/
int numberRoman(char roman) {
	char caracter = roman;
	int number = 0;
	//Se comprueva que el caracter pertenezca a los Numero romanos
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
	if(argc > 1) {
		yylval.cad = argv[1];
		yy_scan_string(yylval.cad);
	}
	yyparse();
	return 0;
}