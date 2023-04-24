%{
    #include<bits/stdc++.h>
	#include "symtab.cpp"
	#include "ast.h"
    using namespace std;
    extern int yylex();
    extern int yyparse();
    extern int yyerror(char *s);
    extern "C" int yylineno;

	char* TOC(string);

	char* helpType;
	char* helperInType;
	char* helperOutType;
	char* helperMethodName;
	int flag;
	int pps;
	int helppps;

	stack<int> line;

	int nodeNum  = 0;
%}

%union {
	 struct {
		char* str;
		char* type;
	}TL;
	 struct {
		char* str;
		char* type;
	}NTL;
}

%token < TL > ABSTRACT BOOLEAN BREAK BYTE CASE CATCH CHAR CLASS CONST
%token < TL > DEFAULT DO DOUBLE ELSE EXTENDS FINAL FINALLY FLOAT FOR GOTO
%token < TL > IF IMPLEMENTS IMPORT INSTANCEOF INT INTERFACE LONG NATIVE NEW
%token < TL > PACKAGE PRIVATE PROTECTED PUBLIC RETURN SUSPEND ASSERT
%token < TL > SHORT STATIC SUPER SWITCH SYNCHRONIZED THIS THROW
%token < TL > VOID VOLATILE WHILE IDENT CONTINUE TRANSIENT TRY
%token < TL > NULLLITERAL BOOLLITERAL INTLITERAL THROWS
%token < TL > CHARLITERAL FLOATLITERAL STRINGLITERAL
%token < TL > LP RP LC RC LB RB SM CM DOT ASN LT GT EXCL TILDE QUEST COLON
%token < TL > EQ NE LE GE ANDAND OROR INC DEC PLUS MINUS MUL DIV AND OR CARET
%token < TL > MOD SHL SHR LSHR PLASN MIASN MUASN DIASN MODASN
%token < TL > ANDASN ORASN CARETASN SLASN SRASN LSRASN 
%token < TL > ATR ACCESSSPEC ARROW DIAMOND TDOT
%token < TL > EXPORTS OPENS REQUIRES USES MODULE PERMITS SEALED VAR 
%token < TL > NSEALED PROVIDES TO WITH OPEN RECORD TRANSITIVE YIELD
%token < TL > STRICTFP ENUM


%type < NTL > Modifiers ArrayType DimExprs Dims ArgumentList BlockStatements
%type < NTL > ImportDeclarations TypeDeclarations SwitchBlockStatementGroups SwitchLabels
%type < NTL > StatementExpressionList ClassBodyDeclarations FormalParameterList VariableDeclaratorId
%type < NTL > MethodDeclarator ClassTypeList ExtendsInterfaces InterfaceMemberDeclarations
%type < NTL > InterfaceTypeList VariableDeclarators VariableInitializers


%type < NTL > Start Literal Type PrimitiveType NumericType IntegralType FloatingPointType
%type < NTL > ReferenceType ClassOrInterfaceType ClassType InterfaceType Name
%type < NTL > SimpleName QualifiedName CompilationUnit
%type < NTL > PackageDeclaration ImportDeclaration SingleTypeImportDeclaration
%type < NTL > TypeImportOnDemandDeclaration TypeDeclaration Modifier
%type < NTL > ClassDeclaration ClassExtends Interfaces ClassBody
%type < NTL > ClassBodyDeclaration ClassMemberDeclaration
%type < NTL > FieldDeclaration VariableDeclarator
%type < NTL > VariableInitializer MethodDeclaration MethodHeader
%type < NTL > FormalParameter MethodBody
%type < NTL > StaticInitializer ConstructorDeclaration ConstructorDeclarator
%type < NTL > ConstructorBody ExplicitConstructorInvocation InterfaceDeclaration
%type < NTL > InterfaceBody
%type < NTL > ConstantDeclaration AbstractMethodDeclaration ArrayInitializer
%type < NTL > Block BlockStatement
%type < NTL > LocalVariableDeclarationStatement LocalVariableDeclaration Statement
%type < NTL > StatementNoShortIf StatementWithoutTrailingSubstatement EmptyStatement
%type < NTL > LabeledStatement LabeledStatementNoShortIf ExpressionStatement
%type < NTL > StatementExpression IfThenStatement IfThenElseStatement ForStatement
%type < NTL > IfThenElseStatementNoShortIf SwitchStatement SwitchBlock ForInit
%type < NTL > SwitchBlockStatementGroup
%type < NTL > SwitchLabel WhileStatement WhileStatementNoShortIf DoStatement
%type < NTL > ForStatementNoShortIf ForUpdate BreakStatement
%type < NTL > ContinueStatement ReturnStatement ThrowStatement SynchronizedStatement
%type < NTL > Finally Primary PrimaryNoNewArray
%type < NTL > ClassInstanceCreationExpression ArrayCreationExpression
%type < NTL > DimExpr FieldAccess MethodInvocation ArrayAccess
%type < NTL > PostFixExpression PostIncrementExpression PostDecrementExpression
%type < NTL > UnaryExpression PreIncrementExpression PreDecrementExpression
%type < NTL > UnaryExpressionNotPlusMinus CastExpression MultiplicativeExpression
%type < NTL > AdditiveExpression ShiftExpression RelationalExpression EqualityExpression
%type < NTL > AndExpression ExclusiveOrExpression InclusiveOrExpression LeftHandSide
%type < NTL > ConditionalAndExpression ConditionalOrExpression ConditionalExpression
%type < NTL > AssignmentExpression Assignment AssignmentOperator Expression
%type < NTL > ConstantExpression InterfaceMemberDeclaration
%type < NTL > BasicForStatement BasicForStatementNoShortIf
%type < NTL > EnhancedForStatement EnhancedForStatementNoShortIf
%type < NTL > for_token 

