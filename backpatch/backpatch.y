%{
#include<bits/stdc++.h>
#include "node.h"
using namespace std;

int yylex(void);
void yyerror(const char*);
extern vector<string> save;
extern vector<int> patch[100];
extern int nextinst;
%}


%union{
int num;
char entry[32];
struct node* patchlist;
}

%type <num> M
%token orr
%token andd
%token nott
%token <entry> rel
%type <patchlist> B
%token <entry> id
%type <entry> E
%left orr
%left andd
%right nott
%%

S:B '\n' { printf("Three address code of given expression:\n");
	calc();printcode();
}
	
 ;
B:B orr  M B { 
		$$=new node();
		//cout<<"or"<<endl;
		//cout<<$3<<endl;
		backpatch($1->falselist,$1->cnt2,$3);
	    $$->truelist=mergeList($1->truelist,$4->truelist,$1->cnt1,$4->cnt1);
	    $$->cnt1=$1->cnt1+$4->cnt1;
	    $$->falselist=$4->falselist;
	    $$->cnt2=$4->cnt2;
	}
 |B andd M B{ 
 		$$=new node();
 		//cout<<"and"<<endl;
		//cout<<$3<<endl;
 		backpatch($1->truelist,$1->cnt1,$3);
	 	$$->truelist=$4->truelist;
	 	$$->cnt1=$4->cnt1;
	 	$$->falselist=mergeList($1->falselist,$4->falselist,$1->cnt2,$4->cnt2);
	 	$$->cnt2=$1->cnt2+$4->cnt2;
 }
 |nott B { 
 		$$=new node();
 		$$->truelist=$2->falselist;
 		$$->cnt1=$2->cnt2;
	 	$$->falselist=$2->truelist;
	 	$$->cnt2=$2->cnt1;
 }
 |'('B')' {
 		$$=new node();
 		$$->truelist=$2->truelist;
 		$$->cnt1=$2->cnt1;
 		$$->cnt2=$2->cnt2;
		$$->falselist=$2->falselist;
 }
 |E rel E { 
 		$$=new node();
 		$$->truelist[$$->cnt1++]=nextinst++;
 		
 		
      	$$->falselist[$$->cnt2++]=nextinst++;
      	
		string buf="";
		string e1,e2,e3;
		e1=$1;
		e2=$2;
		e3=$3;
		buf+="if"+e1+e2+e3+"goto_";
		save.push_back(buf);
		save.push_back("goto_");
 }
 ;
E:id
 ;
M: {
	
		$$=nextinst;}
 ;

%%

						
int main()
{
	yyparse();
}

void yyerror(const char* str)
{
	printf("%s\n",str);
}

