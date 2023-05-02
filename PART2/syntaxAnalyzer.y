%{
#include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
int yylex(void);
extern int lineNo;
int declareFlag=0;

//int lineNo=1;
 
void yyerror(const char *s);
int funccallflag=0;
int currScope=0;
    int forFlag=0;
     
    int checking=0;
 
int yywrap();
void add(char);
void add_var(char* s , int i, char* ss,int flagg);
void adjust_var(char* tt);
void insert_type();
int search(char *);

struct node* mknode(struct node *children[], int nc ,char *token);

 
    struct prints{
            char types[100][100];
            int count;
        }prints[10];
     
     
        struct dataType {
            int isFunc;
            char * id_name;
            char * data_type;
            char * type;
            int line_no;
            int flag;
            int scope;
        } symbol_table[40];
     
        struct funcs{
            char *name;
            char *types[100];
            int count;
            char type[100];
        } funcs[100];
        int funcCount=0;
     
        char currTypes[100][100];
        int currtcount=0;

int addAsFunc=0;
    int rFlag=0;
    char rType[100]; 
int count=0;
int q;
char type[10];
 
typedef struct T{
        char *sval;
        char cval;
        float val;
        char *type;
    } T;

    struct node { 
        struct node* child[15];
	char token[100]; 
        
    };
    
 struct node *head;
   void cc(struct node* par)
{
        for(int i=0;i<15;++i){
                par->child[i]=malloc(sizeof(struct node));
                par->child[i] = NULL;
        }
        return;
}

void fillarr(struct node* nodearray[],int k)
{
        for(int i=0;i<k;++i){
                nodearray[i] = (struct node*)malloc(sizeof(struct node));
        }
}
%}
 
%union {struct {
            char *sval;
            char cval;
            float val;
            char *type;
            struct node* nd;
        } t;
    }
%type <t> switchStatement  operator compound callParams printf datatype type param expression caseExpr var declarative list listEntry cVar var1 index valueList arrvals printVars valueBlock funcCall  exprOperand cIndex wloopexpr loopexpr declare_var declare_var1 s program funcs func params statements params1 statement nonIfStatement ifStatement ifWithElse ifWithoutElse jump return forStatement forInit whileStatement switchexpr cases cases1 case defaultCase assignment
 
%token INT FLOAT CHAR IF ELSE BREAK CASE CONTINUE FOR RETURN SWITCH WHILE DEFAULT ELSEIF
%token LE GE NE EQ AND OR MAIN VOID PRINTF <t> STRINGLIT CHARLIT NUM FLOATNUM IDENTIFIER 
 
%left '='
%left OR
%left AND
%left EQ NE
%left '<' LE '>' GE
%left '+' '-'
%left '*' '/' '%'
%right '!'
%% 
 
 
s : program { 
        printf("valid input");
        return 1;
        
        }
        ;
 
program :funcs
        ;
 
datatype: type 
        | VOID 
        ;

type    : INT   
        | FLOAT 
        | CHAR 
        ;
 
funcs: func 
      | func funcs
     | %empty {$$.nd=malloc(sizeof(struct node)); $$.nd=NULL;}
     ;    
 
func  : datatype IDENTIFIER '(' params ')' '{' statements '}' 
      /* datatype MAIN '(' params ')' '{' statements '}' {
        
        add_var("main" , 1 ,$1.type,0);  

                struct node* nodechild[8] ;fillarr(nodechild,8);
                struct  node* mainnode = malloc(sizeof(struct node));strcpy(mainnode->token,"MAIN");cc(mainnode);
                struct  node* lb = malloc(sizeof(struct node)) ;strcpy(lb->token, "(");cc(lb);
                struct  node* rb = malloc(sizeof(struct node)) ;strcpy(rb->token ,")");cc(rb);
                nodechild[0] = $1.nd;nodechild[1] = mainnode;nodechild[2] = lb; nodechild[3] = $4.nd;nodechild[4] =rb;
                struct  node* llb = malloc(sizeof(struct node));strcpy(llb->token , "{") ;cc(llb);
                nodechild[5] = llb; nodechild[6] = $7.nd;
                struct  node* rrb = malloc(sizeof(struct node));strcpy(rrb -> token , "}") ;cc(rrb);
                nodechild[7] = rrb;
                $$.nd = mknode(nodechild, 8, "func");
        } */
        ;
 
