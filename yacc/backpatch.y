%{
#include<stdio.h>
 
#include<stdlib.h>
 
#include<string.h>
 
#include<ctype.h>
 
#include<math.h>
 
#define START 100
 
typedef struct s
 
{
 
int* true;
 
int* false;
 
int* next;
 
int quad;
 
char place[5];
 
}ETYPE;
 
int nextquad=START;
 
char code[25][50];
 
%}
 
%union
{
char id[10]; 
ETYPE eval;
 
}
 
%left "|"
 
%left "&"
 
%left "!"
 
%left "<" ">"
 
%left "+" "-"
 
%left "*" "/"
 
%left "(" ")"
 
 
 
%right "="
 
 
 
%token <id> LETTER INTEGER FLOAT
 
%token FOR WHILE DO IF THEN ELSE
 
%type <eval> PROGRAM BLOCK STATEMENTS ASSIGN COND LVAL E M N Q
 
 
 
%start PROGRAM
 
 
 
%%
 
 
 
PROGRAM: BLOCK {
 
int i;
 
Backpatch($1.next,nextquad);
 
for(i=START;i<nextquad;i++)
 
printf("\n%s",code[i-START]);
 
printf("\n%d\n",nextquad);
 
}
 
 
 
BLOCK: DO M BLOCK WHILE M COND {
 
Backpatch($6.true,$2.quad);
 
$$.next=$6.false;
 
}
 
| FOR ASSIGN M COND M ASSIGN Q BLOCK {
 
Backpatch($8.next,$5.quad);
 
Backpatch($6.next,$3.quad);
 
Backpatch($4.true,$7.quad);
 
$$.next=$4.false;
 
sprintf(code[nextquad-START],"%d\tgoto %d",nextquad,$5.quad);
 
Gen();
 
}
 
| WHILE M COND M BLOCK {
 
Backpatch($5.next,$2.quad);
 
Backpatch($3.true,$4.quad);
 
$$.next=$3.false;
 
sprintf(code[nextquad-START],"%d\tgoto %d",nextquad,$2.quad);
 
Gen();
 
}
 
| IF COND M BLOCK {
 
Backpatch($2.true,$3.quad);
 
$$.next=Merge($2.false,$4.next);
 
}
 
| IF COND M BLOCK N ELSE M BLOCK {
 
Backpatch($2.true,$3.quad);
 
Backpatch($2.false,$7.quad);
 
$$.next=Merge($4.next,$5.next);
 
$$.next=Merge($$.next,$8.next);
 
}
 
| '{' STATEMENTS '}' {
 
$$.next=$2.next;
 
}
 
| ASSIGN ';' {
 
$$.next=(int*)malloc(sizeof(int)*15);
 
$$.next[0]=0;
 
}
 
| E { }
 
 
 
STATEMENTS: STATEMENTS M BLOCK {
 
Backpatch($1.next,$2.quad);
 
$$.next=$3.next;
 
}
 
| BLOCK {
 
$$.next=$1.next;
 
}
 
 
 
ASSIGN: LVAL '=' E {
 
sprintf(code[nextquad-START],"%d\t%s = %s",nextquad,$1.place,$3.place);
 
Gen();
 
}
 
| E { }
 
 
 
LVAL: LETTER {strcpy($$.place,$1);}
 
 
 
E: E '+' E {
 
strcpy($$.place,Newtemp());
 
sprintf(code[nextquad-START],"%d\t%s = %s + %s",nextquad,$$.place,$1.place,$3.place);
 
Gen();
 
}
 
| E '-' E {
 
strcpy($$.place,Newtemp());
 
sprintf(code[nextquad-START],"%d\t%s = %s - %s",nextquad,$$.place,$1.place,$3.place);
 
Gen();
 
}
 
| E '*' E {
 
strcpy($$.place,Newtemp());
 
sprintf(code[nextquad-START],"%d\t%s = %s * %s",nextquad,$$.place,$1.place,$3.place);
 
Gen();
 
}
 
