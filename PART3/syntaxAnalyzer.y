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

        // printf("valid code\n"); 
        struct node* nodechild[1] ;
        fillarr(nodechild,1);
        nodechild[0] = $1.nd;
        $$.nd = mknode(nodechild,1 , "s");
        head = $1.nd;
        return 1;
        
        }
        ;
 
program :funcs{
        struct node* nodechild[1];
        fillarr(nodechild,1);
        nodechild[0] = $1.nd;
        $$.nd = mknode(nodechild,1 , "program");
        }
        ;
 
datatype: type {$$.type = calloc(10, 1); strcpy($$.type,$1.type)  ;
                struct node* cn[1] ; fillarr(cn,1);
                cn[0] = $1.nd;
                $$.nd = mknode(cn,1,"datatype");
        }
        | VOID {
                $$.type = calloc(10, 1);
                strcpy($$.type, "VOID");
                struct node* arr[1];fillarr(arr,1);
                struct node* voidnode = malloc(sizeof(struct node));strcpy(voidnode->token,"void");cc(voidnode);
                arr[0] = voidnode; 
                $$.nd = mknode(arr,1,"datatype");
        }
        ;

type    : INT {  
        $$.type = calloc(10, 1); strcpy($$.type,"int");

                struct node* intnode = malloc(sizeof(struct node));
                strcpy(intnode->token ,"INT"); cc(intnode);
                struct node* cn[1];fillarr(cn,1);cn[0] = intnode;
                $$.nd = mknode(cn,1,"type");
        }
        | FLOAT {
                $$.type = calloc(10, 1); strcpy($$.type,"float") ;
                struct node* floatnode = malloc(sizeof(struct node));strcpy(floatnode->token ,"FLOAT");cc(floatnode);
                struct node* cn[1];fillarr(cn,1);cn[0] = floatnode;
                $$.nd = mknode(cn,1,"type");
                
        }
        | CHAR {
                // printf("---------------------------\n\n");
                $$.type = calloc(10, 1); strcpy($$.type,"char") ;
                struct node* charnode = malloc(sizeof(struct node));strcpy(charnode->token ,"char");cc(charnode);
                struct node* cn[1];fillarr(cn,1);cn[0] = charnode;
                $$.nd = mknode(cn,1,"type");
        }
        ;
 
funcs: func {
        struct node* nodechild[1] ;
        fillarr(nodechild,1);
        nodechild[0] = $1.nd;
        $$.nd = mknode(nodechild,1 , "funcs");
      }
      | func funcs{
        struct node* nodechild[2] ;fillarr(nodechild,2);
        nodechild[0] = $1.nd;nodechild[1] = $2.nd;
        $$.nd = mknode(nodechild,2 , "funcs");
     }
     | %empty {$$.nd=malloc(sizeof(struct node)); $$.nd=NULL;}
     ;    
 
func  : datatype IDENTIFIER '(' {
            // currScope++;
            currScope=0;
            count=0;
    } params ')' '{' statements '}' {
        // printf("ONCEEEEE\n");
                addAsFunc=1;
            add_var($2.sval , 1 , $1.type ,0);
            addAsFunc=0;

                funcs[funcCount].name=calloc(100,1);
     strcpy(funcs[funcCount].name,$2.sval);
     strcpy(funcs[funcCount].type,$1.type); 
//      printf("%sTYPEEEEEEEEEEEe\n",$1.type);
     if(!search($2.sval)){
            printf("Semantic Error: Variable not declared\n");
            exit(1);
     }
     funcCount++;
     if(strlen(rType)==0&&strcmp($1.type,"void")==0)
     {
     
     }
     else if(strcmp(rType,$1.type)==0)
     {
     
     }
     else{
     
            printf("Semantic error:Return type invalid");
     
            exit(1);
     }
     
     rFlag=0;
     for(int i=0;i<100;i++)
     rType[i]='\0';
     
            currScope--;

                struct node* nodechild[8] ;fillarr(nodechild,8);
                
                struct  node* iden = malloc(sizeof(struct node)) ;
                strcpy(iden->token ,"IDENTIFIER");cc(iden);
                struct node* chd = malloc(sizeof(struct node));strcpy(chd->token,$2.sval);cc(chd);  
                iden->child[0] = malloc(sizeof(struct node));
                iden->child[0] = chd;
                struct  node* lb = malloc(sizeof(struct node)) ;strcpy(lb->token, "(");cc(lb);
                struct  node* rb = malloc(sizeof(struct node)) ;strcpy(rb->token ,")");cc(rb);
                struct  node* llb = malloc(sizeof(struct node));strcpy(llb->token , "{") ;cc(llb);
                struct  node* rrb = malloc(sizeof(struct node));strcpy(rrb -> token , "}") ;cc(rrb);
                nodechild[0] = $1.nd; nodechild[1] = iden;nodechild[2] = lb;
                nodechild[3] = $5.nd;
                nodechild[4] =rb; nodechild[5] = llb;nodechild[6] = $8.nd;nodechild[7] = rrb;
                $$.nd = mknode(nodechild, 8, "func");

        }
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
 
params  :   %empty {$$.nd=malloc(sizeof(struct node));$$.nd = NULL;}
        |  param params1 {
                struct node* arr[2];fillarr(arr,2);
                arr[0] = $1.nd;
                arr[1] = $2.nd;
                $$.nd = mknode(arr,2,"params");                
        }
        ;
 
params1 : %empty   {$$.nd=malloc(sizeof(struct node)); $$.nd = NULL;}
        | ',' param params1{
                struct node* arr[3];fillarr(arr,3);
                struct node* commanode = malloc(sizeof(struct node)) ;strcpy(commanode->token,",");cc(commanode);
                arr[0] = commanode;
                arr[1] = $2.nd;
                arr[2] = $3.nd;
                $$.nd = mknode(arr,3,"params1");
        }
        ;
 
param   : datatype IDENTIFIER {
                $$.type = calloc(10, 1);strcpy($$.type, $1.type);
 
                $2.type = calloc(10, 1);strcpy($2.type, $1.type);
                
            add_var($2.sval,1,$2.type,0);

            funcs[funcCount].types[funcs[funcCount].count]=calloc(10,1);
            strcpy(funcs[funcCount].types[funcs[funcCount].count],$1.type);
            funcs[funcCount].count=funcs[funcCount].count+1;
    //      
            struct node* arr[2];fillarr(arr,2);
            arr[0] = $1.nd;
            struct node* idennode = malloc(sizeof(struct node));cc(idennode);strcpy(idennode->token,"IDENTIFIER");
            struct node* idenchild = malloc(sizeof(struct node));cc(idenchild);strcpy(idenchild->token,$2.sval);
            idennode -> child[0] = malloc(sizeof(struct node));
            idennode -> child[0] = idenchild;

            arr[1] = idennode;
            
            $$.nd = mknode(arr,2,"param");
        }
        ;
 
statements  :   %empty { $$.nd=malloc(sizeof(struct node)); $$.nd = NULL; }       
            |   statement statements{
                struct node* arr[2];
                fillarr(arr,2);
                arr[0] = $1.nd;arr[1] = $2.nd;
                $$.nd = mknode(arr,2,"statements");
            }
            ;
 
statement : ifStatement {
                struct node* arr[1];
                fillarr(arr,1);
                arr[0] = $1.nd;
                $$.nd = mknode(arr,1,"statement");
          }
          |nonIfStatement{
                struct node* arr[1];fillarr(arr,1);
                arr[0] = $1.nd;
                $$.nd = mknode(arr,1,"statement");
          }
          ;
 
nonIfStatement: switchStatement {
                struct node* arr[1];fillarr(arr,1);
                arr[0] = $1.nd;
                $$.nd = mknode(arr,1,"nonIfStatement");
                }
                |forStatement {
                struct node* arr[1];fillarr(arr,1);
                arr[0] = $1.nd;
                $$.nd = mknode(arr,1,"nonIfStatement");
                }
                |whileStatement {
                struct node* arr[1];fillarr(arr,1);
                arr[0] = $1.nd;
                $$.nd = mknode(arr,1,"nonIfStatement");
                }
                
                |declarative ';' {
                struct node* arr[2];fillarr(arr,2);

                arr[0] = $1.nd;
                struct node* seminode = malloc(sizeof(struct node));cc(seminode);strcpy(seminode->token,";");
                arr[1] = seminode;

                $$.nd = mknode(arr,2,"nonIfStatement");
                }

                |assignment ';' {
                struct node* arr[2];fillarr(arr,2);

                arr[0] = $1.nd;
                struct node* seminode = malloc(sizeof(struct node));strcpy(seminode->token,";");cc(seminode);
                arr[1] = seminode;

                $$.nd = mknode(arr,2,"nonIfStatement");
                }

                |return {
                struct node* arr[1];fillarr(arr,1);
                arr[0] = $1.nd;

                $$.nd = mknode(arr,1,"nonIfStatement");
                }
                |jump {
                struct node* arr[1];fillarr(arr,1);
                arr[0] = $1.nd;

                $$.nd = mknode(arr,1,"nonIfStatement");
                }
                |compound {
                struct node* arr[1];fillarr(arr,1);
                arr[0] = $1.nd;

                $$.nd = mknode(arr,1,"nonIfStatement");
                }

                | printf ';' {
                struct node* arr[2];fillarr(arr,2);

                arr[0] = $1.nd;
                struct node* seminode = malloc(sizeof(struct node));strcpy(seminode->token,";");cc(seminode);
                arr[1] = seminode;

                $$.nd = mknode(arr,2,"nonIfStatement");
                }
            ;
 
ifStatement : ifWithElse {
                struct node* arr[1];fillarr(arr,1);
                arr[0] = $1.nd;

                $$.nd = mknode(arr,1,"ifStatement");
        }
            | ifWithoutElse {
                struct node* arr[1];fillarr(arr,1);
                arr[0] = $1.nd;

                $$.nd = mknode(arr,1,"ifStatement");
            }
            ;
 
 ifWithoutElse   : IF '(' expression ')' statement {
                        struct node* arr[5];fillarr(arr,5);
                        struct node* ifnode = malloc(sizeof(struct node));strcpy(ifnode->token,"IF");cc(ifnode);
                        struct node* lb = malloc(sizeof(struct node));strcpy(lb->token,"(");cc(lb);
                        struct node* rb = malloc(sizeof(struct node));strcpy(rb->token,")");cc(rb);

                        arr[0] = ifnode;arr[1] = lb;arr[2] = $3.nd;arr[3] = rb;arr[4] = $5.nd;

                        $$.nd = mknode(arr,5,"ifWithoutElse");
                
                }
                | IF '(' expression ')' ';'{
                         struct node* arr[4];fillarr(arr,4);
                        struct node* ifnode = malloc(sizeof(struct node));strcpy(ifnode->token,"IF");cc(ifnode);
                        struct node* lb = malloc(sizeof(struct node));strcpy(lb->token,"(");cc(lb);
                        struct node* rb = malloc(sizeof(struct node));strcpy(rb->token,")");cc(rb);

                        arr[0] = ifnode;arr[1] = lb;arr[2] = $3.nd;arr[3] = rb;
             
                        $$.nd = mknode(arr,4,"ifWithoutElse");
                        
                }
                | IF '(' expression ')' ifWithElse ELSE ifWithoutElse{
                        struct node* arr[7];fillarr(arr,7);
                        struct node* ifnode = malloc(sizeof(struct node));strcpy(ifnode->token,"IF");cc(ifnode);
                        struct node* lb = malloc(sizeof(struct node));strcpy(lb->token,"(");cc(lb);
                        struct node* rb = malloc(sizeof(struct node));strcpy(rb->token,")");cc(rb);
                        arr[0] = ifnode;arr[1] = lb;arr[2] = $3.nd;arr[3] = rb;arr[4] = $5.nd;
                        struct node* elsenode = malloc(sizeof(struct node));strcpy(elsenode->token,"ELSE");cc(elsenode);
                        arr[5] = elsenode;arr[6] = $7.nd;
                        $$.nd = mknode(arr,7,"ifWithoutElse");
                        
                }
                ;
 
