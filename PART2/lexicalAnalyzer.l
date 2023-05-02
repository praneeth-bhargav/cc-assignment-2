%{
  #include "y.tab.h"
  #include<stdio.h>
  #include<string.h>
  int yywrap();
  int lineNo=1;
  // struct tableEntry
  // {
  //   int lineNo;
  //   char val[1000];
  //   char type[1000];
  // };
  // typedef struct tableEntry tableEntry;
  // tableEntry symbolTable[1000];
  // int entries=0;
 
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
number      [-]?{digit}+
floatnum    [-]?{digit}+"."{digit}+([eE][-+]?{digit}+)?|[-]?[0-9]+"."[0-9]+|[-]?{digit}+[eE][-+]?{digit}+
charLiteral ['].[']
strLiteral  [\"]{strchars}[\"]
include     ['#']{chars}[>]

%%

 
"void" {return VOID;
}
"int" { 
  // symbolTable[entries].lineNo=lineNo;
  
  // strcpy(symbolTable[entries].val,yytext);
  
  // char str[]="Keyword\0";
  // strcpy(symbolTable[entries].type,str);
  // printf("Int\n");
  // entries++;
  return INT;
  }
"float" {
  // symbolTable[entries].lineNo=lineNo;
  
  // strcpy(symbolTable[entries].val,yytext);
  
  // char str[]="Keyword\0";
  // strcpy(symbolTable[entries].type,str);
 
  // entries++;
  return FLOAT;
  }
"char" {
  // symbolTable[entries].lineNo=lineNo;
  
  // strcpy(symbolTable[entries].val,yytext);
  
  // char str[]="Keyword\0";
  // strcpy(symbolTable[entries].type,str);
 
  // entries++;
  // printf("in char\n");
  return CHAR;
  }
 
"if" {
  // symbolTable[entries].lineNo=lineNo;
  
  // strcpy(symbolTable[entries].val,yytext);
  
  // char str[]="Keyword\0";
  // strcpy(symbolTable[entries].type,str);
 
  // entries++;
  return IF;
  }
"else" {
  // symbolTable[entries].lineNo=lineNo;
  
  // strcpy(symbolTable[entries].val,yytext);
  
  // char str[]="Keyword\0";
  // strcpy(symbolTable[entries].type,str);
 
  // entries++;
  return ELSE;
  }
"break" {
  //  symbolTable[entries].lineNo=lineNo;
  
  // strcpy(symbolTable[entries].val,yytext);
  
  // char str[]="Keyword\0";
  // strcpy(symbolTable[entries].type,str);
 
  // entries++;
    return BREAK;
    }
"case" {
  // symbolTable[entries].lineNo=lineNo;
  
  // strcpy(symbolTable[entries].val,yytext);
  
  // char str[]="Keyword\0";
  // strcpy(symbolTable[entries].type,str);
 
  // entries++;
  return CASE;
  }
"continue"  {
  // symbolTable[entries].lineNo=lineNo;
  
  // strcpy(symbolTable[entries].val,yytext);
  
  // char str[]="Keyword\0";
  // strcpy(symbolTable[entries].type,str);
 
  // entries++;
  return CONTINUE ;
  } 
"for" {
  // symbolTable[entries].lineNo=lineNo;
  
  // strcpy(symbolTable[entries].val,yytext);
  
  // char str[]="Keyword\0";
  // strcpy(symbolTable[entries].type,str);
 
  // entries++;
  return FOR ;
  }
"return" {
  // symbolTable[entries].lineNo=lineNo;
  
  // strcpy(symbolTable[entries].val,yytext);
  
  // char str[]="Keyword\0";
  // strcpy(symbolTable[entries].type,str);
 
  // entries++;
  return RETURN;
  }
"switch" {
  // symbolTable[entries].lineNo=lineNo;
  
  // strcpy(symbolTable[entries].val,yytext);
  
  // char str[]="Keyword\0";
  // strcpy(symbolTable[entries].type,str);
 
  // entries++;
  return SWITCH;
  }
"while" {
  // symbolTable[entries].lineNo=lineNo;
  
  // strcpy(symbolTable[entries].val,yytext);
  
  // char str[]="Keyword\0";
  // strcpy(symbolTable[entries].type,str);
 
  // entries++;
  return WHILE;
  }
"default" {
  // symbolTable[entries].lineNo=lineNo;
  
  // strcpy(symbolTable[entries].val,yytext);
  
  // char str[]="Keyword\0";
  // strcpy(symbolTable[entries].type,str);
 
  // entries++;
  return DEFAULT ;
  }
 
{floatnum} {
  // printf("From lexFFF: %s\n",yytext);
  // yylval.t.val = atof(yytext);
  // printf("%f:::\n",yylval.t.val);
  // yylval.t.type = calloc(10,1);
  // strcpy(yylval.t.type,"float");
  // yylval.t.sval = calloc(100,1);
  // strcpy(yylval.t.sval,yytext);

  return FLOATNUM;
}
"else if" {
  return ELSEIF ;
}
 
"<=" {
  // symbolTable[entries].lineNo=lineNo;
  
  // strcpy(symbolTable[entries].val,yytext);
  
  // char str[]="Operator\0";
  // strcpy(symbolTable[entries].type,str);
  // entries++;
  return LE;
  }
  
">=" {
  // symbolTable[entries].lineNo=lineNo;
  
  // strcpy(symbolTable[entries].val,yytext);
  
  // char str[]="Operator\0";
  // strcpy(symbolTable[entries].type,str);
  // entries++;
  return GE;
  }
"!="  {
  // symbolTable[entries].lineNo=lineNo;
  
  // strcpy(symbolTable[entries].val,yytext);
  
  // char str[]="Operator\0";
  // strcpy(symbolTable[entries].type,str);
  // entries++;
  return NE;
  }
"==" {
  // symbolTable[entries].lineNo=lineNo;
  
  // strcpy(symbolTable[entries].val,yytext);
  
  // char str[]="Operator\0";
  // strcpy(symbolTable[entries].type,str);
  // entries++;
  return EQ;
  }
"&&" {
  // symbolTable[entries].lineNo=lineNo;
  
  // strcpy(symbolTable[entries].val,yytext);
  
  // char str[]="Operator\0";
  // strcpy(symbolTable[entries].type,str);
  // entries++;
  return AND;
  }
"||" {
  // symbolTable[entries].lineNo=lineNo;
  
  // strcpy(symbolTable[entries].val,yytext);
  
  // char str[]="Operator\0";
  // strcpy(symbolTable[entries].type,str);
  // entries++;
  return OR;
  }
"+"  {
  // symbolTable[entries].lineNo=lineNo;
      
  //     strcpy(symbolTable[entries].val,yytext);
      
  //     char str[]="Operator\0";
  //     strcpy(symbolTable[entries].type,str);
  //     entries++;
      return *yytext;
      }
"-" {
  // symbolTable[entries].lineNo=lineNo;
      
  //     strcpy(symbolTable[entries].val,yytext);
      
  //     char str[]="Operator\0";
  //     strcpy(symbolTable[entries].type,str);
  //     entries++;
      return *yytext;
      }
"*" {
  // symbolTable[entries].lineNo=lineNo;
      
  //     strcpy(symbolTable[entries].val,yytext);
      
  //     char str[]="Operator\0";
  //     strcpy(symbolTable[entries].type,str);
  //     entries++;
      return *yytext;
      }
"/" {
  // symbolTable[entries].lineNo=lineNo;
      
  //     strcpy(symbolTable[entries].val,yytext);
      
  //     char str[]="Operator\0";
  //     strcpy(symbolTable[entries].type,str);
  //     entries++;
      return *yytext;
      }
"," {
  //  symbolTable[entries].lineNo=lineNo;
  
  // strcpy(symbolTable[entries].val,yytext);
  
  // char str[]="Punctuator\0";
  // strcpy(symbolTable[entries].type,str);
  // entries++;
 
  
   return *yytext;
   } 
";" {
  // symbolTable[entries].lineNo=lineNo;
  
  // strcpy(symbolTable[entries].val,yytext);
  
  // char str[]="Punctuator\0";
  // strcpy(symbolTable[entries].type,str);
  // entries++;
 // printf("semicolon\n");
  return *yytext;
  } 
"!" {
  // symbolTable[entries].lineNo=lineNo;
  
  // strcpy(symbolTable[entries].val,yytext);
  
  // char str[]="Operator\0";
  // strcpy(symbolTable[entries].type,str);
  // entries++;
  return *yytext;
  }
  
"=" {
  // symbolTable[entries].lineNo=lineNo;
  
  // strcpy(symbolTable[entries].val,yytext);
  
  // char str[]="Operator\0";
  // strcpy(symbolTable[entries].type,str);
  // entries++;
  // printf("Equals from lex\n");
  return *yytext;
  } 
"<" {
  // symbolTable[entries].lineNo=lineNo;
  
  // strcpy(symbolTable[entries].val,yytext);
  
  // char str[]="Operator\0";
  // strcpy(symbolTable[entries].type,str);
  // entries++;
  return *yytext;
  }
">" {
 
  // symbolTable[entries].lineNo=lineNo;
  
  // strcpy(symbolTable[entries].val,yytext);
  
  // char str[]="Operator\0";
  // strcpy(symbolTable[entries].type,str);
  // entries++;
  return *yytext;
  }
"(" {
  // symbolTable[entries].lineNo=lineNo;
  
  // strcpy(symbolTable[entries].val,yytext);
  
  // char str[]="Punctuator\0";
  // strcpy(symbolTable[entries].type,str);
  // entries++;
  return *yytext;
  }
")"  {
  // symbolTable[entries].lineNo=lineNo;
  
  // strcpy(symbolTable[entries].val,yytext);
  
  // char str[]="Punctuator\0";
  // strcpy(symbolTable[entries].type,str);
  // entries++;
  return *yytext;
  }
"{" {
  // symbolTable[entries].lineNo=lineNo;
  
  // strcpy(symbolTable[entries].val,yytext);
  
  // char str[]="Punctuator\0";
  // strcpy(symbolTable[entries].type,str);
  // entries++;
  // printf("\nHere from lex-> {\n");
  return *yytext;
  }
"}"  {
  // symbolTable[entries].lineNo=lineNo;
  
  // strcpy(symbolTable[entries].val,yytext);
  
  // char str[]="Punctuator\0";
  // strcpy(symbolTable[entries].type,str);
  // entries++;
  return *yytext;
  }
":" {
  // symbolTable[entries].lineNo=lineNo;
  
  // strcpy(symbolTable[entries].val,yytext);
  
  // char str[]="Punctuator\0";
  // strcpy(symbolTable[entries].type,str);
  // entries++;
  return *yytext;
  }
"[" {
  // symbolTable[entries].lineNo=lineNo;
  
  // strcpy(symbolTable[entries].val,yytext);
  
  // char str[]="Punctuator\0";
  // strcpy(symbolTable[entries].type,str);
  // entries++;
  return *yytext;
  }
"]" {
  // symbolTable[entries].lineNo=lineNo;
  
  // strcpy(symbolTable[entries].val,yytext);
  
  // char str[]="Punctuator\0";
  // strcpy(symbolTable[entries].type,str);
  // entries++;
  return *yytext;
  }
"%" {
  // symbolTable[entries].lineNo=lineNo;
  
  // strcpy(symbolTable[entries].val,yytext);
  
  // char str[]="Punctuator\0";
  // strcpy(symbolTable[entries].type,str);
  // entries++;
  return *yytext;
  }
"printf" {return PRINTF;
}
 
 
 
{comment} {
            for(int i=0;i<yyleng;i++)
            {
              if(yytext[i]=='\n')
              lineNo++;
            }
}
 
{identifier}  {
  // symbolTable[entries].lineNo=lineNo;
  
  // strcpy(symbolTable[entries].val,yytext);
  
  // char str[]="Identifier\0";
  // strcpy(symbolTable[entries].type,str);
  // entries++;
  // printf("Identifier is %s\n",yytext);
  // yylval.t.sval = calloc(100,1);
  // strcpy(yylval.t.sval, yytext);
  return IDENTIFIER;
}
 
{number}  {
  // symbolTable[entries].lineNo=lineNo;
  
  // strcpy(symbolTable[entries].val,yytext);
  
  // char str[]="Number\0";
  // strcpy(symbolTable[entries].type,str);
  // entries++;
  // printf("Number recognized:%s\n",yytext);
  // int numVal=atoi(yytext);
  // printf("%d\n",numVal);


  // yylval.t.val = numVal;
  // printf("%d:::\n",yylval.t.val);
  // yylval.t.type = calloc(10, 1);
  // strcpy(yylval.t.type, "int");
  // yylval.t.sval = calloc(100, 1);
  // strcpy(yylval.t.sval, yytext);
//   printf("From lex: %s\n",yytext);
  //yylval = atoi(yytext);
  return NUM;
}
 
{strLiteral}  {
  // symbolTable[entries].lineNo=lineNo;
  
  // strcpy(symbolTable[entries].val,yytext);
  
  // char str[]="String literal\0";
  // strcpy(symbolTable[entries].type,str);
  // entries++;
  // printf("got a string\n");
  // yylval.t.sval = calloc(100,1);
  // strcpy( yylval.t.sval,yytext);
  // printf("yylval.t.sval = %s\n",yylval.t.sval);
  // yylval.t.type = calloc(10,1);
  // strcpy(yylval.t.type,"string");
  // printf("Stringlit from lex\n");
  return STRINGLIT;
}
 
{charLiteral}   {
  // symbolTable[entries].lineNo=lineNo;
  
  // strcpy(symbolTable[entries].val,yytext);
  
  // char str[]="Character literal\0";
  // strcpy(symbolTable[entries].type,str);
  // entries++;
  // yylval.t.cval = yytext[1];
  // char temp[100]={'\0'};
  // temp[0]=yytext[1];
  // yylval.t.sval=calloc(100,1);
  // strcpy(yylval.t.sval,temp);
  // // printf("%c:::cval\n",yylval.t.cval);
  // yylval.t.type = calloc(10, 1);
  // strcpy(yylval.t.type, "char");
  return CHARLIT;
}
 
{operator}  {
  // symbolTable[entries].lineNo=lineNo;
  
  // strcpy(symbolTable[entries].val,yytext);
  
  // char str[]="Operator\0";
  // strcpy(symbolTable[entries].type,str);
  // entries++;
}
 
{punctuator}  {
  // symbolTable[entries].lineNo=lineNo;
  
  // strcpy(symbolTable[entries].val,yytext);
  
  // char str[]="Punctuator\0";
  // strcpy(symbolTable[entries].type,str);
  // entries++;
}
 
{include} {
 
}
 
"\n"      {
  lineNo++;
  }
 
 
 
%%
// int yywrap()
// { 
//   return 1;
// }
// int check1(int i)
// {
//   if(i+3>=entries)
//   return 0;
 
//   if(strcmp(symbolTable[i+1].val,"(")!=0)
//   return 0;
 
//   if(strcmp(symbolTable[i+3].val,")")!=0)
// return 0;
 
//   return 1;
// }
// int check2(int i)
// {
 
//   if(strcmp(symbolTable[i+1].val,"(")!=0)
//   return 0;
 
//   int count=0;
//   for(int j=0;j<strlen(symbolTable[i+2].val)-1;j++)
//   {
//     if(symbolTable[i+2].val[j]=='%'&&symbolTable[i+2].val[j+1]=='d')
//     count++;
//     else if(symbolTable[i+2].val[j]=='%'&&symbolTable[i+2].val[j+1]=='c')
//     count++;
//     else if(symbolTable[i+2].val[j]=='%'&&symbolTable[i+2].val[j+1]=='f')
//     count++;
//     else if(symbolTable[i+2].val[j]=='%'&&symbolTable[i+2].val[j+1]=='s')
//     count++;
 
//   }
  
//   if(2*count+i+3>=entries)
//   return 0;
//   for(int j=i+3;j<=2*count+i+1;j+=2)
//   {
//     if(strcmp(symbolTable[j].val,",")!=0)
//     return 0;
//   }
 
 
//   if(strcmp(symbolTable[2*count+i+3].val,")")!=0)
//     return 0;
  
 
//   return 1;
// }
 
// int validatep(int i)
// {
//   if(check1(i))
//   return 1;
  
//   return check2(i);
// }
// int main()
// {
 
//   yyin = fopen("input.txt","r");
 
//   yylex();
//   printf("SYMBOL TABLE\n");
//   for(int i=0;i<entries;i++)
//   {
//     if(strcmp(symbolTable[i].val,"printf")==0)
//     {
//       if(validatep(i)==0)
//       printf("Invalid printf at Line no %d\n",symbolTable[i].lineNo);
//     }
//   }
//   printf("Line No\t\tToken Value\tToken type\n");
 
//   for(int i=0;i<entries;i++){
//     printf("%d\t\t%s\t\t%s\n",symbolTable[i].lineNo,symbolTable[i].val,symbolTable[i].type);
//   }
 
//   return 0;
// }