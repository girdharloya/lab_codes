%{
#include<stdio.h>
#include<math.h>
#define YYSTYPE double
%}
%token number
%%
N: L '.' X { printf("The result is %lf \n\n",$1+$3);}
 ;
X: B X {$$=$1/2+$2/2;} 
 | B {$$=$1/2;}
 ;
L: L B {$$=$1*2+$2;}
 | B      {$$=$1;}
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
