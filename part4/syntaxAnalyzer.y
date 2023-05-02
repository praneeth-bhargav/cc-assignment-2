%{
    
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
int yylex(void);
extern int lineNo;
int declareFlag=0;
extern char* yytext;
//int lineNo=1;
 
void yyerror(const char *s); 

int currScope=0;
int forFlag=0;

int checking=0;
 
int yywrap();
void add(char);
void add_var(char* s , int i, char* ss,int flagg);
void adjust_var(char* tt);
void insert_type();
int search(char *);

int temp_count = 0;

    char* snum[5];

    char* generate_temp(){
        char* temp = malloc(32);
        sprintf(temp, "t%d", temp_count++);
        return temp;

    }

    void tostring(char* str, int num)
{
    int i, rem, len = 0, n;
 
    n = num;
    while (n != 0)
    {
        len++;
        n /= 10;
    }
    for (i = 0; i < len; i++)
    {
        rem = num % 10;
        num = num / 10;
        str[len - (i + 1)] = rem + '0';
    }
    str[len] = '\0';
}

    int label_count = 0; 

    char* generate_label(){
        char* label = malloc(32);
        sprintf(label, "L%d", label_count);
        label_count = label_count + 1;
        return label;
    }

    void address_code(char* s1, char* s2, char* s3, char* s4){
        printf("%s %s %s %s", s1, s2, s3, s4);
    }

    int address_count = 0;

    struct addressCode{
        int action;
        char s2[100];
        char s3[100];
        char s1[100];
        char s4[100];
    } addressTable[100];

    void enter_table(int action, char* s1, char* s2, char* s3, char* s4){
        // printf("BAZISAPUKA%s\n",s4);
        addressTable[address_count].action = action;
        strcpy(addressTable[address_count].s1, s1);
        strcpy(addressTable[address_count].s2, s2);
        strcpy(addressTable[address_count].s3, s3);
        strcpy(addressTable[address_count].s4, s4);
        address_count++;
    }


    void insert_type();
     

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
        int isFunc;
    } T;
 
 
 
%}
 
%union {struct {
            char *sval;
            char cval;
            float val;
            char *type;
        } t;
    }
%type <t> printVars printf operator return datatype type param expression caseExpr var declarative list listEntry cVar var1 index valueList arrvals valueBlock funcCall  exprOperand cIndex wloopexpr loopexpr declare_var declare_var1 nonIfStatement statement statements
 
 
%token INT FLOAT CHAR IF ELSE BREAK CASE CONTINUE FOR RETURN SWITCH WHILE DEFAULT ELSEIF
%token MAIN VOID PRINTF <t> STRINGLIT CHARLIT NUM FLOATNUM IDENTIFIER '=' OR AND EQ NE '<' LE '>' GE '+' '-' '*' '/' '%' '!'
 
%left '='
%left OR
%left AND
%left EQ NE
%left '<' LE '>' GE
%left '+' '-'
%left '*' '/' '%'
%right '!'
/* unary left */
 
%% 
 
 
s : program { return 1;}
  ;
 
program :funcs
        ;
 
datatype: type {$$.type = calloc(10, 1); strcpy($$.type,$1.type)  ; }
        | VOID {
                $$.type = calloc(10, 1);
                strcpy($$.type, "void");
 
                }
        ;
 
 
type    : INT { $$.type = calloc(10, 1); strcpy($$.type,"int")  ;  }
        | FLOAT {$$.type = calloc(10, 1); strcpy($$.type,"float") ;}
        | CHAR {$$.type = calloc(10, 1); strcpy($$.type,"char") ;}
        ;
 
funcs: func 
     | func funcs
     | %empty 
     ;    
 
func: datatype IDENTIFIER '(' {
        // currScope++;
        currScope=0;
        count=0;
} params ')' '{'  statements '}' {
        addAsFunc=1;
        add_var($2.sval , 1 , $1.type ,0);
        addAsFunc=0;

 funcs[funcCount].name=calloc(100,1);
 strcpy(funcs[funcCount].name,$2.sval); 
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

 }
    | datatype MAIN '(' params ')' '{' statements '}' {
        add_var("main" , 1 ,$1.type,0); 
    funcs[funcCount].name=calloc(100,1);
    strcpy(funcs[funcCount].name,"main"); 
    funcCount++;

    }
    ;
 
