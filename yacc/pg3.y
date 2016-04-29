%{
#include<stdio.h>
#include<math.h>
int val=0;
char ch=a;
%}
%token number;
%%

S:E { printf("The result is %d %d \n\n",$1,$val);}
 ;
E:E '+' T{$$=$1 +$3;val=val+1;}
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
Q:Q '%' R{$$=$1%$3; }
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
int gen_code(char a,char b,char c,char d){
	
} 
 

								







