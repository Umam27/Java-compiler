%{
    #include<bits/stdc++.h>
    using namespace std;
    #include "ast.h"
    #include "symtab.h"
    #include "new.tab.h"
    extern YYSTYPE yylval;
    int yylex();

    // int n;
%}

digit [0-9]
nonZeroDigit [1-9]
letter [a-zA-Z_]

%option yylineno

%%

" " {
    printf(" ");
}

"\n" {
    printf("\n");
}

"\t" {
    printf("\t");
}

\/\/.* {
    // printf("//comment ");
}
"/*"(.|\n)*"*/" {
    // Handling Comment
    printf("/*Comment*/");
}

"=" {
    printf("=");
    
    yylval.TL.str = strdup(yytext);
    return ASN;
}
"*=" {
    printf("*=");
    
    yylval.TL.str = strdup(yytext);
    return MUASN;
}
"/=" {
    printf("/=");
    
    yylval.TL.str = strdup(yytext);
    return DIASN;
}
"%=" {
    printf("mod=");
    
    yylval.TL.str = strdup(yytext);
    return MODASN;
}
"+=" {
    printf("+=");
    
    yylval.TL.str = strdup(yytext);
    return PLASN;
}
"-=" {
    printf("-=");
    
    yylval.TL.str = strdup(yytext);
    return MIASN;
}
"<<=" {
    printf("<<=");
    
    yylval.TL.str = strdup(yytext);
    return SLASN;
}
">>=" {
    printf(">>=");
    
    yylval.TL.str = strdup(yytext);
    return SRASN;
}
">>>=" {
    printf(">>>=");
    
    yylval.TL.str = strdup(yytext);
    return LSRASN;
}
"&=" {
    
    printf("&=");
    
    yylval.TL.str = strdup(yytext);
    return ANDASN;
}
"^=" {
    printf("^=");
    
    yylval.TL.str = strdup(yytext);
    return CARETASN;
}
"|=" {
    printf("|=");
    
    yylval.TL.str = strdup(yytext);
    return ORASN;
}

"(" {
    printf("(");
    
    yylval.TL.str = strdup(yytext);
    return LP;
}
")" {
    printf(")");
    
    yylval.TL.str = strdup(yytext);
    return RP;
}
"{" {
    printf("{");
    
    yylval.TL.str = strdup(yytext);
    return LC;
}
"}" {
    printf("}");
    
    yylval.TL.str = strdup(yytext);
    return RC;
}
"[" {
    printf("[");
    
    yylval.TL.str = strdup(yytext);
    return LB;
}
"]" {
    printf("]");
    
    yylval.TL.str = strdup(yytext);
    return RB;
}
"<" {
    printf("<");
    
    yylval.TL.str = strdup(yytext);
    return LT;
}
">" {
    printf(">");
    
    yylval.TL.str = strdup(yytext);
    return GT;
}
";"    {
    printf(";");
    
    yylval.TL.str = strdup(yytext);
    return SM;
}
"," {
    printf(",");
    
    yylval.TL.str = strdup(yytext);
    return CM;
}
"."    {
    printf(".");
    
    yylval.TL.str = strdup(yytext);
    return DOT;
}
"!" {
    printf("!");
    
    yylval.TL.str = strdup(yytext);
    return EXCL;
}
"~" {
    printf("~");
    
    yylval.TL.str = strdup(yytext);
    return TILDE;
}
"^" {
    printf("^");
    
    yylval.TL.str = strdup(yytext);
    return CARET;
}
"?" {
    printf("?");
    
    yylval.TL.str = strdup(yytext);
    return QUEST;
}
":" {
    printf(":");
    
    yylval.TL.str = strdup(yytext);
    return COLON;
}
"::"    {
    printf("::");
    
    yylval.TL.str = strdup(yytext);
    return ACCESSSPEC;
}

"++"    {
    printf("++");
    
    yylval.TL.str = strdup(yytext);
    return INC;
}
"--"    {
    printf("--");
    
    yylval.TL.str = strdup(yytext);
    return DEC;
}

