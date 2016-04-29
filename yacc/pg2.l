%{
#include"y.tab.h"
#include<math.h>
//extern double yylval;
%}
%%
[0-1] {yylval=atoi(yytext);return number;}
[\t] ;
[\n] return 0;
. return yytext[0];
%%

