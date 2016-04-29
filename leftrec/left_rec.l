delim [|\n]
alpha [A-Z]
alpha2 [a-zA-Z]*
ar [->]
%{
        #include<stdio.h>
	#include<string.h>
	char table[100][2];
	char value[100][10];
	int table_length=0,i=0;
	char leftchar[100];
	char rightchar[100];
	int alphabet[26];
	int non_terminals_count=0;
	char non_terminals_chars[100][2];
	char new_table[100][2];
	char new_value[100][100];
%}
%%
{alpha}("->") {	printf("found  left symbol %s\n",yytext);yytext[yyleng-2]='\0';		strcpy(leftchar,yytext); int number=(int)(yytext[0]-'A');
		if(alphabet[number]!=1)
		{	alphabet[number]++;
			strcpy(non_terminals_chars[non_terminals_count],leftchar);
			non_terminals_count++;
			
		}
}
{alpha2}{delim}	{printf("found right symbol %s\n",yytext);	
		if(yytext[yyleng-1]=='|')	yytext[yyleng-1]='\0';
		strcpy(rightchar,yytext);		
 		strcpy(table[i],leftchar);	
		strcpy(value[i],rightchar);
		i++;
		table_length=i;
		}

%%
int main(int argc,char *argv[]){
	int j=0,i;
	printf("opening file\n");
	yyin = fopen(argv[1],"r");
	yylex();
	printf("printing table\n");
	for(j=0;j<i;j++)
		printf("%s and %s \n",table[j],value[j]);
	printf("non terminals are %d",non_terminals_count);
	for(i=0;i<non_terminals_count;i++){
		for(j=0;j<i-1;j++){
			for(k=0;k<table_length;k++){
				temp[0]=value[k][0];	temp[1]='\0';
				if( strcmp(table[k],non_terminal_chars[j])==0 && strcmp(temp,non_terminal_chars[j])==0){
					//now you have to add all such productions in the new table as its child
					
				}
			}
		}
	
	}
	
	printf("finished\n");
	
	
	return 0;
	
}
