%{
    #include<bits/stdc++.h>
    using namespace std;
    #include "ast.h"
    #include "new.tab.h"
    extern YYSTYPE yylval;
    int yylex();
%}

digit [0-9]
nonZeroDigit [1-9]
letter [a-zA-Z_]

%option yylineno

%%

" " {
    //printf(" ");
}

"\n" {
    //printf("\n");
}

"\t" {
    //printf("\t");
}

\/\/.* {
    // //printf("//commemt ");
}
"/*"(.|\n)*"*/" {
    // Handling Comment
    //printf("/*Comment*/");
}

"=" {
    //printf("=");
    yylval.str = yytext;
    return ASN;
}
"*=" {
    //printf("*=");
    yylval.str = yytext;
    return MUASN;
}
"/=" {
    //printf("/=");
    yylval.str = yytext;
    return DIASN;
}
"%=" {
    //printf("mod=");
    yylval.str = yytext;
    return MODASN;
}
"+=" {
    //printf("+=");
    yylval.str = yytext;
    return PLASN;
}
"-=" {
    //printf("-=");
    yylval.str = yytext;
    return MIASN;
}
"<<=" {
    //printf("<<=");
    yylval.str = yytext;
    return SLASN;
}
">>=" {
    //printf(">>=");
    yylval.str = yytext;
    return SRASN;
}
">>>=" {
    //printf(">>>=");
    yylval.str = yytext;
    return LSRASN;
}
"&=" {
    
    //printf("&=");
    yylval.str = yytext;
    return ANDASN;
}
"^=" {
    //printf("^=");
    yylval.str = yytext;
    return CARETASN;
}
"|=" {
    //printf("|=");
    yylval.str = yytext;
    return ORASN;
}

"(" {
    //printf("(");
    yylval.str = yytext;
    return LP;
}
")" {
    //printf(")");
    yylval.str = yytext;
    return RP;
}
"{" {
    //printf("{");
    yylval.str = yytext;
    return LC;
}
"}" {
    //printf("}");
    yylval.str = yytext;
    return RC;
}
"[" {
    //printf("[");
    yylval.str = yytext;
    return LB;
}
"]" {
    //printf("]");
    yylval.str = yytext;
    return RB;
}
"<" {
    //printf("<");
    yylval.str = yytext;
    return LT;
}
">" {
    //printf(">");
    yylval.str = yytext;
    return GT;
}
";"    {
    //printf(";");
    yylval.str = yytext;
    return SM;
}
"," {
    //printf(",");
    yylval.str = yytext;
    return CM;
}
"."    {
    //printf(".");
    yylval.str = yytext;
    return DOT;
}
"!" {
    //printf("!");
    yylval.str = yytext;
    return EXCL;
}
"~" {
    //printf("~");
    yylval.str = yytext;
    return TILDE;
}
"^" {
    //printf("^");
    yylval.str = yytext;
    return CARET;
}
"?" {
    //printf("?");
    yylval.str = yytext;
    return QUEST;
}
":" {
    //printf(":");
    yylval.str = yytext;
    return COLON;
}
"::"    {
    //printf("::");
    yylval.str = yytext;
    return ACCESSSPEC;
}

"++"    {
    //printf("++");
    yylval.str = yytext;
    return INC;
}
"--"    {
    //printf("--");
    yylval.str = yytext;
    return DEC;
}

"+" {
    //printf("+");
    yylval.str = yytext;
    return PLUS;
}
"-" {
    //printf("-");
    yylval.str = yytext;
    return MINUS;
}
"*" {
    //printf("*");
    yylval.str = yytext;
    return MUL;
}
"/" {
    //printf("/");
    yylval.str = yytext;
    return DIV;
}
"%" {
    //printf("mod");
    yylval.str = yytext;
    return MOD;
}

"<<" {
    //printf("<<");
    yylval.str = yytext;
    return SHL;
}
">>" {
    //printf("<<");
    yylval.str = yytext;
    return SHR;
}
">>>" {
    //printf(">>>");
    yylval.str = yytext;
    return LSHR;
}

"<=" {
    //printf("<=");
    yylval.str = yytext;
    return LE;
}
">=" {
    //printf(">=");
    yylval.str = yytext;
    return GE;
}
"==" {
    //printf("==");
    yylval.str = yytext;
    return EQ;
}
"!=" {
    //printf("!=");
    yylval.str = yytext;
    return NE;
}

"&" {
    //printf("&");
    yylval.str = yytext;
    return AND;
}
"|" {
    //printf("|");
    yylval.str = yytext;
    return OR;
}
"&&" {
    //printf("&&");
    yylval.str = yytext;
    return ANDAND;
}
"||" {
    //printf("||");
    yylval.str = yytext;
    return OROR;
}