ifWithElse  : IF '(' expression ')' statement ELSE ifWithElse {
                   struct node* arr[7];fillarr(arr,7);
                   arr[2] = $3.nd;arr[4] = $5.nd;arr[6] = $7.nd;
                   
                   struct node* ifnode = malloc(sizeof(struct node));strcpy(ifnode->token,"IF");cc(ifnode);
                   struct node* lb = malloc(sizeof(struct node)); strcpy(lb->token,"("); cc(lb);
                   struct node* rb = malloc(sizeof(struct node)); strcpy(rb->token,")"); cc(rb);
                   struct node* elsenode = malloc(sizeof(struct node)); strcpy(elsenode->token,"ELSE"); cc(elsenode);
                   arr[0] = ifnode;arr[1] = lb;arr[3] = rb;arr[5] = elsenode;

                   $$.nd = mknode(arr,7,"ifWithElse");
                }
             | nonIfStatement {
                struct node* arr[1];fillarr(arr,1);
                arr[0] = $1.nd;

                $$.nd = mknode(arr,1,"ifWithElse");
                }
            ;

jump:   BREAK ';' {

                struct node* arr[2];fillarr(arr,2);
                struct node* breaknode = malloc(sizeof(struct node));strcpy(breaknode->token,"BREAK");cc(breaknode);
                struct node* scnode = malloc(sizeof(struct node));strcpy(scnode->token,";");cc(scnode);
                arr[0] = breaknode ; arr[1] = scnode;
                $$.nd = mknode(arr,2,"jump");

        }
    |   CONTINUE ';' {

                struct node* arr[2];fillarr(arr,2);
                struct node* contnode = malloc(sizeof(struct node));strcpy(contnode->token,"CONTINUE");cc(contnode);
                struct node* scnode = malloc(sizeof(struct node));strcpy(scnode->token,";");cc(scnode);
                arr[0] = contnode; arr[1] = scnode;
                $$.nd = mknode(arr,2,"jump");
        }
    ;
 
return: RETURN NUM ';' {
        rFlag=1; strcpy(rType,"int");
        struct node* arr[3];fillarr(arr,3);
        struct node* returnnode = malloc(sizeof(struct node));strcpy(returnnode->token,"RETURN");cc(returnnode);
        struct node* numnode = malloc(sizeof(struct node));strcpy(numnode->token,"NUM");cc(numnode);
          
        struct node* numchild = malloc(sizeof(struct node));cc(numchild);strcpy(numchild->token,$2.sval);
        numnode->child[0] = malloc(sizeof(struct node));
        numnode->child[0] = numchild;

        struct node* scnode = malloc(sizeof(struct node));strcpy(scnode->token,";");cc(scnode);
        arr[0] = returnnode;arr[1] = numnode;arr[2] = scnode;
        
        $$.nd = mknode(arr,3,"return");
        }
      | RETURN FLOATNUM ';'   {
        rFlag=1; strcpy(rType,"float");
         struct node* arr[3];fillarr(arr,3);
        struct node* returnnode = malloc(sizeof(struct node));strcpy(returnnode->token,"RETURN");cc(returnnode);
         struct node* floatnode = malloc(sizeof(struct node));strcpy(floatnode->token,"FLOATNUM");cc(floatnode);

        struct node* floatchild = malloc(sizeof(struct node));cc(floatnode);strcpy(floatchild->token,$2.sval);
        floatnode->child[0] = malloc(sizeof(struct node));
        floatnode->child[0] = floatchild;
        struct node* scnode = malloc(sizeof(struct node));strcpy(scnode->token,";");cc(scnode);
        arr[0] = returnnode;arr[1] = floatnode;arr[2] = scnode;

        $$.nd = mknode(arr,3,"return");
      }
      | RETURN ';' {
        rFlag=1;
         struct node* arr[2];fillarr(arr,2);
        struct node* returnnode = malloc(sizeof(struct node));strcpy(returnnode->token,"RETURN");cc(returnnode);
        struct node* scnode = malloc(sizeof(struct node));strcpy(scnode->token,";");cc(scnode);

        arr[0] = returnnode;arr[1] = scnode;
        $$.nd = mknode(arr,2,"return");
      }
      | RETURN CHARLIT ';' {
        rFlag=1; strcpy(rType,"char");
         struct node* arr[3];fillarr(arr,3);
        struct node* returnnode = malloc(sizeof(struct node));strcpy(returnnode->token,"RETURN");cc(returnnode);
         struct node* charnode = malloc(sizeof(struct node));strcpy(charnode->token,"CHARLIT");cc(charnode);

         struct  node* cch = malloc(sizeof(struct node));
        strcpy(cch->token,$2.sval);cc(cch);
        charnode->child[0] = malloc(sizeof(struct node));
        charnode->child[0]=cch;
         
        struct node* scnode = malloc(sizeof(struct node));strcpy(scnode->token,";");cc(scnode);
        arr[0] = returnnode;arr[1] = charnode;arr[2] = scnode;

        $$.nd = mknode(arr,3,"return");
      }
      | RETURN expression ';' {
        rFlag=1; strcpy(rType,"$2.type");
        struct node* arr[3];fillarr(arr,3);
        struct node* returnnode = malloc(sizeof(struct node));strcpy(returnnode->token,"RETURN");cc(returnnode);
        struct node* scnode = malloc(sizeof(struct node));strcpy(scnode->token,";");cc(scnode);
        arr[0] = returnnode;arr[1] = $2.nd;arr[2] = scnode;

        $$.nd = mknode(arr,3,"return");
      }
      ;
 
compound: '{' {if(forFlag==0)currScope++;} statements '}' {
        for(int i=0;i<count;i++)
        {
                if(symbol_table[i].scope==currScope)
                strcpy(symbol_table[i].id_name,"");
        }
        if(forFlag==0)currScope--;
        struct node* arr[3];fillarr(arr,3);
        struct node* lb = malloc(sizeof(struct node));strcpy(lb->token,"{");cc(lb);
        struct node* rb = malloc(sizeof(struct node));strcpy(rb->token,"}");cc(rb);
        arr[0] = lb;arr[1] = $3.nd;arr[2] = rb;

        $$.nd = mknode(arr,3,"compound");
        }
        ;
 
 expression  :   '!' expression {
                $$.type = calloc(10, 1);
                strcpy($$.type, $2.type);
                struct node* arr[2];fillarr(arr,2);
                arr[1] = $2.nd;
                struct node* notnode = malloc(sizeof(struct node));strcpy(notnode->token,"!");cc(notnode);
                arr[0] = notnode;
                $$.nd = mknode(arr,2,"expression");
        }
        |   expression operator expression  {
                if(strcmp($1.type,$3.type) == 0) strcpy($$.type, $1.type);
                else if ((strcmp($1.type,"int") == 0 && strcmp($3.type,"float")==0 )|| (strcmp($3.type,"int") == 0 && strcmp($1.type,"float")==0 )){
                        strcpy($$.type,"float");
                }
                else{
                        printf("Semantic error1: invalid type combination of expressions\n");
                        exit(1);
                }
                struct node* arr[3];fillarr(arr,3);
                arr[0] = $1.nd;arr[1] = $2.nd;arr[2] = $3.nd;
                $$.nd = mknode(arr,3,"expression");
        }
        |   exprOperand  { 
                $$.type = calloc(10, 1);
                strcpy($$.type, $1.type);
                
                struct node* arr[1]; fillarr(arr,1);arr[0] = $1.nd;
                $$.nd = mknode(arr,1,"expression");
        }
            |   '(' expression  ')' {
                $$.type = calloc(10, 1);strcpy($$.type, $2.type);
                struct node* arr[3];fillarr(arr,3);
                arr[1] = $2.nd;
                struct node* lb = malloc(sizeof(struct node));strcpy(lb->token,"(");cc(lb);
                struct node* rb = malloc(sizeof(struct node));strcpy(rb->token,"(");cc(rb);
                arr[0] = lb; arr[2] = rb;
                $$.nd = mknode(arr,3,"expression");
        }
        ;
 
operator    :   '+' {struct node* nodd = malloc(sizeof(struct node));strcpy(nodd->token,"+");cc(nodd);struct node* arr[1];arr[0] = nodd; $$.nd = mknode(arr,1,"operator"); }
                |'-' {struct node* nodd = malloc(sizeof(struct node));strcpy(nodd->token,"-");cc(nodd);struct node* arr[1];arr[0] = nodd; $$.nd = mknode(arr,1,"operator"); }
                |'*' {struct node* nodd = malloc(sizeof(struct node));strcpy(nodd->token,"*");cc(nodd);struct node* arr[1];arr[0] = nodd; $$.nd = mknode(arr,1,"operator"); }
                |'/' {struct node* nodd = malloc(sizeof(struct node));strcpy(nodd->token,"/");cc(nodd);struct node* arr[1];arr[0] = nodd; $$.nd = mknode(arr,1,"operator"); }
                |'%' {struct node* nodd = malloc(sizeof(struct node));strcpy(nodd->token,"%");cc(nodd);struct node* arr[1];arr[0] = nodd; $$.nd = mknode(arr,1,"operator"); }
                |'>' {struct node* nodd = malloc(sizeof(struct node));strcpy(nodd->token,">");cc(nodd);struct node* arr[1];arr[0] = nodd; $$.nd = mknode(arr,1,"operator"); }
                |'<' {struct node* nodd = malloc(sizeof(struct node));strcpy(nodd->token,"<");cc(nodd);struct node* arr[1];arr[0] = nodd; $$.nd = mknode(arr,1,"operator"); }
                |GE {struct node* nodd = malloc(sizeof(struct node));strcpy(nodd->token,"GE");cc(nodd);struct node* arr[1];arr[0] = nodd; $$.nd = mknode(arr,1,"operator"); }
                |LE {struct node* nodd = malloc(sizeof(struct node));strcpy(nodd->token,"LE");cc(nodd);struct node* arr[1];arr[0] = nodd; $$.nd = mknode(arr,1,"operator"); }
                |EQ {struct node* nodd = malloc(sizeof(struct node));strcpy(nodd->token,"EQ");cc(nodd);struct node* arr[1];arr[0] = nodd; $$.nd = mknode(arr,1,"operator"); }
                |NE {struct node* nodd = malloc(sizeof(struct node));strcpy(nodd->token,"NE");cc(nodd);struct node* arr[1];arr[0] = nodd; $$.nd = mknode(arr,1,"operator"); }
                |OR {struct node* nodd = malloc(sizeof(struct node));strcpy(nodd->token,"OR");cc(nodd);struct node* arr[1];arr[0] = nodd; $$.nd = mknode(arr,1,"operator"); }
                |AND {
                        struct node* nodd = malloc(sizeof(struct node));
                        strcpy(nodd->token,"AND");cc(nodd);
                        struct node* arr[1];arr[0] = nodd; 
                        $$.nd = mknode(arr,1,"operator"); 
                }
                 
            ;
 