params  :   %empty
        |  param params1 
        ;
 
params1 : %empty   
        | ',' param params1
        ;
 
param   : datatype IDENTIFIER {
                $$.type = calloc(10, 1);
                strcpy($$.type, $1.type);
 
                $2.type = calloc(10, 1);
                strcpy($2.type, $1.type);
                
        add_var($2.sval,1,$2.type,0);
        
        funcs[funcCount].types[funcs[funcCount].count]=calloc(10,1);
        strcpy(funcs[funcCount].types[funcs[funcCount].count],$1.type);
        funcs[funcCount].count=funcs[funcCount].count+1;
//         if(!search($2.sval)){
//         printf("Semantic Error: Variable not declared\n");
//  }
        
        }
        ;
 
statements  :   %empty
            |   statement statements 
            ;
 
statement: ifStatement|nonIfStatement
          ;
 
nonIfStatement: switchStatement|forStatement|whileStatement|declarative ';' |assignment ';' 
            |return|jump|compound| printf ';'
            ;
 
 
 
 
ifStatement : ifWithElse
            | ifWithoutElse
            ;
 

ifWithoutElse   : IF '(' expression ')' statement {char* intemp; intemp = generate_label(); enter_table( 1, "if", $3.sval, "isfalse goto", intemp);
                
                enter_table(3, intemp, "", " ", ":");

                }
                | IF '(' expression ')' {char* intemp; intemp = generate_label(); enter_table( 1, "if", $3.sval, "isfalse goto", intemp);
                
                enter_table(3, intemp, "", " ", ":");

                }
                ';'
                | IF '(' expression ')' ifWithElse ELSE ifWithoutElse
                ;
 
ifWithElse  : IF '(' expression ')' statement ELSE ifWithElse
            | nonIfStatement
            ;
 
 
jump:   BREAK ';' {
        sprintf(snum, "%d", label_count);

        enter_table(5, "goto", "L", snum, "");
                }
    |   CONTINUE ';' {
                sprintf(snum, "%d", label_count-1);
                enter_table(5, "goto", "L", snum, "");
        }
    ;

return: RETURN NUM ';' {enter_table(4, "ret",$2.sval,"goto", "Label:LL");  rFlag=1; strcpy(rType,"int");}
      | RETURN FLOATNUM ';' {enter_table(4, "ret",$2.sval,"goto", "Label:LL"); rFlag=1; strcpy(rType,"float");}
      | RETURN ';' { rFlag=1;  }
      | RETURN CHARLIT ';' {enter_table(4, "ret",$2.sval,"goto", "Label:LL"); rFlag=1; strcpy(rType,"char");}
      | RETURN expression ';' {enter_table(4, "ret",$2.sval,"goto", "Label:LL"); rFlag=1; strcpy(rType,$2.type);}
      ;
 
compound: '{' {if(forFlag==0)currScope++;} statements '}' {if(forFlag==0)currScope--;}
        ;
 
 
expression  :   '!' expression {
                $$.type = calloc(10, 1);
                strcpy($$.type, $2.type);
                // if(strcmp($$.type,"int")==0||strcmp($$.type,"float")==0)
                // $$.val = $2.val;
                // else if(strcmp($$.type,"char"))
                // $$.val = $2.cval;
                // else
                // {
                //         $$.sval = calloc(100,1);
                //         strcpy($$.sval,$2.sval)
                // }
                }
            |   expression operator expression  {
                if(strcmp($1.type,$3.type) == 0) strcpy($$.type, $1.type);
                else if ((strcmp($1.type,"int") == 0 && strcmp($3.type,"float")==0 )|| (strcmp($3.type,"int") == 0 && strcmp($1.type,"float")==0 )){
                        strcpy($$.type,"float");
                }
                else{
                        printf("Semantic error1: invalid type combination of expressions\n");
                        exit(1);
                        // return 1;
                }

                $$.sval = generate_temp();
                //     printf("operator: %s \n\n ", $2.sval);
                    
                //     printf("Expression Entered into table %s, %s, %s, %s \n\n", $2.sval, $1.sval, $3.sval, $$.sval);

                    enter_table(0, $$.sval, $1.sval, $2.sval, $3.sval);
                    

                
            }
            |   exprOperand  { 
                $$.type = calloc(10, 1);
                strcpy($$.type, $1.type);
 
                // if(strcmp($$.type,"float") == 0 || strcmp($$.type,"int") == 0) $$.val = $1.val;
                // else if(strcmp($$.type,"char") == 0) $$.cval = $1.cval;
                // else if (strcmp($$.type,"string") == 0){
                //         $$.sval = calloc(100,1);
                //         strcpy($$.sval,$1.sval);
                // }
                
                
                }
            |   '(' expression  ')' {
                $$.type = calloc(10, 1);
                strcpy($$.type, $2.type);
 
                // if(strcmp($$.type,"float") == 0 || strcmp($$.type,"int") == 0) $$.val = $1.val;
                // else if(strcmp($$.type,"char") == 0) $$.cval = $1.cval;
                // else if (strcmp($$.type,"string") == 0){
                //         $$.sval = calloc(100,1);
                //         strcpy($$.sval,$1.sval);
                // }
            }
            ;
 
