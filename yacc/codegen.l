%{
	#include<stdio.h>
	#include"y.tab.h"
	char ch='a';
%}
%%
[0-9]+ { yylval.dval=yytext[0];return NUM;}
\n {return 0;}
. {return yytext[0];}
%%
void yyerror(char* str)
{
        printf("\n%s",str);
}
char gencode(char ch1,char first,char op,char second)
{
        printf("\n%c = %c %c %c\n",ch,first,op,second);
        return ch++;
}
int main()
{
        yyparse();
        return 0;
}