%start Start

%%

Start: CompilationUnit {
	printGSB();
}
        ;

Literal: INTLITERAL {
			$$.type = TOC("int");
			$$.str = ($1).str;
			// insertLit(($1).str, "int", yylineno);
		}
		| FLOATLITERAL {
			$$.type = TOC("float");
			$$.str = ($1).str;
			// insertLit(($1).str, "float", yylineno);
		}
		| BOOLLITERAL {
			$$.type = TOC("boolean");
			$$.str = ($1).str;
			// insertLit(($1).str, "boolean", yylineno);
		}
		| STRINGLITERAL {
			$$.type = TOC("string");
			$$.str = ($1).str;
			// insertLit(($1).str, "string", yylineno);
		}
		| CHARLITERAL {
			$$.type = TOC("char");
			$$.str = ($1).str;
			// insertLit(($1).str, "char", yylineno);
		}
		| NULLLITERAL {
			$$.type = TOC("null");
			$$.str = ($1).str;
			// insertLit(($1).str, "null", yylineno);
		}
		;

Type: PrimitiveType {
	$$.type = ($1).type;
}
		| ReferenceType {
	$$.type = ($1).type;
}
		;

PrimitiveType: NumericType {
	$$.type = ($1).type;
}
        | BOOLEAN {
			$$.type = TOC("boolean");
		}
		;

NumericType: IntegralType {
	$$.type = ($1).type;
}
		| FloatingPointType {
	$$.type = ($1).type;
}

IntegralType: BYTE {
			$$.type = TOC("byte");
		}
		| SHORT {
			$$.type = TOC("short");
		}
		| INT {
			$$.type = TOC("int");
		}
		| LONG {
			$$.type = TOC("long");
		}
		| CHAR {
			$$.type = TOC("char");
		}
		;

FloatingPointType: FLOAT {
			$$.type = TOC("float");
		}
		| DOUBLE {
			$$.type = TOC("double");
		}
		;

ReferenceType: ClassOrInterfaceType {
			$$.type = ($1).type;
		}
        | ArrayType {
			$$.type = ($1).type;
		}
		;

ClassOrInterfaceType: Name {
	$$.type = ($1).type;
}
        ;

ClassType: ClassOrInterfaceType {
	$$.type = ($1).type;
}
        ;

InterfaceType: ClassOrInterfaceType {
}
        ;

ArrayType: PrimitiveType LB RB {
	$$.type = TOC(string(($1).type) + "[]");
}
		| Name LB RB {
	$$.type = TOC(string(($1).type) + "[]");
}
        | ArrayType LB RB {
			$$.type = TOC(string(($1).type) + "[]");
		}
		;

Name: SimpleName {
	$$.str = ($1).str;
	$$.type = ($1).type;
}
	    | QualifiedName {
	$$.str = ($1).str;
	$$.type = ($1).type;
}
        ;

SimpleName: IDENT {
	$$.str = ($1).str;
	$$.type = ($1).str;
}
        ;

QualifiedName: Name DOT IDENT {
	$$.str = TOC(string(($1).str) + "." + string(($3).str));
	$$.type = TOC(membLookup(($1).str, ($3).str));
}
        ;

CompilationUnit: PackageDeclaration {
}
		| ImportDeclarations {
}
		| TypeDeclarations {
}
		| PackageDeclaration ImportDeclarations {
}
		| ImportDeclarations TypeDeclarations {
}
		| PackageDeclaration TypeDeclarations {
}
		| PackageDeclaration ImportDeclarations TypeDeclarations {
}
        ;

ImportDeclarations: ImportDeclaration {
}
        | ImportDeclarations ImportDeclaration {
		}
        ;

TypeDeclarations: TypeDeclaration {
}
	    | TypeDeclarations TypeDeclaration {
		}
        ;

PackageDeclaration: PACKAGE Name SM {
}
		;