operator    :   '+' {
         $$.sval = calloc(10, 1);strcpy($$.sval, $1.sval); 
        }
                |'-' {
         $$.sval = calloc(10, 1);strcpy($$.sval, $1.sval); 
        }
                |'*' {
         $$.sval = calloc(10, 1);strcpy($$.sval, $1.sval); 
        }
                |'/' {
         $$.sval = calloc(10, 1);strcpy($$.sval, $1.sval); 
        }
                |'%' {
         $$.sval = calloc(10, 1);strcpy($$.sval, $1.sval); 
        }
                |'>' {
         $$.sval = calloc(10, 1);strcpy($$.sval, $1.sval); 
        }
                |'<' {
         $$.sval = calloc(10, 1);strcpy($$.sval, $1.sval); 
        }
                |GE {
         $$.sval = calloc(10, 1);strcpy($$.sval, $1.sval);
        }
                |LE {
         $$.sval = calloc(10, 1);strcpy($$.sval, $1.sval); 
        }
                |EQ {
         $$.sval = calloc(10, 1);strcpy($$.sval, $1.sval); 
        }
                |NE {
         $$.sval = calloc(10, 1);strcpy($$.sval, $1.sval); 
        }
                |OR {
         $$.sval = calloc(10, 1);strcpy($$.sval, $1.sval);
        }
                |AND {
         $$.sval = calloc(10, 1);strcpy($$.sval, $1.sval); 
        }
            ;
 
forStatement    :   FOR '(' forInit {currScope++; forFlag=0;} ';' loopexpr  ';' loopexpr  ')' {char* intemp = generate_label(); 
        enter_table(3, intemp,"", " ", ":");
        

        //char* snum1;

        // printf("FOR STATEMENT val:::::::::::::: %d", label_count);

        //tostring(snum1, label_count);
        
        sprintf(snum, "%d", label_count);

        // printf("FO$ STa %s,,,,,,,,,,,,", snum);
        
        //sprintf(result, "%d", label_count);
        enter_table(1, "if", $6.sval, "isfalse goto L", snum);
                
                //sprintf(intemp, "%d", label_count-1);
               

                
                // printf("ttttttttttttttttttttttttttttttttttt");
                
                

                } 
                statement {currScope--; forFlag=0; 
                // printf("llllllllllllll"); 
                char* intemp1 = generate_label();

                //char* snum2[5];

                        // printf("FOR STATEMENT val:::::::::::::: %d", label_count);

        
                sprintf(snum, "%d", label_count-2);
                // printf("FO$ STa %s,,,,,,,,,,,,", snum);
        
                
                enter_table(1, "", "", " goto L", snum);
                enter_table(3,intemp1,"", " ", ":");
                
                

                }   
                |   FOR '(' forInit ';' loopexpr  ';' loopexpr  ')' {char* intemp = generate_label(); 
        enter_table(3, intemp,"", " ", ":");
        //char snum[5];

        //char* snum3[5];
        // printf("FOR STATEMENT val:::::::::::::: %d", label_count);

        
        sprintf(snum, "%d", label_count);
        // printf("FO$ STa %s,,,,,,,,,,,,", snum);
        
        
        //sprintf(result, "%d", label_count);
        enter_table(1, "if", $5.sval, "isfalse goto L", snum);
                
                //sprintf(intemp, "%d", label_count-1);
               

                
                // printf("ttttttttttttttttttttttttttttttttttt");
                
                

                } ';' {
                        // printf("llllllllllllll"); 
                char* intemp1 = generate_label();

                char* snum[5];

                        // printf("FOR STATEMENT val:::::::::::::: %d", label_count);

        
                sprintf(snum, "%d", label_count-2);
                
                // printf("FO$ STa %s,,,,,,,,,,,,", snum);
        

                enter_table(1, "", "", "goto L", (char*)snum);
                enter_table(3,intemp1,"", " ", ":");
                       
                
                //sprintf(intemp1, "%d", label_count-1);
                }
                
                

                
                /* |   FOR '(' forInit ';' loopexpr  ';' loopexpr  ')'  */
                /* |   FOR '(' forInit ';' loopexpr  ';' loopexpr  ')' compound  */
                ;
 
 
 