"+" {
    printf("+");
    
    yylval.TL.str = strdup(yytext);
    return PLUS;
}
"-" {
    printf("-");
    
    yylval.TL.str = strdup(yytext);
    return MINUS;
}
"*" {
    printf("*");
    
    yylval.TL.str = strdup(yytext);
    return MUL;
}
"/" {
    printf("/");
    
    yylval.TL.str = strdup(yytext);
    return DIV;
}
"%" {
    printf("mod");
    
    yylval.TL.str = strdup(yytext);
    return MOD;
}

"<<" {
    printf("<<");
    
    yylval.TL.str = strdup(yytext);
    return SHL;
}
">>" {
    printf("<<");
    
    yylval.TL.str = strdup(yytext);
    return SHR;
}
">>>" {
    printf(">>>");
    
    yylval.TL.str = strdup(yytext);
    return LSHR;
}

"<=" {
    printf("<=");
    
    yylval.TL.str = strdup(yytext);
    return LE;
}
">=" {
    printf(">=");
    
    yylval.TL.str = strdup(yytext);
    return GE;
}
"==" {
    printf("==");
    
    yylval.TL.str = strdup(yytext);
    return EQ;
}
"!=" {
    printf("!=");
    
    yylval.TL.str = strdup(yytext);
    return NE;
}

"&" {
    printf("&");
    
    yylval.TL.str = strdup(yytext);
    return AND;
}
"|" {
    printf("|");
    
    yylval.TL.str = strdup(yytext);
    return OR;
}
"&&" {
    printf("&&");
    
    yylval.TL.str = strdup(yytext);
    return ANDAND;
}
"||" {
    printf("||");
    
    yylval.TL.str = strdup(yytext);
    return OROR;
}

"->" {
    printf("->");
    
    yylval.TL.str = strdup(yytext);
    return ARROW;
}
"<>"    {
    printf("<>");
    
    yylval.TL.str = strdup(yytext);
    return DIAMOND;
}
"@"    {
    printf("@");
    
    yylval.TL.str = strdup(yytext);
    return ATR;
}
"..." {
    printf("...");
    
    yylval.TL.str = strdup(yytext);
    return TDOT;
}

"var"    {
    printf("var");
    
    yylval.TL.str = strdup(yytext);
    return VAR;
}
"new"    {
    printf("new");
    
    yylval.TL.str = strdup(yytext);
    return NEW;
}
"super"    {
    printf("super");
    
    yylval.TL.str = strdup(yytext);
    return SUPER;
}
"class"    {
    printf("class");
    
    yylval.TL.str = strdup(yytext);
    return CLASS;
}
"void"    {
    printf("void");
    
    yylval.TL.str = strdup(yytext);
    return VOID;
}
"this"    {
    printf("this");
    
    yylval.TL.str = strdup(yytext);
    return THIS;
}
"try"    {
    printf("try");
    
    yylval.TL.str = strdup(yytext);
    return TRY;
}

"instanceof" {
    printf("instanceof");
    
    yylval.TL.str = strdup(yytext);
    return INSTANCEOF;
}
"finally"    {
    printf("finally");
    
    yylval.TL.str = strdup(yytext);
    return FINALLY;
}
"catch"    {
    printf("finally");
    
    yylval.TL.str = strdup(yytext);
    return CATCH;
}
"synchronized"    {
    printf("synchronized");
    
    yylval.TL.str = strdup(yytext);
    return SYNCHRONIZED;
}
"throw"    {
    printf("throw");
    
    yylval.TL.str = strdup(yytext);
    return THROW;
}
"return"    {
    printf("return");
    
    yylval.TL.str = strdup(yytext);
    return RETURN;
}
"continue"    {
    printf("continue");
    
    yylval.TL.str = strdup(yytext);
    return CONTINUE;
}
"yield"    {
    printf("yield");
    
    yylval.TL.str = strdup(yytext);
    return YIELD;
}
"break"    {
    printf("break");
    
    yylval.TL.str = strdup(yytext);
    return BREAK;
}