forStatement    :   FOR '(' forInit {currScope++; forFlag=0;} ';' loopexpr  ';' loopexpr  ')' statement {
                        currScope--; forFlag=0;
                        struct node* arr[9];fillarr(arr,9);
                        arr[2] = $3.nd;arr[4] = $6.nd;arr[6] = $8.nd;arr[8] = $10.nd;
                        struct node* fornode;strcpy(fornode->token,"FOR");cc(fornode); arr[0] = fornode;
                        struct node* lb;strcpy(lb->token,"(");cc(lb); arr[1] = lb;
                        struct node* sc;strcpy(sc->token,";");cc(sc); arr[3] = sc;
                        struct node* sc1;strcpy(sc1->token,";");cc(sc1); arr[5] = sc1;
                        struct node* rb;strcpy(rb->token,")");cc(rb); arr[7] = rb;
                        $$.nd = mknode(arr,9,"forStatement");
                }
                |   FOR '(' forInit ';' loopexpr  ';' loopexpr  ')' ';' {
                        struct node* arr[9];fillarr(arr,9);
                        arr[2] = $3.nd;arr[4] = $5.nd;arr[6] = $7.nd;
                        struct node* fornode=malloc(sizeof(struct node));strcpy(fornode->token,"FOR");cc(fornode); arr[0] = fornode;
                        struct node* lb=malloc(sizeof(struct node));strcpy(lb->token,"(");cc(lb); arr[1] = lb;
                        struct node* sc=malloc(sizeof(struct node));strcpy(sc->token,";");cc(sc); arr[3] = sc;
                        struct node* sc1=malloc(sizeof(struct node));strcpy(sc1->token,";");cc(sc1); arr[5] = sc1;
                        struct node* rb=malloc(sizeof(struct node));strcpy(rb->token,")");cc(rb); arr[7] = rb;
                        struct node* sc2=malloc(sizeof(struct node));strcpy(sc2->token,";");cc(sc2); 
                        arr[8] = sc2;
                        $$.nd = mknode(arr,9,"forStatement");
                }
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
 
 
 
loopexpr    : wloopexpr {
                $$.type = calloc(10, 1);
                strcpy($$.type, $1.type);
                struct node* arr[1];fillarr(arr,1);arr[0] = $1.nd; $$.nd = mknode(arr,1,"loopexpr");
        }
              | %empty {
                $$.type = calloc(10, 1);strcpy($$.type, "none");
                $$.nd=malloc(sizeof(struct node));
                $$.nd = NULL;
        }
        ;
            
wloopexpr       : expression {
                $$.type = calloc(10, 1);
                strcpy($$.type, $1.type);
                struct node* arr[1];fillarr(arr,1);arr[0] = $1.nd; $$.nd = mknode(arr,1,"wloopexpr");
        }
                | assignment {
                struct node* arr[1];fillarr(arr,1);arr[0] = $1.nd; $$.nd = mknode(arr,1,"wloopexpr");
                }
                ;
 
forInit :   %empty {$$.nd=malloc(sizeof(struct node)); $$.nd=NULL;}
        |  expression {
                struct node* arr[1];fillarr(arr,1);arr[0] = $1.nd; $$.nd = mknode(arr,1,"forInit");
        }
        |assignment {
                struct node* arr[1];fillarr(arr,1);arr[0] = $1.nd; $$.nd = mknode(arr,1,"forInit");
        }
        |declarative {
                struct node* arr[1];fillarr(arr,1);arr[0] = $1.nd; $$.nd = mknode(arr,1,"forInit");
        }
        ;                   
 
whileStatement: WHILE '(' wloopexpr ')' statement {
                   struct node* arr[5];fillarr(arr,5);
                   arr[2] = $3.nd;arr[4] = $5.nd;
                   struct node* wnode=malloc(sizeof(struct node));strcpy(wnode->token,"WHILE");cc(wnode);arr[0] = wnode;
                   struct node* lb=malloc(sizeof(struct node));strcpy(lb->token,"(");cc(lb);arr[1] = lb;
                   struct node* rb=malloc(sizeof(struct node));strcpy(rb->token,")");cc(rb);arr[3] = rb;
                   $$.nd = mknode(arr,5,"whileStatement");

                }
              | WHILE '(' wloopexpr ')' ';' {
                struct node* arr[5];fillarr(arr,5);
                   arr[2] = $3.nd;
                   struct node* wnode=malloc(sizeof(struct node));strcpy(wnode->token,"WHILE");cc(wnode);arr[0] = wnode;
                   struct node* lb=malloc(sizeof(struct node));strcpy(lb->token,"(");cc(lb);arr[1] = lb;
                   struct node* rb=malloc(sizeof(struct node));strcpy(rb->token,")");cc(rb);arr[3] = rb;
                   struct node* sc=malloc(sizeof(struct node));strcpy(sc->token,";");cc(sc);arr[4] = sc;
                   $$.nd = mknode(arr,5,"whileStatement");
              }
              /* | WHILE '(' wloopexpr ')' {
                struct node* arr[4];fillarr(arr,4);
                   arr[2] = $3.nd;
                   struct node* wnode=malloc(sizeof(struct node));strcpy(wnode->token,"WHILE");cc(wnode);arr[0] = wnode;
                   struct node* lb=malloc(sizeof(struct node));strcpy(lb->token,"(");cc(lb);arr[1] = lb;
                   struct node* rb=malloc(sizeof(struct node));strcpy(rb->token,")");cc(rb);arr[3] = rb;
                   $$.nd = mknode(arr,4,"whileStatement");
              } */
                ;
 
switchStatement :   SWITCH '(' switchexpr ')' '{' cases '}'    {

                        struct node* arr[7];fillarr(arr,7);
                        arr[2] = $3.nd;arr[5] = $6.nd;
                        struct node* sw=malloc(sizeof(struct node));strcpy(sw->token,"SWITCH");cc(sw);arr[0] = sw;
                        struct node* lb=malloc(sizeof(struct node));strcpy(lb->token,"(");cc(lb);arr[1] = lb;
                        struct node* rb=malloc(sizeof(struct node));strcpy(rb->token,")");cc(rb);arr[3] = rb;
                        struct node* llb=malloc(sizeof(struct node));strcpy(llb->token,"{");cc(llb);arr[4] = llb;
                        struct node* rrb=malloc(sizeof(struct node));strcpy(rrb->token,"}");cc(rrb);arr[5] = rrb;
                        $$.nd = mknode(arr,7,"switchStatement");
                }
 
switchexpr:  expression {
                struct node* arr[1];fillarr(arr,1);
                arr[0] = $1.nd; $$.nd = mknode(arr,1,"switchexpr");
        }
            | assignment {
                struct node* arr[1];fillarr(arr,1);
                arr[0] = $1.nd; $$.nd = mknode(arr,1,"switchexpr");
            }
            ;
            
cases   :   %empty {$$.nd=malloc(sizeof(struct node)); $$.nd=NULL;}
        | cases1 defaultCase cases1 {
                struct node* arr[3];fillarr(arr,3);
                arr[0] = $1.nd; arr[1] = $2.nd; arr[2] = $3.nd;
                $$.nd = mknode(arr,3,"cases");
        }
        | case cases {
                struct node* arr[2];fillarr(arr,2);
                arr[0] = $1.nd; arr[1] = $2.nd;
                $$.nd = mknode(arr,2,"cases");
        }
        | case {
                struct node* arr[1];fillarr(arr,1);
                arr[0] = $1.nd; $$.nd = mknode(arr,1,"cases");
        }
        ;
 
cases1   :   %empty {$$.nd=malloc(sizeof(struct node)); $$.nd=NULL;}
        | case cases1 {
                struct node* arr[2];fillarr(arr,2);
                arr[0] = $1.nd; arr[1] = $2.nd; 
                $$.nd = mknode(arr,2,"cases1");
        }
        | case {
                struct node* arr[1];fillarr(arr,1);
                arr[0] = $1.nd; 
                $$.nd = mknode(arr,1,"cases1");
        }
        ;
 
case    :   CASE  caseExpr ':' statements  {
                struct node* arr[4];fillarr(arr,4);
                arr[1] = $2.nd; arr[3] = $4.nd;
                struct node* casenode = malloc(sizeof(struct node));strcpy(casenode,"CASE");cc(casenode); 
                arr[0] = casenode;
                struct node* col = malloc(sizeof(struct node));strcpy(col,":");cc(col); arr[2] = col;

                $$.nd = mknode(arr,4,"case");
        }                  
        ;                      
 
defaultCase:  DEFAULT  ':' statements {
                struct node* arr[3];fillarr(arr,3);
                arr[2] = $3.nd;
                struct node* defnode = malloc(sizeof(struct node));strcpy(defnode,"DEFAULT");cc(defnode);arr[0] = defnode;
                struct node* defnode1 = malloc(sizeof(struct node));strcpy(defnode1,":");cc(defnode1);arr[1] = defnode1;
                $$.nd = mknode(arr,3,"defaultCase");
        }                          
 
caseExpr  :   '!' caseExpr {
                $$.type = calloc(10, 1); strcpy($$.type,$2.type);
                struct node* arr[2];fillarr(arr,2);arr[1] = $2.nd;
                struct node* notnode = malloc(sizeof(struct node));strcpy(notnode->token,"!");cc(notnode);
                arr[0] = notnode;
                $$.nd = mknode(arr,2,"caseExpr");
                }
            |   caseExpr operator caseExpr {
                $$.type = calloc(10, 1); strcpy($$.type,$1.type);
                struct node* arr[3];fillarr(arr,3);
                arr[0] = $1.nd;arr[1] = $2.nd; arr[2] = $3.nd;
                $$.nd = mknode(arr,3,"caseExpr");
            }
            |   NUM {
                $$.type = calloc(10, 1); strcpy($$.type,"int");int ival=atoi($1.sval); $$.val=ival; 
                struct node* arr[1];fillarr(arr,1);
                struct node* numnode = malloc(sizeof(struct node));strcpy(numnode->token,"NUM");cc(numnode);
                struct node* numchild = malloc(sizeof(struct node));
                cc(numchild);
                strcpy(numchild->token,$1.sval);
                numnode->child[0] = malloc(sizeof(struct node));
                numnode->child[0] = numchild;
                arr[0] = numnode; $$.nd = mknode(arr,1,"caseExpr");
           } 
            |   '(' caseExpr  ')' {
                $$.type = calloc(10, 1); strcpy($$.type,$2.type); 
                struct node* arr[3]; arr[1] = $2.nd;
                struct node* lb = malloc(sizeof(struct node));strcpy(lb->token,"(");cc(lb); arr[0] = lb;
                struct node* rb = malloc(sizeof(struct node));strcpy(rb->token,")");cc(rb); arr[2] = rb;
                $$.nd = mknode(arr,3,"caseExpr");
            }
            ;        
 
assignment  : var '=' expression {
                if(strcmp($1.type,"float") == 0&&strcmp($3.type,"int")==0){
                }
                else if(strcmp($1.type,$3.type)==0){}
                else{
                        // printf("Expected: %s\n",$1.type);
                        // printf("Assigned: %s\n",$3.type);
                        printf("Semantic Error1: Expected Type and Assigned Types are different\n");
                        exit(1);  
                }

                struct node* arr[3];fillarr(arr,3);arr[0] = $1.nd;arr[2] = $3.nd;
                struct node* eqnode = malloc(sizeof(struct node));strcpy(eqnode->token,"=");cc(eqnode);
                arr[1] = eqnode; $$.nd = mknode(arr,3,"assignment");
                }
            ;
 