loopexpr    : wloopexpr {
                $$.type = calloc(10, 1);
                strcpy($$.type, $1.type);
 
                }
            | %empty {
                $$.type = calloc(10, 1);
                strcpy($$.type, "none");
 
                }
            ;
            
wloopexpr       : expression {
                $$.type = calloc(10, 1);
                strcpy($$.type, $1.type);
 
                }
                | assignment {
                // $$.type = calloc(10, 1);
                // strcpy($$.type, $1.type);
 
                }
                ;
 
forInit :   %empty
        |  expression 
        |assignment
        |declarative 
        ;                   
 
whileStatement: WHILE '(' wloopexpr ')' {char* intemp = generate_label(); 
        enter_table(3, intemp,"", " ", ":");
        //char snum[5];

        char* snum[5];
        
        sprintf(snum, "%d", label_count);

        
        //sprintf(result, "%d", label_count);
        enter_table(1, "if", $3.sval, "isfalse goto L", snum);
                
                //sprintf(intemp, "%d", label_count-1);
               

                
                // printf("ttttttttttttttttttttttttttttttttttt");
                
                

                } statement {
                        // printf("llllllllllllll"); 
                char* intemp1 = generate_label();

                char* snum[5];
        
                sprintf(snum, "%d", label_count-2);
                
                enter_table(1, "", "", " goto L", snum);
                enter_table(3,intemp1,"", " ", ":");
                       
                
                //sprintf(intemp1, "%d", label_count-1);
                }
              | WHILE '(' wloopexpr ')' {char* intemp = generate_label(); 
        enter_table(3, intemp,"", " ", ":");
        //char snum[5];

        char* snum[5];
        
        sprintf(snum, "%d", label_count);

        
        //sprintf(result, "%d", label_count);
        enter_table(1, "if", $3.sval, "isfalse goto L", snum);
                
                //sprintf(intemp, "%d", label_count-1);
               

                
                // printf("ttttttttttttttttttttttttttttttttttt");
                
                

                }
              ';' {
                // printf("llllllllllllll"); 
                char* intemp1 = generate_label();

                char* snum[5];
        
                sprintf(snum, "%d", label_count-2);
                
                enter_table(1, "", "", "goto L", snum);
                enter_table(3,intemp1,"", " ", ":");
                       
                
                //sprintf(intemp1, "%d", label_count-1);
                }
              /* | WHILE '(' wloopexpr ')' */
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
 
caseExpr  :   '!' caseExpr {$$.type = calloc(10, 1); strcpy($$.type,$2.type); }
            |   caseExpr operator caseExpr {$$.type = calloc(10, 1); strcpy($$.type,$1.type); }
            |   NUM {$$.type = calloc(10, 1); strcpy($$.type,"int");int ival=atoi($1.sval); $$.val=ival; } 
            |   '(' caseExpr  ')' {$$.type = calloc(10, 1); strcpy($$.type,$2.type); }
            ;        
 
