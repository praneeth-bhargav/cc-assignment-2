/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison implementation for Yacc-like parsers in C

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

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.5.1"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* First part of user prologue.  */
#line 1 "syntaxAnalyzer.y"

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

#line 162 "y.tab.c"

# ifndef YY_CAST
#  ifdef __cplusplus
#   define YY_CAST(Type, Val) static_cast<Type> (Val)
#   define YY_REINTERPRET_CAST(Type, Val) reinterpret_cast<Type> (Val)
#  else
#   define YY_CAST(Type, Val) ((Type) (Val))
#   define YY_REINTERPRET_CAST(Type, Val) ((Type) (Val))
#  endif
# endif
# ifndef YY_NULLPTR
#  if defined __cplusplus
#   if 201103L <= __cplusplus
#    define YY_NULLPTR nullptr
#   else
#    define YY_NULLPTR 0
#   endif
#  else
#   define YY_NULLPTR ((void*)0)
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* Use api.header.include to #include this header
   instead of duplicating it here.  */
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
    

#line 284 "y.tab.c"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */



#ifdef short
# undef short
#endif

/* On compilers that do not define __PTRDIFF_MAX__ etc., make sure
   <limits.h> and (if available) <stdint.h> are included
   so that the code can choose integer types of a good width.  */

#ifndef __PTRDIFF_MAX__
# include <limits.h> /* INFRINGES ON USER NAME SPACE */
# if defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stdint.h> /* INFRINGES ON USER NAME SPACE */
#  define YY_STDINT_H
# endif
#endif

/* Narrow types that promote to a signed type and that can represent a
   signed or unsigned integer of at least N bits.  In tables they can
   save space and decrease cache pressure.  Promoting to a signed type
   helps avoid bugs in integer arithmetic.  */

#ifdef __INT_LEAST8_MAX__
typedef __INT_LEAST8_TYPE__ yytype_int8;
#elif defined YY_STDINT_H
typedef int_least8_t yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef __INT_LEAST16_MAX__
typedef __INT_LEAST16_TYPE__ yytype_int16;
#elif defined YY_STDINT_H
typedef int_least16_t yytype_int16;
#else
typedef short yytype_int16;
#endif

#if defined __UINT_LEAST8_MAX__ && __UINT_LEAST8_MAX__ <= __INT_MAX__
typedef __UINT_LEAST8_TYPE__ yytype_uint8;
#elif (!defined __UINT_LEAST8_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST8_MAX <= INT_MAX)
typedef uint_least8_t yytype_uint8;
#elif !defined __UINT_LEAST8_MAX__ && UCHAR_MAX <= INT_MAX
typedef unsigned char yytype_uint8;
#else
typedef short yytype_uint8;
#endif

#if defined __UINT_LEAST16_MAX__ && __UINT_LEAST16_MAX__ <= __INT_MAX__
typedef __UINT_LEAST16_TYPE__ yytype_uint16;
#elif (!defined __UINT_LEAST16_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST16_MAX <= INT_MAX)
typedef uint_least16_t yytype_uint16;
#elif !defined __UINT_LEAST16_MAX__ && USHRT_MAX <= INT_MAX
typedef unsigned short yytype_uint16;
#else
typedef int yytype_uint16;
#endif

#ifndef YYPTRDIFF_T
# if defined __PTRDIFF_TYPE__ && defined __PTRDIFF_MAX__
#  define YYPTRDIFF_T __PTRDIFF_TYPE__
#  define YYPTRDIFF_MAXIMUM __PTRDIFF_MAX__
# elif defined PTRDIFF_MAX
#  ifndef ptrdiff_t
#   include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  endif
#  define YYPTRDIFF_T ptrdiff_t
#  define YYPTRDIFF_MAXIMUM PTRDIFF_MAX
# else
#  define YYPTRDIFF_T long
#  define YYPTRDIFF_MAXIMUM LONG_MAX
# endif
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned
# endif
#endif

#define YYSIZE_MAXIMUM                                  \
  YY_CAST (YYPTRDIFF_T,                                 \
           (YYPTRDIFF_MAXIMUM < YY_CAST (YYSIZE_T, -1)  \
            ? YYPTRDIFF_MAXIMUM                         \
            : YY_CAST (YYSIZE_T, -1)))

#define YYSIZEOF(X) YY_CAST (YYPTRDIFF_T, sizeof (X))