ImportDeclaration: SingleTypeImportDeclaration {
}
		| TypeImportOnDemandDeclaration {
}
		;

SingleTypeImportDeclaration: IMPORT Name SM {
}
		;

TypeImportOnDemandDeclaration: IMPORT Name DOT MUL SM {
}
		;

TypeDeclaration: ClassDeclaration {
	$$.str = ($1).str;
	$$.type = TOC("class");
	goUp();
}
        | InterfaceDeclaration {
}
        | SM {
	$$.str = TOC("");
	$$.type = TOC("empty");
}
        ;

Modifiers: Modifier {
	$$.type = ($1).type;
}
	    | Modifiers Modifier {
	$$.type = TOC(string(($1).type) + "_" + string(($2).type));
}
        ;

Modifier: PUBLIC {
	$$.type = TOC("public");
	pps *= 2;
}
		| PROTECTED {
	$$.type = TOC("protected");
}
		| PRIVATE {
	$$.type = TOC("private");
	pps *= 3;
}
		| ABSTRACT {
	$$.type = TOC("abstract");
}
		| STATIC {
	$$.type = TOC("static");
	pps *= 5;
}
		| FINAL {
	$$.type = TOC("final");
} 
		| TRANSIENT {
	$$.type = TOC("transient");
}
		| VOLATILE {
	$$.type = TOC("volatile");
}
		| SYNCHRONIZED {
	$$.type = TOC("synchronized");
}
        | NATIVE {
	$$.type = TOC("native");
}
		;

ClassDeclaration: CLASS IDENT {addClassChild(($2).str, pps, yylineno); helpType = TOC("NULL"); pps = 1;} ClassBody {
	$$.str = ($2).str;
}
        | Modifiers CLASS IDENT {addClassChild(($3).str, pps, yylineno); helpType = TOC("NULL"); pps = 1;} ClassBody {
			$$.str = ($3).str;
		}
        | CLASS IDENT ClassExtends {addClassChild(($2).str, pps, yylineno); helpType = TOC("NULL"); pps = 1;} ClassBody {
			$$.str = ($2).str;
		}
        | Modifiers CLASS IDENT ClassExtends {addClassChild(($3).str, pps, yylineno); helpType = TOC("NULL"); pps = 1;} ClassBody {
			$$.str = ($3).str;
		}
        ;

ClassExtends: EXTENDS ClassType {
}
        ;

Interfaces: IMPLEMENTS InterfaceTypeList {
}
        ;

InterfaceTypeList: InterfaceType  {
}
	    | InterfaceTypeList CM InterfaceType {
		}
        ;

ClassBody: LC ClassBodyDeclarations RC {
}
        | LC RC {
}
        ;

ClassBodyDeclarations: ClassBodyDeclaration {
}
	    | ClassBodyDeclarations ClassBodyDeclaration {
		}
        ;

ClassBodyDeclaration: ClassMemberDeclaration {
}
		| StaticInitializer {
}
		| ConstructorDeclaration {
}
		;

ClassMemberDeclaration: FieldDeclaration {
}
		| MethodDeclaration {
}
		;

//

FieldDeclaration: Modifiers Type VariableDeclarators SM {
	// helpType = ($2).type;
}
        | Type VariableDeclarators SM {
	// helpType = ($1).type;
}
        ;

VariableDeclarators: VariableDeclarator {
	($1).type = helpType;
	insertId(($1).str, helpType, yylineno, pps);
	pps = 1;
}
		| VariableDeclarators CM VariableDeclarator {
			insertId(($3).str, helpType, yylineno, pps);
			pps = 1;
		}
		;

VariableDeclarator: VariableDeclaratorId {
	$$.str = ($1).str;
	$$.type = ($1).type;
}
		| VariableDeclaratorId ASN VariableInitializer {
			$$.str = ($1).str;
			$$.type = ($1).type;
			checkType(($1).type, ($3).type, yylineno);
		}
		;

VariableDeclaratorId: IDENT {
	$$.str = ($1).str;
	$$.type = helpType;
}
		| VariableDeclaratorId LB RB {
			$$.str = ($1).str;
			$$.type = TOC(string(($1).type) + "[]");
		}
		;

VariableInitializer: Expression {
	$$.type = ($1).type;
}
		| ArrayInitializer {
	$$.type = ($1).type;
}
		;

MethodDeclaration: MethodHeader MethodBody {
	goUp();
	if(!line.empty()){
		insertMethodType(helperMethodName, helperInType, helperOutType, line.top(), helppps);
		helppps = 1;
		line.pop();
	}
}
		;

MethodHeader: Type MethodDeclarator {
	line.push(yylineno);
	helperOutType = ($1).type;
}
		| VOID MethodDeclarator {
			line.push(yylineno);
			helperOutType = TOC("void");
		}
        | Modifiers Type MethodDeclarator {
			line.push(yylineno);
			helperOutType = ($2).type;
		}
		| Modifiers VOID MethodDeclarator {
			line.push(yylineno);
			helperOutType = TOC("void");
		}
		;

