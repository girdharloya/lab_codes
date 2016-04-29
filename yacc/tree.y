%{
#include<stdio.h>
#include<math.h>
%}
%token number
%%

S:E { printf("The result is %d \n\n",$1);}
 ;
E:E '+' T{	node n=new node
		$$=$1 +$3;}
 |T      {$$=$1;}
 ;
T:T '-' F{$$=$1-$3;}
 |F      {$$=$1;}
 ;
F:F '*' P{$$=$1*$3;}
 | P     {$$=$1;}
 ;
P:P '/' Q{$$=$1/$3;}
 | Q	 {$$=$1;}
 ;
Q:Q '%' R{$$=$1%$3;}
 | R	 {$$=$1;}
 ;
R:A '^'R {$$=PW($1,$3);}
 |A      {$$=$1;}
A: number {$$=$1;}
 ;
%%
int main()
{
printf("enter an expression");
yyparse();
}
yyerror()
{
printf("error \n");
}
int PW(int x, int y)
{
int i,j;
j=x;
for(i=1;i<y;i++)
x=x*j;
return (x);
} 
 

								