declarative  :  type list  {
 
        if(declareFlag == 1)
        {
                if(strcmp($1.type,$2.type) == 0){
                        
                }
                else if(strcmp($1.type,"float")==0&&strcmp($2.type,"int")==0){
                        for(int i=count-1;i>=0;i--)
                        {
                                if(symbol_table[i].flag!=10)
                                break;
                                else 
                                {
                                        strcpy(symbol_table[i].data_type,"float");
                                }
                        }
                }
                else{
                        // printf("Lolz dhanush\n");
                        // printf("Here-> %s and %s\n",$1.type,$2.type);
                   printf("Semantic Error: Expected Type and Assigned Types are different\n");
                   exit(1);     
                }
        }
        else{
           adjust_var($1.type);     
        }
        $$.type = calloc(10, 1);
        strcpy($$.type,$1.type); 
         declareFlag = 0;
        struct node* arr[2];fillarr(arr,2);
        arr[0] = $1.nd;arr[1] = $2.nd; $$.nd = mknode(arr,2,"declarative");
        } 
        ;

list :  listEntry {
                struct node* nodechild[1] ; fillarr(nodechild,1);
                nodechild[0]=$1.nd;
                $$.nd = mknode(nodechild, 1, "list");
                if(declareFlag==1){$$.type=calloc(10,1); strcpy($$.type,$1.type);}}
       | listEntry ',' list {
                struct node* nodechild[3] ;
                 fillarr(nodechild,3);
                 nodechild[0]=$1.nd;
                struct  node* lbrack = malloc(sizeof(struct node)) ;strcpy(lbrack->token, ",");cc(lbrack);
                nodechild[1] = lbrack;nodechild[2]=$3.nd;
                $$.nd = mknode(nodechild, 3, "list");
                if(declareFlag==1){$$.type=calloc(10,1); strcpy($$.type,$1.type);}}
        ;
        