"->" {
    //printf("->");
    yylval.str = yytext;
    return ARROW;
}
"<>"    {
    //printf("<>");
    yylval.str = yytext;
    return DIAMOND;
}
"@"    {
    //printf("@");
    yylval.str = yytext;
    return ATR;
}
"..." {
    //printf("...");
    yylval.str = yytext;
    return TDOT;
}

"var"    {
    //printf("var");
    yylval.str = yytext;
    return VAR;
}
"new"    {
    //printf("new");
    yylval.str = yytext;
    return NEW;
}
"super"    {
    //printf("super");
    yylval.str = yytext;
    return SUPER;
}
"class"    {
    //printf("class");
    yylval.str = yytext;
    return CLASS;
}
"void"    {
    //printf("void");
    yylval.str = yytext;
    return VOID;
}
"this"    {
    //printf("this");
    yylval.str = yytext;
    return THIS;
}
"try"    {
    //printf("try");
    yylval.str = yytext;
    return TRY;
}

"instanceof" {
    //printf("instanceof");
    yylval.str = yytext;
    return INSTANCEOF;
}
"finally"    {
    //printf("finally");
    yylval.str = yytext;
    return FINALLY;
}
"catch"    {
    //printf("finally");
    yylval.str = yytext;
    return CATCH;
}
"synchronized"    {
    //printf("synchronized");
    yylval.str = yytext;
    return SYNCHRONIZED;
}
"throw"    {
    //printf("throw");
    yylval.str = yytext;
    return THROW;
}
"return"    {
    //printf("return");
    yylval.str = yytext;
    return RETURN;
}
"continue"    {
    //printf("continue");
    yylval.str = yytext;
    return CONTINUE;
}
"yield"    {
    //printf("yield");
    yylval.str = yytext;
    return YIELD;
}
"break"    {
    //printf("break");
    yylval.str = yytext;
    return BREAK;
}

"for"    {
    //printf("for");
    yylval.str = yytext;
    return FOR;
}
"do"    {
    //printf("do");
    yylval.str = yytext;
    return DO;
}
"while"    {
    //printf("while");
    yylval.str = yytext;
    return WHILE;
}
"default"    {
    //printf("default");
    yylval.str = yytext;
    return DEFAULT;
}
"assert"    {
    //printf("assert");
    yylval.str = yytext;
    return ASSERT;
}
"switch"    {
    //printf("switch");
    yylval.str = yytext;
    return SWITCH;
}
"case"    {
    //printf("case");
    yylval.str = yytext;
    return CASE;
}
"if"    {
    //printf("if");
    yylval.str = yytext;
    return IF;
}
"else"    {
    //printf("else");
    yylval.str = yytext;
    return ELSE;
}

"byte" {
    //printf("byte");
    yylval.str = yytext;
    return BYTE;
}
"boolean"    {
    //printf("boolean");
    yylval.str = yytext;
    return BOOLEAN;
}
"char" {
    //printf("char");
    yylval.str = yytext;
    return CHAR;
}
"double" {
    //printf("double");
    yylval.str = yytext;
    return DOUBLE;
}
"float" {
    //printf("float");
    yylval.str = yytext;
    return FLOAT;
}
"int" {
    //printf("int");
    yylval.str = yytext;
    return INT;
}
"long" {
    //printf("long");
    yylval.str = yytext;
    return LONG;
}
"short" {
    //printf("short");
    yylval.str = yytext;
    return SHORT;
}

"const" {
    //printf("const");
    yylval.str = yytext;
    return CONST;
}
"goto" {
    //printf("goto");
    yylval.str = yytext;
    return GOTO;
}

"abstract"    {
    //printf("abstract");
    yylval.str = yytext;
    return ABSTRACT;
}
"protected"    {
    //printf("protected");
    yylval.str = yytext;
    return PROTECTED;
}
"public"    {
    //printf("public");
    yylval.str = yytext;
    return PUBLIC;
}
"private"    {
    //printf("private");
    yylval.str = yytext;
    return PRIVATE;
}
"interface"    {
    //printf("interface");
    yylval.str = yytext;
    return INTERFACE;
}
"static"    {
    //printf("static");
    yylval.str = yytext;
    return STATIC;
}
"strictfp"    {
    //printf("strictfp");
    yylval.str = yytext;
    return STRICTFP;
}
"final"    {
    //printf("final");
    yylval.str = yytext;
    return FINAL;
}
"permits"    {
    //printf("permits");
    yylval.str = yytext;
    return PERMITS;
}
"extends"    {
    //printf("permits");
    yylval.str = yytext;
    return EXTENDS;
}
"sealed"    {
    //printf("sealed");
    yylval.str = yytext;
    return SEALED;
}
"non-sealed"    {
    //printf("non-sealed");
    yylval.str = yytext;
    return NSEALED;
}
"transitive"    {
    //printf("transitive");
    yylval.str = yytext;
    return TRANSITIVE;
}
"throws"    {
    //printf("transitive");
    yylval.str = yytext;
    return THROWS;
}
"native"    {
    //printf("native");
    yylval.str = yytext;
    return NATIVE;
}
"transient" {
    //printf("transient");
    yylval.str = yytext;
    return TRANSIENT;
}
"volatile"    {
    //printf("volatile");
    yylval.str = yytext;
    return VOLATILE;
}
"implements"    {
    //printf("implements");
    yylval.str = yytext;
    return IMPLEMENTS;
}