assignment  : var '=' expression {
                                if(strcmp($1.type,"float") == 0&&strcmp($3.type,"int")==0){
                                }
                                else if(strcmp($1.type,$3.type)==0)
                                {
                                }
                                else
                                {
                                        
                                        printf("Semantic Error1: Expected Type and Assigned Types are different\n");
                                        exit(1);  
                                }
                                enter_table(0, $1.sval , "=", $3.sval, "");
                                
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
        } 
        ;
 
/* declarative:  type IDENTIFIER '[' index ']' '=' '{' valueList '}' {printf("WDADWAWDDWADWAWDDWDW\n");}
; */
 
/* arrDeclaration: type IDENTIFIER '[' index ']' '=' '{' valueList '}' {printf("INSIDE DES4");} */
 
 
list : listEntry {if(declareFlag==1){$$.type=calloc(10,1); strcpy($$.type,$1.type);}}
     | listEntry ',' list {if(declareFlag==1){$$.type=calloc(10,1); strcpy($$.type,$1.type);}}
     ;
 
listEntry   :IDENTIFIER '[' cIndex ']' '=' STRINGLIT  { 
         add_var($1.sval,1,"char",0); $$.type=calloc(10,1); strcpy($$.type,"char"); declareFlag=1;} 
            | IDENTIFIER '[' expression ']'  '=' STRINGLIT {
                if(strcmp($3.type,"int")!=0){
                        printf("Semantic error: Datatype of array index invalid");
                        exit(1);
                }
                add_var($1.sval,1,"char",0); $$.type=calloc(10,1); strcpy($$.type,"char"); declareFlag=1;}
            | IDENTIFIER '['  ']'  '=' STRINGLIT { add_var($1.sval,1,"char",0); $$.type=calloc(10,1); strcpy($$.type,"char"); declareFlag=1;}
            | IDENTIFIER '[' expression ']' '[' expression ']'  '=' STRINGLIT {
                if(strcmp($3.type,"int")!=0){
                        printf("Semantic error: Datatype of array index invalid");
                        exit(1);
                }
                if(strcmp($6.type,"int")!=0){
                        printf("Semantic error: Datatype of array index invalid");
                        exit(1);
                }
                add_var($1.sval,1,"char",0); $$.type=calloc(10,1); strcpy($$.type,"char"); declareFlag=1;}
            | IDENTIFIER '['  ']' '[' expression ']'  '=' STRINGLIT {
                if(strcmp($5.type,"int")!=0){
                        printf("Semantic error: Datatype of array index invalid");
                        exit(1);
                }
                add_var($1.sval,1,"char",0); $$.type=calloc(10,1); strcpy($$.type,"char"); declareFlag=1;}
            /* |    declare_var {printf("INSIDE DES3");add_var($1.sval,0,"NULL");}
            |   declare_var1 '=' '{' valueList '}' {printf("IN VAR1\n"); add_var($1.sval,0,"NULL");}
            |   declare_var1 '=' '{' valueBlock '}'{add_var($1.sval,0,"NULL");} */
            | IDENTIFIER {add_var($1.sval,0,"NULL",0); }
            | IDENTIFIER '[' expression  ']' {
                if(strcmp($3.type,"int")!=0){
                        printf("Semantic error: Datatype of array index invalid");
                        exit(1);
                }
                add_var($1.sval,0,"NULL",0);}
            | IDENTIFIER '[' expression ']' '[' expression ']' {
                if(strcmp($3.type,"int")!=0){
                        printf("Semantic error: Datatype of array index invalid");
                        exit(1);
                }
                add_var($1.sval,0,"NULL",0);}
            | IDENTIFIER '[' expression  ']' '=' '{' valueList '}' {
                if(strcmp($3.type,"int")!=0){
                        printf("Semantic error: Datatype of array index invalid");
                        exit(1);
                }
                add_var($1.sval,1,$7.type,10); $$.type=calloc(10,1); strcpy($$.type,$7.type); declareFlag=1;}
            | IDENTIFIER '['  ']' '=' '{' valueList '}' {add_var($1.sval,1,$6.type,10); $$.type=calloc(10,1); strcpy($$.type,$6.type); declareFlag=1;}
            | IDENTIFIER '[' expression ']' '[' expression ']' '='  '{' valueList '}' {
                if(strcmp($3.type,"int")!=0){
                        printf("Semantic error: Datatype of array index invalid");
                        exit(1);
                }
                if(strcmp($6.type,"int")!=0){
                        printf("Semantic error: Datatype of array index invalid");
                        exit(1);
                }
                add_var($1.sval,1,$10.type,10); $$.type=calloc(10,1); strcpy($$.type,$10.type); declareFlag=1;}
            | IDENTIFIER '['  ']' '[' expression ']' '=' '{' valueList '}' {
                if(strcmp($5.type,"int")!=0){
                        printf("Semantic error: Datatype of array index invalid");
                        exit(1);
                }
                add_var($1.sval,1,$9.type,10); $$.type=calloc(10,1); strcpy($$.type,$9.type); declareFlag=1;}
            | IDENTIFIER '[' expression  ']' '=' '{' valueBlock '}' {
                if(strcmp($3.type,"int")!=0){
                        printf("Semantic error: Datatype of array index invalid");
                        exit(1);
                }
                add_var($1.sval,1,$7.type,10); $$.type=calloc(10,1); strcpy($$.type,$7.type); declareFlag=1;}
            | IDENTIFIER '['  ']' '[' expression ']' '=' '{' valueBlock '}' {
                if(strcmp($5.type,"int")!=0){
                        printf("Semantic error: Datatype of array index invalid");
                        exit(1);
                }
                add_var($1.sval,1,$9.type,10); $$.type=calloc(10,1); strcpy($$.type,$9.type); declareFlag=1;}
            | IDENTIFIER '[' expression ']' '[' expression ']' '=' '{' valueBlock '}' {
                if(strcmp($3.type,"int")!=0){
                        printf("Semantic error: Datatype of array index invalid");
                        exit(1);
                }
                if(strcmp($6.type,"int")!=0){
                        printf("Semantic error: Datatype of array index invalid");
                        exit(1);
                }
                add_var($1.sval,1,$10.type,10); $$.type=calloc(10,1); strcpy($$.type,$10.type); declareFlag=1;}
            |  IDENTIFIER '[' ']' '=' '{' valueList '}' {add_var($1.sval,1,$6.type,10); $$.type=calloc(10,1); strcpy($$.type,$6.type); declareFlag=1;}
            |  IDENTIFIER '[' ']' '[' expression ']' '=' '{' valueBlock '}'  {
                if(strcmp($5.type,"int")!=0){
                        printf("Semantic error: Datatype of array index invalid");
                        exit(1);
                }
                add_var($1.sval,1,$9.type,10); $$.type=calloc(10,1); strcpy($$.type,$9.type); declareFlag=1;} 
            |  IDENTIFIER '=' expression {
            add_var($1.sval,1,$3.type,10); $$.type=calloc(10,1); strcpy($$.type,$3.type); declareFlag=1;
            }
            ;
 