listEntry   :IDENTIFIER '[' cIndex ']' '=' STRINGLIT  { 
        
               struct node* nodechild[6] ;fillarr(nodechild,6);
                 
               struct  node* lbrack = malloc(sizeof(struct node));strcpy(lbrack->token, "IDENTIFIER");cc(lbrack);
               struct node* idenchild = malloc(sizeof(struct node));cc(idenchild); strcpy(idenchild->token,$1.sval);
               lbrack->child[0] = malloc(sizeof(struct node));
               lbrack->child[0] = idenchild;nodechild[0] = lbrack;

                struct  node* lbrac = malloc(sizeof(struct node)) ;strcpy(lbrac->token, "[");cc(lbrac);
                nodechild[1] = lbrac;nodechild[2]=$3.nd;
                struct  node* lbra= malloc(sizeof(struct node)) ;strcpy(lbra->token, "]");cc(lbra);
                nodechild[3] = lbra;
                struct  node* eq = malloc(sizeof(struct node)) ;strcpy(eq->token, "=");cc(eq);
                nodechild[4] = eq;
                struct  node* st = malloc(sizeof(struct node)) ;
                strcpy(st->token, "STRINGLIT");cc(st);
                struct  node* ssch = malloc(sizeof(struct node));strcpy(ssch->token,$6.sval);cc(ssch);
                st->child[0] = malloc(sizeof(struct node));
                st->child[0]=ssch;
                nodechild[5] = st;
                $$.nd = mknode(nodechild, 6, "listEntry");
                add_var($1.sval,1,"char",0); $$.type=calloc(10,1); strcpy($$.type,"char"); declareFlag=1;
        } 

        | IDENTIFIER '[' expression ']'  '=' STRINGLIT {

                if(strcmp($3.type,"int")!=0){
                            printf("Semantic error: Datatype of array index invalid");
                            exit(1);
                    }
                    add_var($1.sval,1,"char",0); $$.type=calloc(10,1); strcpy($$.type,"char"); declareFlag=1;
                
                struct node* nodechild[6] ;fillarr(nodechild,6);
                struct  node* lbrack = malloc(sizeof(struct node)) ;strcpy(lbrack->token, "IDENTIFIER");cc(lbrack);
                struct node* idenchild = malloc(sizeof(struct node));cc(idenchild);strcpy(idenchild->token,$1.sval);
                lbrack->child[0] = malloc(sizeof(struct node));
                lbrack->child[0] = idenchild;
                nodechild[0] = lbrack;
                struct  node* lbrac = malloc(sizeof(struct node)) ;strcpy(lbrac->token, "[");cc(lbrac);
                nodechild[1] = lbrac;nodechild[2]=$3.nd;
                struct  node* lbra= malloc(sizeof(struct node)) ;strcpy(lbra->token, "]");cc(lbra);
                nodechild[3] = lbra;
                struct  node* eq = malloc(sizeof(struct node)) ;strcpy(eq->token, "=");cc(eq);
                nodechild[4] = eq;
                struct  node* st = malloc(sizeof(struct node)) ;strcpy(st->token, "STRINGLIT");cc(st);
                struct  node* ssch = malloc(sizeof(struct node));strcpy(ssch->token,$6.sval);cc(ssch);
                st->child[0] = malloc(sizeof(struct node));
                st->child[0]=ssch;nodechild[5] = st;

               $$.nd = mknode(nodechild, 6, "listEntry");
        }

        | IDENTIFIER '['  ']'  '=' STRINGLIT {
        struct node* nodechild[5] ;fillarr(nodechild,5);
                 
        struct  node* lbrack = malloc(sizeof(struct node)) ;strcpy(lbrack->token, "IDENTIFIER");cc(lbrack);
        struct node* idenchild = malloc(sizeof(struct node));cc(idenchild);strcpy(idenchild->token,$1.sval);
        lbrack->child[0] = malloc(sizeof(struct node));
        lbrack -> child[0] = idenchild;nodechild[0] = lbrack;

        struct  node* lbrac = malloc(sizeof(struct node)) ;strcpy(lbrac->token, "[");cc(lbrac);
        nodechild[1] = lbrac;
        struct  node* lbra= malloc(sizeof(struct node)) ;strcpy(lbra->token, "]");cc(lbra);
        nodechild[2] = lbra;
        struct  node* eq = malloc(sizeof(struct node)) ;strcpy(eq->token, "=");cc(eq);
        nodechild[3] = eq;
        struct  node* st = malloc(sizeof(struct node)) ;
        strcpy(st->token, "STRINGLIT");cc(st);
        struct  node* ssch = malloc(sizeof(struct node));
        strcpy(ssch->token,$5.sval);cc(ssch);
        st->child[0] = malloc(sizeof(struct node));
        st->child[0]=ssch;
        nodechild[4] = st;
        $$.nd = mknode(nodechild, 5, "listEntry");   
        add_var($1.sval,1,"char",0); $$.type=calloc(10,1); strcpy($$.type,"char"); 
        declareFlag=1;
        }
        | IDENTIFIER '[' expression ']' '[' expression ']'  '=' '{' STRINGLIT '}' {


                struct node* nodechild[11] ;fillarr(nodechild,11);
                struct  node* lbrack = malloc(sizeof(struct node)) ;strcpy(lbrack->token, "IDENTIFIER");cc(lbrack);
               struct node* idenchild = malloc(sizeof(struct node));cc(idenchild);strcpy(idenchild->token,$1.sval);
               lbrack->child[0] = malloc(sizeof(struct node));
               lbrack->child[0] = idenchild;nodechild[0] = lbrack;
                struct  node* lbrac = malloc(sizeof(struct node)) ;strcpy(lbrac->token, "[");cc(lbrac);
        

                nodechild[1] = lbrac;nodechild[2]=$3.nd;
                struct  node* lbra= malloc(sizeof(struct node)) ;strcpy(lbra->token, "]");cc(lbra);
                nodechild[3] = lbra;
                struct  node* e1 = malloc(sizeof(struct node)) ;
                strcpy(e1->token, "[");cc(e1);
                nodechild[4] = e1;nodechild[5]=$6.nd;
                struct  node* e2= malloc(sizeof(struct node)) ;
                strcpy(e2->token, "]");cc(e2);
                nodechild[6] = e2;
                struct  node* eq = malloc(sizeof(struct node)) ;
                strcpy(eq->token, "=");
                cc(eq);
                nodechild[7] = eq;
                

                struct  node* st = malloc(sizeof(struct node)) ;
                strcpy(st->token, "STRINGLIT");cc(st);
               
               struct  node* ssch = malloc(sizeof(struct node));strcpy(ssch->token,$10.sval);cc(ssch);
               st->child[0] = malloc(sizeof(struct node));
               st->child[0]=ssch;
                nodechild[9] = st;

                struct  node* lcur= malloc(sizeof(struct node)) ;
                strcpy(lcur->token, "{");cc(lcur);
                nodechild[8] = lcur;
                struct  node* rcur= malloc(sizeof(struct node)) ;
                strcpy(lcur->token, "}");cc(lcur);
                nodechild[10] = rcur;

                
               $$.nd = mknode(nodechild, 11, "listEntry");

                if(strcmp($3.type,"int")!=0){
                        printf("Semantic error: Datatype of array index invalid");
                        exit(1);
                }
                if(strcmp($6.type,"int")!=0){
                        printf("Semantic error: Datatype of array index invalid");
                        exit(1);
                }
                add_var($1.sval,1,"char",0); $$.type=calloc(10,1); strcpy($$.type,"char"); declareFlag=1;
        }
            | IDENTIFIER '['  ']' '[' expression ']'  '=' '{' STRINGLIT '}' {

                struct node* nodechild[10] ;fillarr(nodechild,10);
                struct  node* lbrack = malloc(sizeof(struct node)) ;strcpy(lbrack->token, "IDENTIFIER");cc(lbrack);


               struct node* idenchild = malloc(sizeof(struct node));cc(idenchild);strcpy(idenchild->token,$1.sval);
                lbrack->child[0] = malloc(sizeof(struct node));
                lbrack->child[0] = idenchild;nodechild[0] = lbrack;
                struct  node* lbrac = malloc(sizeof(struct node)) ;strcpy(lbrac->token, "[");cc(lbrac);
                nodechild[1] = lbrac;
                struct  node* lbra= malloc(sizeof(struct node)) ;strcpy(lbra->token, "]");cc(lbra);
                nodechild[2] = lbra;
                struct  node* e1 = malloc(sizeof(struct node)) ;strcpy(e1->token, "[");cc(e1);
                nodechild[3] = e1;nodechild[4]=$5.nd;
                struct  node* e2= malloc(sizeof(struct node)) ;
                strcpy(e2->token, "]");cc(e2);
                nodechild[5] = e2;
                struct  node* eq = malloc(sizeof(struct node)) ;strcpy(eq->token, "="); cc(eq);
                
                nodechild[6] = eq;
                struct  node* st = malloc(sizeof(struct node)) ;strcpy(st->token, "STRINGLIT");cc(st);
                struct  node* ssch = malloc(sizeof(struct node));strcpy(ssch->token,$9.sval);cc(ssch);
                  st->child[0] = malloc(sizeof(struct node));
                st->child[0]=ssch;nodechild[8] = st;

                struct  node* lcur= malloc(sizeof(struct node)) ;
                strcpy(lcur->token, "{");cc(lcur);
                nodechild[7] = lcur;
                struct  node* rcur= malloc(sizeof(struct node)) ;
                strcpy(lcur->token, "}");cc(lcur);
                nodechild[9] = rcur;




               $$.nd = mknode(nodechild, 10, "listEntry");
                if(strcmp($5.type,"int")!=0){
                        printf("Semantic error: Datatype of array index invalid");
                        exit(1);
                }
                add_var($1.sval,1,"char",0); $$.type=calloc(10,1); strcpy($$.type,"char"); declareFlag=1;}
            
            | IDENTIFIER {

                   struct node* nodechild[1] ;
                    fillarr(nodechild,1);
                   struct  node* lbrack = malloc(sizeof(struct node)) ;
                   strcpy(lbrack->token, "IDENTIFIER");cc(lbrack);
                struct node* idenchild = malloc(sizeof(struct node));cc(idenchild);strcpy(idenchild->token,$1.sval);
                lbrack->child[0] = malloc(sizeof(struct node));
                lbrack->child[0] = idenchild;
        
                nodechild[0] = lbrack;
                $$.nd = mknode(nodechild, 1, "listEntry");
                add_var($1.sval,0,"NULL",0);}
        | IDENTIFIER '[' expression  ']' {
                struct node* nodechild[4] ;fillarr(nodechild,4);
                struct  node* lbrack = malloc(sizeof(struct node)) ;strcpy(lbrack->token, "IDENTIFIER");cc(lbrack);
        
              struct node* idenchild = malloc(sizeof(struct node));cc(idenchild);strcpy(idenchild->token,$1.sval);
              lbrack->child[0] = malloc(sizeof(struct node));
              lbrack->child[0] = idenchild;nodechild[0] = lbrack;
                struct  node* lbrac = malloc(sizeof(struct node)) ;strcpy(lbrac->token, "[");cc(lbrac);
        

               nodechild[1] = lbrac;nodechild[2]=$3.nd;
                struct  node* lbra= malloc(sizeof(struct node)) ;strcpy(lbra->token, "]");cc(lbra);
                nodechild[3] = lbra;$$.nd = mknode(nodechild, 4, "listEntry");

                if(strcmp($3.type,"int")!=0){
                        printf("Semantic error: Datatype of array index invalid");
                        exit(1);
                }
                add_var($1.sval,0,"NULL",0);
        }
            | IDENTIFIER '[' expression ']' '[' expression ']' {
                struct node* nodechild[7] ;fillarr(nodechild,7);
                struct  node* lbrack = malloc(sizeof(struct node)) ;
                strcpy(lbrack->token, "IDENTIFIER");cc(lbrack);
                struct node* idenchild = malloc(sizeof(struct node));cc(idenchild);strcpy(idenchild->token,$1.sval);
                lbrack->child[0] = malloc(sizeof(struct node));
                lbrack->child[0] = idenchild;nodechild[0] = lbrack;
                struct  node* lbrac = malloc(sizeof(struct node)) ;strcpy(lbrac->token, "[");cc(lbrac);
                nodechild[1] = lbrac;nodechild[2]=$3.nd;
                struct  node* lbra= malloc(sizeof(struct node)) ;strcpy(lbra->token, "]");cc(lbra);
                nodechild[3] = lbra;struct  node* e1 = malloc(sizeof(struct node)) ;strcpy(e1->token, "[");cc(e1);
        

               nodechild[4] = e1;nodechild[5]=$6.nd;
                struct  node* e2= malloc(sizeof(struct node)) ;strcpy(e2->token, "]");cc(e2);
                nodechild[6] = e2;
                
                $$.nd = mknode(nodechild, 7, "listEntry");

                if(strcmp($3.type,"int")!=0){
                        printf("Semantic error: Datatype of array index invalid");
                        exit(1);
                }
                add_var($1.sval,0,"NULL",0);}

        | IDENTIFIER '[' expression  ']' '=' '{' valueList '}' {
                 struct node* nodechild[8] ;fillarr(nodechild,8);
                struct  node* lbrack = malloc(sizeof(struct node)) ;strcpy(lbrack->token, "IDENTIFIER");cc(lbrack);
                  struct node* idenchild = malloc(sizeof(struct node));cc(idenchild);strcpy(idenchild->token,$1.sval);
                lbrack->child[0] = malloc(sizeof(struct node));
                lbrack->child[0] = idenchild;
                nodechild[0] = lbrack;
                struct  node* lbrac = malloc(sizeof(struct node)) ;
                strcpy(lbrac->token, "[");cc(lbrac);
                nodechild[1] = lbrac;
                nodechild[2]=$3.nd;
                struct  node* lbra= malloc(sizeof(struct node)) ;strcpy(lbra->token, "]");cc(lbra);
                nodechild[3] = lbra;struct  node* eq= malloc(sizeof(struct node)) ;
                strcpy(eq->token, "=");cc(eq);
                nodechild[4] = eq;

                struct  node* lcur= malloc(sizeof(struct node)) ;
                strcpy(lcur->token, "{");cc(lcur);
                nodechild[5] = lcur;nodechild[6]=$7.nd;
                struct  node* rcur= malloc(sizeof(struct node)) ;strcpy(rcur->token, "}");cc(rcur);
                nodechild[7] = rcur;$$.nd = mknode(nodechild, 8, "listEntry");

                if(strcmp($3.type,"int")!=0){
                        printf("Semantic error: Datatype of array index invalid");
                        exit(1);
                }
                add_var($1.sval,1,$7.type,10); $$.type=calloc(10,1); strcpy($$.type,$7.type); declareFlag=1;}
        | IDENTIFIER '['  ']' '=' '{' valueList '}' {
                struct node* nodechild[7] ;
                 fillarr(nodechild,7);
                struct  node* lbrack = malloc(sizeof(struct node)) ;strcpy(lbrack->token, "IDENTIFIER");
                cc(lbrack);
                struct node* idenchild = malloc(sizeof(struct node));cc(idenchild);strcpy(idenchild->token,$1.sval);
                lbrack->child[0] = malloc(sizeof(struct node));
                lbrack->child[0] = idenchild;
                nodechild[0] = lbrack;
                struct  node* lbrac = malloc(sizeof(struct node)) ;strcpy(lbrac->token, "[");cc(lbrac);
                nodechild[1] = lbrac;
                struct  node* lbra= malloc(sizeof(struct node)) ;strcpy(lbra->token, "]");cc(lbra);
                nodechild[2] = lbra;
                struct  node* eq= malloc(sizeof(struct node)) ;strcpy(eq->token, "=");cc(eq);
                nodechild[3] = eq;
                struct  node* lcur= malloc(sizeof(struct node)) ;
                strcpy(lcur->token, "{");cc(lcur);
                nodechild[4] = lcur;nodechild[5]=$6.nd;struct  node* rcur= malloc(sizeof(struct node)) ;
                strcpy(rcur->token, "}");cc(rcur);
                nodechild[6] = rcur;
                $$.nd = mknode(nodechild, 7, "listEntry");
                add_var($1.sval,1,$6.type,10); $$.type=calloc(10,1); strcpy($$.type,$6.type); declareFlag=1;}
        | IDENTIFIER '[' expression ']' '[' expression ']' '='  '{' valueList '}' {
                struct node* nodechild[11] ;fillarr(nodechild,11);
                struct  node* lbrack = malloc(sizeof(struct node)) ;strcpy(lbrack->token, "IDENTIFIER");
                cc(lbrack);
                struct node* idenchild = malloc(sizeof(struct node));cc(idenchild);strcpy(idenchild->token,$1.sval);
                lbrack->child[0] = malloc(sizeof(struct node));
                lbrack->child[0] = idenchild;
                nodechild[0] = lbrack;
                struct  node* lbrac = malloc(sizeof(struct node)) ;strcpy(lbrac->token, "[");
                cc(lbrac);
                nodechild[1] = lbrac;nodechild[2]=$3.nd;
                struct  node* lbra= malloc(sizeof(struct node)) ;strcpy(lbra->token, "]");cc(lbra);
                nodechild[3] = lbra;
                struct  node* e1 = malloc(sizeof(struct node)) ;strcpy(e1->token, "[");cc(e1);
                nodechild[4] = e1;nodechild[5]=$6.nd;
                struct  node* e2= malloc(sizeof(struct node)) ;strcpy(e2->token, "]");cc(e2);
                nodechild[6] = e2;
                struct  node* eq= malloc(sizeof(struct node)) ;
                strcpy(eq->token, "=");cc(eq);
                nodechild[7] = eq;
                struct  node* lc= malloc(sizeof(struct node)) ; strcpy(lc->token, "{");cc(lc);
                nodechild[8] = lc;nodechild[9] = $10.nd;
                struct  node* rcu= malloc(sizeof(struct node)) ;
                strcpy(rcu->token, "}");cc(rcu);
                nodechild[10] = rcu;

                $$.nd = mknode(nodechild, 11, "listEntry");
                if(strcmp($3.type,"int")!=0){
                        printf("Semantic error: Datatype of array index invalid");
                        exit(1);
                }
                if(strcmp($6.type,"int")!=0){
                        printf("Semantic error: Datatype of array index invalid");
                        exit(1);
                }
                add_var($1.sval,1,$10.type,10); $$.type=calloc(10,1); strcpy($$.type,$10.type); declareFlag=1;
        }
            | IDENTIFIER '['  ']' '[' expression ']' '=' '{' valueList '}' {
                
                struct node* nodechild[10] ;fillarr(nodechild,10);
                struct  node* lbrack = malloc(sizeof(struct node)) ;strcpy(lbrack->token, "IDENTIFIER");cc(lbrack);
                struct node* idenchild = malloc(sizeof(struct node));
                cc(idenchild);strcpy(idenchild->token,$1.sval);
                lbrack->child[0] = malloc(sizeof(struct node));
                lbrack->child[0] = idenchild;nodechild[0] = lbrack;
                struct  node* lbrac = malloc(sizeof(struct node)) ;strcpy(lbrac->token, "[");cc(lbrac);
                nodechild[1] = lbrac;
                struct  node* lbra= malloc(sizeof(struct node)) ;strcpy(lbra->token, "]");cc(lbra);
                nodechild[2] = lbra;
                struct  node* e1 = malloc(sizeof(struct node)) ;strcpy(e1->token, "[");cc(e1);
                nodechild[3] = e1;nodechild[4]=$5.nd;
                struct  node* e2= malloc(sizeof(struct node)) ;strcpy(e2->token, "]");cc(e2);
                nodechild[5] = e2;struct  node* eq= malloc(sizeof(struct node)) ;strcpy(eq->token, "=");cc(eq);
                nodechild[6] = eq;
                struct  node* lc= malloc(sizeof(struct node)) ;strcpy(lc->token, "{");cc(lc);
                nodechild[7] = lc;nodechild[8] = $9.nd;
                struct  node* rcu= malloc(sizeof(struct node)) ;strcpy(rcu->token, "}");cc(rcu);
                nodechild[9] = rcu;
                
                $$.nd = mknode(nodechild, 10, "listEntry");
                if(strcmp($5.type,"int")!=0){
                        printf("Semantic error: Datatype of array index invalid");
                        exit(1);
                }
                add_var($1.sval,1,$9.type,10); $$.type=calloc(10,1); strcpy($$.type,$9.type); declareFlag=1;
        }
            | IDENTIFIER '[' expression  ']' '=' '{' valueBlock '}' {
                struct node* nodechild[8] ;fillarr(nodechild,8);
                struct  node* lbrack = malloc(sizeof(struct node)) ;strcpy(lbrack->token, "IDENTIFIER");cc(lbrack);
                struct node* idenchild = malloc(sizeof(struct node));cc(idenchild);strcpy(idenchild->token,$1.sval);
                lbrack->child[0] = malloc(sizeof(struct node));
                lbrack->child[0] = idenchild;
                nodechild[0] = lbrack;
                struct  node* lbrac = malloc(sizeof(struct node)) ;strcpy(lbrac->token, "[");cc(lbrac);
                nodechild[1] = lbrac;
                nodechild[2]=$3.nd;
                struct  node* lbra= malloc(sizeof(struct node)) ;strcpy(lbra->token, "]");cc(lbra);
                nodechild[3] = lbra;
                struct  node* eq= malloc(sizeof(struct node)) ;strcpy(eq->token, "=");cc(eq);
                nodechild[4] = eq;
                struct  node* lcur= malloc(sizeof(struct node)) ;strcpy(lcur->token, "{");cc(lcur);
                nodechild[5] = lcur;
                nodechild[6]=$7.nd;
                struct  node* rcur= malloc(sizeof(struct node)) ;strcpy(rcur->token, "}");cc(rcur);
                nodechild[7] = rcur;
                
                $$.nd = mknode(nodechild, 8, "listEntry");
                if(strcmp($3.type,"int")!=0){
                        printf("Semantic error: Datatype of array index invalid");
                        exit(1);
                }
                add_var($1.sval,1,$7.type,10); $$.type=calloc(10,1); strcpy($$.type,$7.type); declareFlag=1;
        }
            | IDENTIFIER '['  ']' '[' expression ']' '=' '{' valueBlock '}' {
                struct node* nodechild[10] ; fillarr(nodechild,10);
                struct  node* lbrack = malloc(sizeof(struct node)) ;strcpy(lbrack->token, "IDENTIFIER");cc(lbrack);
                struct node* idenchild = malloc(sizeof(struct node));cc(idenchild);strcpy(idenchild->token,$1.sval);
                lbrack->child[0] = idenchild;
                nodechild[0] = lbrack;
                struct  node* lbrac = malloc(sizeof(struct node)) ;strcpy(lbrac->token, "[");cc(lbrac);
                nodechild[1] = lbrac;
                struct  node* lbra= malloc(sizeof(struct node)) ;strcpy(lbra->token, "]");cc(lbra);
                nodechild[2] = lbra;
                struct  node* e1 = malloc(sizeof(struct node)) ;strcpy(e1->token, "["); cc(e1);
                nodechild[3] = e1;
               nodechild[4]=$5.nd;
                struct  node* e2= malloc(sizeof(struct node)) ;strcpy(e2->token, "]");cc(e2);
                nodechild[5] = e2;
               struct  node* eq= malloc(sizeof(struct node)) ;
                strcpy(eq->token, "=");cc(eq);
                nodechild[6] = eq;
                struct  node* lc= malloc(sizeof(struct node)) ;strcpy(lc->token, "{");cc(lc);
                nodechild[7] = lc;nodechild[8] = $9.nd;
                struct  node* rcu= malloc(sizeof(struct node)) ;strcpy(rcu->token, "}");cc(rcu);
                nodechild[9] = rcu;
                                                                                                                                          $$.nd = mknode(nodechild, 10, "listEntry");
                if(strcmp($5.type,"int")!=0){
                        printf("Semantic error: Datatype of array index invalid");
                        exit(1);
                }
                add_var($1.sval,1,$9.type,10); $$.type=calloc(10,1); strcpy($$.type,$9.type); declareFlag=1;
        }
            | IDENTIFIER '[' expression ']' '[' expression ']' '=' '{' valueBlock '}' {
                struct node* nodechild[11] ;fillarr(nodechild,11);
                struct  node* lbrack = malloc(sizeof(struct node)) ;strcpy(lbrack->token, "IDENTIFIER");cc(lbrack);
                struct node* idenchild = malloc(sizeof(struct node));cc(idenchild);strcpy(idenchild->token,$1.sval);
                lbrack->child[0] = malloc(sizeof(struct node));
                lbrack->child[0] = idenchild;nodechild[0] = lbrack;
                struct  node* lbrac = malloc(sizeof(struct node)) ;strcpy(lbrac->token, "[");
                cc(lbrac);
                nodechild[1] = lbrac;nodechild[2]=$3.nd;
                struct  node* lbra= malloc(sizeof(struct node)) ;strcpy(lbra->token, "]");cc(lbra);
                nodechild[3] = lbra;
                struct  node* e1 = malloc(sizeof(struct node)) ;strcpy(e1->token, "[");cc(e1);
                nodechild[4] = e1;nodechild[5]=$6.nd;
                struct  node* e2= malloc(sizeof(struct node)) ;strcpy(e2->token, "]");cc(e2);
                nodechild[6] = e2;
                struct  node* eq= malloc(sizeof(struct node)) ; strcpy(eq->token, "=");cc(eq);
                nodechild[7] = eq;
                struct  node* lc= malloc(sizeof(struct node)) ;
                strcpy(lc->token, "{");cc(lc);
                nodechild[8] = lc;nodechild[9] = $10.nd;
                struct  node* rcu= malloc(sizeof(struct node)) ;strcpy(rcu->token, "}");cc(rcu);
                nodechild[10] = rcu;

                $$.nd = mknode(nodechild, 11, "listEntry");
                if(strcmp($3.type,"int")!=0){
                        printf("Semantic error: Datatype of array index invalid");
                        exit(1);
                }
                if(strcmp($6.type,"int")!=0){
                        printf("Semantic error: Datatype of array index invalid");
                        exit(1);
                }
                add_var($1.sval,1,$10.type,10); $$.type=calloc(10,1); strcpy($$.type,$10.type); declareFlag=1;
        }
        |  IDENTIFIER '[' ']' '[' expression ']' '=' '{' valueBlock '}'  {
                if(strcmp($5.type,"int")!=0){
                        printf("Semantic error: Datatype of array index invalid");
                        exit(1);
                }
                add_var($1.sval,1,$9.type,10); $$.type=calloc(10,1); strcpy($$.type,$9.type); declareFlag=1;
                struct node* arr[10];fillarr(arr,10);
                arr[4] = $5.nd; arr[8] = $9.nd;
                struct node* id=malloc(sizeof(struct node));strcpy(id->token,"IDENTIFIER");cc(id);
                struct node* idenchild = malloc(sizeof(struct node));cc(idenchild);strcpy(idenchild->token,$1.sval);
                id->child[0] = malloc(sizeof(struct node));
                id->child[0] = idenchild;arr[0] = id;
                struct node* lb=malloc(sizeof(struct node));strcpy(lb->token,"[");cc(lb);arr[1] = lb;
                struct node* rb=malloc(sizeof(struct node));strcpy(rb->token,"]");cc(rb);arr[2] = rb;
                struct node* lb1=malloc(sizeof(struct node));strcpy(lb1->token,"[");cc(lb1);arr[3] = lb1;
                struct node* rb1=malloc(sizeof(struct node));strcpy(rb1->token,"]");cc(rb1);arr[5] = rb1;
                struct node* eq=malloc(sizeof(struct node));strcpy(eq->token,"=");cc(eq);arr[6] = eq;
                struct node* lb2=malloc(sizeof(struct node));strcpy(lb2->token,"{");cc(lb2);arr[7] = lb2;
                struct node* rb2=malloc(sizeof(struct node));strcpy(rb2->token,"}");cc(rb2);arr[9] = rb2;
                $$.nd = mknode(arr,10,"listEntry");
                } 
        |  IDENTIFIER '=' expression {
                add_var($1.sval,1,$3.type,10); $$.type=calloc(10,1); strcpy($$.type,$3.type); declareFlag=1;
                struct node* arr[3];fillarr(arr,3);
                arr[2] = $3.nd;
                struct node* id=malloc(sizeof(struct node));strcpy(id->token,"IDENTIFIER");cc(id);
                struct node* idenchild = malloc(sizeof(struct node));cc(idenchild);strcpy(idenchild->token,$1.sval);
                 id->child[0] = malloc(sizeof(struct node));
                id->child[0] = idenchild;arr[0] = id;
                struct node* eq=malloc(sizeof(struct node));strcpy(eq->token,"=");cc(eq);arr[1] = eq;
                $$.nd = mknode(arr,3,"listEntry");
        }
        ;
 