MethodDeclarator: IDENT LP {addChild(); helppps = pps; pps = 1;} RP {
	helperMethodName = ($1).str;
	helperInType = TOC("void");
}
		| IDENT LP {addChild(); helppps = pps; pps = 1;} FormalParameterList RP {
	helperMethodName = ($1).str;
	helperInType = ($4).type;
}
		;

FormalParameterList: FormalParameter {
	$$.type = ($1).type;
}
		| FormalParameterList CM FormalParameter {
			$$.type = TOC(string(($1).type) + "X" + string(($3).type));
		}
		;

FormalParameter: Type {helpType = ($1).type;} VariableDeclaratorId {
	$$.type = ($1).type;
	insertId(($3).str, ($3).type, yylineno, 1);
}
		;

ClassTypeList: ClassType {
}
        | ClassTypeList CM ClassType {
		}
        ;

MethodBody: Block {
}
        | SM {
}
        ;

StaticInitializer: STATIC {addChild();} Block {
	goUp();
}
		;

ConstructorDeclaration: ConstructorDeclarator ConstructorBody {
	goUp();
	if(!line.empty()){
		insertConsType(helperMethodName, helperInType, "void", line.top());
		line.pop();
	}
}
		| Modifiers ConstructorDeclarator ConstructorBody {
			goUp();
			if(!line.empty()){
				insertConsType(helperMethodName, helperInType, "void", line.top());
				line.pop();
			}
}
		;

ConstructorDeclarator: SimpleName  LP {addChild();} RP {
	helperMethodName = ($1).str;
	helperInType = TOC("void");
}
		| SimpleName  LP {addChild();} FormalParameterList RP {
	helperMethodName = ($1).str;
	helperInType = ($4).type;
		}
		;

ConstructorBody: LC RC {
}
        | LC ExplicitConstructorInvocation RC {
}
        | LC BlockStatements RC {
} 
        | LC ExplicitConstructorInvocation BlockStatements RC {
}
        ; 

ExplicitConstructorInvocation: THIS LP RP SM {
}
		| THIS LP ArgumentList RP SM {
}
		| SUPER LP RP SM {
}
		| SUPER LP ArgumentList RP SM
        ;

/////
InterfaceDeclaration: INTERFACE IDENT InterfaceBody {
}
		| Modifiers INTERFACE IDENT InterfaceBody {
}
		| INTERFACE IDENT ExtendsInterfaces InterfaceBody {
}
		| Modifiers INTERFACE IDENT ExtendsInterfaces InterfaceBody {
}
        ;

ExtendsInterfaces: EXTENDS InterfaceType {
}
	    | ExtendsInterfaces CM InterfaceType {
		}
        ;

InterfaceBody: LC RC {
}
		| LC InterfaceMemberDeclarations RC {
}
        ;

InterfaceMemberDeclarations: InterfaceMemberDeclaration {
}
		| InterfaceMemberDeclarations InterfaceMemberDeclaration {
		}
        ;

InterfaceMemberDeclaration: ConstantDeclaration {
}
		| AbstractMethodDeclaration {
}
		;
/////

ConstantDeclaration: FieldDeclaration {
}
        ;

AbstractMethodDeclaration: MethodHeader SM {
	if(!line.empty()){
		insertMethodType(helperMethodName, helperInType, helperOutType, line.top(), 1);
		line.pop();
	}
	
}
        ;

//

ArrayInitializer: LC RC {
	$$.type = TOC("[]");
}
        | LC CM RC {
			$$.type = TOC("[]");
}
        | LC VariableInitializers RC {
			$$.type = TOC(string(($2).type) + "[]");
}
        | LC VariableInitializers CM RC {
			$$.type = TOC(string(($2).type) + "[]");
}
		;

VariableInitializers: VariableInitializer {
	$$.type = ($1).type;
}
		| VariableInitializers CM VariableInitializer {
			$$.type = ($3).type;
			//check if the types are the same
		}
		;

//

Block: LC {if(flag==1){addChild();flag=0;}} BlockStatements RC {
}
		| LC RC {
}
		;

BlockStatements: BlockStatement {
}
		| BlockStatements BlockStatement {
		}
        ;

BlockStatement: LocalVariableDeclarationStatement {
}
		| Statement {
}
		;

LocalVariableDeclarationStatement: LocalVariableDeclaration SM {
}
		;

LocalVariableDeclaration: Type {helpType = ($1).type;} VariableDeclarators {
}
		;

Statement: StatementWithoutTrailingSubstatement {

}
		| LabeledStatement {
}
		| IfThenStatement {
}
		| IfThenElseStatement {
}
		| WhileStatement {
}
		| ForStatement {
}
		;

