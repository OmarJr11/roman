/* 

Convertir un número romano en decimal usando Flex y Bison

Instegrantes: 
	Anderson Arciniegas 27481456
	Omar Gonzalez 27244029

./makefile.sh 		para crear los archivos ejecutables
./roman XIVV 		para correr el programa 

*/

%{
	#include <stdio.h>
	#include <string.h>
	#include <stdlib.h>
	#include "romanNumbersBison.tab.h"
	void showError();
%}

romans 	^M{0,3}D?(CM|CD|D?C{0,3})L?(XC|XL|L?X{0,3})V?(IX|IV|V?I{0,3})

%%

{romans} 		{yylval.cad = yytext; return (ROMANS);}

.				{showError(); return(OTHER);}	
[ \t\r]			{}

%%

void showError(char *other){
	printf(" <<ErrorLexico \"%s\" >>\n", other);
}