cIndex:index {$$.type=calloc(10,1); strcpy($$.type,$1.type);}
        | %empty 
        ;
 
 
 
index   :   expression {$$.type=calloc(10,1); strcpy($$.type,$1.type);}
        |       var  {$$.type=calloc(10,1); strcpy($$.type,$1.type);}
        ;
 
cVar    :   var {$$.type = calloc(100, 1); strcpy($$.type,$1.type); strcpy($$.sval,$1.sval);}
        |   IDENTIFIER '[' ']' 
        {$$.type = calloc(100, 1); 

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
        if(flag==0)
        {
                printf("Semantic error:Variable undeclared");
                exit(1);
        }

        strcpy($$.sval,$1.sval);
        if(!search($1.sval)){
        printf("Semantic Error: Variable not declared\n");
        exit(1);
 }
        }
        ;
declare_var :        IDENTIFIER   {$$.type = calloc(100, 1); strcpy($$.sval,$1.sval);if(!search($1.sval)){
        printf("Semantic Error: Variable not declared\n");
        exit(1);
 }}
            |   declare_var1 {$$.type = calloc(100, 1); strcpy($$.sval,$1.sval);}
            ;

var :       IDENTIFIER   {
        ///here
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
        if(flag==0)
        {
                printf("Semantic error:Variable undeclared");
                exit(1);
        }
         strcpy($$.sval,$1.sval);
         if(!search($1.sval)){
        printf("Semantic Error: Variable not declared\n");
        exit(1);
 }
         }
        | IDENTIFIER '[' expression ']' {
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
                if(flag==0)
                {
                        printf("Semantic error:Variable undeclared");
                        exit(1);
                }
                $$.type = calloc(100, 1); strcpy($$.sval,$1.sval);
                if(!search($1.sval)){
        printf("Semantic Error: Variable not declared\n");
        exit(1);
 }
                
                }
        |       IDENTIFIER '[' expression ']' '[' expression ']' {$$.type = calloc(100, 1); strcpy($$.sval,$1.sval);
        
        if(!search($1.sval)){
        printf("Semantic Error: Variable not declared\n");
        exit(1);
 }
        }
