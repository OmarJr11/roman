%{
	#include <stdio.h>
	#include <string.h>
	#include "romanNumbersBison.tab.h"
	void showError();
%}

romans 	^M{0,3}D?(CM|CD|D?C{0,3})L?(XC|XL|L?X{0,3})V?(IX|IV|V?I{0,3})$

%%

{romans} 		{sscanf(yytext, "%s", yylval.cad); return (ROMANS);}

.				{showError(); return(OTHER);}	
[ \t\r]			{}

%%

void showError(char* other){
	printf(" <<ErrorLexico \"%s\" >>", other);
}