cIndex:index {

                struct node* nodechild[1] ;fillarr(nodechild,1);nodechild[0]=$1.nd;
                $$.nd = mknode(nodechild, 1, "cIndex");
                        
                $$.type=calloc(10,1); strcpy($$.type,$1.type);}
        | %empty {$$.nd=malloc(sizeof(struct node)); $$.nd=NULL;}
        ;
 
index   :   expression {
                struct node* nodechild[1] ;fillarr(nodechild,1);
                nodechild[0]=$1.nd;$$.nd = mknode(nodechild, 1, "index");
                $$.type=calloc(10,1); strcpy($$.type,$1.type);}
        |       var  {
                struct node* nodechild[1] ;fillarr(nodechild,1);
                nodechild[0]=$1.nd;$$.nd = mknode(nodechild, 1, "index");
                $$.type=calloc(10,1); strcpy($$.type,$1.type);}
        ;
 
cVar    :   var {
                struct node* nodechild[1] ;fillarr(nodechild,1);nodechild[0]=$1.nd;
                $$.nd = mknode(nodechild, 1, "cVar");
                $$.type = calloc(100, 1); strcpy($$.type,$1.type); strcpy($$.sval,$1.sval);}
        |   IDENTIFIER '[' ']' {
                struct node* nodechild[3] ;fillarr(nodechild,3);
                struct  node* lbrack = malloc(sizeof(struct node)) ;strcpy(lbrack->token, "IDENTIFIER");cc(lbrack);
                struct  node* identch = malloc(sizeof(struct node));
                strcpy(identch->token,$1.sval);cc(identch);
                 lbrack->child[0] = malloc(sizeof(struct node));
                lbrack->child[0]=identch;
                nodechild[0] = lbrack;
                struct  node* lbrac = malloc(sizeof(struct node)) ;strcpy(lbrac->token, "[");cc(lbrac);
                nodechild[1] = lbrac;
                struct  node* lb = malloc(sizeof(struct node)) ;strcpy(lb->token, "]");cc(lb);
                nodechild[2] = lb;$$.nd = mknode(nodechild, 3, "cVar");
                $$.type = calloc(100, 1); 
                int flag=0;
                for(int i=0;i<count;i++)
                {
                        if(strcmp(symbol_table[i].id_name,$1.sval)==0)
                        {
                                strcpy($$.type,symbol_table[i].data_type);
                                flag=1;
                                break;
                        }
                }
                if(flag==0){
                        printf("Semantic error:Variable undeclared - %s",$1.sval);
                        exit(1);
                }
                strcpy($$.sval,$1.sval);}
        ;
declare_var :        IDENTIFIER   {
                struct node* nodechild[1] ;fillarr(nodechild,1);
                struct  node* lbrack = malloc(sizeof(struct node)) ; strcpy(lbrack->token, "IDENTIFIER");
                struct  node* identch = malloc(sizeof(struct node));strcpy(identch->token,$1.sval);cc(identch);
                  lbrack->child[0] = malloc(sizeof(struct node));
                lbrack->child[0]=identch;cc(lbrack);
                nodechild[0] = lbrack;
                $$.nd = mknode(nodechild, 1, "declare_var");
                $$.type = calloc(100, 1); strcpy($$.sval,$1.sval);}

            |   declare_var1 {
                    struct node* nodechild[1] ;fillarr(nodechild,1);nodechild[0]=$1.nd;
                    $$.nd = mknode(nodechild, 1, "declare_var");
                    $$.type = calloc(100, 1); strcpy($$.sval,$1.sval);
           }
            ;