StatementNoShortIf: StatementWithoutTrailingSubstatement  {
}
		| LabeledStatementNoShortIf {
} 
		| IfThenElseStatementNoShortIf {
}
		| WhileStatementNoShortIf {
}
		| ForStatementNoShortIf {
}
		;

StatementWithoutTrailingSubstatement: {flag=1;} Block {
	goUp();
}
		| EmptyStatement {
}
		| ExpressionStatement {
}
		| SwitchStatement {
}
		| DoStatement {
}
		| BreakStatement {
}
		| ContinueStatement {
}
		| ReturnStatement {
}
		| SynchronizedStatement {
}
		| ThrowStatement {
}
		;

EmptyStatement: SM {
}
		;

LabeledStatement: IDENT COLON Statement {
}
		;

LabeledStatementNoShortIf: IDENT COLON StatementNoShortIf {
}
		;

ExpressionStatement: StatementExpression SM {
	$$.type = ($1).type;
}
		;

StatementExpression: Assignment {
	$$.type = ($1).type;
}
		| PreIncrementExpression {
	$$.type = ($1).type;
}
		| PreDecrementExpression {
	$$.type = ($1).type;
}
		| PostIncrementExpression {
	$$.type = ($1).type;
}
		| PostDecrementExpression {
	$$.type = ($1).type;
}
		| MethodInvocation {
	$$.type = ($1).type;
	//lookup karna hai type
}
		| ClassInstanceCreationExpression {
	$$.type = ($1).type;
}
		;


IfThenStatement:  IF LP Expression RP Statement {
}
		;

IfThenElseStatement:  IF LP Expression RP StatementNoShortIf ELSE Statement {
}
		;

IfThenElseStatementNoShortIf:  IF LP Expression RP StatementNoShortIf ELSE StatementNoShortIf {
}
		;

SwitchStatement:  SWITCH LP Expression {helpType = ($3).type;} RP {addChild();} SwitchBlock {
	goUp();
}
		;

SwitchBlock: LC RC {
}
		| LC SwitchBlockStatementGroups RC {
}
		| LC SwitchLabels RC {
}
		| LC SwitchBlockStatementGroups SwitchLabels RC {
}
		;

SwitchBlockStatementGroups: SwitchBlockStatementGroup {
}
		| SwitchBlockStatementGroups SwitchBlockStatementGroup {
		}
        ;

SwitchBlockStatementGroup: SwitchLabels BlockStatements {
}
		;

SwitchLabels: SwitchLabel {
}
		| SwitchLabels SwitchLabel {
		}
        ;

SwitchLabel: CASE ConstantExpression COLON {
	checkType(($2).type, helpType, yylineno);
}
		| DEFAULT COLON {
}
		;

WhileStatement:	WHILE LP Expression RP Statement {
}
		;

WhileStatementNoShortIf: WHILE LP Expression RP StatementNoShortIf {
}
		;

DoStatement: DO {addChild();} Statement {goUp();} WHILE LP Expression RP SM {
}
		;

ForStatement: BasicForStatement {
}
		| EnhancedForStatement {
}
		;


ForStatementNoShortIf: BasicForStatementNoShortIf {
}
		| EnhancedForStatementNoShortIf {
}
		;


for_token: FOR {
	addChild();
}
		;

BasicForStatement: for_token  LP SM SM RP Statement  {
	goUp();
}
		| for_token  LP ForInit SM SM RP Statement {
	goUp();
}
		| for_token  LP SM Expression SM RP Statement {
	goUp();
} 
		| for_token  LP SM SM ForUpdate RP Statement {
	goUp();
}
		| for_token  LP ForInit SM Expression SM RP Statement {
	goUp();
}
		| for_token  LP SM Expression SM ForUpdate RP Statement {
	goUp();
}
		| for_token  LP ForInit SM SM ForUpdate RP Statement {
	goUp();
}
		| for_token  LP ForInit SM Expression SM ForUpdate RP Statement {
	goUp();
}
		;




BasicForStatementNoShortIf: for_token  LP SM SM RP StatementNoShortIf {
	goUp();
}
		| for_token  LP ForInit SM SM RP StatementNoShortIf {
	goUp();
}
		| for_token  LP SM Expression SM RP StatementNoShortIf {
	goUp();
}
		| for_token  LP SM SM ForUpdate RP StatementNoShortIf {
	goUp();
}
		| for_token  LP ForInit SM Expression SM RP StatementNoShortIf {
	goUp();
}
		| for_token  LP SM Expression SM ForUpdate RP StatementNoShortIf {
	goUp();
}
	
		| for_token  LP ForInit SM SM ForUpdate RP StatementNoShortIf {
	goUp();
}
		| for_token  LP ForInit SM Expression SM ForUpdate RP StatementNoShortIf {
	goUp();
}
		;