params  :   %empty 
        |  param params1 
        ;
 
params1 : %empty   
        | ',' param params1
        ;
 
param   : datatype IDENTIFIER 
        ;
 
statements  :   %empty     
            |   statement statements
            ;
 
statement : ifStatement 
          |nonIfStatement
          ;
 
nonIfStatement: switchStatement 
                |forStatement 
                |whileStatement 
                
                |declarative ';' 

                |assignment ';'

                |return 
                |jump 
                |compound

                | printf ';' 
            ;
 
ifStatement : ifWithElse 
            | ifWithoutElse 
            ;
 
 ifWithoutElse   : IF '(' expression ')' statement 
                | IF '(' expression ')' ';'
                | IF '(' expression ')' ifWithElse ELSE ifWithoutElse
                ;
 
ifWithElse  : IF '(' expression ')' statement ELSE ifWithElse 
             | nonIfStatement 
            ;

jump:   BREAK ';' 
    |   CONTINUE ';' 
    ;
 
return: RETURN NUM ';' 
      | RETURN FLOATNUM ';'   
      | RETURN ';' 
      | RETURN CHARLIT ';'
      | RETURN expression ';'
      ;
 
compound: '{' statements '}' 
        ;
 
 expression  :   '!' expression 
        |   expression operator expression  
        |   exprOperand  
            |   '(' expression  ')'
        ;
 
operator    :   '+' 
                |'-' 
                |'*' 
                |'/' 
                |'%' 
                |'>' 
                |'<' 
                |GE 
                |LE 
                |EQ 
                |NE 
                |OR 
                |AND    
                 
            ;
 
forStatement    :   FOR '(' forInit  ';' loopexpr  ';' loopexpr  ')' statement 
                |   FOR '(' forInit ';' loopexpr  ';' loopexpr  ')' ';' 
                /* |   FOR '(' forInit ';' loopexpr  ';' loopexpr  ')' compound {
                        struct node* arr[9];fillarr(arr,9);
                        arr[2] = $3.nd;arr[4] = $5.nd;arr[6] = $7.nd;arr[8] = $9.nd;
                        struct node* fornode;strcpy(fornode->token,"FOR");cc(fornode); arr[0] = fornode;
                        struct node* lb;strcpy(lb->token,"(");cc(lb); arr[1] = lb;
                        struct node* sc;strcpy(sc->token,";");cc(sc); arr[3] = sc;
                        struct node* sc1;strcpy(sc1->token,";");cc(sc1); arr[5] = sc1;
                        struct node* rb;strcpy(rb->token,")");cc(rb); arr[7] = rb;
                        $$.nd = mknode(arr,9,"forStatement");
                } */
                ;
 
 
 
loopexpr    : wloopexpr 
              | %empty
        ;
            
wloopexpr       : expression 
                | assignment 
                ;
 
forInit :   %empty 
        |  expression 
        |assignment 
        |declarative 
        ;                   
 
whileStatement: WHILE '(' wloopexpr ')' statement 
              | WHILE '(' wloopexpr ')' ';' 
              /* | WHILE '(' wloopexpr ')' {
                struct node* arr[4];fillarr(arr,4);
                   arr[2] = $3.nd;
                   struct node* wnode=malloc(sizeof(struct node));strcpy(wnode->token,"WHILE");cc(wnode);arr[0] = wnode;
                   struct node* lb=malloc(sizeof(struct node));strcpy(lb->token,"(");cc(lb);arr[1] = lb;
                   struct node* rb=malloc(sizeof(struct node));strcpy(rb->token,")");cc(rb);arr[3] = rb;
                   $$.nd = mknode(arr,4,"whileStatement");
              } */
                ;
 
switchStatement :   SWITCH '(' switchexpr ')' '{' cases '}'   
 
switchexpr:  expression 
            | assignment 
            ;
            
cases   :   %empty 
        | cases1 defaultCase cases1 
        | case cases 
        | case 
        ;
 