var :       IDENTIFIER   {
                struct node* nodechild[1] ;fillarr(nodechild,1);
                struct  node* lbrack = malloc(sizeof(struct node)) ;strcpy(lbrack->token, "IDENTIFIER");cc(lbrack);
        
                struct  node* identch = malloc(sizeof(struct node));strcpy(identch->token,$1.sval);cc(identch);
                  lbrack->child[0] = malloc(sizeof(struct node));
                lbrack->child[0]=identch;
                nodechild[0] = lbrack;
                $$.nd = mknode(nodechild, 1, "var");
                $$.type = calloc(100, 1);
                int flag=0;
                for(int i=0;i<count;i++)
                {
                        if(strcmp(symbol_table[i].id_name,$1.sval)==0)
                        {
                                strcpy($$.type,symbol_table[i].data_type);
                                flag=1;
                                break;
                        }
                }
                if(flag==0){
                        printf("Semantic error:Variable undeclared - %s",$1.sval);
                        exit(1);
                }
                 strcpy($$.sval,$1.sval);
                 if(!search($1.sval)){
            printf("Semantic Error: Variable not declared123\n");
            exit(1);
     }
        }
        | IDENTIFIER '[' expression ']' {
                struct node* nodechild[4] ;fillarr(nodechild,4);
                struct  node* lbrack = malloc(sizeof(struct node)) ;strcpy(lbrack->token, "IDENTIFIER");cc(lbrack);
                struct  node* identch = malloc(sizeof(struct node));strcpy(identch->token,$1.sval);cc(identch);
                  lbrack->child[0] = malloc(sizeof(struct node));
                lbrack->child[0]=identch;
                nodechild[0] = lbrack;
                struct  node* lbrac = malloc(sizeof(struct node)) ;
                strcpy(lbrac->token, "[");cc(lbrac);
                nodechild[1] = lbrac;nodechild[2] = $3.nd;
                struct  node* lbra = malloc(sizeof(struct node)) ;strcpy(lbra->token, "]");cc(lbra);
                nodechild[3] = lbra;
                $$.nd = mknode(nodechild, 4, "var");
                $$.type = calloc(100, 1);
                int flag=0;
                for(int i=0;i<count;i++){
                        if(strcmp(symbol_table[i].id_name,$1.sval)==0)
                        {
                                strcpy($$.type,symbol_table[i].data_type);
                                flag=1;
                                break;
                        }
                }
                if(flag==0){
                        printf("Semantic error:Variable undeclared - %s",$1.sval);
                        exit(1);
                }
                $$.type = calloc(100, 1); strcpy($$.sval,$1.sval);
                if(!search($1.sval)){
            printf("Semantic Error: Variable not declared9\n");
            exit(1);
     }
        }
        |       IDENTIFIER '[' expression ']' '[' expression ']' {
                        if(!search($1.sval)){
            printf("Semantic Error: Variable not declared8\n");
            exit(1);
     }
                
                        struct node* nodechild[7] ;fillarr(nodechild,7);
                        struct  node* lbrack = malloc(sizeof(struct node)) ;strcpy(lbrack->token, "IDENTIFIER");
                        cc(lbrack);
                        struct  node* identch = malloc(sizeof(struct node));strcpy(identch->token,$1.sval);cc(identch);
                          lbrack->child[0] = malloc(sizeof(struct node));
                        lbrack->child[0]=identch;
                        nodechild[0] = lbrack;
                        struct  node* lbrac = malloc(sizeof(struct node)) ;strcpy(lbrac->token, "[");cc(lbrac);
                        nodechild[1] = lbrac;nodechild[2] = $3.nd;
                        struct  node* lbra = malloc(sizeof(struct node)) ;strcpy(lbra->token, "]");cc(lbra);
                        nodechild[3] = lbra;
                        struct  node* lbrac1 = malloc(sizeof(struct node)) ;
                        strcpy(lbrac1->token, "[");
                        cc(lbrac1);
                        nodechild[4] = lbrac1;nodechild[5] = $6.nd;
                        struct  node* lbra1 = malloc(sizeof(struct node)) ;strcpy(lbra1->token, "]");cc(lbra1);
                        nodechild[6] = lbra1;
                        $$.nd = mknode(nodechild, 7, "var");
                        $$.type = calloc(100, 1); strcpy($$.sval,$1.sval);}
                        ;
   
declare_var1:       IDENTIFIER '[' expression ']' {
                struct node* nodechild[4] ;
                fillarr(nodechild,4);
                struct  node* lbrack = malloc(sizeof(struct node)) ;strcpy(lbrack->token, "IDENTIFIER");
                cc(lbrack);
                struct  node* identch = malloc(sizeof(struct node));strcpy(identch->token,$1.sval);cc(identch);
                  lbrack->child[0] = malloc(sizeof(struct node));
                lbrack->child[0]=identch;nodechild[0] = lbrack;
                struct  node* lbrac = malloc(sizeof(struct node)) ;strcpy(lbrac->token, "[");cc(lbrac);
                nodechild[1] = lbrac;nodechild[2] = $3.nd;
                struct  node* lbra = malloc(sizeof(struct node)) ;strcpy(lbra->token, "]");cc(lbra);
                nodechild[3] = lbra;
                $$.nd = mknode(nodechild, 4, "declare_var1");

                $$.type = calloc(100, 1); strcpy($$.sval,$1.sval);}
    |       IDENTIFIER '[' expression ']' '[' expression ']' {

                struct node* nodechild[7] ;fillarr(nodechild,7);
                struct  node* lbrack = malloc(sizeof(struct node)) ;strcpy(lbrack->token, "IDENTIFIER");cc(lbrack);
                struct  node* identch = malloc(sizeof(struct node));strcpy(identch->token,$1.sval);cc(identch);
                  lbrack->child[0] = malloc(sizeof(struct node));
                lbrack->child[0]=identch;nodechild[0] = lbrack;
                struct  node* lbrac = malloc(sizeof(struct node)) ;strcpy(lbrac->token, "[");cc(lbrac);
                nodechild[1] = lbrac;nodechild[2] = $3.nd;
                struct  node* lbra = malloc(sizeof(struct node)) ;strcpy(lbra->token, "]");cc(lbra);
                nodechild[3] = lbra;
                struct  node* lbrac1 = malloc(sizeof(struct node)) ;strcpy(lbrac1->token, "[");cc(lbrac1);
                nodechild[4] = lbrac1;nodechild[5] = $6.nd;
                struct  node* lbra1 = malloc(sizeof(struct node)) ;strcpy(lbra1->token, "]");cc(lbra1);
                nodechild[6] = lbra1;
                $$.nd = mknode(nodechild, 7, "declare_var1");
                $$.type = calloc(100, 1); strcpy($$.sval,$1.sval);}
        ;
 
 
    
valueList : arrvals ',' valueList  {
                struct node* nodechild[3] ;fillarr(nodechild,3);nodechild[0]=$1.nd;
                struct  node* lbrack = malloc(sizeof(struct node)) ;strcpy(lbrack->token, ",");cc(lbrack);
                nodechild[1] = lbrack;nodechild[2]=$3.nd;
                $$.nd = mknode(nodechild, 3, "valueList");
                $$.type = calloc(10, 1);strcpy($$.type, $1.type);
        }
          | arrvals {
                struct node* nodechild[1] ;fillarr(nodechild,1);
                 nodechild[0]=$1.nd;
                $$.nd = mknode(nodechild, 1, "valueList");$$.type = calloc(10, 1);
                strcpy($$.type, $1.type);
        }
        ;
 
valueBlock : '{' valueList '}' ',' valueBlock {
                struct node* nodechild[5] ;fillarr(nodechild,5);
                struct  node* lbrack = malloc(sizeof(struct node)) ;
                strcpy(lbrack->token, "{");
                cc(lbrack);
                nodechild[0] = lbrack;nodechild[1] = $2.nd;
                struct  node* rbrack = malloc(sizeof(struct node)) ;strcpy(rbrack->token, "}");cc(rbrack);
                nodechild[2] = rbrack;
                struct  node* coma = malloc(sizeof(struct node)) ;
                strcpy(coma->token, ",");
                cc(coma);
                nodechild[3] = coma;
                nodechild[4] = $5.nd;
                $$.nd = mknode(nodechild, 5, "valueBlock");
                $$.type = calloc(10, 1);
                strcpy($$.type, $2.type);
 
        }
            | '{' valueList '}' {

                struct node* nodechild[3] ;fillarr(nodechild,3);
                struct  node* lbrack = malloc(sizeof(struct node)) ;strcpy(lbrack->token, "{");cc(lbrack);
                nodechild[0] = lbrack;nodechild[1] = $2.nd;
                struct  node* rbrack = malloc(sizeof(struct node)) ;strcpy(rbrack->token, "}");cc(rbrack);
                nodechild[2] = rbrack;
                $$.nd = mknode(nodechild, 3, "valueBlock");
                $$.type = calloc(10, 1);strcpy($$.type, $2.type);
 
        }
            |  valueList ',' valueBlock {

                struct node* nodechild[3] ;fillarr(nodechild,3);
                nodechild[0]=$1.nd;
                struct  node* l = malloc(sizeof(struct node)) ;strcpy(l->token, ",");cc(l);
                nodechild[1] = l;
                nodechild[2]=$3.nd;
                $$.nd = mknode(nodechild, 3, "valueBlock");
                $$.type = calloc(10, 1);
                strcpy($$.type, $1.type);
 
        }
            | valueList {
                struct node* nodechild[1] ;fillarr(nodechild,1);
                nodechild[0]=$1.nd;
                $$.nd = mknode(nodechild, 1, "valueBlock");
                $$.type = calloc(10, 1);
                strcpy($$.type, $1.type);
        }
        ;
 
funcCall    :  IDENTIFIER '(' {funccallflag=1;} callParams ')' {
        // printf("BROOOOOOOOOOOO\n");
                struct node* nodechild[4] ;fillarr(nodechild,4);
                struct  node* identi = malloc(sizeof(struct node));strcpy(identi->token,"IDENTIFIER");cc(identi);
                struct  node* identch = malloc(sizeof(struct node));strcpy(identch->token,$1.sval);cc(identch);
                  identi->child[0] = malloc(sizeof(struct node));
                identi->child[0]=identch;nodechild[0] = identi;
                struct  node* lb = malloc(sizeof(struct node)) ;strcpy(lb->token, "(");cc(lb);
                nodechild[1] = lb;nodechild[2] = $4.nd;
                struct  node* rb = malloc(sizeof(struct node)) ;strcpy(rb->token, ")");cc(rb);
                nodechild[3] = rb;
                $$.nd = mknode(nodechild, 4, "funcCall");
                int g = 0,i;
                for(i=0;i<funcCount;++i){
                        if(strcmp(funcs[i].name,$1.sval) == 0){
                                g = 1; break;
                        }
                }
                if(g == 0){
                        printf("Semantic Error: Function undeclared - %s\n",$1.sval);
                        exit(1);
                }
                
                $$.type = calloc(100,1);
                strcpy($$.type,funcs[i].type);

                int flag11=0;
                    for(int i=0;i<funcCount;i++)
                    {
                            // printf("\n\n\n%d %s\n\n\n",i+1,funcs[i].name);
                            if(strcmp($1.sval,funcs[i].name)==0){
                                    if(funcs[i].count!=currtcount)
                                    {
                                            
                                            printf("Semantic error: Function call has incorrect number of parameters passed");
                                            exit(1);
                                    }
                            for(int j=0;j<funcs[i].count;j++)
                            {
                                            
                                    if(strcmp(funcs[i].types[j],currTypes[currtcount-j-1])!=0)
                                    {
                                            printf("Semantic error: Function call has incorrect types of parameters passed");
                                            exit(1);
                                    }
                            }
                            }
                    }
                    
     
                    currtcount=0;
                
        }
        ;
 
