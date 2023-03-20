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

#ifndef YY_YY_NEW_TAB_H_INCLUDED
# define YY_YY_NEW_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    ABSTRACT = 258,
    BOOLEAN = 259,
    BREAK = 260,
    BYTE = 261,
    CASE = 262,
    CATCH = 263,
    CHAR = 264,
    CLASS = 265,
    CONST = 266,
    DEFAULT = 267,
    DO = 268,
    DOUBLE = 269,
    ELSE = 270,
    EXTENDS = 271,
    FINAL = 272,
    FINALLY = 273,
    FLOAT = 274,
    FOR = 275,
    GOTO = 276,
    IF = 277,
    IMPLEMENTS = 278,
    IMPORT = 279,
    INSTANCEOF = 280,
    INT = 281,
    INTERFACE = 282,
    LONG = 283,
    NATIVE = 284,
    NEW = 285,
    PACKAGE = 286,
    PRIVATE = 287,
    PROTECTED = 288,
    PUBLIC = 289,
    RETURN = 290,
    SUSPEND = 291,
    ASSERT = 292,
    SHORT = 293,
    STATIC = 294,
    SUPER = 295,
    SWITCH = 296,
    SYNCHRONIZED = 297,
    THIS = 298,
    THROW = 299,
    THROWS = 300,
    VOID = 301,
    VOLATILE = 302,
    WHILE = 303,
    IDENT = 304,
    CONTINUE = 305,
    TRANSIENT = 306,
    TRY = 307,
    NULLLITERAL = 308,
    BOOLLITERAL = 309,
    INTLITERAL = 310,
    CHARLITERAL = 311,
    FLOATLITERAL = 312,
    STRINGLITERAL = 313,
    LP = 314,
    RP = 315,
    LC = 316,
    RC = 317,
    LB = 318,
    RB = 319,
    SM = 320,
    CM = 321,
    DOT = 322,
    ASN = 323,
    LT = 324,
    GT = 325,
    EXCL = 326,
    TILDE = 327,
    QUEST = 328,
    COLON = 329,
    EQ = 330,
    NE = 331,
    LE = 332,
    GE = 333,
    ANDAND = 334,
    OROR = 335,
    INC = 336,
    DEC = 337,
    PLUS = 338,
    MINUS = 339,
    MUL = 340,
    DIV = 341,
    AND = 342,
    OR = 343,
    CARET = 344,
    MOD = 345,
    SHL = 346,
    SHR = 347,
    LSHR = 348,
    PLASN = 349,
    MIASN = 350,
    MUASN = 351,
    DIASN = 352,
    MODASN = 353,
    ANDASN = 354,
    ORASN = 355,
    CARETASN = 356,
    SLASN = 357,
    SRASN = 358,
    LSRASN = 359,
    ATR = 360,
    ACCESSSPEC = 361,
    ARROW = 362,
    DIAMOND = 363,
    TDOT = 364,
    EXPORTS = 365,
    OPENS = 366,
    REQUIRES = 367,
    USES = 368,
    MODULE = 369,
    PERMITS = 370,
    SEALED = 371,
    VAR = 372,
    NSEALED = 373,
    PROVIDES = 374,
    TO = 375,
    WITH = 376,
    OPEN = 377,
    RECORD = 378,
    TRANSITIVE = 379,
    YIELD = 380,
    STRICTFP = 381,
    ENUM = 382
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 23 "new.y"

   char* str;
   ASTnode* n;
   ASTnodes* ns;

#line 191 "new.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_NEW_TAB_H_INCLUDED  */