EnhancedForStatement: for_token  LP LocalVariableDeclaration COLON Expression RP Statement {
	goUp();
}
		;

EnhancedForStatementNoShortIf: for_token  LP LocalVariableDeclaration COLON Expression RP StatementNoShortIf {
	goUp();
}
		;

ForInit: StatementExpressionList {
}
		| LocalVariableDeclaration {
}
		;

ForUpdate: StatementExpressionList {
}
		;

StatementExpressionList: StatementExpression {
}
		| StatementExpressionList CM StatementExpression {
		}
		;

BreakStatement: BREAK SM {
}
		| BREAK IDENT SM {
}
		;

ContinueStatement: CONTINUE SM {
}
		| CONTINUE IDENT SM {
}
		;

ReturnStatement: RETURN SM {
}
		| RETURN Expression SM {
		// type check kar sakte hai
}
		;

ThrowStatement:  THROW Expression SM {
}
		;

SynchronizedStatement: SYNCHRONIZED LP Expression RP {addChild();} Block {
	goUp();
}
		;

Finally: FINALLY {addChild();} Block {
	goUp();
}
		;

//

Primary: PrimaryNoNewArray {
	$$.type = ($1).type;
	$$.str = $$.str;
}
		| ArrayCreationExpression {
			$$.type = ($1).type;
			$$.str = TOC("ArrayCreationExpression");
}
		;

PrimaryNoNewArray: Literal {
	$$.type = ($1).type;
	$$.str = ($1).str;
}
		| THIS {
			$$.type = TOC("class");
			$$.str = ($1).str;
}
		| LP Expression RP {
			$$.type = ($2).type;
			$$.str = ($2).type;
}
		| ClassInstanceCreationExpression {
			$$.type = ($1).type;
			$$.str = ($1).type;
}
		| FieldAccess {
			$$.type = ($1).type;
			$$.str = ($1).type;
}
		| MethodInvocation {
			$$.type = ($1).type;
			$$.str = ($1).type;

}
		| ArrayAccess {
			$$.type = ($1).type;
			$$.str = ($1).type;
}
		;

ClassInstanceCreationExpression: NEW LP ArgumentList RP {
	checkType(lookup(($2).type), "class", yylineno);
	if(methodLookup(($1).str, "void")=="NULL"){
		cout<<"Method "<< ($1).str <<" not found"<<endl;
	}; // this funcn returns the output type of the method
	$$.type = TOC(methodLookup(($1).str, "void"));
	$$.type = ($2).type;
}
		| NEW ClassType LP RP {
			checkType(lookup(($2).type), "class", yylineno);
			$$.type = ($2).type;
}
		;

ArgumentList: Expression {
	$$.type = ($1).type;
}
		| ArgumentList CM Expression {
			$$.type = TOC(string(($1).type) + "X" + string(($3).type));
		}
		;

ArrayCreationExpression: NEW PrimitiveType DimExprs {
	$$.type = TOC(string(($2).type) + string(($3).type));
}
		| NEW PrimitiveType DimExprs Dims {
	$$.type = TOC(string(($2).type) + string(($3).type) + string(($4).type));
}
		| NEW ClassOrInterfaceType DimExprs {
	$$.type = TOC(string(($2).type) + string(($3).type));
}
		| NEW ClassOrInterfaceType DimExprs Dims {
			$$.type = TOC(string(($2).type) + string(($3).type) + string(($4).type));
}
		;

DimExprs: DimExpr {
	$$.type = ($1).type;
}
		| DimExprs DimExpr {
			$$.type = TOC(string(($1).type) + string(($2).type));
		}
		;

DimExpr: LB Expression RB {
	$$.type = TOC("[]");
}
		;

Dims: LB RB  {
	$$.type = TOC("[]");
}
		| Dims LB RB {
			$$.type = TOC(string(($1).type) + "[]");
		}
        ;

FieldAccess: Primary DOT IDENT {
	$$.type = TOC(membLookup(($1).str, ($3).str));
}
		| SUPER DOT IDENT {
			//not handled (optional)
}
        ;

MethodInvocation: Name LP RP {
	//also save type for aall 4 cases
	if(methodLookup(($1).str, "void")=="NULL"){
		cout<<"Method "<< ($1).str <<" not in scope or recursive call."<<endl;
	}; // this funcn returns the output type of the method
	$$.type = TOC(methodLookup(($1).str, "void"));
}
		| Name LP ArgumentList RP {
			//lookup nhi kr payenge becaus eudent would be a member of class.
			if(methodLookup(string(($1).str), string(($3).type))=="NULL"){
				cout<<"Method "<< ($1).str <<" not in scope or recursive call."<<endl;
			}; // this funcn returns the output type of the method
			$$.type = TOC(methodLookup(string(($1).str), string(($3).type)));
}
		| Primary LP ArgumentList RP {
			//not handled (optional)
}
		| SUPER LP ArgumentList RP {
			//not handled (optional)
}
		;

