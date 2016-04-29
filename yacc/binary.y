%{
#include<stdio.h>
#include<math.h>
%}
%token number
%%

N:L { printf("The result is %d \n\n",$1);}
 ;
L:L B{$$=$1*2+$2;}
 |B      {$$=$1;}
 ;
B: number {$$=$1;}
 ;
%%
int main()
{
printf("enter a binary number \n ");
yyparse();
}
yyerror()
{
printf("error \n");
}