cases1   :   %empty
        | case cases1 
        | case 
        ;
 
case    :   CASE  caseExpr ':' statements      
        ;                      
 
defaultCase:  DEFAULT  ':' statements
                ;               
 
caseExpr  :   '!' caseExpr
            |   caseExpr operator caseExpr 
            |   NUM 
            |   '(' caseExpr  ')' 
            ;        
 
assignment  : var '=' expression 
            ;
 
declarative  :  type list 
        ;

list :  listEntry 
       | listEntry ',' list 
        ;
        
listEntry   :IDENTIFIER '[' cIndex ']' '=' STRINGLIT 

        | IDENTIFIER '[' expression ']'  '=' STRINGLIT 

        | IDENTIFIER '['  ']'  '=' STRINGLIT 
        | IDENTIFIER '[' expression ']' '[' expression ']'  '=' '{' STRINGLIT '}'
            | IDENTIFIER '['  ']' '[' expression ']'  '=' '{' STRINGLIT '}' 
            | IDENTIFIER 
        | IDENTIFIER '[' expression  ']' 
            | IDENTIFIER '[' expression ']' '[' expression ']' 

        | IDENTIFIER '[' expression  ']' '=' '{' valueList '}' 
        | IDENTIFIER '['  ']' '=' '{' valueList '}' 
        | IDENTIFIER '[' expression ']' '[' expression ']' '='  '{' valueList '}' 
            | IDENTIFIER '['  ']' '[' expression ']' '=' '{' valueList '}' 
            | IDENTIFIER '[' expression  ']' '=' '{' valueBlock '}' 
            | IDENTIFIER '['  ']' '[' expression ']' '=' '{' valueBlock '}' 
            | IDENTIFIER '[' expression ']' '[' expression ']' '=' '{' valueBlock '}' 
        |  IDENTIFIER '[' ']' '[' expression ']' '=' '{' valueBlock '}'  
        |  IDENTIFIER '=' expression 
        ;
 
cIndex:index 
        | %empty 
        ;
 
index   :   expression 
        |       var  
        ;
 
cVar    :   var 
        |   IDENTIFIER '[' ']' 
        ;
declare_var :        IDENTIFIER   

            |   declare_var1 
            ;

var :       IDENTIFIER   
        | IDENTIFIER '[' expression ']' 
        |       IDENTIFIER '[' expression ']' '[' expression ']' 
                        ;
   
declare_var1:       IDENTIFIER '[' expression ']' 
    |       IDENTIFIER '[' expression ']' '[' expression ']' 
        ;
 
 
    
valueList : arrvals ',' valueList  
          | arrvals 
        ;
 
valueBlock : '{' valueList '}' ',' valueBlock 
            | '{' valueList '}' 
            |  valueList ',' valueBlock 
            | arrvals ',' valueBlock
            | arrvals
            | valueList 
        ;
 
funcCall    :  IDENTIFIER '(' {funccallflag=1;} callParams ')' 
        ;
 
callParams : var ',' callParams
                | %empty 
                |arrvals 
                |arrvals ',' callParams
                | var
                ;
 
exprOperand  : arrvals 
        |   var  
        |   funcCall 
                ;   
 
arrvals :   NUM 
        |   FLOATNUM 
        |   CHARLIT
        ;
printf  :  PRINTF '('  STRINGLIT ')' 
        
        |  PRINTF '(' STRINGLIT ','  printVars ')' 
          
        ;
 
printVars : IDENTIFIER ',' printVars
          | IDENTIFIER 
        ;    
 
 