ArrayAccess: Name LB Expression RB {
	if(lookup(($1).type) == "NULL") {
		cout<< " err : Variable "<<($1).str<<" not in scope of usage on line "<<yylineno<<" \n ";
	}
	$$.type = TOC(lookup(($1).str).substr(0, lookup(($1).str).length() - 2));
	checkType(($3).type, "int", yylineno);
}
		| PrimaryNoNewArray LB Expression RB {
	$$.type = TOC(lookup(($1).str).substr(0, lookup(($1).str).length() - 2));
	checkType(($3).type, "int", yylineno);
}
		;

PostFixExpression: Primary {
	$$.type = ($1).type;
}
		| Name {
	if(lookup(($1).type) == "NULL") {
		cout<< " err : Variable "<<($1).str<<" not in scope of usage on line "<<yylineno<<" \n ";
	}
	$$.type = TOC(lookup(($1).type));
}
		| PostIncrementExpression {
	$$.type = ($1).type;
}
		| PostDecrementExpression {
	$$.type = ($1).type;
}
		;

PostIncrementExpression: PostFixExpression INC {
	$$.type = ($1).type;
}
		;

PostDecrementExpression: PostFixExpression DEC {
	$$.type = ($1).type;
}
		;

UnaryExpression: PreIncrementExpression {
	$$.type = ($1).type;
} 
		| PreDecrementExpression {
			$$.type = ($1).type;
}
		| PLUS UnaryExpression {
			$$.type = ($2).type;
}
		| MINUS UnaryExpression {
			$$.type = ($2).type;
}
		| UnaryExpressionNotPlusMinus {
			$$.type = ($1).type;
} 
		;

PreIncrementExpression: INC UnaryExpression {
	$$.type = ($2).type;
}
		;

PreDecrementExpression: DEC UnaryExpression {
	$$.type = ($2).type;
}
		;

UnaryExpressionNotPlusMinus: PostFixExpression {
	$$.type = ($1).type;
}
		| TILDE UnaryExpression {
			$$.type = ($2).type;
}
		| EXCL UnaryExpression {
			$$.type = ($2).type;
}
		| CastExpression {
			$$.type = ($1).type;
}
		;

CastExpression: LP PrimitiveType RP UnaryExpression {
	checkType(($2).type, "numeric", yylineno);
	checkType(($4).type, "numeric", yylineno);
	$$.type = ($2).type;
}
        | LP PrimitiveType Dims RP UnaryExpression {
			checkType(($2).type, "numeric", yylineno);
			checkType(($5).type, "numeric", yylineno);
			$$.type = TOC(string(($2).type) + string(($3).type));
}
		| LP Expression RP UnaryExpressionNotPlusMinus {
			checkType(($2).type, "numeric", yylineno);
			checkType(($4).type, "numeric", yylineno);
			$$.type = ($2).type;
}
		| LP Name Dims RP UnaryExpressionNotPlusMinus {
			checkType(($2).type, "numeric", yylineno);
			checkType(($5).type, "numeric", yylineno);
			$$.type = TOC(string(($2).type) + string(($3).type));
}
		;

MultiplicativeExpression: UnaryExpression {
	$$.type = ($1).type;
}
		| MultiplicativeExpression MUL UnaryExpression  {
			checkType(($1).type, "numeric", yylineno);
			checkType(($3).type, "numeric", yylineno);
	$$.type = max(($1).type, ($3).type);
}
		| MultiplicativeExpression DIV UnaryExpression {
			checkType(($1).type, "numeric", yylineno);
			checkType(($3).type, "numeric", yylineno);
	$$.type = max(($1).type, ($3).type);
}
		| MultiplicativeExpression MOD UnaryExpression {
			checkType(($1).type, "numeric", yylineno);
			checkType(($3).type, "int", yylineno);
	//type check karna hai
	$$.type = ($1).type;
}
		;

AdditiveExpression: MultiplicativeExpression {
	$$.type = ($1).type;
}
		| AdditiveExpression PLUS MultiplicativeExpression {
			$$.type = max(($1).type, ($3).type);
}
		| AdditiveExpression MINUS MultiplicativeExpression  {
			$$.type = max(($1).type, ($3).type);
}
		;

ShiftExpression: AdditiveExpression {
	$$.type = ($1).type;
}
		| ShiftExpression SHL AdditiveExpression {
			checkType(($1).type, "int", yylineno);
			checkType(($3).type, "int", yylineno);
			$$.type = ($1).type;
}
		| ShiftExpression SHR AdditiveExpression {
			checkType(($1).type, "int", yylineno);
			checkType(($3).type, "int", yylineno);
			$$.type = ($1).type;
}
		| ShiftExpression LSHR AdditiveExpression {
			checkType(($1).type, "int", yylineno);
			checkType(($3).type, "int", yylineno);
			$$.type = ($1).type;
}
		;