"for"    {
    printf("for");
    
    yylval.TL.str = strdup(yytext);
    return FOR;
}
"do"    {
    printf("do");
    
    yylval.TL.str = strdup(yytext);
    return DO;
}
"while"    {
    printf("while");
    
    yylval.TL.str = strdup(yytext);
    return WHILE;
}
"default"    {
    printf("default");
    
    yylval.TL.str = strdup(yytext);
    return DEFAULT;
}
"assert"    {
    printf("assert");
    
    yylval.TL.str = strdup(yytext);
    return ASSERT;
}
"switch"    {
    printf("switch");
    
    yylval.TL.str = strdup(yytext);
    return SWITCH;
}
"case"    {
    printf("case");
    
    yylval.TL.str = strdup(yytext);
    return CASE;
}
"if"    {
    printf("if");
    
    yylval.TL.str = strdup(yytext);
    return IF;
}
"else"    {
    printf("else");
    
    yylval.TL.str = strdup(yytext);
    return ELSE;
}

"byte" {
    printf("byte");
    
    yylval.TL.str = strdup(yytext);
    return BYTE;
}
"boolean"    {
    printf("boolean");
    
    yylval.TL.str = strdup(yytext);
    return BOOLEAN;
}
"char" {
    printf("char");
    
    yylval.TL.str = strdup(yytext);
    return CHAR;
}
"double" {
    printf("double");
    
    yylval.TL.str = strdup(yytext);
    return DOUBLE;
}
"float" {
    printf("float");
    
    yylval.TL.str = strdup(yytext);
    return FLOAT;
}
"int" {
    printf("int");
    
    yylval.TL.str = strdup(yytext);
    return INT;
}
"long" {
    printf("long");
    
    yylval.TL.str = strdup(yytext);
    return LONG;
}
"short" {
    printf("short");
    
    yylval.TL.str = strdup(yytext);
    return SHORT;
}

"const" {
    printf("const");
    
    yylval.TL.str = strdup(yytext);
    return CONST;
}
"goto" {
    printf("goto");
    
    yylval.TL.str = strdup(yytext);
    return GOTO;
}

"abstract"    {
    printf("abstract");
    
    yylval.TL.str = strdup(yytext);
    return ABSTRACT;
}
"protected"    {
    printf("protected");
    
    yylval.TL.str = strdup(yytext);
    return PROTECTED;
}
"public"    {
    printf("public");
    
    yylval.TL.str = strdup(yytext);
    return PUBLIC;
}
"private"    {
    printf("private");
    
    yylval.TL.str = strdup(yytext);
    return PRIVATE;
}
"interface"    {
    printf("interface");
    
    yylval.TL.str = strdup(yytext);
    return INTERFACE;
}
"static"    {
    printf("static");
    
    yylval.TL.str = strdup(yytext);
    return STATIC;
}
"strictfp"    {
    printf("strictfp");
    
    yylval.TL.str = strdup(yytext);
    return STRICTFP;
}
"final"    {
    printf("final");
    
    yylval.TL.str = strdup(yytext);
    return FINAL;
}
"permits"    {
    printf("permits");
    
    yylval.TL.str = strdup(yytext);
    return PERMITS;
}
"extends"    {
    printf("extends");
    
    yylval.TL.str = strdup(yytext);
    return EXTENDS;
}
"sealed"    {
    printf("sealed");
    
    yylval.TL.str = strdup(yytext);
    return SEALED;
}
"non-sealed"    {
    printf("non-sealed");
    
    yylval.TL.str = strdup(yytext);
    return NSEALED;
}
"transitive"    {
    printf("transitive");
    
    yylval.TL.str = strdup(yytext);
    return TRANSITIVE;
}
"throws"    {
    printf("transitive");
    
    yylval.TL.str = strdup(yytext);
    return THROWS;
}
"native"    {
    printf("native");
    
    yylval.TL.str = strdup(yytext);
    return NATIVE;
}
"transient" {
    printf("transient");
    
    yylval.TL.str = strdup(yytext);
    return TRANSIENT;
}
"volatile"    {
    printf("volatile");
    
    yylval.TL.str = strdup(yytext);
    return VOLATILE;
}
"implements"    {
    printf("implements");
    
    yylval.TL.str = strdup(yytext);
    return IMPLEMENTS;
}

"provides"    {
    printf("provides");
    
    yylval.TL.str = strdup(yytext);
    return PROVIDES;
}

"with"    {
    printf("with");
    
    yylval.TL.str = strdup(yytext);
    return WITH;
}

"uses"    {
    printf("uses");
    
    yylval.TL.str = strdup(yytext);
    return USES;
}

"opens"    {
    printf("opens");
    
    yylval.TL.str = strdup(yytext);
    return OPENS;
}