%% 
#include "lex.yy.c"
#include <stdio.h>
#include <string.h>
int main(int argc, char *argv[])
{
	yyin = fopen(argv[1], "r");
        /* head= malloc(sizeof(struct node));

            for(int i=0;i<100;i++)
            {
                    funcs[funcCount].count=0;
            } */
        yyparse();


            /* int mainFlag=0;
            for(int i=0;i<count;i++)
            {
                    if(symbol_table[i].isFunc==1)
                    {
                            if(strcmp(symbol_table[i].id_name,"main")==0)
                            {
                                    mainFlag=1;
                                    break;
                            }
                    }
            }
            if(mainFlag==0)
            {
                    printf("Error:main() function not declared");
                    /* exit(1); */
            /* } */
 
        /* printf("\n\n");
	printf("\t\t\t\t\t\t\t\t PHASE 1: LEXICAL ANALYSIS \n\n");
	printf("\nSYMBOL   DATATYPE   TYPE   SCOPE \n");
	printf("_______________________________________\n\n");
	int i=0;
	for(i=0; i<count; i++) {
		printf("%s\t%s\t%s\t%d\t\n", symbol_table[i].id_name, symbol_table[i].data_type, symbol_table[i].type, symbol_table[i].scope);
	}
	for(i=0;i<count;i++) {
		free(symbol_table[i].id_name);
		free(symbol_table[i].type);
	}
	printf("\n\n"); */ 
 
	fclose(yyin);
        /* printf("Before Printing Tree\n");

        print_tree(head,0);
        printf("After Printing Tree\n"); */
 
	return 0;
}




struct node* mknode(struct node *children[], int nc, char *token) {	
	struct node *newnode = (struct node *)malloc(sizeof(struct node));

	char *newstr = (char *)malloc(strlen(token)+1);
	strcpy(newstr, token);
        strcpy( newnode->token ,newstr);
        for(int i=0;i<nc;++i)
        {
                newnode -> child[i] = (struct node *)malloc(sizeof(struct node));
                newnode -> child[i]=children[i];
        }

	
	

	return(newnode);
}

void print_tree(struct node* root, int depth)
{
        if( root == NULL){
                return;
        }
        for(int i=0;i<depth;++i){
                printf("  ");
        }
        printf("%s\n",root->token);
 
        for(int i=0;i<15;++i)
        {
                 /* if(root->child[i] != NULL){  */
                     print_tree(root->child[i] , depth+1); 
                 /* }  */
                
               
        }

}
int search(char *type) {
	int i;
	for(i=count-1; i>=0; i--) {
		if(strcmp(symbol_table[i].id_name, type)==0&&symbol_table[i].scope<=currScope) {
			return -1;
			break;
		}
	}
	return 0;
}
void add_var(char* s , int i , char* set_type,int flagg){
        int chk = 0;
            for(int i=0;i<count;++i)
            {
                    if(strcmp(symbol_table[i].id_name,s) == 0&&symbol_table[i].scope==currScope){
                            printf("\n{Semantic Error: Re declaration of variables\n");
                            exit(1);
                            return; // variable already exists, so dont add again
                    }
            }
     
            // Add the Variable to Symbol Table 
            symbol_table[count].id_name = strdup(s);
            if(addAsFunc==1)
            symbol_table[count].isFunc=1;
     
            symbol_table[count].scope=currScope;
            symbol_table[count].type=strdup("Variable");
            if(i == 1){
                symbol_table[count].data_type=strdup(set_type);
                if(flagg==10)
                symbol_table[count].flag=10;
    	}
            else{
                    char* temp = "NULL";
                 symbol_table[count].data_type=strdup(temp);
            }
            
            count++;
}
void adjust_var(char* tt)
{
        for(int i=0;i<count;++i)
        {
                if(strcmp(symbol_table[i].type,"Variable") == 0  && strcmp(symbol_table[i].data_type,"NULL") == 0 )
                {
                    strcpy(symbol_table[i].data_type,tt);
                }
        }
}
 
void add(char c) {
  q=search(yytext);
  if(!q) {
    if(c == 'V') {
	    symbol_table[count].id_name=strdup(yytext);
	    symbol_table[count].data_type=strdup(type);
	
	    symbol_table[count].type=strdup("Variable");
	    count++;
	}
      else  if(c == 'U') {
	    symbol_table[count].id_name=strdup(yytext);
	    symbol_table[count].data_type="NULL";
	
	    symbol_table[count].type=strdup("Variable");
	    count++;
	}
   }
}
void insert_type() {
	strcpy(type, yytext);
}
//extern int lineno;
extern char *yytext;
yyerror(char *s) {
	printf("Syntax error");
        exit(1);
} 