;
   
     
declare_var1:       IDENTIFIER '[' expression ']' {$$.type = calloc(100, 1); strcpy($$.sval,$1.sval);
if(!search($1.sval)){
        printf("Semantic Error: Variable not declared\n");
        exit(1);
 }}
    |       IDENTIFIER '[' expression ']' '[' expression ']' {$$.type = calloc(100, 1); strcpy($$.sval,$1.sval);
    
    if(!search($1.sval)){
        printf("Semantic Error: Variable not declared\n");
        exit(1);
 }
    }
    ;
 
 
    
valueList : arrvals ',' valueList  {
                $$.type = calloc(10, 1);
                strcpy($$.type, $1.type);
 
                }
          | arrvals {
                $$.type = calloc(10, 1);
                strcpy($$.type, $1.type);
 
                }
          ;
 
valueBlock : '{' valueList '}' ',' valueBlock {
                $$.type = calloc(10, 1);
                strcpy($$.type, $2.type);
 
                }
            | '{' valueList '}' {
                $$.type = calloc(10, 1);
                strcpy($$.type, $2.type);
 
                }
            |  valueList ',' valueBlock {
                $$.type = calloc(10, 1);
                strcpy($$.type, $1.type);
 
                }
            | valueList {
                $$.type = calloc(10, 1);
                strcpy($$.type, $1.type);
 
                }
            ;
 
funcCall    :  IDENTIFIER '(' callParams ')' {
                int g = 0,i;
                for(i=0;i<count;++i)
                {
                        if(strcmp(symbol_table[i].id_name,$1.sval) == 0){
                                g = 1;
                                break;
                        }
                }
                if(g == 0){
                        printf("Semantic Error: Function undeclared\n");
                        exit(1);
                }
                
                $$.type = calloc(100,1);
                strcpy($$.type,symbol_table[i].data_type);

                // for(int i=0;i<currtcount;i++)
                // printf("%s\n",currTypes[i]);

                
                

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
                if(!search($1.sval)){
        printf("Semantic Error: Variable not declared\n");
        exit(1);
 }
}
            ;
 
callParams : var ',' callParams {
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
                printf("Semantic error:Variable undeclared");
                exit(1);
        }
        }
                | %empty
                | var {int flag=0;
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
                printf("Semantic error:Variable undeclared");
                exit(1);
        }}
                ;
 
exprOperand : arrvals {
                $$.type = calloc(10, 1);
                strcpy($$.type, $1.type);
 
                if(strcmp($$.type,"float") == 0 || strcmp($$.type,"int") == 0) {$$.val = $1.val; $$.sval = calloc(100,1);
                            strcpy($$.sval,$1.sval);}
                else if(strcmp($$.type,"char") == 0) {$$.cval = $1.cval;$$.sval = calloc(100,1);
                            strcpy($$.sval,$1.sval);}
                else if (strcmp($$.type,"string") == 0){
                        $$.sval = calloc(100,1);
                        strcpy($$.sval,$1.sval);
                }
 
                }
            |   var  {
                $$.type = calloc(10, 1);
                strcpy($$.type, $1.type);
 
                // if(strcmp($$.type,"float") == 0 || strcmp($$.type,"int") == 0) $$.val = $1.val;
                // else if(strcmp($$.type,"char") == 0) $$.cval = $1.cval;
                // else if (strcmp($$.type,"string") == 0){
                //         $$.sval = calloc(100,1);
                //         strcpy($$.sval,$1.sval);
                // }
 
                }
            |   funcCall {
                $$.type = calloc(10, 1);
                strcpy($$.type, $1.type);
 
                // if(strcmp($$.type,"float") == 0 || strcmp($$.type,"int") == 0) $$.val = $1.val;
                // else if(strcmp($$.type,"char") == 0) $$.cval = $1.cval;
                // else if (strcmp($$.type,"string") == 0){
                //         $$.sval = calloc(100,1);
                //         strcpy($$.sval,$1.sval);
                // }
 
                }
            ;   
 