"provides"    {
    //printf("provides");
    yylval.str = yytext;
    return PROVIDES;
}

"with"    {
    //printf("with");
    yylval.str = yytext;
    return WITH;
}

"uses"    {
    //printf("uses");
    yylval.str = yytext;
    return USES;
}

"opens"    {
    //printf("opens");
    yylval.str = yytext;
    return OPENS;
}

"record"    {
    //printf("record");
    yylval.str = yytext;
    return RECORD;
}
"to"    {
    //printf("to");
    yylval.str = yytext;
    return TO;
}
"exports"    {
    //printf("exports");
    yylval.str = yytext;
    return EXPORTS;
}
"requires"    {
    //printf("requires");
    yylval.str = yytext;
    return REQUIRES;
}
"open"    {
    //printf("open");
    yylval.str = yytext;
    return OPEN;
}
"module"    {
    //printf("module");
    yylval.str = yytext;
    return MODULE;
}
"import"    {
    //printf("import");
    yylval.str = yytext;
    return IMPORT;
}
"package"    {
    //printf("package");
    yylval.str = yytext;
    return PACKAGE;
}
"enum"    {
    //printf("enum");
    yylval.str = yytext;
    return ENUM;
}


0[xX][0-9a-fA-F][0-9a-fA-F_]+[lL]? {
    //printf("%s", yytext);
    yylval.str = yytext;
    return INTLITERAL;
}
0[lL]?|{nonZeroDigit}[0-9_]*{digit}*[lL]?|{nonZeroDigit}[]+[0-9*]{digit}+[lL]? {
    //printf("%s", yytext);
    yylval.str = yytext;
    return INTLITERAL;
}
[0][0-7]+[_0-7]+[lL]?   {
    //printf("%s", yytext);
    yylval.str = yytext;
    return INTLITERAL;
}
[0][bB][01][01_]+[lL]?   {
    //printf("%s", yytext);
    yylval.str = yytext;
    return INTLITERAL;
}

{digit}+[fF] {
    //printf("%s", yytext);
    yylval.str = yytext;
    return FLOATLITERAL;
}
{digit}+\.{digit}*([eE][+-]?{digit}+)?[fF] {
    //printf("%s", yytext);
    yylval.str = yytext;
    return FLOATLITERAL;
}
\.{digit}+([eE][+-]?{digit}+)?[fF] {
    //printf("%s", yytext);
    yylval.str = yytext;
    return FLOATLITERAL;
}
{digit}+[eE][+-]?{digit}+[fF] {
    //printf("%s", yytext);
    yylval.str = yytext;
    return FLOATLITERAL;
}
{digit}+\.{digit}*([eE][+-]?{digit}+)?[dD]? {
    //printf("%s", yytext);
    yylval.str = yytext;
    return FLOATLITERAL;
}
\.{digit}+([eE][+-]?{digit}+)?[dD]? {
    //printf("%s", yytext);
    yylval.str = yytext;
    return FLOATLITERAL;
}
{digit}+[eE][+-]?{digit}+[dD]? {
    //printf("%s", yytext);
    yylval.str = yytext;
    return FLOATLITERAL;
}

"true"|"false" {
    //printf("%s", yytext);
    yylval.str = yytext;
    return BOOLLITERAL;
}

"\""[^\"]*"\"" {
    //printf("%s", yytext);
    yylval.str = yytext;
    return STRINGLITERAL;
}

'.'|'%' {
    //printf("%s", yytext);
    yylval.str = yytext;
    return CHARLITERAL;
}

"null" {
    //printf("%s", yytext);
    yylval.str = yytext;
    return NULLLITERAL;
}

{letter}({digit}|{letter})* {
    //printf("%s", yytext);
    yylval.str = yytext;
    return IDENT;
}

{digit}+{letter}+ {
    //printf("Invalid Identifier at line number %d on the lexeme %s\n", yylineno, yytext);
    return 0;
}



%%

int yywrap() {return 1;}