"record"    {
    printf("record");
    
    yylval.TL.str = strdup(yytext);
    return RECORD;
}
"to"    {
    printf("to");
    
    yylval.TL.str = strdup(yytext);
    return TO;
}
"exports"    {
    printf("exports");
    
    yylval.TL.str = strdup(yytext);
    return EXPORTS;
}
"requires"    {
    printf("requires");
    
    yylval.TL.str = strdup(yytext);
    return REQUIRES;
}
"open"    {
    printf("open");
    
    yylval.TL.str = strdup(yytext);
    return OPEN;
}
"module"    {
    printf("module");
    
    yylval.TL.str = strdup(yytext);
    return MODULE;
}
"import"    {
    printf("import");
    
    yylval.TL.str = strdup(yytext);
    return IMPORT;
}
"package"    {
    printf("package");
    
    yylval.TL.str = strdup(yytext);
    return PACKAGE;
}
"enum"    {
    printf("enum");
    
    yylval.TL.str = strdup(yytext);
    return ENUM;
}


0[xX][0-9a-fA-F][0-9a-fA-F_]+[lL]? {
    printf("%s", yytext);
    yylval.TL.str = strdup(yytext);
    return INTLITERAL;
}
0[lL]?|{nonZeroDigit}[0-9_]*{digit}*[lL]?|{nonZeroDigit}[]+[0-9*]{digit}+[lL]? {
    printf("%s", yytext);
    yylval.TL.str = strdup(yytext);
    return INTLITERAL;
}
[0][0-7]+[_0-7]+[lL]?   {
    printf("%s", yytext);
    yylval.TL.str = strdup(yytext);
    return INTLITERAL;
}
[0][bB][01][01_]+[lL]?   {
    printf("%s", yytext);
    yylval.TL.str = strdup(yytext);
    return INTLITERAL;
}

{digit}+[fF] {
    printf("%s", yytext);
    yylval.TL.str = strdup(yytext);
    return FLOATLITERAL;
}
{digit}+\.{digit}*([eE][+-]?{digit}+)?[fF] {
    printf("%s", yytext);
    yylval.TL.str = strdup(yytext);
    return FLOATLITERAL;
}
\.{digit}+([eE][+-]?{digit}+)?[fF] {
    printf("%s", yytext);
    yylval.TL.str = strdup(yytext);
    return FLOATLITERAL;
}
{digit}+[eE][+-]?{digit}+[fF] {
    printf("%s", yytext);
    yylval.TL.str = strdup(yytext);
    return FLOATLITERAL;
}
{digit}+\.{digit}*([eE][+-]?{digit}+)?[dD]? {
    printf("%s", yytext);
    yylval.TL.str = strdup(yytext);
    return FLOATLITERAL;
}
\.{digit}+([eE][+-]?{digit}+)?[dD]? {
    printf("%s", yytext);
    yylval.TL.str = strdup(yytext);
    return FLOATLITERAL;
}
{digit}+[eE][+-]?{digit}+[dD]? {
    printf("%s", yytext);
    yylval.TL.str = strdup(yytext);
    return FLOATLITERAL;
}

"true"|"false" {
    printf("%s", yytext);
    yylval.TL.str = strdup(yytext);
    return BOOLLITERAL;
}

"\""[^\"]*"\"" {
    printf("%s", yytext);
    yylval.TL.str = strdup(yytext);
    return STRINGLITERAL;
}

'.'|'%' {
    printf("%s", yytext);
    yylval.TL.str = strdup(yytext);
    return CHARLITERAL;
}

"null" {
    printf("%s", yytext);
    yylval.TL.str = strdup(yytext);
    return NULLLITERAL;
}

"System.out.println" {
    
    printf("%s", yytext);
    yylval.TL.str = strdup(yytext);
    return IDENT;
}
"System.out.print" {
    
    printf("%s", yytext);
    yylval.TL.str = strdup(yytext);
    return IDENT;
}

{letter}({digit}|{letter})* {
    
    printf("%s", yytext);
    yylval.TL.str = strdup(yytext);
    return IDENT;
}

{digit}+{letter}+ {
    printf("Invalid Identifier");
    return 0; 
}



%%

int yywrap() {return 1;}