arrvals :   NUM {
        strcpy($$.type,"int"); int ival=atoi($1.sval); $$.val = ival; $$.sval=calloc(100,1); strcpy($$.sval,$1.sval);}
        |   FLOATNUM {strcpy($$.type,"float"); float fval=atof($1.sval); $$.val = fval; $$.sval=calloc(100,1); strcpy($$.sval,$1.sval);}
        |   CHARLIT {strcpy($$.type,"char"); $$.cval = $1.cval; $$.sval=calloc(100,1); strcpy($$.sval,$1.sval);}
        ;
 
 
printf  :  PRINTF '('  STRINGLIT ')' {enter_table(2, "printf", $3.sval, "", "");}
        |  PRINTF '(' STRINGLIT ','  printVars ')' {
                // for(int i=0;i<prints[0].count;i++)
                // {
                //         printf("%s\n",prints[0].types[i]);
                // }


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

                enter_table(2, "printf", $3.sval, $5.sval, "");

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
          }
          ;    
 
 
%% 
#include "lex.yy.c"
#include <stdio.h>
#include <string.h>
int main(int argc, char *argv[])
{
	yyin = fopen(argv[1], "r");
	/* if(!yyparse())
		printf("\nParsing complete\n");
	else
		printf("\nParsing failed\n"); */
        
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
                exit(1);
        }
 
        /* printf("\n\n"); */
	/* printf("\t\t\t\t\t\t\t\t PHASE 1: LEXICAL ANALYSIS \n\n"); */
	/* printf("\nSYMBOL   DATATYPE   TYPE   SCOPE \n");
	printf("_______________________________________\n\n");
	int i=0;
	for(i=0; i<count; i++) {
		printf("%s\t%s\t%s\t%d\t\n", symbol_table[i].id_name, symbol_table[i].data_type, symbol_table[i].type, symbol_table[i].scope);
	} */
        int i=0;
	for(i=0;i<count;i++) {
		free(symbol_table[i].id_name);
		free(symbol_table[i].type);
	}
	/* printf("\n\n"); */

        /* for(int i=0;i<funcCount;i++)
        {
                printf("\n\n\n%d %s\n\n\n",i+1,funcs[i].name);

                for(int j=0;j<funcs[i].count;j++)
                {
                        printf("%d %s\n",j+1,funcs[i].types[j]);
                }
        } */

        enter_table(3, "LastLabel:", "LL", "\n","EOF");

        printf("\n ### Address Table ### \n");

        for(int i = 0; i < address_count; i++){
                if(addressTable[i].action == 1 || addressTable[i].action == 2 || addressTable[i].action == 4 || addressTable[i].action == 5)
                printf("%s %s %s %s\n", addressTable[i].s1,  addressTable[i].s2,  addressTable[i].s3,  addressTable[i].s4);
                if(addressTable[i].action == 0 && strcmp(addressTable[i].s2 , "=") != 0)
                printf("%s = %s %s %s\n", addressTable[i].s1,  addressTable[i].s2,  addressTable[i].s3,  addressTable[i].s4);
                if(addressTable[i].action == 3)
                printf("%s%s %s %s\n", addressTable[i].s1,  addressTable[i].s2,  addressTable[i].s3,  addressTable[i].s4);
                if(addressTable[i].action == 0 && strcmp(addressTable[i].s2 , "=") == 0 )
                printf("%s := %s %s\n", addressTable[i].s1,  addressTable[i].s3,  addressTable[i].s4);
        }

    	printf("\n\n");
 
	fclose(yyin);
 
	return 0;
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
 
void insert_type() {
	strcpy(type, yytext);
}
//extern int lineno;
extern char *yytext;
yyerror(char *s) {
	printf("Syntax error");
} 