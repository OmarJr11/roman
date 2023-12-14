#!/bin/bash
	clear
echo "<inicio>"
	flex -l romanNumbersFlex.l
	bison -dv romanNumbersBison.y
	gcc -o main romanNumbersBison.tab.c lex.yy.c -lfl
echo "<fin>"