RelationalExpression: ShiftExpression {
	$$.type = ($1).type;
}
		| RelationalExpression LT ShiftExpression {
			checkType(($1).type, "numeric", yylineno);
			$$.type = TOC("boolean");
}
		| RelationalExpression GT ShiftExpression {
			checkType(($1).type, "numeric", yylineno);
			$$.type = TOC("boolean");
}
		| RelationalExpression LE ShiftExpression {
			checkType(($1).type, "numeric", yylineno);
			$$.type = TOC("boolean");
}
		| RelationalExpression GE ShiftExpression {
			checkType(($1).type, "numeric", yylineno);
			$$.type = TOC("boolean");
}
		| RelationalExpression INSTANCEOF ReferenceType {
			checkType(($1).type, ($3).type, yylineno);
			$$.type = TOC("boolean");
}
		;

EqualityExpression: RelationalExpression {
	$$.type = ($1).type;
}
		| EqualityExpression EQ RelationalExpression{
			checkType(($1).type, ($3).type, yylineno);
			$$.type = TOC("boolean");
}
		| EqualityExpression NE RelationalExpression {
			checkType(($1).type, ($3).type, yylineno);
			$$.type = TOC("boolean");
}
		;

AndExpression: EqualityExpression {
	$$.type = ($1).type;
}
		| AndExpression AND EqualityExpression {
			checkType(($1).type, ($3).type, yylineno);
			checkType(($1).type, "booleannumeric", yylineno);
			$$.type= ($1).type;
}
		;

ExclusiveOrExpression: AndExpression {
	$$.type = ($1).type;
}
		| ExclusiveOrExpression CARET AndExpression {
			checkType(($1).type, ($3).type, yylineno);
			checkType(($1).type, "booleannumeric", yylineno);
			$$.type = ($1).type;
}
		;

InclusiveOrExpression: ExclusiveOrExpression  {
	$$.type = ($1).type;
}
		| InclusiveOrExpression OR ExclusiveOrExpression {
			checkType(($1).type, ($3).type, yylineno);
			checkType(($1).type, "booleannumeric", yylineno);
			$$.type = ($1).type;
}
		;

ConditionalAndExpression: InclusiveOrExpression {
	$$.type = ($1).type;
}
		| ConditionalAndExpression ANDAND InclusiveOrExpression {
			checkType(($1).type, "boolean", yylineno);
			checkType(($3).type, "boolean", yylineno);
			$$.type = TOC("boolean");
}
		;

ConditionalOrExpression: ConditionalAndExpression {
	$$.type = ($1).type;
}
		| ConditionalOrExpression OROR ConditionalAndExpression {
			checkType(($1).type, "boolean", yylineno);
			checkType(($3).type, "boolean", yylineno);
			$$.type = TOC("boolean");
}
		;

ConditionalExpression: ConditionalOrExpression {
	$$.type = ($1).type;
}
		| ConditionalOrExpression QUEST Expression COLON ConditionalExpression {
			checkType(($1).type, "boolean", yylineno);
			checkType(($3).type, ($5).type, yylineno);
			$$.type = ($3).type;
}
		;

AssignmentExpression: ConditionalExpression {
	$$.type = ($1).type;

}
		| Assignment {
			$$.type = ($1).type;
}
		;

Assignment: LeftHandSide AssignmentOperator AssignmentExpression {
	$$.type = ($3).type;
	checkType(($1).type, ($3).type, yylineno);
}
		;

LeftHandSide: Name {
	if(lookup(($1).type) == "NULL") {
		cout<< " err : Variable "<<($1).str<<" not in scope of usage on line "<<yylineno<<" \n ";
	}
	$$.type = TOC(lookup(($1).type));
}
		| FieldAccess {
	$$.type = ($1).type;
}
		| ArrayAccess {
	$$.type = ($1).type;
}
		;

AssignmentOperator: ASN {
}
		| MUASN{
}
		| DIASN{
}
		| MODASN{
}
		| PLASN{
}
		| MIASN{
}
		| SLASN{
}
		| SRASN{
}
		| LSRASN{
}
		| ANDASN{
}
		| CARETASN{
}
		| ORASN{
}
		;

Expression: AssignmentExpression {
	$$.type = ($1).type;
}
		;

ConstantExpression: Expression  {
	$$.type = ($1).type;
}
        ;

%%

int yyerror(char *s){
    printf("error: %s\n", s);
	return 0;
}

char* TOC(string s)
{
	char* newchr = new char[s.length() + 1];
	strcpy(newchr, s.c_str());
	return newchr;

}

int main(){
	symTabInit();
	pps = 1;
    yyparse();
    return 0;
}