/* Stored state numbers (used for stacks). */
typedef yytype_int16 yy_state_t;

/* State numbers in computations.  */
typedef int yy_state_fast_t;

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

#ifndef YY_ATTRIBUTE_PURE
# if defined __GNUC__ && 2 < __GNUC__ + (96 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_PURE __attribute__ ((__pure__))
# else
#  define YY_ATTRIBUTE_PURE
# endif
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# if defined __GNUC__ && 2 < __GNUC__ + (7 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_UNUSED __attribute__ ((__unused__))
# else
#  define YY_ATTRIBUTE_UNUSED
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && ! defined __ICC && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                            \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")              \
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END      \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif

#if defined __cplusplus && defined __GNUC__ && ! defined __ICC && 6 <= __GNUC__
# define YY_IGNORE_USELESS_CAST_BEGIN                          \
    _Pragma ("GCC diagnostic push")                            \
    _Pragma ("GCC diagnostic ignored \"-Wuseless-cast\"")
# define YY_IGNORE_USELESS_CAST_END            \
    _Pragma ("GCC diagnostic pop")
#endif
#ifndef YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_END
#endif


#define YY_ASSERT(E) ((void) (0 && (E)))

#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yy_state_t yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (YYSIZEOF (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (YYSIZEOF (yy_state_t) + YYSIZEOF (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYPTRDIFF_T yynewbytes;                                         \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * YYSIZEOF (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / YYSIZEOF (*yyptr);                        \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, YY_CAST (YYSIZE_T, (Count)) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYPTRDIFF_T yyi;                      \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  11
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   591

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  49
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  49
/* YYNRULES -- Number of rules.  */
#define YYNRULES  143
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  264

#define YYUNDEFTOK  2
#define YYMAXUTOK   285