| E '/' E {
 
strcpy($$.place,Newtemp());
 
sprintf(code[nextquad-START],"%d\t%s = %s / %s",nextquad,$$.place,$1.place,$3.place);
 
Gen();
 
}
 
| '-' E %prec '*' {
 
strcpy($$.place,Newtemp());
 
sprintf(code[nextquad-START],"%d\t%s = - %s",nextquad,$$.place,$2.place);
 
Gen();
 
}
 
| LETTER {
 
strcpy($$.place,$1);
 
}
 
| INTEGER {
 
strcpy($$.place,$1);
 
}
 
| FLOAT {
 
strcpy($$.place,$1);
 
}
 
 
 
COND: COND '&' M COND {
 
Backpatch($1.true,$3.quad);
 
$$.true=$4.true;
 
$$.false=Merge($1.false,$4.false);
 
}
 
| COND '|' M COND {
 
Backpatch($1.false,$3.quad);
 
$$.true=Merge($1.true,$4.true);
 
$$.false=$4.false;
 
}
 
| '!' COND {
 
$$.true=$2.false;
 
$$.false=$2.true;
 
}
 
| '(' COND ')' {
 
$$.true=$2.true;
 
$$.false=$2.false;
 
}
 
| E '<' E {
 
$$.true=Makelist(nextquad);
 
$$.false=Makelist(nextquad+1);
 
sprintf(code[nextquad-START],"%d\tif %s < %s goto ",nextquad,$1.place,$3.place);
 
Gen();
 
sprintf(code[nextquad-START],"%d\tgoto ",nextquad);
 
Gen();
 
}
 
| E '>' E {
 
$$.true=Makelist(nextquad);
 
$$.false=Makelist(nextquad+1);
 
sprintf(code[nextquad-START],"%d\tif %s > %s goto ",nextquad,$1.place,$3.place);
 
Gen();
 
sprintf(code[nextquad-START],"%d\tgoto ",nextquad);
 
Gen();
 
}
 
| E {
 
$$.true=Makelist(nextquad);
 
$$.false=Makelist(nextquad+1);
 
sprintf(code[nextquad-START],"%d\tif %s goto ",nextquad,$1.place);
 
Gen();
 
sprintf(code[nextquad-START],"%d\tgoto ",nextquad);
 
Gen();
 
}
 
 
 
M: {
 
$$.quad=nextquad;
 
}
 
N: {
 
$$.next=Makelist(nextquad);
 
sprintf(code[nextquad-START],"%d\tgoto ",nextquad);
 
Gen();
 
}
 
Q: {
 
$$.next=Makelist(nextquad);
 
sprintf(code[nextquad-START],"%d\tgoto ",nextquad);
 
Gen();
 
$$.quad=nextquad;
 
}
 
 
 
%%
 
 
 
/*
#include "lex.yy.c"
 
 
 
main()
 
{
 
yyparse();
 
}
 
*/
 
yyerror(char *errmesg)
 
{
 
printf("\n%s\n",errmesg);
 
}
 
 
 
char* Newtemp()
 
{
 
static int count=1;
 
char* ch=(char*)malloc(sizeof(char)*5);
 
sprintf(ch,"T%d",count++);
 
return ch;
 
}
 
 
 
int* Makelist(int nquad)
 
{
 
int* list=(int*)malloc(sizeof(int)*15);
 
list[0]=nquad;
 
list[1]=0;
 
return list;
 
}
 
 
 
int* Merge(int* list1,int* list2)
 
{
 
int* temp=list1,count1=0,count2=0;
 
while(list1[count1]!=0) count1++;
 
while(list1[count2]!=0)
 
{
 
list1[count1]=list2[count2];
 
count1++;
 
count2++;
 
}
 
return temp;
 
}
 
 
 
void Backpatch(int* list,int nquad)
 
{
 
char addr[10];
 
sprintf(addr,"%d",nquad);
 
while(*list!=0)
 
{
 
int index=*list++-START;
 
strcat(code[index],addr);
 
}
 
}
 
 
 
void Gen()
 
{
 
nextquad++;
 
}
