%{
#include <stdio.h>
#include <string.h>
%}
 
LETTER [A-Za-z]
DIGIT [0-9]
OPERATOR [+-*/=<>&|!(){}]
FOR "for"
WHILE "while"
IF "if"
DO "do"
ELSE "else"
THEN "then"
 
%%
{LETTER} {strcpy(yylval.id,yytext);
return LETTER;}
{DIGIT}+"."{DIGIT}+ {strcpy(yylval.id,yytext);
return FLOAT;}
{DIGIT}+ {strcpy(yylval.id,yytext);
return INTEGER;}
{FOR} {return FOR;}
{WHILE} {return WHILE;}
{DO} {return DO;}
{IF} {return IF;}
{THEN} {return THEN;}
{ELSE} {return ELSE;}
[ \n\t]* ;
"end" {return 0;}
%%