/* YYTRANSLATE(TOKEN-NUM) -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, with out-of-bounds checking.  */
#define YYTRANSLATE(YYX)                                                \
  (0 <= (YYX) && (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex.  */
static const yytype_int8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    39,     2,     2,     2,    38,     2,     2,
      40,    41,    36,    34,    44,    35,     2,    37,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,    46,    45,
      32,    31,    33,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,    47,     2,    48,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    42,     2,    43,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_int16 yyrline[] =
{
       0,   117,   117,   124,   127,   128,   131,   132,   133,   136,
     137,   138,   141,   159,   160,   163,   164,   167,   170,   171,
     174,   175,   178,   179,   180,   182,   184,   186,   187,   188,
     190,   193,   194,   197,   198,   199,   202,   203,   206,   207,
     210,   211,   212,   213,   214,   217,   220,   221,   222,   223,
     226,   227,   228,   229,   230,   231,   232,   233,   234,   235,
     236,   237,   238,   242,   243,   258,   259,   262,   263,   266,
     267,   268,   269,   272,   273,   284,   286,   287,   290,   291,
     292,   293,   296,   297,   298,   301,   304,   307,   308,   309,
     310,   313,   316,   319,   320,   323,   325,   327,   328,   329,
     330,   331,   332,   334,   335,   336,   337,   338,   339,   340,
     341,   342,   345,   346,   349,   350,   361,   362,   363,   372,
     373,   376,   377,   378,   379,   380,   381,   384,   384,   387,
     388,   389,   390,   391,   394,   395,   396,   399,   400,   401,
     403,   405,   409,   410
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 0
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "INT", "FLOAT", "CHAR", "IF", "ELSE",
  "BREAK", "CASE", "CONTINUE", "FOR", "RETURN", "SWITCH", "WHILE",
  "DEFAULT", "ELSEIF", "LE", "GE", "NE", "EQ", "AND", "OR", "MAIN", "VOID",
  "PRINTF", "STRINGLIT", "CHARLIT", "NUM", "FLOATNUM", "IDENTIFIER", "'='",
  "'<'", "'>'", "'+'", "'-'", "'*'", "'/'", "'%'", "'!'", "'('", "')'",
  "'{'", "'}'", "','", "';'", "':'", "'['", "']'", "$accept", "s",
  "program", "datatype", "type", "funcs", "func", "params", "params1",
  "param", "statements", "statement", "nonIfStatement", "ifStatement",
  "ifWithoutElse", "ifWithElse", "jump", "return", "compound",
  "expression", "operator", "forStatement", "loopexpr", "wloopexpr",
  "forInit", "whileStatement", "switchStatement", "switchexpr", "cases",
  "cases1", "case", "defaultCase", "caseExpr", "assignment", "declarative",
  "list", "listEntry", "cIndex", "index", "var", "valueList", "valueBlock",
  "funcCall", "$@1", "callParams", "exprOperand", "arrvals", "printf",
  "printVars", YY_NULLPTR
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_int16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,    61,    60,    62,    43,    45,    42,    47,    37,    33,
      40,    41,   123,   125,    44,    59,    58,    91,    93
};
# endif

#define YYPACT_NINF (-192)

#define yypact_value_is_default(Yyn) \
  ((Yyn) == YYPACT_NINF)

#define YYTABLE_NINF (-116)

#define yytable_value_is_error(Yyn) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int16 yypact[] =
{
      66,  -192,  -192,  -192,  -192,    18,  -192,    24,  -192,  -192,
      66,  -192,    25,  -192,    66,    49,    72,    89,  -192,    74,
      66,  -192,   256,    89,    97,    99,   100,   102,   278,   116,
     130,   131,    92,   256,   143,   138,   256,  -192,  -192,  -192,
    -192,  -192,  -192,  -192,  -192,  -192,  -192,   129,   134,   155,
     142,  -192,   551,  -192,  -192,    22,   146,   152,   154,    37,
     551,   551,  -192,   403,  -192,  -192,  -192,  -192,   551,   551,
     191,   551,   162,   -19,  -192,   172,  -192,  -192,  -192,  -192,
     551,  -192,  -192,  -192,  -192,   425,   550,   177,  -192,  -192,
     155,  -192,  -192,  -192,  -192,  -192,   450,  -192,  -192,  -192,
    -192,  -192,  -192,  -192,  -192,  -192,  -192,  -192,  -192,  -192,
    -192,   551,   550,   182,  -192,   550,   193,  -192,    23,   192,
    -192,   551,   136,   143,   550,   147,   551,    98,  -192,   550,
     189,   190,  -192,   203,   195,   550,   -16,   293,   200,  -192,
     201,  -192,  -192,   243,   244,   207,  -192,   209,   213,   211,
       4,  -192,  -192,   212,   216,   551,    -2,   551,    44,   234,
     279,   265,   551,    98,  -192,    98,    68,   229,   258,     4,
     203,  -192,   315,  -192,   140,   337,    50,   551,   248,   236,
    -192,  -192,   237,  -192,   238,  -192,  -192,  -192,    68,    68,
     381,  -192,   242,   271,  -192,   258,  -192,  -192,   251,   252,
     264,  -192,   179,   359,  -192,   551,   551,   233,  -192,   475,
     256,    68,   256,  -192,   271,  -192,   140,   255,   140,    58,
     257,   259,   268,   500,   525,  -192,  -192,  -192,  -192,   550,
    -192,  -192,  -192,    94,   273,  -192,   179,  -192,   179,   260,
     256,   147,   276,    67,   277,   280,   294,  -192,   294,  -192,
     120,   243,  -192,  -192,  -192,  -192,   179,   296,    87,   297,
    -192,  -192,  -192,  -192
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
      11,     6,     7,     8,     5,     0,     2,     0,     4,     3,
       9,     1,     0,    10,    13,     0,     0,    15,    17,     0,
       0,    14,    18,    15,     0,     0,     0,     0,     0,     0,
       0,     0,   116,    18,     0,     0,    18,    21,    20,    32,
      31,    28,    27,    29,    23,    24,    22,     0,     0,     0,
       0,    16,     0,    38,    39,    69,   139,   137,   138,   116,
       0,     0,    42,     0,   135,   136,    48,   134,     0,     0,
       0,     0,     0,   100,    92,    93,    12,    19,    26,    25,
       0,    30,   139,   137,   138,     0,    70,     0,    71,    72,
     135,    43,    40,    41,   127,    46,     0,    58,    57,    60,
      59,    62,    61,    56,    55,    50,    51,    52,    53,    54,
      44,     0,    76,     0,    77,    67,     0,    68,     0,     0,
      45,     0,     0,     0,    91,     0,    66,   130,    49,    47,
       0,     0,   140,     0,   117,   111,     0,     0,     0,   112,
     135,    94,    34,    33,    31,     0,    65,   133,     0,   131,
      78,    74,    73,   143,     0,     0,     0,     0,   101,     0,
       0,     0,    66,   130,   128,   130,     0,     0,     0,    78,
       0,   141,     0,    97,     0,     0,     0,     0,     0,     0,
      37,    36,     0,    35,     0,   129,   132,    89,     0,     0,
       0,    75,     0,    82,    80,     0,   142,   118,     0,   120,
       0,    96,     0,     0,    95,     0,     0,     0,    87,     0,
      18,     0,    18,    79,    82,   104,     0,     0,     0,     0,
       0,   120,   102,     0,     0,    64,    63,    90,    85,    88,
      86,    83,   119,     0,     0,   103,     0,   107,     0,     0,
       0,     0,     0,     0,     0,   122,   126,   123,   119,   124,
       0,     0,    33,    99,   106,   108,     0,     0,     0,     0,
     121,    98,   105,   109
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -192,  -192,  -192,     2,    73,   291,  -192,  -192,   299,   322,
     -32,  -122,   183,  -192,   184,  -117,  -192,  -192,  -192,   -23,
    -173,  -192,   198,   275,  -192,  -192,  -192,  -192,   196,  -159,
    -191,  -192,  -129,   -48,   306,   223,  -192,  -192,  -192,   -22,
    -144,  -170,  -192,  -192,  -124,  -192,  -121,  -192,   194
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,     5,     6,     7,    34,     9,    10,    16,    21,    17,
      35,    36,    37,    38,    39,    40,    41,    42,    43,   115,
     111,    44,   145,   146,    87,    45,    46,   113,   167,   168,
     169,   193,   190,    47,    48,    74,    75,   138,   139,    64,
     246,   220,    65,   127,   148,    66,    67,    50,   154
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int16 yytable[] =
{
      49,    72,   214,   143,    77,    63,   149,    88,   144,   152,
     195,    49,   121,   166,    49,   156,    15,   211,    11,   -82,
     114,   117,    15,   214,   173,     1,     2,     3,   122,    85,
     198,   157,    86,    90,   213,   211,   211,    95,    96,   185,
     174,   186,   149,   181,   149,   112,    90,    90,   119,    82,
      83,    84,    59,   199,    12,   231,   211,   124,   219,   208,
     209,    60,    61,   244,   132,    14,   247,   133,   249,     1,
       2,     3,   232,     8,   234,   176,   201,    94,   117,    18,
     259,   221,   229,     8,    71,   226,   260,     8,   129,   243,
       4,   177,   202,     8,   248,   199,   187,   199,   135,   137,
     140,   235,   236,    49,    90,   147,   258,   188,   189,    49,
     254,   236,   221,    19,   117,   221,    22,   221,   251,   252,
     242,    82,    83,    84,   144,    82,    83,    84,    32,   221,
     262,   236,   172,    20,   175,   221,   218,    52,    49,    71,
      90,   147,    55,   147,    53,    54,   257,    82,    83,    84,
       1,     2,     3,    24,   203,    25,    68,    26,    27,    28,
      29,    30,   218,    82,    83,    84,    59,    82,    83,    84,
      69,    70,    31,    73,    78,    60,    61,    32,   228,    79,
     230,    76,   223,   224,   136,    49,    80,    81,    49,    33,
      49,    91,   142,     1,     2,     3,    24,    92,    25,    93,
      26,    27,    28,    29,    30,   120,    82,    83,    84,    97,
      98,    99,   100,   101,   102,    31,   123,   118,    49,    49,
      32,   218,   126,   130,   103,   104,   105,   106,   107,   108,
     109,   150,    33,   153,   131,   151,     1,     2,     3,    24,
     134,    25,   155,    26,    27,    28,    29,    30,   159,  -115,
     160,   161,   162,   163,   164,   165,   170,   171,    31,     1,
       2,     3,    24,    32,    25,   178,    26,    27,    28,    29,
      30,   182,   191,   192,   204,    33,   205,   206,   225,   207,
     166,    31,     1,     2,     3,   179,    32,    25,   212,    26,
      27,    28,    29,    30,   215,   217,   216,   233,    33,   239,
     237,    13,   250,   238,    31,    56,    57,    58,    59,    32,
      97,    98,    99,   100,   101,   102,   245,    60,    61,   253,
     255,    33,    51,    62,   256,   103,   104,   105,   106,   107,
     108,   109,    97,    98,    99,   100,   101,   102,   236,   261,
     263,   158,    23,   180,   116,   183,   141,   103,   104,   105,
     106,   107,   108,   109,    97,    98,    99,   100,   101,   102,
     184,    89,     0,   197,   196,   194,     0,     0,     0,   103,
     104,   105,   106,   107,   108,   109,    97,    98,    99,   100,
     101,   102,     0,     0,     0,   200,     0,     0,     0,     0,
       0,   103,   104,   105,   106,   107,   108,   109,    97,    98,
      99,   100,   101,   102,     0,     0,     0,   222,     0,     0,
       0,     0,     0,   103,   104,   105,   106,   107,   108,   109,
      97,    98,    99,   100,   101,   102,     0,   210,     0,     0,
       0,     0,     0,     0,     0,   103,   104,   105,   106,   107,
     108,   109,    97,    98,    99,   100,   101,   102,   110,     0,
       0,     0,     0,     0,     0,     0,     0,   103,   104,   105,
     106,   107,   108,   109,     0,     0,   125,    97,    98,    99,
     100,   101,   102,     0,     0,     0,     0,     0,     0,     0,
       0,     0,   103,   104,   105,   106,   107,   108,   109,     0,
       0,   128,    97,    98,    99,   100,   101,   102,     0,     0,
       0,     0,     0,     0,     0,     0,     0,   103,   104,   105,
     106,   107,   108,   109,     0,     0,   227,    97,    98,    99,
     100,   101,   102,     0,     0,     0,     0,     0,     0,     0,
       0,     0,   103,   104,   105,   106,   107,   108,   109,     0,
       0,   240,    97,    98,    99,   100,   101,   102,     0,     0,
       0,     0,     0,     0,     0,     0,     0,   103,   104,   105,
     106,   107,   108,   109,     0,     0,   241,    97,    98,    99,
     100,   101,   102,     0,     0,     0,     0,     0,    82,    83,
      84,    59,   103,   104,   105,   106,   107,   108,   109,     0,
      60,    61
};

static const yytype_int16 yycheck[] =
{
      22,    33,   193,   125,    36,    28,   127,    55,   125,   131,
     169,    33,    31,     9,    36,    31,    14,   190,     0,    15,
      68,    69,    20,   214,    26,     3,     4,     5,    47,    52,
     174,    47,    55,    55,   193,   208,   209,    60,    61,   163,
      42,   165,   163,   160,   165,    68,    68,    69,    71,    27,
      28,    29,    30,   174,    30,   214,   229,    80,   202,   188,
     189,    39,    40,   233,    41,    40,   236,    44,   238,     3,
       4,     5,   216,     0,   218,    31,    26,    40,   126,    30,
     250,   202,   211,    10,    47,   207,   256,    14,   111,   233,
      24,    47,    42,    20,   238,   216,    28,   218,   121,   122,
     122,    43,    44,   125,   126,   127,   250,    39,    40,   131,
      43,    44,   233,    41,   162,   236,    42,   238,   240,   241,
      26,    27,    28,    29,   241,    27,    28,    29,    30,   250,
      43,    44,   155,    44,   157,   256,    42,    40,   160,    47,
     162,   163,    40,   165,    45,    45,    26,    27,    28,    29,
       3,     4,     5,     6,   177,     8,    40,    10,    11,    12,
      13,    14,    42,    27,    28,    29,    30,    27,    28,    29,
      40,    40,    25,    30,    45,    39,    40,    30,   210,    45,
     212,    43,   205,   206,    48,   207,    31,    45,   210,    42,
     212,    45,    45,     3,     4,     5,     6,    45,     8,    45,
      10,    11,    12,    13,    14,    43,    27,    28,    29,    17,
      18,    19,    20,    21,    22,    25,    44,    26,   240,   241,
      30,    42,    45,    41,    32,    33,    34,    35,    36,    37,
      38,    42,    42,    30,    41,    45,     3,     4,     5,     6,
      48,     8,    47,    10,    11,    12,    13,    14,    48,    48,
       7,     7,    45,    44,    41,    44,    44,    41,    25,     3,
       4,     5,     6,    30,     8,    31,    10,    11,    12,    13,
      14,     6,    43,    15,    26,    42,    40,    40,    45,    41,
       9,    25,     3,     4,     5,     6,    30,     8,    46,    10,
      11,    12,    13,    14,    43,    31,    44,    42,    42,    31,
      43,    10,    42,    44,    25,    27,    28,    29,    30,    30,
      17,    18,    19,    20,    21,    22,    43,    39,    40,    43,
      43,    42,    23,    45,    44,    32,    33,    34,    35,    36,
      37,    38,    17,    18,    19,    20,    21,    22,    44,    43,
      43,    48,    20,   160,    69,   161,   123,    32,    33,    34,
      35,    36,    37,    38,    17,    18,    19,    20,    21,    22,
     162,    55,    -1,    48,   170,   169,    -1,    -1,    -1,    32,
      33,    34,    35,    36,    37,    38,    17,    18,    19,    20,
      21,    22,    -1,    -1,    -1,    48,    -1,    -1,    -1,    -1,
      -1,    32,    33,    34,    35,    36,    37,    38,    17,    18,
      19,    20,    21,    22,    -1,    -1,    -1,    48,    -1,    -1,
      -1,    -1,    -1,    32,    33,    34,    35,    36,    37,    38,
      17,    18,    19,    20,    21,    22,    -1,    46,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    32,    33,    34,    35,    36,
      37,    38,    17,    18,    19,    20,    21,    22,    45,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    32,    33,    34,
      35,    36,    37,    38,    -1,    -1,    41,    17,    18,    19,
      20,    21,    22,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    32,    33,    34,    35,    36,    37,    38,    -1,
      -1,    41,    17,    18,    19,    20,    21,    22,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    32,    33,    34,
      35,    36,    37,    38,    -1,    -1,    41,    17,    18,    19,
      20,    21,    22,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    32,    33,    34,    35,    36,    37,    38,    -1,
      -1,    41,    17,    18,    19,    20,    21,    22,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    32,    33,    34,
      35,    36,    37,    38,    -1,    -1,    41,    17,    18,    19,
      20,    21,    22,    -1,    -1,    -1,    -1,    -1,    27,    28,
      29,    30,    32,    33,    34,    35,    36,    37,    38,    -1,
      39,    40
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_int8 yystos[] =
{
       0,     3,     4,     5,    24,    50,    51,    52,    53,    54,
      55,     0,    30,    54,    40,    52,    56,    58,    30,    41,
      44,    57,    42,    58,     6,     8,    10,    11,    12,    13,
      14,    25,    30,    42,    53,    59,    60,    61,    62,    63,
      64,    65,    66,    67,    70,    74,    75,    82,    83,    88,
      96,    57,    40,    45,    45,    40,    27,    28,    29,    30,
      39,    40,    45,    68,    88,    91,    94,    95,    40,    40,
      40,    47,    59,    30,    84,    85,    43,    59,    45,    45,
      31,    45,    27,    28,    29,    68,    68,    73,    82,    83,
      88,    45,    45,    45,    40,    68,    68,    17,    18,    19,
      20,    21,    22,    32,    33,    34,    35,    36,    37,    38,
      45,    69,    68,    76,    82,    68,    72,    82,    26,    68,
      43,    31,    47,    44,    68,    41,    45,    92,    41,    68,
      41,    41,    41,    44,    48,    68,    48,    68,    86,    87,
      88,    84,    45,    60,    64,    71,    72,    88,    93,    95,
      42,    45,    60,    30,    97,    47,    31,    47,    48,    48,
       7,     7,    45,    44,    41,    44,     9,    77,    78,    79,
      44,    41,    68,    26,    42,    68,    31,    47,    31,     6,
      61,    64,     6,    63,    71,    93,    93,    28,    39,    40,
      81,    43,    15,    80,    77,    78,    97,    48,    89,    95,
      48,    26,    42,    68,    26,    40,    40,    41,    81,    81,
      46,    69,    46,    78,    79,    43,    44,    31,    42,    89,
      90,    95,    48,    68,    68,    45,    60,    41,    59,    81,
      59,    78,    89,    42,    89,    43,    44,    43,    44,    31,
      41,    41,    26,    89,    90,    43,    89,    90,    89,    90,
      42,    60,    60,    43,    43,    43,    44,    26,    89,    90,
      90,    43,    43,    43
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_int8 yyr1[] =
{
       0,    49,    50,    51,    52,    52,    53,    53,    53,    54,
      54,    54,    55,    56,    56,    57,    57,    58,    59,    59,
      60,    60,    61,    61,    61,    61,    61,    61,    61,    61,
      61,    62,    62,    63,    63,    63,    64,    64,    65,    65,
      66,    66,    66,    66,    66,    67,    68,    68,    68,    68,
      69,    69,    69,    69,    69,    69,    69,    69,    69,    69,
      69,    69,    69,    70,    70,    71,    71,    72,    72,    73,
      73,    73,    73,    74,    74,    75,    76,    76,    77,    77,
      77,    77,    78,    78,    78,    79,    80,    81,    81,    81,
      81,    82,    83,    84,    84,    85,    85,    85,    85,    85,
      85,    85,    85,    85,    85,    85,    85,    85,    85,    85,
      85,    85,    86,    86,    87,    87,    88,    88,    88,    89,
      89,    90,    90,    90,    90,    90,    90,    92,    91,    93,
      93,    93,    93,    93,    94,    94,    94,    95,    95,    95,
      96,    96,    97,    97
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_int8 yyr2[] =
{
       0,     2,     1,     1,     1,     1,     1,     1,     1,     1,
       2,     0,     8,     0,     2,     0,     3,     2,     0,     2,
       1,     1,     1,     1,     1,     2,     2,     1,     1,     1,
       2,     1,     1,     5,     5,     7,     7,     1,     2,     2,
       3,     3,     2,     3,     3,     3,     2,     3,     1,     3,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     9,     9,     1,     0,     1,     1,     0,
       1,     1,     1,     5,     5,     7,     1,     1,     0,     3,
       2,     1,     0,     2,     1,     4,     3,     2,     3,     1,
       3,     3,     2,     1,     3,     6,     6,     5,    11,    10,
       1,     4,     7,     8,     7,    11,    10,     8,    10,    11,
      10,     3,     1,     0,     1,     1,     1,     4,     7,     3,
       1,     5,     3,     3,     3,     1,     1,     0,     5,     3,
       0,     1,     3,     1,     1,     1,     1,     1,     1,     1,
       4,     6,     3,     1
};


#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)
#define YYEMPTY         (-2)
#define YYEOF           0

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                    \
  do                                                              \
    if (yychar == YYEMPTY)                                        \
      {                                                           \
        yychar = (Token);                                         \
        yylval = (Value);                                         \
        YYPOPSTACK (yylen);                                       \
        yystate = *yyssp;                                         \
        goto yybackup;                                            \
      }                                                           \
    else                                                          \
      {                                                           \
        yyerror (YY_("syntax error: cannot back up")); \
        YYERROR;                                                  \
      }                                                           \
  while (0)

/* Error token number */
#define YYTERROR        1
#define YYERRCODE       256



/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)

/* This macro is provided for backward compatibility. */
#ifndef YY_LOCATION_PRINT
# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
#endif


# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Type, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*-----------------------------------.
| Print this symbol's value on YYO.  |
`-----------------------------------*/

static void
yy_symbol_value_print (FILE *yyo, int yytype, YYSTYPE const * const yyvaluep)
{
  FILE *yyoutput = yyo;
  YYUSE (yyoutput);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyo, yytoknum[yytype], *yyvaluep);
# endif
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/*---------------------------.
| Print this symbol on YYO.  |
`---------------------------*/

static void
yy_symbol_print (FILE *yyo, int yytype, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyo, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  yy_symbol_value_print (yyo, yytype, yyvaluep);
  YYFPRINTF (yyo, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yy_state_t *yybottom, yy_state_t *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yy_state_t *yyssp, YYSTYPE *yyvsp, int yyrule)
{
  int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %d):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       yystos[+yyssp[yyi + 1 - yynrhs]],
                       &yyvsp[(yyi + 1) - (yynrhs)]
                                              );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen(S) (YY_CAST (YYPTRDIFF_T, strlen (S)))
#  else
/* Return the length of YYSTR.  */
static YYPTRDIFF_T
yystrlen (const char *yystr)
{
  YYPTRDIFF_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYPTRDIFF_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYPTRDIFF_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
        switch (*++yyp)
          {
          case '\'':
          case ',':
            goto do_not_strip_quotes;

          case '\\':
            if (*++yyp != '\\')
              goto do_not_strip_quotes;
            else
              goto append;

          append:
          default:
            if (yyres)
              yyres[yyn] = *yyp;
            yyn++;
            break;

          case '"':
            if (yyres)
              yyres[yyn] = '\0';
            return yyn;
          }
    do_not_strip_quotes: ;
    }

  if (yyres)
    return yystpcpy (yyres, yystr) - yyres;
  else
    return yystrlen (yystr);
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYPTRDIFF_T *yymsg_alloc, char **yymsg,
                yy_state_t *yyssp, int yytoken)
{
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat: reported tokens (one for the "unexpected",
     one per "expected"). */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Actual size of YYARG. */
  int yycount = 0;
  /* Cumulated lengths of YYARG.  */
  YYPTRDIFF_T yysize = 0;

  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[+*yyssp];
      YYPTRDIFF_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
      yysize = yysize0;
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYPTRDIFF_T yysize1
                    = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
                  if (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM)
                    yysize = yysize1;
                  else
                    return 2;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
    default: /* Avoid compiler warnings. */
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    /* Don't count the "%s"s in the final size, but reserve room for
       the terminator.  */
    YYPTRDIFF_T yysize1 = yysize + (yystrlen (yyformat) - 2 * yycount) + 1;
    if (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM)
      yysize = yysize1;
    else
      return 2;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          ++yyp;
          ++yyformat;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
{
  YYUSE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}




/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    yy_state_fast_t yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yy_state_t yyssa[YYINITDEPTH];
    yy_state_t *yyss;
    yy_state_t *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYPTRDIFF_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYPTRDIFF_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
  goto yysetstate;


/*------------------------------------------------------------.
| yynewstate -- push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;


/*--------------------------------------------------------------------.
| yysetstate -- set current state (the top of the stack) to yystate.  |
`--------------------------------------------------------------------*/
yysetstate:
  YYDPRINTF ((stderr, "Entering state %d\n", yystate));
  YY_ASSERT (0 <= yystate && yystate < YYNSTATES);
  YY_IGNORE_USELESS_CAST_BEGIN
  *yyssp = YY_CAST (yy_state_t, yystate);
  YY_IGNORE_USELESS_CAST_END

  if (yyss + yystacksize - 1 <= yyssp)
#if !defined yyoverflow && !defined YYSTACK_RELOCATE
    goto yyexhaustedlab;
#else
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYPTRDIFF_T yysize = yyssp - yyss + 1;

# if defined yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        yy_state_t *yyss1 = yyss;
        YYSTYPE *yyvs1 = yyvs;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * YYSIZEOF (*yyssp),
                    &yyvs1, yysize * YYSIZEOF (*yyvsp),
                    &yystacksize);
        yyss = yyss1;
        yyvs = yyvs1;
      }
# else /* defined YYSTACK_RELOCATE */
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yy_state_t *yyss1 = yyss;
        union yyalloc *yyptr =
          YY_CAST (union yyalloc *,
                   YYSTACK_ALLOC (YY_CAST (YYSIZE_T, YYSTACK_BYTES (yystacksize))));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
# undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YY_IGNORE_USELESS_CAST_BEGIN
      YYDPRINTF ((stderr, "Stack size increased to %ld\n",
                  YY_CAST (long, yystacksize)));
      YY_IGNORE_USELESS_CAST_END

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }
#endif /* !defined yyoverflow && !defined YYSTACK_RELOCATE */

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;


/*-----------.
| yybackup.  |
`-----------*/
yybackup:
  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);
  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  /* Discard the shifted token.  */
  yychar = YYEMPTY;
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
  case 2:
#line 117 "syntaxAnalyzer.y"
            { 
        printf("valid input");
        return 1;
        
        }
#line 1716 "y.tab.c"
    break;

  case 11:
#line 138 "syntaxAnalyzer.y"
              {(yyval.t).nd=malloc(sizeof(struct node)); (yyval.t).nd=NULL;}
#line 1722 "y.tab.c"
    break;

  case 127:
#line 384 "syntaxAnalyzer.y"
                              {funccallflag=1;}
#line 1728 "y.tab.c"
    break;


#line 1732 "y.tab.c"

      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */
  {
    const int yylhs = yyr1[yyn] - YYNTOKENS;
    const int yyi = yypgoto[yylhs] + *yyssp;
    yystate = (0 <= yyi && yyi <= YYLAST && yycheck[yyi] == *yyssp
               ? yytable[yyi]
               : yydefgoto[yylhs]);
  }

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = YY_CAST (char *, YYSTACK_ALLOC (YY_CAST (YYSIZE_T, yymsg_alloc)));
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:
  /* Pacify compilers when the user code never invokes YYERROR and the
     label yyerrorlab therefore never appears in user code.  */
  if (0)
    YYERROR;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYTERROR;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;


/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;


#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif


/*-----------------------------------------------------.
| yyreturn -- parsing is finished, return the result.  |
`-----------------------------------------------------*/
yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  yystos[+*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  return yyresult;
}
#line 414 "syntaxAnalyzer.y"
 
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