callParams : var ',' callParams{
        int flag=0;
            for(int i=0;i<count;i++)
            {
                    if(strcmp(symbol_table[i].id_name,$1.sval)==0)
                    {
                            flag=1;
                            strcpy(currTypes[currtcount],symbol_table[i].data_type); currtcount++;
                            break;
                    }
            }
            if(flag==0)
            {
                    printf("Semantic error:Variable undeclared - %s",$1.sval);
                    exit(1);
            }
                struct node* nodechild[3] ;fillarr(nodechild,3);
                nodechild[0] =$1.nd;
                struct  node* coma = malloc(sizeof(struct node)) ;strcpy(coma->token, ",");cc(coma);
                nodechild[1] = coma;nodechild[2] =$3.nd;
                $$.nd = mknode(nodechild, 3, "callParams");
          
        }
                | %empty {$$.nd=malloc(sizeof(struct node)); $$.nd=NULL;}
                |arrvals {
                            strcpy(currTypes[currtcount],$1.type); currtcount++;
                            

                        struct node* nodechild[1] ;fillarr(nodechild,1);
                        nodechild[0] =$1.nd;
                        $$.nd = mknode(nodechild, 1, "callParams");

                }
                |arrvals ',' callParams{
                        // printf("*******\n");

                        strcpy(currTypes[currtcount],$1.type); currtcount++;
                        struct node* nodechild[3] ;fillarr(nodechild,3);
                        nodechild[0] =$1.nd;
                        struct  node* coma = malloc(sizeof(struct node)) ;strcpy(coma->token, ",");cc(coma);
                        nodechild[1] = coma;nodechild[2] =$3.nd;
                        $$.nd = mknode(nodechild, 3, "callParams");
                }
                | var{
                        int flag=0;
            for(int i=0;i<count;i++)
            {
                    if(strcmp(symbol_table[i].id_name,$1.sval)==0)
                    {
                            flag=1;
                            strcpy(currTypes[currtcount],symbol_table[i].data_type); currtcount++;
                            break;
                    }
            }
            if(flag==0)
            {
                    printf("Semantic error:Variable undeclared - %s",$1.sval);
                    exit(1);
            }
                        struct node* nodechild[1] ;fillarr(nodechild,1);
                        nodechild[0] =$1.nd;
                        $$.nd = mknode(nodechild, 1, "callParams");
                }
                ;
 
exprOperand  : arrvals {
                        struct node* nodechild[1] ;fillarr(nodechild,1);
                        nodechild[0] =$1.nd;
                        $$.nd = mknode(nodechild, 1, "exprOperand");
                        $$.type = calloc(10, 1);strcpy($$.type, $1.type);
                        if(strcmp($$.type,"float") == 0 || strcmp($$.type,"int") == 0) $$.val = $1.val;
                        else if(strcmp($$.type,"char") == 0) $$.cval = $1.cval;
                        else if (strcmp($$.type,"string") == 0){
                                $$.sval = calloc(100,1);
                                strcpy($$.sval,$1.sval);
                        }

                }
        |   var  {
                struct node* nodechild[1] ;fillarr(nodechild,1);
                nodechild[0] =$1.nd;
                $$.nd = mknode(nodechild, 1, "exprOperand");
                $$.type = calloc(10, 1);strcpy($$.type, $1.type);
                
        }
        |   funcCall {

                        struct node* nodechild[1] ;fillarr(nodechild,1);
                        nodechild[0] =$1.nd;
                        $$.nd = mknode(nodechild, 1, "exprOperand");
                        $$.type = calloc(10, 1);strcpy($$.type, $1.type);
                }
                ;   
 
arrvals :   NUM {
                struct node* nodechild[1] ;fillarr(nodechild,1);
                struct  node* num = malloc(sizeof(struct node));strcpy(num->token,"NUM");cc(num);
                struct node* numchild = malloc(sizeof(struct node));cc(numchild);
                strcpy(numchild->token,$1.sval);num->child[0] = numchild;
                num->child[0] = malloc(sizeof(struct node));
                num->child[0] = numchild;
                nodechild[0] = num;
                $$.nd = mknode(nodechild, 1, "arrvals");strcpy($$.type,"int");
                int ival=atoi($1.sval); $$.val = ival;
        }
        |   FLOATNUM {
                strcpy($$.type,"float"); float fval=atof($1.sval);
                $$.val = fval;
                struct node* arr[1]; fillarr(arr,1);
                struct node* floatnode = malloc(sizeof(struct node));cc(floatnode);strcpy(floatnode->token,"FLOATNUM");
                struct node* floatchild = malloc(sizeof(struct node));cc(floatnode);
                strcpy(floatchild->token,$1.sval);
                floatnode->child[0] = malloc(sizeof(struct node));
                floatnode->child[0] = floatchild;
                arr[0] = floatnode;
                $$.nd = mknode(arr,1,"arrvals");
        }
        |   CHARLIT {
                strcpy($$.type,"char"); $$.cval = $1.cval;
                struct node* arr[1];fillarr(arr,1);
                struct node* charnode = malloc(sizeof(struct node));cc(charnode);
                strcpy(charnode->token,"CHARLIT");
                struct node* charchild = malloc(sizeof(struct node));cc(charchild);
                strcpy(charchild->token,$1.sval);
                  charnode->child[0] = malloc(sizeof(struct node));
                charnode->child[0] = charchild;
                arr[0] = charnode;
                $$.nd  = mknode(arr,1,"arrvals"); 
        }
        ;
printf  :  PRINTF '('  STRINGLIT ')' 
        {
                struct node* nodechild[4] ;fillarr(nodechild,4);
                struct  node* p = malloc(sizeof(struct node));strcpy(p->token,"PRINTF");cc(p);nodechild[0] = p;
                struct  node* lb = malloc(sizeof(struct node)) ;strcpy(lb->token, "(");cc(lb);
                nodechild[1] = lb;
                struct  node* s = malloc(sizeof(struct node)) ;strcpy(s->token, "STRINGLIT");cc(s);
                struct  node* ssch = malloc(sizeof(struct node));strcpy(ssch->token,$3.sval);cc(ssch);
                  s->child[0] = malloc(sizeof(struct node));
                s->child[0]=ssch;
                nodechild[2] = s;
                struct  node* rb = malloc(sizeof(struct node)) ;
                strcpy(rb->token ,")");
                cc(rb);
                nodechild[3] =rb;
                $$.nd = mknode(nodechild, 4, "printf");
        }
        |  PRINTF '(' STRINGLIT ','  printVars ')' 
          {     

                    char currTypes[100][100];
                    int currtypesno=0;
     
                    for(int i=0;i<strlen($3.sval)-1;i++)
                    {
                            if($3.sval[i]=='%'&&$3.sval[i+1]=='d')
                            {
                                    strcpy(currTypes[currtypesno],"int");
                                    currtypesno++;
                            }
                            else if($3.sval[i]=='%'&&$3.sval[i+1]=='c')
                            {
                                    strcpy(currTypes[currtypesno],"char");
                                    currtypesno++;
                            } 
                            else if($3.sval[i]=='%'&&$3.sval[i+1]=='f')
                            {
                                    strcpy(currTypes[currtypesno],"float");
                                    currtypesno++;
                            }
                            else if($3.sval[i]=='%'&&$3.sval[i+1]=='s')
                            {
                                    strcpy(currTypes[currtypesno],"char");
                                    currtypesno++;
                            }
                    }
                    if(currtypesno!=prints[0].count)
                    {
                            printf("Semantic error:Invalid number of arguments in printf");
                            exit(1);
                    }
                    for(int i=0;i<currtypesno;i++)
                    {
                            if(strcmp(currTypes[i],prints[0].types[currtypesno-i-1])!=0)
                            {
                                    printf("Semantic error:Invalid argument type given in printf");
                                    exit(1);
                            }
                    }
                    prints[0].count=0;


                struct node* nodechild[6] ;
                fillarr(nodechild,6);
                struct  node* p = malloc(sizeof(struct node));
                strcpy(p->token,"PRINTF");cc(p);
                nodechild[0] = p;
                struct  node* lb = malloc(sizeof(struct node)) ;strcpy(lb->token, "(");cc(lb);
                nodechild[1] = lb;
                struct  node* ss = malloc(sizeof(struct node)) ;strcpy(ss->token, "STRINGLIT");cc(ss);
                struct  node* ssch = malloc(sizeof(struct node));strcpy(ssch->token,$3.sval);cc(ssch);
                ss->child[0] = malloc(sizeof(struct node));
                ss->child[0]=ssch;nodechild[2] = ss;
                struct  node* coma = malloc(sizeof(struct node)) ;
                strcpy(coma->token, ",");cc(coma);
                nodechild[3] = coma;nodechild[4]=$5.nd;
                struct  node* rb = malloc(sizeof(struct node)) ;
                strcpy(rb->token ,")");cc(rb);
                nodechild[5]=rb;

                $$.nd = mknode(nodechild, 6, "printf");
        }
        ;
 
printVars : IDENTIFIER ',' printVars{
                if(!search($1.sval)){
            printf("Semantic Error: Variable not declared\n");
            exit(1);
            }
     
            int i;
            for(i=0;i<count;i++)
            {
                    if(strcmp(symbol_table[i].id_name,$1.sval)==0) 
                    {
                            break;
                    }      
            }
     
            strcpy(prints[0].types[prints[0].count],symbol_table[i].data_type);
            prints[0].count=prints[0].count+1;
            struct node* nodechild[3] ;fillarr(nodechild,3);
            struct  node* identi = malloc(sizeof(struct node));
            strcpy(identi->token,"IDENTIFIER");cc(identi);
            struct  node* identch = malloc(sizeof(struct node));strcpy(identch->token,$1.sval);cc(identch);
              identi->child[0] = malloc(sizeof(struct node));
            identi->child[0]=identch;
            nodechild[0] = identi;
            struct  node* lb = malloc(sizeof(struct node)) ;strcpy(lb->token, ",");cc(lb);
            nodechild[1] = lb;nodechild[2]=$3.nd;
            $$.nd = mknode(nodechild,3,"printVars");
        }
          | IDENTIFIER {

              if(!search($1.sval)){
            printf("Semantic Error: Variable not declared\n");
            exit(1);
     }
                    int i;
            for(i=0;i<count;i++)
            {
                    if(strcmp(symbol_table[i].id_name,$1.sval)==0) 
                    {
                            break;
                    }      
            }
     
            strcpy(prints[0].types[prints[0].count],symbol_table[i].data_type);
            prints[0].count=prints[0].count+1;

                struct node* nodechild[1] ;fillarr(nodechild,1);
                struct  node* identi = malloc(sizeof(struct node));strcpy(identi->token,"IDENTIFIER");cc(identi);
                struct  node* identch = malloc(sizeof(struct node));strcpy(identch->token,$1.sval);cc(identch);
                  identi->child[0] = malloc(sizeof(struct node));
                identi->child[0]=identch;nodechild[0] = identi;
                $$.nd = mknode(nodechild,1,"printVars");
        }
        ;    
 
 
%% 
#include "lex.yy.c"
#include <stdio.h>
#include <string.h>
int main(int argc, char *argv[])
{
	yyin = fopen(argv[1], "r");
        head= malloc(sizeof(struct node));

            for(int i=0;i<100;i++)
            {
                    funcs[funcCount].count=0;
            }
        yyparse();


            int mainFlag=0;
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
            }
 
        /* printf("\n\n");
	printf("\t\t\t\t\t\t\t\t PHASE 1: LEXICAL ANALYSIS \n\n");
	printf("\nSYMBOL   DATATYPE   TYPE   SCOPE \n");
	printf("_______________________________________\n\n"); */
	int i=0;
	/* for(i=0; i<count; i++) {
		printf("%s\t%s\t%s\t%d\t\n", symbol_table[i].id_name, symbol_table[i].data_type, symbol_table[i].type, symbol_table[i].scope);
	} */
	for(i=0;i<count;i++) {
		free(symbol_table[i].id_name);
		free(symbol_table[i].type);
	}
	/* printf("\n\n"); */
 
	fclose(yyin);
        /* printf("Before Printing Tree\n"); */

        print_tree(head,0);
        /* printf("After Printing Tree\n"); */
 
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
                            printf("\n{Semantic Error: Re declaration of variable - %s\n",s);
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