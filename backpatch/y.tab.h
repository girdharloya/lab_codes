#define orr 257
#define andd 258
#define nott 259
#define rel 260
#define id 261
typedef union{
int num;
char entry[32];
struct node* patchlist;
} YYSTYPE;
extern YYSTYPE yylval;
