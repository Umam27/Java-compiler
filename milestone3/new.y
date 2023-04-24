%{
    #include<bits/stdc++.h>
	#include "symtab.cpp"
	#include "3ac.cpp"
	#include "ast.h"
    using namespace std;
    extern int yylex();
    extern int yyparse();
    extern int yyerror(char *s);
    extern "C" int yylineno;

	char* TOC(string);
	char* ITC(int num);

	char* helpType;
	char* helperInType;
	char* helperOutType;
	char* helperMethodName;
	int flag;
	int pps;
	int helppps;
	int helper1;
	int helper2;
	int helperbreak;
	int helperGoto;
	int helpermlv;
	int as;
	string helperop;

	stack<int> line;

	stack<string> args;

	int nodeNum  = 0;
	int flagqn =0;
%}

%union {
	 struct {
		char* str;
		char* type;
		char* temp;
	}TL;
	 struct {
		char* str;
		char* type;
		char* temp;
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
%type < NTL > for_token IfThen_token IfThen_token2 WhileStatement_token for_token2 LabeledStatement_token 
%type < NTL > modifiers_type_token 

%start Start

%%

Start: CompilationUnit {
	printGSB();
	printIR();
}
        ;

Literal: INTLITERAL {
			$$.type = TOC("int");
			$$.str = ($1).str;
			// insertLit(($1).str, "int", yylineno);
			//insertIR() generates and saves the 3AC code which takes in the arguments : operator, operand1, operand2, result; returns the result (only lhs) string
			$$.temp = TOC(insertIR("=", ($1).str, "", "newvar"));
		}
		| FLOATLITERAL {
			$$.type = TOC("float");
			$$.str = ($1).str;
			// insertLit(($1).str, "float", yylineno);
			$$.temp = TOC(insertIR("=", ($1).str, "", "newvar"));
		}
		| BOOLLITERAL{
			$$.type = TOC("boolean");
			$$.str = ($1).str;
			// insertLit(($1).str, "boolean", yylineno);
			$$.temp = TOC(insertIR("=", ($1).str, "", "newvar"));
		}
		| STRINGLITERAL {
			$$.type = TOC("string");
			$$.str = ($1).str;
			// insertLit(($1).str, "string", yylineno);
			$$.temp = TOC(insertIR("=", ($1).str, "", "newvar"));
		}
		| CHARLITERAL{
			$$.type = TOC("char");
			$$.str = ($1).str;
			// insertLit(($1).str, "char", yylineno);
			$$.temp = TOC(insertIR("=", ($1).str, "", "newvar"));
		}
		| NULLLITERAL{
			$$.type = TOC("null");
			$$.str = ($1).str;
			// insertLit(($1).str, "null", yylineno);
			$$.temp = TOC(insertIR("=", ($1).str, "", "newvar"));
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
	$$.temp = ($1).temp;
}
	    | QualifiedName {
	$$.str = ($1).str;
	$$.type = ($1).type;
	$$.temp = ($1).temp;
}
        ;

SimpleName: IDENT {
	$$.str = ($1).str;
	$$.type = ($1).str;
	$$.temp = ($1).str;
}
        ;

QualifiedName: Name DOT IDENT {
	$$.str = TOC(string(($1).str) + "." + string(($3).str));
	$$.type = TOC(membLookup(($1).str, ($3).str));
	flagqn =1;
	$$.temp = $$.str;
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
	localvarspace(($1).str);
	goUp();
	insertIR("classend", ($1).str, "", "");
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

ClassDeclaration: CLASS IDENT {addClassChild(($2).str, pps, yylineno); helpType = TOC("NULL"); pps = 1; insertIR("classstart", ($2).str, "", "");} ClassBody {
	insertConsType(($2).str, "void", "void", 0);
	$$.str = ($2).str;
}
        | Modifiers CLASS IDENT {addClassChild(($3).str, pps, yylineno); helpType = TOC("NULL"); pps = 1; insertIR("classstart", ($3).str, "", "");} ClassBody {
			insertConsType(($3).str, "void", "void", 0);
			$$.str = ($3).str;
		}
        | CLASS IDENT ClassExtends {addClassChild(($2).str, pps, yylineno); helpType = TOC("NULL"); pps = 1; insertIR("classstart", ($2).str, "", "");} ClassBody {
			insertConsType(($2).str, "void", "void", 0);
			$$.str = ($2).str;
		}
        | Modifiers CLASS IDENT ClassExtends {addClassChild(($3).str, pps, yylineno); helpType = TOC("NULL"); pps = 1; insertIR("classstart", ($3).str, "", "");} ClassBody {
			insertConsType(($3).str, "void", "void", 0);
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
modifiers_type_token: Modifiers Type {
	$$.type = ($2).type;
	helpType = ($2).type;
	helperOutType = ($2).type;
}
		| Type {
	$$.type = ($1).type;
	helpType = ($1).type;
	helperOutType = ($1).type;
}
		;

FieldDeclaration: modifiers_type_token VariableDeclarators SM {
	helpType = ($2).type;
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
			insertIR("=", ($3).temp, "", ($1).str);
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
	$$.temp = ($1).temp;
}
		| ArrayInitializer {
	$$.type = ($1).type;
	$$.temp = ($1).temp;
}
		;

//////

MethodDeclaration: MethodHeader MethodBody {
	fillGoto(helpermlv, localvarspace(helperMethodName));
	goUp();
	if(!line.empty()){
		insertMethodType(helperMethodName, helperInType, helperOutType, line.top(), helppps);
		helppps = 1;
		line.pop();
	}
	// localvarspace(helperMethodName);
	insertIR("", "", "", "pop to recover register values esi,edi");
	insertIR("","", "", "mov esp,ebp");
	insertIR("","", "", "pop ebp (restore original basepointer)");
	insertIR("","", "", "ret");
	insertIR("ENDP","_" + string(helperMethodName), "", "");
}
		;

MethodHeader: modifiers_type_token MethodDeclarator {
	line.push(yylineno);
	helperOutType = ($1).type;
	if(!line.empty()){
		insertMethodType(helperMethodName, helperInType, helperOutType, line.top(), helppps);
		helppps = 1;
	}
	insertIR("", "", "", "push ebp");
	insertIR("", "", "", "mov ebp,esp");
	helpermlv = lineIR();
	insertIR("-","stackptr","", "stackptr");
	insertIR("", "", "", "push esi,edi (saving the values of the register the function might modify)");

}
		| VOID MethodDeclarator {
			line.push(yylineno);
			helperOutType = TOC("void");
			if(!line.empty()){
				insertMethodType(helperMethodName, helperInType, helperOutType, line.top(), helppps);
				helppps = 1;
			}
			insertIR("", "", "", "push ebp");
			insertIR("", "", "", "mov ebp,esp");
			helpermlv = lineIR();
			insertIR("-","stackptr","", "stackptr");
			insertIR("", "", "", "push esi,edi (saving the values of the register the function might modify)");

		}
		| Modifiers VOID MethodDeclarator {
			line.push(yylineno);
			helperOutType = TOC("void");
			if(!line.empty()){
				insertMethodType(helperMethodName, helperInType, helperOutType, line.top(), helppps);
				helppps = 1;			
			}
			insertIR("", "", "", "push ebp");
			insertIR("", "", "", "mov ebp,esp");
			helpermlv = lineIR();
			insertIR("-","stackptr","", "stackptr");
			insertIR("", "", "", "push esi,edi (saving the values of the register the function might modify)");

		}
		;

MethodDeclarator: IDENT LP {addChild(); helppps = pps; pps = 1;} RP {
	helperMethodName = ($1).str;
	helperInType = TOC("void");
	insertIR("PROC","_" + string(helperMethodName) , "", "");
}
		| IDENT LP {addChild(); helppps = pps; pps = 1;} FormalParameterList RP {
	helperMethodName = ($1).str;
	helperInType = ($4).type;
	insertIR("PROC", "_" + string(helperMethodName), "", "");
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
	insertFPId(($3).str, ($3).type, yylineno, 1);
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
	insertIR("ENDP", helperMethodName, "", "");
}
		| Modifiers ConstructorDeclarator ConstructorBody {
			goUp();
			if(!line.empty()){
				insertConsType(helperMethodName, helperInType, "void", line.top());
				line.pop();
			}
			insertIR("ENDP", helperMethodName, "", "");
}
		;

ConstructorDeclarator: SimpleName  LP {addChild(); line.push(yylineno);} RP {
	helperMethodName = ($1).str;
	helperInType = TOC("void");
	insertIR("PROC", helperMethodName, "", "");
}
		| SimpleName  LP {addChild(); line.push(yylineno);} FormalParameterList RP {
	helperMethodName = ($1).str;
	helperInType = ($4).type;
	insertIR("PROC", helperMethodName, "", "");
		}
		;

ConstructorBody: LC BlockStatements RC {
}
        | LC ExplicitConstructorInvocation RC {
}
        | LC ExplicitConstructorInvocation BlockStatements RC {
}
        | LC RC {
} 
        ; 

ExplicitConstructorInvocation: THIS LP RP SM {
}
		| THIS LP ArgumentList RP SM {
}


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

InterfaceBody: LC InterfaceMemberDeclarations RC {
}
		| LC RC {
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
	$$.temp = TOC(insertIR("=", "{}", "", "newvar"));
}
        | LC CM RC {
			$$.type = TOC("[]");
			$$.temp = TOC(insertIR("=", "{}", "", "newvar"));
}
        | LC VariableInitializers RC {
			$$.type = TOC(string(($2).type) + "[]");
			$$.temp = TOC(insertIR("=", "{" + string(($2).temp) + "}", "", "newvar"));
}
        | LC VariableInitializers CM RC {
			$$.type = TOC(string(($2).type) + "[]");
			$$.temp = TOC(insertIR("=", "{" + string(($2).temp) + "}", "", "newvar"));
}
		;

VariableInitializers: VariableInitializer {
	$$.type = ($1).type;
	$$.temp = ($1).temp;
}
		| VariableInitializers CM VariableInitializer {
			checkType(($1).type, ($3).type, yylineno);
			$$.type = ($1).type;
			$$.temp = TOC(string(($1).temp) + "," + string(($3).temp));
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

LabeledStatement_token: IDENT COLON {insertIR("LabeledStatement", ($1).str, "", "Next statement");};

LabeledStatement: LabeledStatement_token Statement {
}
		;

LabeledStatementNoShortIf: LabeledStatement_token StatementNoShortIf {
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

IfThen_token: IF LP Expression RP {helperGoto = lineIR(); insertIR("goto",($3).temp,ITC(helperGoto+2),"if"); insertIR("goto","","","");} ;

IfThen_token2: IfThen_token StatementNoShortIf ELSE {fillGoto(helperGoto+1,lineIR()+1); helperGoto = lineIR(); insertIR("goto","","","");} ;


IfThenStatement:  IfThen_token Statement {
	fillGoto(helperGoto+1,lineIR());	
}
		;

IfThenElseStatement:  IfThen_token2 Statement {
	fillGoto(helperGoto,lineIR());
}
		;

IfThenElseStatementNoShortIf:  IfThen_token2 StatementNoShortIf {
	fillGoto(helperGoto,lineIR());
}
		;

SwitchStatement:  SWITCH LP Expression {helpType = ($3).type;} RP {addChild();} SwitchBlock {
	goUp();
}
		;

SwitchBlock: LC SwitchLabels RC {
}
		| LC SwitchBlockStatementGroups RC {
}
// 		| LC SwitchLabels RC {
// }
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

WhileStatement_token: WHILE LP Expression RP {helperGoto = lineIR(); insertIR("goto",($3).temp,ITC(helperGoto+2),"if"); insertIR("goto","","","");} ;

WhileStatement: WhileStatement_token Statement {
	insertIR("goto","",ITC(helperGoto),"");
	fillGoto(helperGoto+1,lineIR());
}
		;

WhileStatementNoShortIf: WhileStatement_token StatementNoShortIf {
	insertIR("goto","",ITC(helperGoto),"");
	fillGoto(helperGoto+1,lineIR());
}
		;

DoStatement: DO {addChild(); helperGoto = lineIR();} Statement {goUp();} WHILE LP Expression RP SM {
	insertIR("goto",($7).temp, ITC(helperGoto),"if");
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
};

for_token2: for_token  LP ForInit SM Expression SM {helper1 = lineIR(); insertIR("goto",($5).temp,ITC(helper1 + 4),"if"); insertIR("goto","","",""); helper2 = lineIR();};

for_token3: for_token2 ForUpdate {insertIR("goto","",ITC(helper1 - 1),"");};

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
		| for_token2 RP Statement {
	goUp();
}
		| for_token  LP SM Expression SM ForUpdate RP Statement {
	goUp();
}
		| for_token  LP ForInit SM SM ForUpdate RP Statement {
	goUp();
}
		| for_token3 RP Statement {
			insertIR("goto", "", ITC(helper2), "");
			fillGoto(helper1 + 1, lineIR());
			if(helperbreak!=0){
				fillGoto(helperbreak,lineIR());
				helperbreak = 0;
			}
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
		| for_token2 RP StatementNoShortIf {
	goUp();
}
		| for_token  LP SM Expression SM ForUpdate RP StatementNoShortIf {
	goUp();
}
	
		| for_token  LP ForInit SM SM ForUpdate RP StatementNoShortIf {
	goUp();
}
		| for_token3 RP StatementNoShortIf {
			insertIR("goto", "", ITC(helper2), "");
			fillGoto(helper1 + 1, lineIR());
			if(helperbreak!=0){
				fillGoto(helperbreak,lineIR());
				helperbreak = 0;
			}
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
	helperbreak = lineIR();
	insertIR("goto","","","");

}
		| BREAK IDENT SM {
}
		;

ContinueStatement: CONTINUE SM {
	insertIR("goto","",ITC(helper1+3),"");
}
		| CONTINUE IDENT SM {
}
		;

ReturnStatement: RETURN SM {
	insertIR("=","NULL","","set eax to return value");
}
		| RETURN Expression SM {
	insertIR("=",($2).temp,"","set eax to return value");
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
	$$.temp = ($1).temp;
}
		| ArrayCreationExpression {
			$$.type = ($1).type;
			$$.str = TOC("ArrayCreationExpression");
			$$.temp = ($1).temp;

}
		;

PrimaryNoNewArray: Literal {
	$$.type = ($1).type;
	$$.str = ($1).str;
	$$.temp = ($1).temp;
}
// 		| THIS {
// 			$$.type = TOC("class");
// 			$$.str = ($1).str;
// 			$$.temp = TOC("this");
// }
		| LP Expression RP {
			$$.type = ($2).type;
			$$.str = ($2).type;
			$$.temp = ($2).temp;
}
		| ClassInstanceCreationExpression {
			$$.type = ($1).type;
			$$.str = ($1).type;
			$$.temp = ($1).temp;
}
		| FieldAccess {
			$$.type = ($1).type;
			$$.str = ($1).type;
			$$.temp = ($1).temp;
}
		| MethodInvocation {
			$$.type = ($1).type;
			$$.str = ($1).type;
			$$.temp = ($1).temp;

}
		| ArrayAccess {
			$$.type = ($1).type;
			$$.str = ($1).type;
			$$.temp = ($1).temp;
}
		;

ClassInstanceCreationExpression: NEW ClassType LP ArgumentList RP {
	checkType(lookup(($2).type), "class", yylineno);
	if(methodLookup(($2).str, "void")=="NULL"){
		cout<<"Method "<< ($2).str <<" not found"<<endl;
	}; // this funcn returns the output type of the method
	$$.type = TOC(methodLookup(($2).str, ($4).type));
	$$.type = ($2).type;
	$$.temp = TOC(insertIR("=", ITC(classSize(($2).str)), "", "newvar"));
	insertIR("", $$.temp,"","pushparam");
	insertIR("","_allocmem","","call");
	insertIR("+","stackptr",ITC(4),"stackptr");
	$$.temp = TOC(insertIR("=","return object reference on heap", "", "newvar"));
	while(!args.empty()){
		insertIR("", args.top(),"","pushparam");
		args.pop();
	}
	insertIR("", $$.temp,"","pushparam");
	insertIR("","_" + string(($2).str),"","call");
	insertIR("+","stackptr",ITC(as+4),"stackptr");
	$$.temp = TOC(insertIR("=","return object from eax","","newvar"));

}
		| NEW ClassType LP RP {
			checkType(lookup(($2).type), "class", yylineno);
			if(methodLookup(($2).str, "void")=="NULL"){
				cout<<"Method "<< ($2).str <<" not found"<<endl;
			}; // this funcn returns the output type of the method
			$$.type = TOC(methodLookup(($2).str, "void"));
			$$.type = ($2).type;
			$$.temp = TOC(insertIR("=", ITC(classSize(($2).str)), "", "newvar"));
			insertIR("", $$.temp,"","pushparam");
			insertIR("","_allocmem","","call");
			insertIR("+","stackptr",ITC(4),"stackptr");
			$$.temp = TOC(insertIR("=","return object reference on heap", "", "newvar"));
			insertIR("", $$.temp,"","pushparam");
			insertIR("","_" + string(($2).str),"","call");
			insertIR("+","stackptr",ITC(4),"stackptr");
			$$.temp = TOC(insertIR("=","return object from eax","","newvar"));
}
		;

ArgumentList: Expression {
	$$.type = ($1).type;
	as = byteSize(($1).type);
	$$.temp = ($1).temp;
	while(!args.empty())args.pop();
	args.push(string(($1).temp));
}
		| ArgumentList CM Expression {
			$$.type = TOC(string(($1).type) + "X" + string(($3).type));
			as += byteSize(($3).type);
			$$.temp = TOC(string(($1).temp) + "," + string(($3).temp));
			args.push(string(($3).temp));
		}
		;

ArrayCreationExpression: NEW PrimitiveType DimExprs {
	$$.type = TOC(string(($2).type) + string(($3).type));
	$$.temp = TOC(insertIR("=", string(($2).type) + string(($3).temp), "", "newvar"));
}
		| NEW PrimitiveType DimExprs Dims {
	$$.type = TOC(string(($2).type) + string(($3).type) + string(($4).type));
	$$.temp = TOC(insertIR("=", string(($2).type) + string(($3).temp) + string(($4).type), "", "newvar"));
}
		| NEW ClassOrInterfaceType DimExprs {
	$$.type = TOC(string(($2).type) + string(($3).type));
	$$.temp = TOC(insertIR("=", string(($2).type) + string(($3).temp), "", "newvar"));
}
		| NEW ClassOrInterfaceType DimExprs Dims {
			$$.type = TOC(string(($2).type) + string(($3).type) + string(($4).type));
			$$.temp = TOC(insertIR("=", string(($2).type) + string(($3).temp) + string(($4).type), "", "newvar"));
}
		;

DimExprs: DimExpr {
	$$.type = ($1).type;
	$$.temp = ($1).temp;
}
		| DimExprs DimExpr {
			$$.type = TOC(string(($1).type) + string(($2).type));
			$$.temp = TOC(string(($1).temp) + string(($2).temp));
		}
		;

DimExpr: LB Expression RB {
	$$.type = TOC("[]");
	$$.temp = TOC("[" + string(($2).temp) + "]");
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
	$$.temp = TOC(insertIR("=",string(($1).str) + "." + string(($3).str),"","newvar"));
}
		| THIS DOT IDENT {
			//this ka kya karna hai
		}
        ;


MethodInvocation: Name LP RP {
	//also save type for aall 4 cases
	if(flagqn==1 ){
		if(($1).type == "ERROR") cout<<"Method (a qn)"<< ($1).str <<" not in scope."<<endl;
	}
	else if(methodLookup(($1).str, "void")=="NULL"){
		cout<<"Method "<< ($1).str <<" not in scope."<<endl;
	};
	 // this funcn returns the output type of the method
	
	if(flagqn==1){
		$$.type = ($1).type;
		flagqn = 0;
	}
	else $$.type = TOC(methodLookup(($1).str, "void"));
	insertIR("","_" + string(($1).str),"","call");
	$$.temp = TOC(insertIR("=","return value from eax","","newvar"));

}
		| Name LP ArgumentList RP {
			//lookup nhi kr payenge becaus eudent would be a member of class.
			if(flagqn==1 ){
				if(($1).type == "ERROR") cout<<"Method (a qn)"<< ($1).str <<" not in scope."<<endl;
			}
			else if(methodLookup(string(($1).str), string(($3).type))=="NULL"){
				cout<<"Method "<< ($1).str <<" not in scope."<<endl;
			}; // this funcn returns the output type of the method
			
			if(flagqn==1){
				$$.type = ($1).type;
				flagqn = 0;
			}
			else $$.type = TOC(methodLookup(string(($1).str), string(($3).type)));
			// as = args.size();
			while(!args.empty()){
				insertIR("", args.top(),"","pushparam");
				args.pop();
			}
			insertIR("","_" + string(($1).str),"","call");
			insertIR("+","stackptr",ITC(as),"stackptr");
			$$.temp = TOC(insertIR("=","return value from eax","","newvar"));
}
		;

ArrayAccess: Name LB Expression RB {
	if(lookup(($1).type) == "NULL") {
		cout<< " err : Variable "<<($1).str<<" not in scope of usage on line "<<yylineno<<" \n ";
	}
	$$.type = TOC(lookup(($1).str).substr(0, lookup(($1).str).length() - 2));
	checkType(($3).type, "int", yylineno);
	$$.temp = TOC(insertIR("=",string(($1).temp) + "[" + string(($3).temp) + "]","","newvar"));
}
		| PrimaryNoNewArray LB Expression RB {
	$$.type = TOC(lookup(($1).str).substr(0, lookup(($1).str).length() - 2));
	checkType(($3).type, "int", yylineno);
	$$.temp = TOC(insertIR("=",string(($1).temp) + "[" + string(($3).temp) + "]","","newvar"));
}
		;

PostFixExpression: Primary {
	$$.type = ($1).type;
	$$.temp = ($1).temp;
}
		| Name {
	if(lookup(($1).type) == "NULL") {
		cout<< " err : Variable "<<($1).str<<" not in scope of usage on line "<<yylineno<<" \n ";
	}
	$$.type = TOC(lookup(($1).type));
	$$.temp = ($1).temp;
}
		| PostIncrementExpression {
	$$.type = ($1).type;
	$$.temp = ($1).temp;
}
		| PostDecrementExpression {
	$$.type = ($1).type;
	$$.temp = ($1).temp;
}
		;

PostIncrementExpression: PostFixExpression INC {
	$$.type = ($1).type;
	$$.temp = ($1).temp;
	insertIR("+", ($1).temp, "1", ($1).temp);
}
		;

PostDecrementExpression: PostFixExpression DEC {
	$$.type = ($1).type;
	$$.temp = ($1).temp;
	insertIR("-", ($1).temp, "1", ($1).temp);
}
		;

UnaryExpression: PreIncrementExpression {
	$$.type = ($1).type;
	$$.temp = ($1).temp;
} 
		| PreDecrementExpression {
			$$.type = ($1).type;
			$$.temp = ($1).temp;
}
		| PLUS UnaryExpression {
			$$.type = ($2).type;
			$$.temp = TOC(insertIR("+ve", "", ($2).temp, "newvar"));
}
		| MINUS UnaryExpression {
			$$.type = ($2).type;
			$$.temp = TOC(insertIR("-ve", "", ($2).temp, "newvar"));
}
		| UnaryExpressionNotPlusMinus {
			$$.type = ($1).type;
			$$.temp = ($1).temp;
} 
		;

PreIncrementExpression: INC UnaryExpression {
	$$.type = ($2).type;
	$$.temp = TOC(insertIR("+", ($2).temp, "1", ($2).temp));
}
		;

PreDecrementExpression: DEC UnaryExpression {
	$$.type = ($2).type;
	$$.temp = TOC(insertIR("-", ($2).temp, "1", ($2).temp));
}
		;

UnaryExpressionNotPlusMinus: PostFixExpression {
	$$.type = ($1).type;
	$$.temp = ($1).temp;
}
		| TILDE UnaryExpression {
			$$.type = ($2).type;
			$$.temp = TOC(insertIR("~", ($2).temp, "", "newvar"));
}
		| EXCL UnaryExpression {
			$$.type = ($2).type;
			$$.temp = TOC(insertIR("!", ($2).temp, "", "newvar"));
}
		| CastExpression {
			$$.type = ($1).type;
			$$.temp = ($1).temp;
}
		;

CastExpression: LP PrimitiveType RP UnaryExpression {
	checkType(($2).type, "numeric", yylineno);
	checkType(($4).type, "numeric", yylineno);
	$$.type = ($2).type;
	$$.temp = TOC(insertIR("cast", ($2).type, ($4).temp, "newvar"));
}
        | LP PrimitiveType Dims RP UnaryExpression {
			checkType(($2).type, "numeric", yylineno);
			checkType(($5).type, "numeric", yylineno);
			$$.type = TOC(string(($2).type) + string(($3).type));
			$$.temp = TOC(insertIR("cast", string(($2).type) + string(($3).type), ($5).temp, "newvar"));
}
		| LP Expression RP UnaryExpressionNotPlusMinus {
			checkType(($2).type, "numeric", yylineno);
			checkType(($4).type, "numeric", yylineno);
			$$.type = ($2).type;
			$$.temp = TOC(insertIR("cast", ($2).type, ($4).temp, "newvar"));
}
		| LP Name Dims RP UnaryExpressionNotPlusMinus {
			checkType(($2).type, "numeric", yylineno);
			checkType(($5).type, "numeric", yylineno);
			$$.type = TOC(string(($2).type) + string(($3).type));
			$$.temp = TOC(insertIR("cast", string(($2).type) + string(($3).type), ($5).temp, "newvar"));
}
		;

MultiplicativeExpression: UnaryExpression {
	$$.type = ($1).type;
	$$.temp = ($1).temp;
}
		| MultiplicativeExpression MUL UnaryExpression  {
			checkType(($1).type, "numeric", yylineno);
			checkType(($3).type, "numeric", yylineno);
			$$.type = max(($1).type, ($3).type);
			$$.temp = TOC(insertIR("*", ($1).temp, ($3).temp, "newvar"));
}
		| MultiplicativeExpression DIV UnaryExpression {
			checkType(($1).type, "numeric", yylineno);
			checkType(($3).type, "numeric", yylineno);
			$$.type = max(($1).type, ($3).type);
			$$.temp = TOC(insertIR("/", ($1).temp, ($3).temp, "newvar"));
}
		| MultiplicativeExpression MOD UnaryExpression {
			checkType(($1).type, "numeric", yylineno);
			checkType(($3).type, "int", yylineno);
			$$.type = ($1).type;
			$$.temp = TOC(insertIR("%", ($1).temp, ($3).temp, "newvar"));
}
		;

AdditiveExpression: MultiplicativeExpression {
	$$.type = ($1).type;
	$$.temp = ($1).temp;
}
		| AdditiveExpression PLUS MultiplicativeExpression {
			$$.type = max(($1).type, ($3).type);
			$$.temp = TOC(insertIR("+", ($1).temp, ($3).temp, "newvar"));
}
		| AdditiveExpression MINUS MultiplicativeExpression  {
			$$.type = max(($1).type, ($3).type);
			$$.temp = TOC(insertIR("-", ($1).temp, ($3).temp, "newvar"));
}
		;

ShiftExpression: AdditiveExpression {
	$$.type = ($1).type;
	$$.temp = ($1).temp;
}
		| ShiftExpression SHL AdditiveExpression {
			checkType(($1).type, "int", yylineno);
			checkType(($3).type, "int", yylineno);
			$$.type = ($1).type;
			$$.temp = TOC(insertIR("<<", ($1).temp, ($3).temp, "newvar"));
}
		| ShiftExpression SHR AdditiveExpression {
			checkType(($1).type, "int", yylineno);
			checkType(($3).type, "int", yylineno);
			$$.type = ($1).type;
			$$.temp = TOC(insertIR(">>", ($1).temp, ($3).temp, "newvar"));
}
		| ShiftExpression LSHR AdditiveExpression {
			checkType(($1).type, "int", yylineno);
			checkType(($3).type, "int", yylineno);
			$$.type = ($1).type;
			$$.temp = TOC(insertIR("<<<", ($1).temp, ($3).temp, "newvar"));
}
		;

RelationalExpression: ShiftExpression {
	$$.type = ($1).type;
	$$.temp = ($1).temp;
}
		| RelationalExpression LT ShiftExpression {
			checkType(($1).type, "numeric", yylineno);
			$$.type = TOC("boolean");
			$$.temp = TOC(insertIR("<", ($1).temp, ($3).temp, "newvar"));
}
		| RelationalExpression GT ShiftExpression {
			checkType(($1).type, "numeric", yylineno);
			$$.type = TOC("boolean");
			$$.temp = TOC(insertIR(">", ($1).temp, ($3).temp, "newvar"));
}
		| RelationalExpression LE ShiftExpression {
			checkType(($1).type, "numeric", yylineno);
			$$.type = TOC("boolean");
			$$.temp = TOC(insertIR("<=", ($1).temp, ($3).temp, "newvar"));
}
		| RelationalExpression GE ShiftExpression {
			checkType(($1).type, "numeric", yylineno);
			$$.type = TOC("boolean");
			$$.temp = TOC(insertIR(">=", ($1).temp, ($3).temp, "newvar"));
}
		| RelationalExpression INSTANCEOF ReferenceType {
			checkType(($1).type, ($3).type, yylineno);
			$$.type = TOC("boolean");
			$$.temp = TOC(insertIR("instanceof", ($1).temp, ($3).temp, "newvar"));
}
		;

EqualityExpression: RelationalExpression {
	$$.type = ($1).type;
	$$.temp = ($1).temp;
}
		| EqualityExpression EQ RelationalExpression{
			checkType(($1).type, ($3).type, yylineno);
			$$.type = TOC("boolean");
			$$.temp = TOC(insertIR("==", ($1).temp, ($3).temp, "newvar"));
}
		| EqualityExpression NE RelationalExpression {
			checkType(($1).type, ($3).type, yylineno);
			$$.type = TOC("boolean");
			$$.temp = TOC(insertIR("!=", ($1).temp, ($3).temp, "newvar"));
}
		;

AndExpression: EqualityExpression {
	$$.type = ($1).type;
	$$.temp = ($1).temp;
}
		| AndExpression AND EqualityExpression {
			checkType(($1).type, ($3).type, yylineno);
			checkType(($1).type, "booleannumeric", yylineno);
			$$.type= ($1).type;
			$$.temp = TOC(insertIR("&", ($1).temp, ($3).temp, "newvar"));
}
		;

ExclusiveOrExpression: AndExpression {
	$$.type = ($1).type;
	$$.temp = ($1).temp;
}
		| ExclusiveOrExpression CARET AndExpression {
			checkType(($1).type, ($3).type, yylineno);
			checkType(($1).type, "booleannumeric", yylineno);
			$$.type = ($1).type;
			$$.temp = TOC(insertIR("^", ($1).temp, ($3).temp, "newvar"));
}
		;

InclusiveOrExpression: ExclusiveOrExpression  {
	$$.type = ($1).type;
	$$.temp = ($1).temp;
}
		| InclusiveOrExpression OR ExclusiveOrExpression {
			checkType(($1).type, ($3).type, yylineno);
			checkType(($1).type, "booleannumeric", yylineno);
			$$.type = ($1).type;
			$$.temp = TOC(insertIR("|", ($1).temp, ($3).temp, "newvar"));
}
		;

ConditionalAndExpression: InclusiveOrExpression {
	$$.type = ($1).type;
	$$.temp = ($1).temp;
}
		| ConditionalAndExpression ANDAND InclusiveOrExpression {
			checkType(($1).type, "boolean", yylineno);
			checkType(($3).type, "boolean", yylineno);
			$$.type = TOC("boolean");
			$$.temp = TOC(insertIR("&&", ($1).temp, ($3).temp, "newvar"));
}
		;

ConditionalOrExpression: ConditionalAndExpression {
	$$.type = ($1).type;
	$$.temp = ($1).temp;
}
		| ConditionalOrExpression OROR ConditionalAndExpression {
			checkType(($1).type, "boolean", yylineno);
			checkType(($3).type, "boolean", yylineno);
			$$.type = TOC("boolean");
			//
			$$.temp = TOC(insertIR("||", ($1).temp, ($3).temp, "newvar"));
}
		;

ConditionalExpression: ConditionalOrExpression {
	$$.type = ($1).type;
	$$.temp = ($1).temp;
}
		| ConditionalOrExpression QUEST Expression COLON ConditionalExpression {
			checkType(($1).type, "boolean", yylineno);
			checkType(($3).type, ($5).type, yylineno);
			$$.type = ($3).type;
			//
			helperGoto = lineIR(); 
			insertIR("goto",($1).temp,ITC(helperGoto+2),"if"); 
			insertIR("goto","",ITC(helperGoto+4),"");
			$$.temp = TOC(insertIR("=", ($3).temp, "", "newvar"));
			insertIR("goto","",ITC(helperGoto+5),"");
			insertIR("=", ($5).temp, "", $$.temp);
			//
}
		;

AssignmentExpression: ConditionalExpression {
	$$.type = ($1).type;
	$$.temp = ($1).temp;
}
		| Assignment {
			$$.type = ($1).type;
			$$.temp = ($1).temp;
}
		;

Assignment: LeftHandSide AssignmentOperator AssignmentExpression {
	$$.type = ($3).type;
	checkType(($1).type, ($3).type, yylineno);
	$$.temp = ($1).temp;
	if(helperop == "=") {
		insertIR("=", ($3).temp, "", ($1).temp);
	}
	else if(helperop == "*=") {
		insertIR("*", ($1).temp, ($3).temp, ($1).temp);
	}
	else if(helperop == "/=") {
		insertIR("/", ($1).temp, ($3).temp, ($1).temp);
	}
	else if(helperop == "mod=") {
		insertIR("mod", ($1).temp, ($3).temp, ($1).temp);
	}
	else if(helperop == "+=") {
		insertIR("+", ($1).temp, ($3).temp, ($1).temp);
	}
	else if(helperop == "-=") {
		insertIR("-", ($1).temp, ($3).temp, ($1).temp);
	}
	else if(helperop == "<<=") {
		insertIR("<<", ($1).temp, ($3).temp, ($1).temp);
	}
	else if(helperop == ">>=") {
		insertIR(">>", ($1).temp, ($3).temp, ($1).temp);
	}
	else if(helperop == ">>>=") {
		insertIR(">>>", ($1).temp, ($3).temp, ($1).temp);
	}
	else if(helperop == "&=") {
		insertIR("&", ($1).temp, ($3).temp, ($1).temp);
	}
	else if(helperop == "^=") {
		insertIR("^", ($1).temp, ($3).temp, ($1).temp);
	}
	else if(helperop == "|=") {
		insertIR("|", ($1).temp, ($3).temp, ($1).temp);
	}
}
		;

LeftHandSide: Name {
	// printf("Name: %s", ($1).type);
	if(lookup(($1).type) == "NULL") {
		cout<< " err : Variable "<<($1).str<<" not in scope of usage on line "<<yylineno<<" \n ";
	}
	$$.type = TOC(lookup(($1).type));
	$$.temp = ($1).str;
}
		| FieldAccess {
	$$.type = ($1).type;
	$$.temp = ($1).temp;
}
		| ArrayAccess {
	$$.type = ($1).type;
	$$.temp = ($1).temp;
}
		;

AssignmentOperator: ASN {
	helperop = "=";
}
		| MUASN{
	helperop = "*=";
}
		| DIASN{
	helperop = "/=";
}
		| MODASN{
	helperop = "mod=";
}
		| PLASN{
	helperop = "+=";
}
		| MIASN{
	helperop = "-=";
}
		| SLASN{
	helperop = "<<=";
}
		| SRASN{
	helperop = ">>=";
}
		| LSRASN{
	helperop = ">>>=";
}
		| ANDASN{
	helperop = "&=";
}
		| CARETASN{
	helperop = "^=";
}
		| ORASN{
	helperop = "|=";
}
		;

Expression: AssignmentExpression {
	$$.type = ($1).type;
	$$.temp = ($1).temp;
}
		;

ConstantExpression: Expression  {
	$$.type = ($1).type;
	$$.temp = ($1).temp;
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
char* ITC(int num) {
	char* newchr = new char[12];
    sprintf(newchr, "%d", num); // Convert integer to string
    return newchr;
}

int main(){
	symTabInit();
	pps = 1;
    yyparse();
    return 0;
}

