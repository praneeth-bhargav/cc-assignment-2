%{
  #include<stdio.h>
  #include<string.h>
  int yywrap();

  int lineNo=1;
  struct tableEntry
  {
    int lineNo;
    char val[1000];
    char type[1000];
  };
  typedef struct tableEntry tableEntry;
  tableEntry symbolTable[1000];
  int entries=0;

%}

digit       [0-9]
chars       .*
allchars    .|\n
strchars     [^\"]*

comment     "//"{chars}"\n"|[\/][\*]{allchars}+?[\*][\/]
keyword     "float"|"int"|"char"|"if"|"else"|"break"|"case"|"continue"|"for"|"if"|"return"|"switch"|"while"|"default"
identifier  [_a-zA-Z][_a-zA-Z0-9]*
operator    "+"|"-"|"*"|"/"|"%"|"="|"=="|"!="|"<"|">"|"<="|">="|"&&"|"||"|"!"|"&"
punctuator  "["|"]"|"("|")"|"{"|"}"|";"|","|"."
number      [-]?{digit}+"."{digit}*([eE][-]?{digit}+)?|[-]?[0-9]+\.?[0-9]+|[-]?[0-9]*
charLiteral ['].[']
strLiteral  [\"]{strchars}[\"]
include     ['#']{chars}[>]
%%


{keyword} {
  symbolTable[entries].lineNo=lineNo;
  
  strcpy(symbolTable[entries].val,yytext);
  
  char str[]="Keyword\0";
  strcpy(symbolTable[entries].type,str);

  entries++;
}

{comment} {
            for(int i=0;i<yyleng;i++)
            {
              if(yytext[i]=='\n')
              lineNo++;
            }
}

{identifier}  {
  symbolTable[entries].lineNo=lineNo;
  
  strcpy(symbolTable[entries].val,yytext);
  
  char str[]="Identifier\0";
  strcpy(symbolTable[entries].type,str);
  entries++;
}

{number}  {
  symbolTable[entries].lineNo=lineNo;
  
  strcpy(symbolTable[entries].val,yytext);
  
  char str[]="Number\0";
  strcpy(symbolTable[entries].type,str);
  entries++;
}

{strLiteral}  {
  symbolTable[entries].lineNo=lineNo;
  
  strcpy(symbolTable[entries].val,yytext);
  
  char str[]="String literal\0";
  strcpy(symbolTable[entries].type,str);
  entries++;
}

{charLiteral}   {
  symbolTable[entries].lineNo=lineNo;
  
  strcpy(symbolTable[entries].val,yytext);
  
  char str[]="Character literal\0";
  strcpy(symbolTable[entries].type,str);
  entries++;
}

{operator}  {
  symbolTable[entries].lineNo=lineNo;
  
  strcpy(symbolTable[entries].val,yytext);
  
  char str[]="Operator\0";
  strcpy(symbolTable[entries].type,str);
  entries++;
}

{punctuator}  {symbolTable[entries].lineNo=lineNo;
  
  strcpy(symbolTable[entries].val,yytext);
  
  char str[]="Punctuator\0";
  strcpy(symbolTable[entries].type,str);
  entries++;
}

{include} {

}





"\n"      {lineNo++;}

%%
int yywrap()
{ 
  return 1;
}
int check1(int i)
{
  if(i+3>=entries)
  return 0;

  if(strcmp(symbolTable[i+1].val,"(")!=0)
  return 0;

  if(strcmp(symbolTable[i+3].val,")")!=0)
  return 0;

  return 1;
}
int check2(int i)
{

  if(strcmp(symbolTable[i+1].val,"(")!=0)
  return 0;

  int count=0;
  for(int j=0;j<strlen(symbolTable[i+2].val)-1;j++)
  {
    if(symbolTable[i+2].val[j]=='%'&&symbolTable[i+2].val[j+1]=='d')
    count++;
    else if(symbolTable[i+2].val[j]=='%'&&symbolTable[i+2].val[j+1]=='c')
    count++;
    else if(symbolTable[i+2].val[j]=='%'&&symbolTable[i+2].val[j+1]=='f')
    count++;
    else if(symbolTable[i+2].val[j]=='%'&&symbolTable[i+2].val[j+1]=='s')
    count++;

  }
  
  if(2*count+i+3>=entries)
  return 0;
  for(int j=i+3;j<=2*count+i+1;j+=2)
  {
    if(strcmp(symbolTable[j].val,",")!=0)
    return 0;
  }


  if(strcmp(symbolTable[2*count+i+3].val,")")!=0)
    return 0;
  

  return 1;
}

int validatep(int i)
{
  if(check1(i))
  return 1;
  
  return check2(i);
}
int main()
{

  yyin = fopen("input.c","r");

  yylex();
  printf("SYMBOL TABLE\n");
  for(int i=0;i<entries;i++)
  {
    if(strcmp(symbolTable[i].val,"printf")==0)
    {
      if(validatep(i)==0)
      printf("Invalid printf at Line no %d\n",symbolTable[i].lineNo);
    }
  }
  printf("Line No\t\tToken Value\tToken type\n");

  for(int i=0;i<entries;i++){
    printf("%d\t\t%s\t\t%s\n",symbolTable[i].lineNo,symbolTable[i].val,symbolTable[i].type);
  }

  return 0;
}