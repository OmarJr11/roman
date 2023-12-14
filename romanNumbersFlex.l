%{
	#include <stdio.h>
	#include <string.h>
	#include "romanNumbersBison.tab.h"
	void showError();
%}

numbers ([0-9])+
romans 	(i|I|v|V|x|X|l|L|c|C|d|D|m|M)+


%%

{romans} 		{sscanf(yytext, "%s", yylval.cad); return (ROMANS);}

.				{showError(); return(OTHER);}	
[ \t\r]			{}

%%

void showError(char* other){
	printf(" <<ErrorLexico \"%s\" >>", other);
}