/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    INT = 258,
    FLOAT = 259,
    CHAR = 260,
    IF = 261,
    ELSE = 262,
    BREAK = 263,
    CASE = 264,
    CONTINUE = 265,
    FOR = 266,
    RETURN = 267,
    SWITCH = 268,
    WHILE = 269,
    DEFAULT = 270,
    ELSEIF = 271,
    LE = 272,
    GE = 273,
    NE = 274,
    EQ = 275,
    AND = 276,
    OR = 277,
    MAIN = 278,
    VOID = 279,
    PRINTF = 280,
    STRINGLIT = 281,
    CHARLIT = 282,
    NUM = 283,
    FLOATNUM = 284,
    IDENTIFIER = 285
  };
#endif
/* Tokens.  */
#define INT 258
#define FLOAT 259
#define CHAR 260
#define IF 261
#define ELSE 262
#define BREAK 263
#define CASE 264
#define CONTINUE 265
#define FOR 266
#define RETURN 267
#define SWITCH 268
#define WHILE 269
#define DEFAULT 270
#define ELSEIF 271
#define LE 272
#define GE 273
#define NE 274
#define EQ 275
#define AND 276
#define OR 277
#define MAIN 278
#define VOID 279
#define PRINTF 280
#define STRINGLIT 281
#define CHARLIT 282
#define NUM 283
#define FLOATNUM 284
#define IDENTIFIER 285

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 93 "syntaxAnalyzer.y"
struct {
            char *sval;
            char cval;
            float val;
            char *type;
            struct node* nd;
        } t;
    

#line 127 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
