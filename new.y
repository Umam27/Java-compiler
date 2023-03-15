%{
    #include<bits/stdc++.h>
	#include "symtab.cpp"
	#include "ast.h"
    using namespace std;
    extern int yylex();
    extern int yyparse();
    extern int yyerror(char *s);
    extern "C" int yylineno;



	string type;

	// helper func
	// void insertType(){
	// 	strcpy(type, yytext);
	// }

	int nodeNum  = 0;
%}

%union {
   char* str;
   ASTnode* n;
   ASTnodes* ns;
}

%token < str > ABSTRACT BOOLEAN BREAK BYTE CASE CATCH CHAR CLASS CONST
%token < str > DEFAULT DO DOUBLE ELSE EXTENDS FINAL FINALLY FLOAT FOR GOTO
%token < str > IF IMPLEMENTS IMPORT INSTANCEOF INT INTERFACE LONG NATIVE NEW
%token < str > PACKAGE PRIVATE PROTECTED PUBLIC RETURN SUSPEND ASSERT
%token < str > SHORT STATIC SUPER SWITCH SYNCHRONIZED THIS THROW THROWS
%token < str > VOID VOLATILE WHILE IDENT CONTINUE TRANSIENT TRY
%token < str > NULLLITERAL BOOLLITERAL INTLITERAL
%token < str > CHARLITERAL FLOATLITERAL STRINGLITERAL
%token < str > LP RP LC RC LB RB SM CM DOT ASN LT GT EXCL TILDE QUEST COLON
%token < str > EQ NE LE GE ANDAND OROR INC DEC PLUS MINUS MUL DIV AND OR CARET
%token < str > MOD SHL SHR LSHR PLASN MIASN MUASN DIASN MODASN
%token < str > ANDASN ORASN CARETASN SLASN SRASN LSRASN 
%token < str > ATR ACCESSSPEC ARROW DIAMOND TDOT
%token < str > EXPORTS OPENS REQUIRES USES MODULE PERMITS SEALED VAR 
%token < str > NSEALED PROVIDES TO WITH OPEN RECORD TRANSITIVE YIELD
%token < str > STRICTFP ENUM


%type < ns > Modifiers ArrayType DimExprs Dims ArgumentList BlockStatements ImportDeclarations TypeDeclarations SwitchBlockStatementGroups SwitchLabels StatementExpressionList Catches ClassBodyDeclarations FormalParameterList VariableDeclaratorId MethodDeclarator ClassTypeList ExtendsInterfaces InterfaceMemberDeclarations  InterfaceTypeList VariableDeclarators VariableInitializers



%type < n > Start Literal Type PrimitiveType NumericType IntegralType FloatingPointType
%type < n > ReferenceType ClassOrInterfaceType ClassType InterfaceType Name
%type < n > SimpleName QualifiedName CompilationUnit
%type < n > PackageDeclaration ImportDeclaration SingleTypeImportDeclaration
%type < n > TypeImportOnDemandDeclaration TypeDeclaration Modifier
%type < n > ClassDeclaration ClassExtends Interfaces ClassBody
%type < n > ClassBodyDeclaration ClassMemberDeclaration
%type < n > FieldDeclaration VariableDeclarator
%type < n > VariableInitializer MethodDeclaration MethodHeader
%type < n > FormalParameter Throws MethodBody
%type < n > StaticInitializer ConstructorDeclaration ConstructorDeclarator
%type < n > ConstructorBody ExplicitConstructorInvocation InterfaceDeclaration
%type < n > InterfaceBody
%type < n > ConstantDeclaration AbstractMethodDeclaration ArrayInitializer
%type < n > Block BlockStatement
%type < n > LocalVariableDeclarationStatement LocalVariableDeclaration Statement
%type < n > StatementNoShortIf StatementWithoutTrailingSubstatement EmptyStatement
%type < n > LabeledStatement LabeledStatementNoShortIf ExpressionStatement
%type < n > StatementExpression IfThenStatement IfThenElseStatement ForStatement
%type < n > IfThenElseStatementNoShortIf SwitchStatement SwitchBlock ForInit
%type < n > SwitchBlockStatementGroup
%type < n > SwitchLabel WhileStatement WhileStatementNoShortIf DoStatement
%type < n > ForStatementNoShortIf ForUpdate BreakStatement
%type < n > ContinueStatement ReturnStatement ThrowStatement SynchronizedStatement
%type < n > TryStatement CatchClause Finally Primary PrimaryNoNewArray
%type < n > ClassInstanceCreationExpression ArrayCreationExpression
%type < n > DimExpr FieldAccess MethodInvocation ArrayAccess
%type < n > PostFixExpression PostIncrementExpression PostDecrementExpression
%type < n > UnaryExpression PreIncrementExpression PreDecrementExpression
%type < n > UnaryExpressionNotPlusMinus CastExpression MultiplicativeExpression
%type < n > AdditiveExpression ShiftExpression RelationalExpression EqualityExpression
%type < n > AndExpression ExclusiveOrExpression InclusiveOrExpression LeftHandSide
%type < n > ConditionalAndExpression ConditionalOrExpression ConditionalExpression
%type < n > AssignmentExpression Assignment AssignmentOperator Expression
%type < n > ConstantExpression InterfaceMemberDeclaration
%type < n > BasicForStatement BasicForStatementNoShortIf
%type < n > EnhancedForStatement EnhancedForStatementNoShortIf


%start Start

%%

Start: CompilationUnit {
	$$ = new ASTnode(++nodeNum, "Start");
	nodeJoin($$, $1);
}
        ;

Literal: INTLITERAL {
			$$ = new ASTnode(++nodeNum , "Literal");
			nodeToTerminal($$, $1, "Integer Literal");
		}
		| FLOATLITERAL {
			$$ = new ASTnode(++nodeNum , "Literal");
			nodeToTerminal($$, $1, "Float Literal");
		}
		| BOOLLITERAL {
			$$ = new ASTnode(++nodeNum , "Literal");
			nodeToTerminal($$, $1, "Bool Literal");
		}
		| STRINGLITERAL {
			$$ = new ASTnode(++nodeNum , "Literal");
			nodeToTerminal($$, $1, "String Literal");
		}
		| CHARLITERAL {
			$$ = new ASTnode(++nodeNum , "Literal");
			nodeToTerminal($$, $1, "Char Literal");
		}
		| NULLLITERAL {
			$$ = new ASTnode(++nodeNum , "Literal");
			nodeToTerminal($$, $1, "Null Literal");
		}
		;

Type: PrimitiveType {
	$$ = new ASTnode(++nodeNum , "Type");
	nodeJoin($$, $1);
}
		| ReferenceType {
	$$ = new ASTnode(++nodeNum , "Type");
	nodeJoin($$, $1);
}
		;

PrimitiveType: NumericType {
	$$ = new ASTnode(++nodeNum , "Primitive Type");
	nodeJoin($$, $1);
}
        | BOOLEAN {
			$$ = new ASTnode(++nodeNum , "Type");
			nodeToTerminal($$, $1, "Boolean");
		}
		;

NumericType: IntegralType {
	$$ = new ASTnode(++nodeNum , "Numeric Type");
	nodeJoin($$, $1);
}
		| FloatingPointType {
	$$ = new ASTnode(++nodeNum , "Numeric Type");
	nodeJoin($$, $1);
}

IntegralType: BYTE {
			$$ = new ASTnode(++nodeNum , "Integer Type");
			nodeToTerminal($$, $1, "Byte");
			//
			// insertType();
		}
		| SHORT {
			$$ = new ASTnode(++nodeNum , "Integer Type");
			nodeToTerminal($$, $1, "Short");
			//
			// insertType();
		}
		| INT {
			$$ = new ASTnode(++nodeNum , "Integer Type");
			nodeToTerminal($$, $1, "Integer");
			//
			// insertType();
		}
		| LONG {
			$$ = new ASTnode(++nodeNum , "Integer Type");
			nodeToTerminal($$, $1, "Long");
			//
			// insertType();
		}
		| CHAR {
			$$ = new ASTnode(++nodeNum , "Integer Type");
			nodeToTerminal($$, $1, "Character");
			//
			// insertType();
		}
		;

FloatingPointType: FLOAT {
			$$ = new ASTnode(++nodeNum , "Floating Point Type");
			nodeToTerminal($$, $1, "Float");
		}
		| DOUBLE {
			$$ = new ASTnode(++nodeNum , "Floating Point Type");
			nodeToTerminal($$, $1, "Double");
		}
		;

ReferenceType: ClassOrInterfaceType {
			$$ = new ASTnode(++nodeNum , "Reference Type");
			nodeJoin($$, $1);
		}
        | ArrayType {
			$$ = new ASTnode(++nodeNum , "Reference Type");
			nodeJoinToList($$, $1);
		}
		;

ClassOrInterfaceType: Name {
	$$ = new ASTnode(++nodeNum , "Class Or Interface Type");
	nodeJoin($$, $1);
}
        ;

ClassType: ClassOrInterfaceType {
	$$ = new ASTnode(++nodeNum , "Class Type");
	nodeJoin($$, $1);
}
        ;

InterfaceType: ClassOrInterfaceType {
	$$ = new ASTnode(++nodeNum , "Interface Type");
	nodeJoin($$, $1);
}
        ;

ArrayType: PrimitiveType LB RB {
	$$ = new ASTnodes();
	$$ -> push_back($1);
	$$ ->push_back(new ASTnode(++nodeNum, $2));
	$$ ->push_back(new ASTnode(++nodeNum, $3));
}
		| Name LB RB {
	$$ = new ASTnodes();
	$$ -> push_back($1);$$ -> push_back($1);
	$$ ->push_back(new ASTnode(++nodeNum, $2));
	$$ ->push_back(new ASTnode(++nodeNum, $3));
}
        | ArrayType LB RB {
			$$ = $1;
			$$ ->push_back(new ASTnode(++nodeNum, $2));
			$$ ->push_back(new ASTnode(++nodeNum, $3));
		}
		;

Name: SimpleName {
	$$ = new ASTnode(++nodeNum , "Name");
	nodeJoin($$, $1);
}
	    | QualifiedName {
	$$ = new ASTnode(++nodeNum , "Name");
	nodeJoin($$, $1);
}
        ;

SimpleName: IDENT {
	$$ = new ASTnode(++nodeNum , "Simple Name");
	nodeToTerminal($$, $1, "Identifier");
}
        ;

QualifiedName: Name DOT IDENT {
	$$ = new ASTnode(++nodeNum, "Qualified Name");
	nodeJoin($$, $1);
	nodeToTerminal($$, $2, "Dot");
	nodeToTerminal($$, $3, "Identifier");
}
        ;

CompilationUnit: PackageDeclaration {
	$$ = new ASTnode(++nodeNum, "Compilation Unit");
	nodeJoin($$, $1);
}
		| ImportDeclarations {
	$$ = new ASTnode(++nodeNum, "Compilation Unit");
	nodeJoinToList($$, $1);
}
		| TypeDeclarations {
	$$ = new ASTnode(++nodeNum, "Compilation Unit");
	nodeJoinToList($$, $1);
}
		| PackageDeclaration ImportDeclarations {
	$$ = new ASTnode(++nodeNum, "Compilation Unit");
	nodeJoin($$, $1);
	nodeJoinToList($$, $2);
}
		| ImportDeclarations TypeDeclarations {
	$$ = new ASTnode(++nodeNum, "Compilation Unit");
	nodeJoinToList($$, $1);
	nodeJoinToList($$, $2);
}
		| PackageDeclaration TypeDeclarations {
	$$ = new ASTnode(++nodeNum, "Compilation Unit");
	nodeJoin($$, $1);
	nodeJoinToList($$, $2);
}
		| PackageDeclaration ImportDeclarations TypeDeclarations {
	$$ = new ASTnode(++nodeNum, "Compilation Unit");
	nodeJoin($$, $1);
	nodeJoinToList($$, $2);
	nodeJoinToList($$, $3);

}
        ;

ImportDeclarations: ImportDeclaration {
	$$ = new ASTnodes();
	$$ -> push_back($1);
}
        | ImportDeclarations ImportDeclaration {
			$$ = $1;
			$$ -> push_back($2);
		}
        ;

TypeDeclarations: TypeDeclaration {
	$$ = new ASTnodes();
	$$ -> push_back($1);
}
	    | TypeDeclarations TypeDeclaration {
			$$ = $1;
			$$ -> push_back($2);
		}
        ;

PackageDeclaration: PACKAGE Name SM {
	$$ = new ASTnode(++nodeNum , "Package Declaration");
	nodeToTerminal($$, $1, "Package");
	nodeJoin($$, $2);
	nodeToTerminal($$, $3, "Semi Colon");
}
		;

ImportDeclaration: SingleTypeImportDeclaration {
	$$ = new ASTnode(++nodeNum, "Import Declaration");
	nodeJoin($$, $1);
}
		| TypeImportOnDemandDeclaration {
	$$ = new ASTnode(++nodeNum, "Import Declaration");
	nodeJoin($$, $1);
}
		;

SingleTypeImportDeclaration: IMPORT Name SM {
	$$ = new ASTnode(++nodeNum, "Single Type Import on demand declaration");
	nodeToTerminal($$, $1 , "Import");
	nodeJoin($$, $2);
	nodeToTerminal($$, $3 , "Semi Column");
}
		;

TypeImportOnDemandDeclaration: IMPORT Name DOT MUL SM {
	$$ = new ASTnode(++nodeNum, "Type Import on demand declaration");
	nodeToTerminal($$, $1 , "Import");
	nodeJoin($$, $2);
	nodeToTerminal($$, $3 , "Dot");
	nodeToTerminal($$, $4 , "Multiply");
	nodeToTerminal($$, $5 , "Semi Column");
}
		;

TypeDeclaration: ClassDeclaration {
	$$ = new ASTnode(++nodeNum, "Type Declaration");
	nodeJoin($$, $1);
}
        | InterfaceDeclaration {
	$$ = new ASTnode(++nodeNum, "Type Declaration");
	nodeJoin($$, $1);
}
        | SM {
	$$ = new ASTnode(++nodeNum, "Type Declaration");
	nodeToTerminal($$, $1, "Semi Colon");
}
        ;

Modifiers: Modifier {
	$$ = new ASTnodes();
	$$ -> push_back($1);
}
	    | Modifiers Modifier {
			$$ = $1;
			$$ -> push_back($2);
		}
        ;

Modifier: PUBLIC {
	$$ = new ASTnode(++nodeNum , "Modifier");
	nodeToTerminal($$, $1, "Public");
	//
	cout<<lookup($1)<<endl;
	cout<<insertDeclType($1,"trial")<<endl;
	cout<<insertMethodType($1,"trialfi","trialfo")<<endl;
	addChild();
}
		| PROTECTED {
	$$ = new ASTnode(++nodeNum , "Modifier");
	nodeToTerminal($$, $1, "Protected");
}
		| PRIVATE {
	$$ = new ASTnode(++nodeNum , "Modifier");
	nodeToTerminal($$, $1, "Private");
}
		| ABSTRACT {
	$$ = new ASTnode(++nodeNum , "Modifier");
	nodeToTerminal($$, $1, "Abstract");
}
		| STATIC {
	$$ = new ASTnode(++nodeNum , "Modifier");
	nodeToTerminal($$, $1, "Static");
}
		| FINAL {
	$$ = new ASTnode(++nodeNum , "Modifier");
	nodeToTerminal($$, $1, "Final");
} 
		| TRANSIENT {
	$$ = new ASTnode(++nodeNum , "Modifier");
	nodeToTerminal($$, $1, "Transitive");
}
		| VOLATILE {
	$$ = new ASTnode(++nodeNum , "Modifier");
	nodeToTerminal($$, $1, "Volatile");
}
		| SYNCHRONIZED {
	$$ = new ASTnode(++nodeNum , "Modifier");
	nodeToTerminal($$, $1, "Synchronized");
}
        | NATIVE {
	$$ = new ASTnode(++nodeNum , "Modifier");
	nodeToTerminal($$, $1, "Native");
}
		;

ClassDeclaration: CLASS IDENT ClassBody {
	$$ = new ASTnode(++nodeNum , "Class Declaration");
	nodeToTerminal($$, $1, "Class");
	nodeToTerminal($$, $2, "Identifier");
	nodeJoin($$, $3);
}
        | Modifiers CLASS IDENT ClassBody {
			$$ = new ASTnode(++nodeNum , "Class Declaration");
			nodeJoinToList($$, $1);
			nodeToTerminal($$, $2, "Class");
			nodeToTerminal($$, $3, "Identifier");
			nodeJoin($$, $4);
		}
        | CLASS IDENT ClassExtends ClassBody {
			$$ = new ASTnode(++nodeNum , "Class Declaration");
			nodeToTerminal($$, $1, "Class");
			nodeToTerminal($$, $2, "Identifier");
			nodeJoin($$, $3);
			nodeJoin($$, $4);
		}
        | CLASS IDENT Interfaces ClassBody {
			$$ = new ASTnode(++nodeNum , "Class Declaration");
			nodeToTerminal($$, $1, "Class");
			nodeToTerminal($$, $2, "Indentifier");
			nodeJoin($$, $3);
			nodeJoin($$, $4);
		}
        | Modifiers CLASS IDENT ClassExtends ClassBody {
			$$ = new ASTnode(++nodeNum , "Class Declaration");
			nodeJoinToList($$, $1);
			nodeToTerminal($$, $2, "Class");
			nodeToTerminal($$, $3, "Identifier");
			nodeJoin($$, $4);
			nodeJoin($$, $5);
		}
        | CLASS IDENT ClassExtends Interfaces ClassBody {
			$$ = new ASTnode(++nodeNum , "Class Declaration");
			nodeToTerminal($$, $1, "Class");
			nodeToTerminal($$, $2, "Identifier");
			nodeJoin($$, $3);
			nodeJoin($$, $4);
			nodeJoin($$, $5);
		}
        | Modifiers CLASS IDENT Interfaces ClassBody {
			$$ = new ASTnode(++nodeNum , "Class Declaration");
			nodeJoinToList($$, $1);
			nodeToTerminal($$, $2, "Class");
			nodeToTerminal($$, $3, "Identifier");
			nodeJoin($$, $4);
			nodeJoin($$, $5);
		}
        | Modifiers CLASS IDENT ClassExtends Interfaces ClassBody {
			$$ = new ASTnode(++nodeNum , "Class Declaration");
			nodeJoinToList($$, $1);
			nodeToTerminal($$, $2, "Class");
			nodeToTerminal($$, $3, "Identifier");
			nodeJoin($$, $4);
			nodeJoin($$, $5);
			nodeJoin($$, $6);
		}
        ;

ClassExtends: EXTENDS ClassType {
	$$ = new ASTnode(++nodeNum, "Class extends");
	nodeToTerminal($$, $1, "Extends");
	nodeJoin($$, $2);
}
        ;

Interfaces: IMPLEMENTS InterfaceTypeList {
	$$ = new ASTnode(++nodeNum, "Interfaces");
	nodeToTerminal($$, $1, "Implements");
	nodeJoinToList($$, $2);
}
        ;

InterfaceTypeList: InterfaceType  {
	$$ = new ASTnodes();
	$$ -> push_back($1);
}
	    | InterfaceTypeList CM InterfaceType {
			$$ = $1;
			$$ -> push_back(new ASTnode(++nodeNum, $2));
			$$ -> push_back($3);
		}
        ;

ClassBody: LC ClassBodyDeclarations RC {
	$$ = new ASTnode(++nodeNum, "Class Body");
	nodeToTerminal($$, $1, "Left Bracket");
	nodeJoinToList($$, $2);
	nodeToTerminal($$, $3, "Right Bracket");
}
        | LC RC {
	$$ = new ASTnode(++nodeNum, "Class Body");
	nodeToTerminal($$, $1, "Left Bracket");
	nodeToTerminal($$, $2, "Right Bracket");
}
        ;

ClassBodyDeclarations: ClassBodyDeclaration {
	$$ = new ASTnodes();
	$$ -> push_back($1);
}
	    | ClassBodyDeclarations ClassBodyDeclaration {
			$$ = $1;
			$$ -> push_back($2);
		}
        ;

ClassBodyDeclaration: ClassMemberDeclaration {
	$$ = new ASTnode(++nodeNum, "Class Body Declaration");
	nodeJoin($$, $1);
}
		| StaticInitializer {
	$$ = new ASTnode(++nodeNum, "Class Body Declaration");
	nodeJoin($$, $1);
}
		| ConstructorDeclaration {
	$$ = new ASTnode(++nodeNum, "Class Body Declaration");
	nodeJoin($$, $1);
}
		;

ClassMemberDeclaration: FieldDeclaration {
	$$ = new ASTnode(++nodeNum, "Class Member Declaration");
	nodeJoin($$, $1);
}
		| MethodDeclaration {
	$$ = new ASTnode(++nodeNum, "Class Member Declaration");
	nodeJoin($$, $1);
}
		;

//

FieldDeclaration: Modifiers Type VariableDeclarators SM {
	$$ = new ASTnode(++nodeNum, "Field Declaration");
	nodeJoinToList($$, $1);
	nodeJoin($$, $2);
	nodeJoinToList($$, $3);
	nodeToTerminal($$, $4, "Semi Colon");
}
        | Type VariableDeclarators SM {
	$$ = new ASTnode(++nodeNum, "Field Declaration");
	nodeJoin($$, $1);
	nodeJoinToList($$, $2);
	nodeToTerminal($$, $3, "Semi Colon");
}
        ;

VariableDeclarators: VariableDeclarator {
	$$ = new ASTnodes();
	$$ -> push_back($1);
}
		| VariableDeclarators CM VariableDeclarator {
			$$ = $1;
			$$ -> push_back(new ASTnode(++nodeNum, $2));
			$$ -> push_back($3);
		}
		;

VariableDeclarator: VariableDeclaratorId {
	$$ = new ASTnode(++nodeNum, "Variable Declarator");
	nodeJoinToList($$, $1);
}
		| VariableDeclaratorId ASN VariableInitializer {
			$$ = new ASTnode(++nodeNum, "Variable Declarator");
			nodeJoinToList($$, $1);
			nodeToTerminal($$, $2, "=");
			nodeJoin($$, $3);

		}
		;

VariableDeclaratorId: IDENT {
	$$ = new ASTnodes();
	$$ -> push_back(new ASTnode(++nodeNum, "Identifier"));
}
		| VariableDeclaratorId LB RB {
			$$ = $1;
			$$ -> push_back(new ASTnode(++nodeNum, "LB"));
			$$ -> push_back(new ASTnode(++nodeNum, "RB"));
		}
		;

VariableInitializer: Expression {
	$$ = new ASTnode(++nodeNum , "Variable Initializer");
	nodeJoin($$, $1);
}
		| ArrayInitializer {
	$$ = new ASTnode(++nodeNum , "Variable Initializer");
	nodeJoin($$, $1);
}
		;

MethodDeclaration: MethodHeader MethodBody {
	$$ = new ASTnode(++nodeNum , "Method Declaration");
	nodeJoin($$, $1);
	nodeJoin($$, $2);
}
		;

MethodHeader: Type MethodDeclarator {
	$$ = new ASTnode(++nodeNum , "Method Header");
	nodeJoin($$, $1);
	nodeJoinToList($$, $2);
}
		| VOID MethodDeclarator {
	$$ = new ASTnode(++nodeNum , "Method Header");
	nodeToTerminal($$, $1, "Void");
	nodeJoinToList($$, $2);
}
		| Type MethodDeclarator Throws {
	$$ = new ASTnode(++nodeNum , "Method Header");
	nodeJoin($$, $1);
	nodeJoinToList($$, $2);
	nodeJoin($$, $3);
}
		| VOID MethodDeclarator Throws {
	$$ = new ASTnode(++nodeNum , "Method Header");
	nodeToTerminal($$, $1, "Void");
	nodeJoinToList($$, $2);
	nodeJoin($$, $3);
}
        | Modifiers Type MethodDeclarator {
			$$ = new ASTnode(++nodeNum , "Method Header");
			nodeJoinToList($$, $1);
			nodeJoin($$, $2);
			nodeJoinToList($$, $3);
		}
		| Modifiers VOID MethodDeclarator {
			$$ = new ASTnode(++nodeNum , "Method Header");
			nodeJoinToList($$, $1);
			nodeToTerminal($$, $2, "Void");
			nodeJoinToList($$, $3);
		}
		| Modifiers Type MethodDeclarator Throws {
			$$ = new ASTnode(++nodeNum , "Method Header");
			nodeJoinToList($$, $1);
			nodeJoin($$, $2);
			nodeJoinToList($$, $3);
			nodeJoin($$, $4);
		} 
		| Modifiers VOID MethodDeclarator Throws {
			$$ = new ASTnode(++nodeNum , "Method Header");
			nodeJoinToList($$, $1);
			nodeToTerminal($$, $2, "Void");
			nodeJoinToList($$, $3);
			nodeJoin($$, $4);
		}
		;

MethodDeclarator: IDENT LP RP {
	$$ = new ASTnodes();
	$$ -> push_back(new ASTnode(++nodeNum, "Identifier"));
	$$ -> push_back(new ASTnode(++nodeNum, "Left Parenthesis"));
	$$ -> push_back(new ASTnode(++nodeNum, "Right Parenthesis"));
}
		| IDENT LP FormalParameterList RP {
	$$ = new ASTnodes();
	$$ -> push_back(new ASTnode(++nodeNum, "Identifier"));
	$$ -> push_back(new ASTnode(++nodeNum, "Left Parenthesis"));
	listJoin($$, $3);
	$$ -> push_back(new ASTnode(++nodeNum, "Right Parenthesis"));
}
		| MethodDeclarator LB RB {
			$$ = $1;
			$$ -> push_back(new ASTnode(++nodeNum, "Left Parenthesis"));
			$$ -> push_back(new ASTnode(++nodeNum, "Right Parenthesis"));
		}
		;

FormalParameterList: FormalParameter {
	$$ = new ASTnodes();
	$$ -> push_back($1);
}
		| FormalParameterList CM FormalParameter {
			$$ = $1;
			$$ -> push_back(new ASTnode(++nodeNum, $2));
			$$ -> push_back($3);
		}
		;

FormalParameter: Type VariableDeclaratorId {
	$$ = new ASTnode(++nodeNum, "Formal Parameter");
	nodeJoin($$, $1);
	nodeJoinToList($$, $2);
}
		;

Throws: THROWS ClassTypeList {
	$$ = new ASTnode(++nodeNum, "Throws");
	nodeToTerminal($$, $1, "Throws");
	nodeJoinToList($$, $2);
}
		;

ClassTypeList: ClassType {
	$$ = new ASTnodes();
	$$ -> push_back($1);
}
        | ClassTypeList CM ClassType {
			$$ = $1;
			$$ -> push_back(new ASTnode(++nodeNum, $2));
			$$ -> push_back($3);
		}
        ;

MethodBody: Block {
	$$ = new ASTnode(++nodeNum, "Method Body");
	nodeJoin($$, $1);
}
        | SM {
	$$ = new ASTnode(++nodeNum, "Method Body");
	nodeToTerminal($$, $1, "Semi Colon");
}
        ;

StaticInitializer: STATIC Block {
	$$ = new ASTnode(++nodeNum, "Static Initializer");
	nodeToTerminal($$, $1, "Static");
	nodeJoin($$, $2);
}
		;

ConstructorDeclaration: ConstructorDeclarator ConstructorBody {
	$$ = new ASTnode(++nodeNum, "Constructor Declaration");
	nodeJoin($$, $1);
	nodeJoin($$, $2);
}
		| Modifiers ConstructorDeclarator ConstructorBody {
	$$ = new ASTnode(++nodeNum, "Constructor Declaration");
	nodeJoinToList($$, $1);
	nodeJoin($$, $2);
	nodeJoin($$, $3);
}
		| ConstructorDeclarator Throws ConstructorBody {
	$$ = new ASTnode(++nodeNum, "Constructor Declaration");
	nodeJoin($$, $1);
	nodeJoin($$, $2);
	nodeJoin($$, $3);
}
		| Modifiers ConstructorDeclarator Throws ConstructorBody {
	$$ = new ASTnode(++nodeNum, "Constructor Declaration");
	nodeJoinToList($$, $1);
	nodeJoin($$, $2);
	nodeJoin($$, $3);
	nodeJoin($$, $4);
}
		;

ConstructorDeclarator: SimpleName LP RP
		| SimpleName LP FormalParameterList RP
		;

ConstructorBody: LC RC {
	$$ = new ASTnode(++nodeNum, "Constructor Body");
	nodeToTerminal($$, $1, "Left Bracket");
	nodeToTerminal($$, $2, "Right Bracket");
}
        | LC ExplicitConstructorInvocation RC {
	$$ = new ASTnode(++nodeNum, "Constructor Body");
	nodeToTerminal($$, $1, "Left Bracket");
	nodeJoin($$, $2);
	nodeToTerminal($$, $3, "Right Bracket");
}
        | LC BlockStatements RC {
	$$ = new ASTnode(++nodeNum, "Constructor Body");
	nodeToTerminal($$, $1, "Left Bracket");
	nodeJoinToList($$, $2);
	nodeToTerminal($$, $3, "Right Bracket");
} 
        | LC ExplicitConstructorInvocation BlockStatements RC {
	$$ = new ASTnode(++nodeNum, "Constructor Body");
	nodeToTerminal($$, $1, "Left Bracket");
	nodeJoin($$, $2);
	nodeJoinToList($$, $3);
	nodeToTerminal($$, $4, "Right Bracket");
}
        ; 

ExplicitConstructorInvocation: THIS LP RP SM {
	$$ = new ASTnode(++nodeNum, "Explicit Construtor Invocation");
	nodeToTerminal($$, $1, "This");
	nodeToTerminal($$, $2, "Left Parenthesis");
	nodeToTerminal($$, $3, "Right Parenthesis");
	nodeToTerminal($$, $4, "Semi Colon");
}
		| THIS LP ArgumentList RP SM {
	$$ = new ASTnode(++nodeNum, "Explicit Construtor Invocation");
	nodeToTerminal($$, $1, "This");
	nodeToTerminal($$, $2, "Left Parenthesis");
	nodeJoinToList($$, $3);
	nodeToTerminal($$, $4, "Right Parenthesis");
	nodeToTerminal($$, $5, "Semi Colon");
}
		| SUPER LP RP SM {
	$$ = new ASTnode(++nodeNum, "Explicit Construtor Invocation");
	nodeToTerminal($$, $1, "Super");
	nodeToTerminal($$, $2, "Left Parenthesis");
	nodeToTerminal($$, $3, "Right Parenthesis");
	nodeToTerminal($$, $4, "Semi Colon");
}
		// | SUPER LP ArgumentList RP SM
        ;

InterfaceDeclaration: INTERFACE IDENT InterfaceBody {
	$$ = new ASTnode(++nodeNum , "Normal Interface Declaration");
	nodeToTerminal($$, $1, "Interface");
	nodeToTerminal($$, $2, "Identifier");
	nodeJoin($$, $3);
}
		| Modifiers INTERFACE IDENT InterfaceBody {
	$$ = new ASTnode(++nodeNum , "Normal Interface Declaration");
	nodeJoinToList($$, $1);
	nodeToTerminal($$, $2, "Interface");
	nodeToTerminal($$, $3, "Identifier");
	nodeJoin($$, $4);
}
		| INTERFACE IDENT ExtendsInterfaces InterfaceBody {
	$$ = new ASTnode(++nodeNum , "Normal Interface Declaration");
	nodeToTerminal($$, $1, "Interface");
	nodeToTerminal($$, $2, "Identifier");
	nodeJoinToList($$, $3);
	nodeJoin($$, $4);
}
		| Modifiers INTERFACE IDENT ExtendsInterfaces InterfaceBody {
	$$ = new ASTnode(++nodeNum , "Normal Interface Declaration");
	nodeJoinToList($$, $1);
	nodeToTerminal($$, $2, "Interface");
	nodeToTerminal($$, $3, "Identifier");
	nodeJoinToList($$, $4);
	nodeJoin($$, $5);
}
        ;

ExtendsInterfaces: EXTENDS InterfaceType {
	$$ = new ASTnodes();
	$$ -> push_back(new ASTnode(++nodeNum, "Extends"));
	$$ -> push_back($2);
}
	    | ExtendsInterfaces CM InterfaceType {
			$$ = $1;
			$$ -> push_back(new ASTnode(++nodeNum, "Comma"));
			$$ -> push_back($3);

		}
        ;

InterfaceBody: LC RC {
	$$ = new ASTnode(++nodeNum , "Interface Body");
	nodeToTerminal($$, $1, "Left Bracket");
	nodeToTerminal($$, $2, "Right Bracket");
}
		| LC InterfaceMemberDeclarations RC {
	$$ = new ASTnode(++nodeNum , "Interface Body");
	nodeToTerminal($$, $1, "Left Bracket");
	nodeJoinToList($$, $2);
	nodeToTerminal($$, $3, "Right Bracket");
}
        ;

InterfaceMemberDeclarations: InterfaceMemberDeclaration {
	$$ = new ASTnodes();
	$$ -> push_back($1);
}
		| InterfaceMemberDeclarations InterfaceMemberDeclaration {
			$$ = $1;
			$$ -> push_back($2);
		}
        ;

InterfaceMemberDeclaration: ConstantDeclaration {
	$$ = new ASTnode(++nodeNum, "Interface Member Declaration");
	nodeJoin($$, $1);
}
		| AbstractMethodDeclaration {
	$$ = new ASTnode(++nodeNum, "Interface Member Declaration");
	nodeJoin($$, $1);
}
		;

ConstantDeclaration: FieldDeclaration {
	$$ = new ASTnode(++nodeNum, "Constant Declaration");
	nodeJoin($$, $1);
}
        ;

AbstractMethodDeclaration: MethodHeader SM {
	$$ = new ASTnode(++nodeNum, "Abstract Method Declaration");
	nodeJoin($$, $1);
	nodeToTerminal($$, $2, "Semi Colon");
}
        ;

//

ArrayInitializer: LC RC {
	$$ = new ASTnode(++nodeNum, "Array Initializer");
	nodeToTerminal($$, $1, "Left Bracket");
	nodeToTerminal($$, $2, "Right Bracket");
}
        | LC CM RC {
	$$ = new ASTnode(++nodeNum, "Array Initializer");
	nodeToTerminal($$, $1, "Left Bracket");
	nodeToTerminal($$, $2, "Comma");
	nodeToTerminal($$, $3, "Right Bracket");
}
        | LC VariableInitializers RC {
	$$ = new ASTnode(++nodeNum, "Array Initializer");
	nodeToTerminal($$, $1, "Left Bracket");
	nodeJoinToList($$, $2);
	nodeToTerminal($$, $3, "Right Bracket");
}
        | LC VariableInitializers CM RC {
	$$ = new ASTnode(++nodeNum, "Array Initializer");
	nodeToTerminal($$, $1, "Left Bracket");
	nodeJoinToList($$, $2);
	nodeToTerminal($$, $3, "Comma");
	nodeToTerminal($$, $4, "Right Bracket");
}
		;

VariableInitializers: VariableInitializer {
	$$ = new ASTnodes();
	$$ -> push_back($1);
}
		| VariableInitializers CM VariableInitializer {
			$$ = $1;
			$$ -> push_back(new ASTnode(++nodeNum, $2));
			$$ -> push_back($3);
		}
		;

//

Block: LC BlockStatements RC {
	$$ = new ASTnode(++nodeNum, "Block");
	nodeToTerminal($$, $1, "Left Bracket");
	nodeJoinToList($$, $2);
	nodeToTerminal($$, $3, "Right Bracket");
}
		| LC RC {
	$$ = new ASTnode(++nodeNum, "Block");
	nodeToTerminal($$, $1, "Left Bracket");
	nodeToTerminal($$, $2, "Right Bracket");
}
		;

BlockStatements: BlockStatement {
	$$ = new ASTnodes();
	$$ -> push_back($1);
}
		| BlockStatements BlockStatement {
			$$ = $1;
			$$ -> push_back($2);
		}
        ;

BlockStatement: LocalVariableDeclarationStatement {
	$$ = new ASTnode(++nodeNum, "Block Statement");
	nodeJoin($$, $1);
}
		| Statement {
	$$ = new ASTnode(++nodeNum, "Block Statement");
	nodeJoin($$, $1);
}
		;

LocalVariableDeclarationStatement: LocalVariableDeclaration SM {
	$$ = new ASTnode(++nodeNum, "Local Variable Declaration Statement");
	nodeJoin($$, $1);
	nodeToTerminal($$, $2, "Semi Colon");
}
		;

LocalVariableDeclaration: Type VariableDeclarators {
	$$ = new ASTnode(++nodeNum, "Local Variable Declaration");
	nodeJoin($$, $1);
	nodeJoinToList($$, $2);
}
		;

Statement: StatementWithoutTrailingSubstatement {
	$$ = new ASTnode(++nodeNum, "Statement");
	nodeJoin($$, $1);
}
		| LabeledStatement {
	$$ = new ASTnode(++nodeNum, "Statement");
	nodeJoin($$, $1);
}
		| IfThenStatement {
	$$ = new ASTnode(++nodeNum, "Statement");
	nodeJoin($$, $1);
}
		| IfThenElseStatement {
	$$ = new ASTnode(++nodeNum, "Statement");
	nodeJoin($$, $1);
}
		| WhileStatement {
	$$ = new ASTnode(++nodeNum, "Statement");
	nodeJoin($$, $1);
}
		| ForStatement {
	$$ = new ASTnode(++nodeNum, "Statement");
	nodeJoin($$, $1);
}
		;

StatementNoShortIf: StatementWithoutTrailingSubstatement  {
	$$ = new ASTnode(++nodeNum, "Statement no short if");
	nodeJoin($$, $1);
}
		| LabeledStatementNoShortIf {
	$$ = new ASTnode(++nodeNum, "Statement no short if");
	nodeJoin($$, $1);
} 
		| IfThenElseStatementNoShortIf {
	$$ = new ASTnode(++nodeNum, "Statement no short if");
	nodeJoin($$, $1);
}
		| WhileStatementNoShortIf {
	$$ = new ASTnode(++nodeNum, "Statement no short if");
	nodeJoin($$, $1);
}
		| ForStatementNoShortIf {
	$$ = new ASTnode(++nodeNum, "Statement no short if");
	nodeJoin($$, $1);
}
		;

StatementWithoutTrailingSubstatement: Block {
	$$ = new ASTnode(++nodeNum, "Statement without substatement");
	nodeJoin($$, $1);
}
		| EmptyStatement {
	$$ = new ASTnode(++nodeNum, "Statement without substatement");
	nodeJoin($$, $1);
}
		| ExpressionStatement {
	$$ = new ASTnode(++nodeNum, "Statement without substatement");
	nodeJoin($$, $1);
}
		| SwitchStatement {
	$$ = new ASTnode(++nodeNum, "Statement without substatement");
	nodeJoin($$, $1);
}
		| DoStatement {
	$$ = new ASTnode(++nodeNum, "Statement without substatement");
	nodeJoin($$, $1);
}
		| BreakStatement {
	$$ = new ASTnode(++nodeNum, "Statement without substatement");
	nodeJoin($$, $1);
}
		| ContinueStatement {
	$$ = new ASTnode(++nodeNum, "Statement without substatement");
	nodeJoin($$, $1);
}
		| ReturnStatement {
	$$ = new ASTnode(++nodeNum, "Statement without substatement");
	nodeJoin($$, $1);
}
		| SynchronizedStatement {
	$$ = new ASTnode(++nodeNum, "Statement without substatement");
	nodeJoin($$, $1);
}
		| ThrowStatement {
	$$ = new ASTnode(++nodeNum, "Statement without substatement");
	nodeJoin($$, $1);
}
		| TryStatement {
	$$ = new ASTnode(++nodeNum, "Statement without substatement");
	nodeJoin($$, $1);
}
		;

EmptyStatement: SM {
	$$ = new ASTnode(++nodeNum, "Empty Statement");
	nodeToTerminal($$, $1, "Semi Colon");
}
		;

LabeledStatement: IDENT COLON Statement {
	$$ = new ASTnode(++nodeNum, "Labelled Statement without Short if");
	nodeToTerminal($$, $1, "Identifier");
	nodeToTerminal($$, $2, "Colon");
	nodeJoin($$, $3);
}
		;

LabeledStatementNoShortIf: IDENT COLON StatementNoShortIf {
	$$ = new ASTnode(++nodeNum, "Labelled Statement without Short if");
	nodeToTerminal($$, $1, "Identifier");
	nodeToTerminal($$, $2, "Colon");
	nodeJoin($$, $3);
}
		;

ExpressionStatement: StatementExpression SM {
	$$ = new ASTnode(++nodeNum, "Expression Statement");
	nodeJoin($$, $1);
	nodeToTerminal($$, $2, "Semi Colon");
}
		;

StatementExpression: Assignment {
	$$ = new ASTnode(++nodeNum, "Statement Expression");
	nodeJoin($$, $1);
}
		| PreIncrementExpression {
	$$ = new ASTnode(++nodeNum, "Statement Expression");
	nodeJoin($$, $1);
}
		| PreDecrementExpression {
	$$ = new ASTnode(++nodeNum, "Statement Expression");
	nodeJoin($$, $1);
}
		| PostIncrementExpression {
	$$ = new ASTnode(++nodeNum, "Statement Expression");
	nodeJoin($$, $1);
}
		| PostDecrementExpression {
	$$ = new ASTnode(++nodeNum, "Statement Expression");
	nodeJoin($$, $1);
}
		| MethodInvocation {
	$$ = new ASTnode(++nodeNum, "Statement Expression");
	nodeJoin($$, $1);
}
		| ClassInstanceCreationExpression {
	$$ = new ASTnode(++nodeNum, "Statement Expression");
	nodeJoin($$, $1);
}
		;


IfThenStatement:  IF LP Expression RP Statement {
	$$ = new ASTnode(++nodeNum, "If then Statement");
	nodeToTerminal($$, $1, "If");
	nodeToTerminal($$, $2, "Left Parenthesis");
	nodeJoin($$, $3);
	nodeToTerminal($$, $4, "Rigth Parenthesis");
	nodeJoin($$, $5);
}
		;

IfThenElseStatement:  IF LP Expression RP StatementNoShortIf ELSE Statement {
	$$ = new ASTnode(++nodeNum, "If then else");
	nodeToTerminal($$, $1, "If");
	nodeToTerminal($$, $2, "Left Parenthesis");
	nodeJoin($$, $3);
	nodeToTerminal($$, $4, "Rigth Parenthesis");
	nodeJoin($$, $5);
	nodeToTerminal($$, $6, "Else");
	nodeJoin($$, $7);
}
		;

IfThenElseStatementNoShortIf:  IF LP Expression RP StatementNoShortIf ELSE StatementNoShortIf {
	$$ = new ASTnode(++nodeNum, "If then else without short if");
	nodeToTerminal($$, $1, "If");
	nodeToTerminal($$, $2, "Left Parenthesis");
	nodeJoin($$, $3);
	nodeToTerminal($$, $4, "Rigth Parenthesis");
	nodeJoin($$, $5);
	nodeToTerminal($$, $6, "Else");
	nodeJoin($$, $7);
}
		;

SwitchStatement:  SWITCH LP Expression RP SwitchBlock {
	$$ = new ASTnode(++nodeNum, "Switch Statement");
	nodeToTerminal($$, $1, "Switch");
	nodeToTerminal($$, $2, "Left Parenthesis");
	nodeJoin($$, $3);
	nodeToTerminal($$, $4, "Right Parenthesis");
	nodeJoin($$, $5);
}
		;

SwitchBlock: LC RC {
	$$ = new ASTnode(++nodeNum, "Switch Block");
	nodeToTerminal($$, $1, "Left Bracket");
	nodeToTerminal($$, $2, "Right Bracket");
}
		| LC SwitchBlockStatementGroups RC {
	$$ = new ASTnode(++nodeNum, "Switch Block");
	nodeToTerminal($$, $1, "Left Bracket");
	nodeJoinToList($$, $2);
	nodeToTerminal($$, $3, "Right Bracket");
}
		| LC SwitchLabels RC {
	$$ = new ASTnode(++nodeNum, "Switch Block");
	nodeToTerminal($$, $1, "Left Bracket");
	nodeJoinToList($$, $2);
	nodeToTerminal($$, $3, "Right Bracket");
}
		| LC SwitchBlockStatementGroups SwitchLabels RC {
	$$ = new ASTnode(++nodeNum, "Switch Block");
	nodeToTerminal($$, $1, "Left Bracket");
	nodeJoinToList($$, $2);
	nodeJoinToList($$, $3);
	nodeToTerminal($$, $4, "Right Bracket");
}
		;

SwitchBlockStatementGroups: SwitchBlockStatementGroup {
	$$ = new ASTnodes();
	$$ -> push_back($1);
}
		| SwitchBlockStatementGroups SwitchBlockStatementGroup {
			$$ = $1;
			$$ -> push_back($2);
		}
        ;

SwitchBlockStatementGroup: SwitchLabels BlockStatements {
	$$ = new ASTnode(++nodeNum, "Switch Block Statement");
	nodeJoinToList($$, $1);
	nodeJoinToList($$, $2);
}
		;

SwitchLabels: SwitchLabel {
	$$ = new ASTnodes();
	$$ -> push_back($1);
}
		| SwitchLabels SwitchLabel {
			$$ = $1;
			$$ -> push_back($2);
		}
        ;

SwitchLabel: CASE ConstantExpression COLON {
	$$ = new ASTnode(++nodeNum, "Switch Label");
	nodeToTerminal($$ , $1, "Case");
	nodeJoin($$, $2);
	nodeToTerminal($$, $3, "Colon");
}
		| DEFAULT COLON {
	$$ = new ASTnode(++nodeNum, "Switch Label");
	nodeToTerminal($$ , $1, "Default");
	nodeToTerminal($$, $2, "Colon");
}
		;

WhileStatement:	WHILE LP Expression RP Statement {
	$$ = new ASTnode(++nodeNum, "While statement");
	nodeToTerminal($$, $1, "While");
	nodeToTerminal($$, $2, "Left Parenthesis");
	nodeJoin($$, $3);
	nodeToTerminal($$, $4, "Right Parenthesis");
	nodeJoin($$, $5);
}
		;

WhileStatementNoShortIf: WHILE LP Expression RP StatementNoShortIf {
	$$ = new ASTnode(++nodeNum, "While statement no short if");
	nodeToTerminal($$, $1, "While");
	nodeToTerminal($$, $2, "Left Parenthesis");
	nodeJoin($$, $3);
	nodeToTerminal($$, $4, "Right Parenthesis");
	nodeJoin($$, $5);
}
		;

DoStatement: DO Statement WHILE LP Expression RP SM {
	$$ = new ASTnode(++nodeNum, "Do statement");
	nodeToTerminal($$, $1, "Do");
	nodeJoin($$, $2);
	nodeToTerminal($$, $3, "While");
	nodeToTerminal($$, $4, "Left Parenthesis");
	nodeJoin($$, $5);
	nodeToTerminal($$, $6, "Right Parenthesis");
	nodeToTerminal($$, $7, "Semi Colon");
}
		;

ForStatement: BasicForStatement {
	$$ = new ASTnode(++nodeNum, "For statement");
	nodeJoin($$, $1);
}
		| EnhancedForStatement {
	$$ = new ASTnode(++nodeNum, "For statement");
	nodeJoin($$, $1);
}
		;


ForStatementNoShortIf: BasicForStatementNoShortIf {
	$$ = new ASTnode(++nodeNum, "For statement no short if");
	nodeJoin($$, $1);
}
		| EnhancedForStatementNoShortIf {
	$$ = new ASTnode(++nodeNum, "For statement no short if");
	nodeJoin($$, $1);
}
		;


BasicForStatement: FOR LP SM SM RP Statement  {
	$$ = new ASTnode(++nodeNum, "Basic For statment");
	nodeToTerminal($$, $1, "For");
	nodeToTerminal($$, $2, "Left Parenthesis");
	nodeToTerminal($$, $3, "Semi Colon");
	nodeToTerminal($$, $4, "Semi Colon");
	nodeToTerminal($$, $5, "Right Parenthesis");
	nodeJoin($$, $6);
}
		| FOR LP ForInit SM SM RP Statement {
	$$ = new ASTnode(++nodeNum, "Basic For statment");
	nodeToTerminal($$, $1, "For");
	nodeToTerminal($$, $2, "Left Parenthesis");
	nodeJoin($$, $3);
	nodeToTerminal($$, $4, "Semi Colon");
	nodeToTerminal($$, $5, "Semi Colon");
	nodeToTerminal($$, $6, "Right Parenthesis");
	nodeJoin($$, $7);
}
		| FOR LP SM Expression SM RP Statement {
	$$ = new ASTnode(++nodeNum, "Basic For statment");
	nodeToTerminal($$, $1, "For");
	nodeToTerminal($$, $2, "Left Parenthesis");
	nodeToTerminal($$, $3, "Semi Colon");
	nodeJoin($$, $4);
	nodeToTerminal($$, $5, "Semi Colon");
	nodeToTerminal($$, $6, "Right Parenthesis");
	nodeJoin($$, $7);
} 
		| FOR LP SM SM ForUpdate RP Statement {
	$$ = new ASTnode(++nodeNum, "Basic For statment no short if");
	nodeToTerminal($$, $1, "For");
	nodeToTerminal($$, $2, "Left Parenthesis");
	nodeToTerminal($$, $3, "Semi Colon");
	nodeToTerminal($$, $4, "Semi Colon");
	nodeJoin($$, $5);
	nodeToTerminal($$, $6, "Right Parenthesis");
	nodeJoin($$, $7);
}
		| FOR LP ForInit SM Expression SM RP Statement {
	$$ = new ASTnode(++nodeNum, "Basic For statment no short if");
	nodeToTerminal($$, $1, "For");
	nodeToTerminal($$, $2, "Left Parenthesis");
	nodeJoin($$, $3);
	nodeToTerminal($$, $4, "Semi Colon");
	nodeJoin($$, $5);
	nodeToTerminal($$, $6, "Semi Colon");
	nodeToTerminal($$, $7, "Right Parenthesis");
	nodeJoin($$, $8);
}
		| FOR LP SM Expression SM ForUpdate RP Statement {
	$$ = new ASTnode(++nodeNum, "Basic For statment no short if");
	nodeToTerminal($$, $1, "For");
	nodeToTerminal($$, $2, "Left Parenthesis");
	nodeToTerminal($$, $3, "Semi Colon");
	nodeJoin($$, $4);
	nodeToTerminal($$, $5, "Semi Colon");
	nodeJoin($$, $6);
	nodeToTerminal($$, $7, "Right Parenthesis");
	nodeJoin($$, $8);
}
		| FOR LP ForInit SM SM ForUpdate RP Statement {
	$$ = new ASTnode(++nodeNum, "Basic For statment no short if");
	nodeToTerminal($$, $1, "For");
	nodeToTerminal($$, $2, "Left Parenthesis");
	nodeJoin($$, $3);
	nodeToTerminal($$, $4, "Semi Colon");
	nodeToTerminal($$, $5, "Semi Colon");
	nodeJoin($$, $6);
	nodeToTerminal($$, $7, "Right Parenthesis");
	nodeJoin($$, $8);
}
		| FOR LP ForInit SM Expression SM ForUpdate RP Statement {
	$$ = new ASTnode(++nodeNum, "Basic For statment no short if");
	nodeToTerminal($$, $1, "For");
	nodeToTerminal($$, $2, "Left Parenthesis");
	nodeJoin($$, $3);
	nodeToTerminal($$, $4, "Semi Colon");
	nodeJoin($$, $5);
	nodeToTerminal($$, $6, "Semi Colon");
	nodeJoin($$, $7);
	nodeToTerminal($$, $8, "Right Parenthesis");
	nodeJoin($$, $9);
}
		;

BasicForStatementNoShortIf: FOR LP SM SM RP StatementNoShortIf {
	$$ = new ASTnode(++nodeNum, "Basic For statment no short if");
	nodeToTerminal($$, $1, "For");
	nodeToTerminal($$, $2, "Left Parenthesis");
	nodeToTerminal($$, $3, "Semi Colon");
	nodeToTerminal($$, $4, "Semi Colon");
	nodeToTerminal($$, $5, "Right Parenthesis");
	nodeJoin($$, $6);
}
		| FOR LP ForInit SM SM RP StatementNoShortIf {
	$$ = new ASTnode(++nodeNum, "Basic For statment no short if");
	nodeToTerminal($$, $1, "For");
	nodeToTerminal($$, $2, "Left Parenthesis");
	nodeJoin($$, $3);
	nodeToTerminal($$, $4, "Semi Colon");
	nodeToTerminal($$, $5, "Semi Colon");
	nodeToTerminal($$, $6, "Right Parenthesis");
	nodeJoin($$, $7);
}
		| FOR LP SM Expression SM RP StatementNoShortIf {
	$$ = new ASTnode(++nodeNum, "Basic For statment no short if");
	nodeToTerminal($$, $1, "For");
	nodeToTerminal($$, $2, "Left Parenthesis");
	nodeToTerminal($$, $3, "Semi Colon");
	nodeJoin($$, $4);
	nodeToTerminal($$, $5, "Semi Colon");
	nodeToTerminal($$, $6, "Right Parenthesis");
	nodeJoin($$, $7);
}
		| FOR LP SM SM ForUpdate RP StatementNoShortIf {
	$$ = new ASTnode(++nodeNum, "Basic For statment no short if");
	nodeToTerminal($$, $1, "For");
	nodeToTerminal($$, $2, "Left Parenthesis");
	nodeToTerminal($$, $3, "Semi Colon");
	nodeToTerminal($$, $4, "Semi Colon");
	nodeJoin($$, $5);
	nodeToTerminal($$, $6, "Right Parenthesis");
	nodeJoin($$, $7);
}
		| FOR LP ForInit SM Expression SM RP StatementNoShortIf {
	$$ = new ASTnode(++nodeNum, "Basic For statment no short if");
	nodeToTerminal($$, $1, "For");
	nodeToTerminal($$, $2, "Left Parenthesis");
	nodeJoin($$, $3);
	nodeToTerminal($$, $4, "Semi Colon");
	nodeJoin($$, $5);
	nodeToTerminal($$, $6, "Semi Colon");
	nodeToTerminal($$, $7, "Right Parenthesis");
	nodeJoin($$, $8);
}
		| FOR LP SM Expression SM ForUpdate RP StatementNoShortIf {
	$$ = new ASTnode(++nodeNum, "Basic For statment no short if");
	nodeToTerminal($$, $1, "For");
	nodeToTerminal($$, $2, "Left Parenthesis");
	nodeToTerminal($$, $3, "Semi Colon");
	nodeJoin($$, $4);
	nodeToTerminal($$, $5, "Semi Colon");
	nodeJoin($$, $6);
	nodeToTerminal($$, $7, "Right Parenthesis");
	nodeJoin($$, $8);
}
	
		| FOR LP ForInit SM SM ForUpdate RP StatementNoShortIf {
	$$ = new ASTnode(++nodeNum, "Basic For statment no short if");
	nodeToTerminal($$, $1, "For");
	nodeToTerminal($$, $2, "Left Parenthesis");
	nodeJoin($$, $3);
	nodeToTerminal($$, $4, "Semi Colon");
	nodeToTerminal($$, $5, "Semi Colon");
	nodeJoin($$, $6);
	nodeToTerminal($$, $7, "Right Parenthesis");
	nodeJoin($$, $8);
}
		| FOR LP ForInit SM Expression SM ForUpdate RP StatementNoShortIf {
	$$ = new ASTnode(++nodeNum, "Basic For statment no short if");
	nodeToTerminal($$, $1, "For");
	nodeToTerminal($$, $2, "Left Parenthesis");
	nodeJoin($$, $3);
	nodeToTerminal($$, $4, "Semi Colon");
	nodeJoin($$, $5);
	nodeToTerminal($$, $6, "Semi Colon");
	nodeJoin($$, $7);
	nodeToTerminal($$, $8, "Right Parenthesis");
	nodeJoin($$, $9);
}
		;

EnhancedForStatement: FOR LP LocalVariableDeclaration COLON Expression RP Statement {
	$$ = new ASTnode(++nodeNum, "Enhanced for Statement");
	nodeToTerminal($$, $1, "For");
	nodeToTerminal($$, $2, "Left Parenthesis");
	nodeJoin($$, $3);
	nodeToTerminal($$, $4, "Colon");
	nodeJoin($$, $5);
	nodeToTerminal($$, $6, "Right Parenthesis");
	nodeJoin($$, $7);
}
		;

EnhancedForStatementNoShortIf: FOR LP LocalVariableDeclaration COLON Expression RP StatementNoShortIf {
	$$ = new ASTnode(++nodeNum, "Enhanced for Statement No short if");
	nodeToTerminal($$, $1, "For");
	nodeToTerminal($$, $2, "Left Parenthesis");
	nodeJoin($$, $3);
	nodeToTerminal($$, $4, "Colon");
	nodeJoin($$, $5);
	nodeToTerminal($$, $6, "Right Parenthesis");
	nodeJoin($$, $7);
}
		;

ForInit: StatementExpressionList {
	$$ = new ASTnode(++nodeNum, "For Init");
	nodeJoinToList($$, $1);
}
		| LocalVariableDeclaration {
	$$ = new ASTnode(++nodeNum, "For Init");
	nodeJoin($$, $1);
}
		;

ForUpdate: StatementExpressionList {
	$$ = new ASTnode(++nodeNum, "For Update");
	nodeJoinToList($$, $1);
}
		;

StatementExpressionList: StatementExpression {
	$$ = new ASTnodes();
	$$ -> push_back($1);
}
		| StatementExpressionList CM StatementExpression {
			$$ = $1;
			$$ -> push_back(new ASTnode(++nodeNum, $2));
			$$ -> push_back($3);
		}
		;

BreakStatement: BREAK SM {
	$$ = new ASTnode(++nodeNum, "Break Statement");
	nodeToTerminal($$, $1, "Break");
	nodeToTerminal($$, $2, "Semi Colon");
}
		| BREAK IDENT SM {
	$$ = new ASTnode(++nodeNum, "Break Statement");
	nodeToTerminal($$, $1, "Break");
	nodeToTerminal($$, $2, "Identifier");
	nodeToTerminal($$, $3, "Semi Colon");
}
		;

ContinueStatement: CONTINUE SM {
	$$ = new ASTnode(++nodeNum, "Continue Statement");
	nodeToTerminal($$, $1, "Continue");
	nodeToTerminal($$, $2, "Semi Colon");
}
		| CONTINUE IDENT SM {
	$$ = new ASTnode(++nodeNum, "Continue Statement");
	nodeToTerminal($$, $1, "Continue");
	nodeToTerminal($$, $2, "Identifier");
	nodeToTerminal($$, $3, "Semi Colon");
}
		;

ReturnStatement: RETURN SM {
	$$ = new ASTnode(++nodeNum, "Return Statement");
	nodeToTerminal($$, $1, "Return");
	nodeToTerminal($$, $2, "Semi Colon");
}
		| RETURN Expression SM {
	$$ = new ASTnode(++nodeNum, "Return Statement");
	nodeToTerminal($$, $1, "Return");
	nodeJoin($$, $2);
	nodeToTerminal($$, $3, "Semi Colon");
}
		;

ThrowStatement:  THROW Expression SM {
	$$ = new ASTnode(++nodeNum, "Throw Statement");
	nodeToTerminal($$, $1, "Throw");
	nodeJoin($$, $2);
	nodeToTerminal($$, $3, "Semi Colon");
}
		;

SynchronizedStatement: SYNCHRONIZED LP Expression RP Block {
	$$ = new ASTnode(++nodeNum , "Synchronized Statement");
	nodeToTerminal($$, $1, "Synchronized");
	nodeToTerminal($$, $2, "Left Parenthesis");
	nodeJoin($$, $3);
	nodeToTerminal($$, $4, "Right Parenthesis");
	nodeJoin($$, $5);
}
		;

TryStatement: TRY Block Catches {
	$$ = new ASTnode(++nodeNum, "Try Statement");
	nodeToTerminal($$, $1, "Try");
	nodeJoin($$, $2);
	nodeJoinToList($$, $3);
}
		| TRY Block Finally {
	$$ = new ASTnode(++nodeNum, "Try Statement");
	nodeToTerminal($$, $1, "Try");
	nodeJoin($$, $2);
	nodeJoin($$, $3);
}
		| TRY Block Catches Finally {
	$$ = new ASTnode(++nodeNum, "Try Statement");
	nodeToTerminal($$, $1, "Try");
	nodeJoin($$, $2);
	nodeJoinToList($$, $3);	
	nodeJoin($$, $4);
}
        ;

Catches: CatchClause {
	$$ = new ASTnodes();
	$$ -> push_back($1);
}
		| Catches CatchClause {
			$$ = $1;
			$$ -> push_back($2);
		}
		;

CatchClause: CATCH LP FormalParameter RP Block {
	$$ = new ASTnode(++nodeNum, "Catch Clause");
	nodeToTerminal($$, $1, "Catch");
	nodeToTerminal($$, $2, "Left Parenthesis");
	nodeJoin($$, $3);
	nodeToTerminal($$, $4, "Right Parenthesis");
	nodeJoin($$, $5);
}
		;

Finally: FINALLY Block {
	$$ = new ASTnode(++nodeNum, "Catch Clause");
	nodeToTerminal($$, $1, "Finally");
	nodeJoin($$, $2);
}
		;

//

Primary: PrimaryNoNewArray {
	$$ = new ASTnode(++nodeNum, "Primary");
	nodeJoin($$, $1);
}
		| ArrayCreationExpression {
	$$ = new ASTnode(++nodeNum, "Primary");
	nodeJoin($$, $1);
}
		;

PrimaryNoNewArray: Literal {
	$$ = new ASTnode(++nodeNum, "Primary No New Array");
	nodeJoin($$, $1);
}
		| THIS {
	$$ = new ASTnode(++nodeNum, "Primary No New Array");
	nodeToTerminal($$, $1, "This");
}
		| LP Expression RP {
	$$ = new ASTnode(++nodeNum, "Primary No New Array");
	nodeToTerminal($$, $1, "Left Parenthesis");
	nodeJoin($$, $2);
	nodeToTerminal($$, $3, "Right Parenthesis");
}
		| ClassInstanceCreationExpression {
	$$ = new ASTnode(++nodeNum, "Primary No New Array");
	nodeJoin($$, $1);
}
		| FieldAccess {
	$$ = new ASTnode(++nodeNum, "Primary No New Array");
	nodeJoin($$, $1);
}
		| MethodInvocation {
	$$ = new ASTnode(++nodeNum, "Primary No New Array");
	nodeJoin($$, $1);
}
		| ArrayAccess {
	$$ = new ASTnode(++nodeNum, "Primary No New Array");
	nodeJoin($$, $1);
}
		;

ClassInstanceCreationExpression: NEW ClassType LP ArgumentList RP {
	$$ = new ASTnode(++nodeNum, "Class instance creation expression");
	nodeToTerminal($$, $1, "New");
	nodeJoin($$, $2);
	nodeToTerminal($$, $3, "Left Parenthesis");
	nodeJoinToList($$, $4);
	nodeToTerminal($$, $5, "Right Parenthesis");
}
		| NEW ClassType LP RP {
	$$ = new ASTnode(++nodeNum, "Class instance creation expression");
	nodeToTerminal($$, $1, "New");
	nodeJoin($$, $2);
	nodeToTerminal($$, $3, "Left Parenthesis");
	nodeToTerminal($$, $4, "Right Parenthesis");
}
		;

ArgumentList: Expression {
	$$ = new ASTnodes();
	$$->push_back($1);
}
		| ArgumentList CM Expression {
			$$ = $1;
			$$->push_back(new ASTnode(++nodeNum, $2));
			$$->push_back($3);
		}
		;

ArrayCreationExpression: NEW PrimitiveType DimExprs {
	$$ = new ASTnode(++nodeNum, "Array Creation Expression");
	nodeToTerminal($$, $1, "New");
	nodeJoin($$, $2);
	nodeJoinToList($$, $3);
}
		| NEW PrimitiveType DimExprs Dims {
	$$ = new ASTnode(++nodeNum, "Array Creation Expression");
	nodeToTerminal($$, $1, "New");
	nodeJoin($$, $2);
	nodeJoinToList($$, $3);
	nodeJoinToList($$, $4);
}
		| NEW ClassOrInterfaceType DimExprs {
	$$ = new ASTnode(++nodeNum, "Array Creation Expression");
	nodeToTerminal($$, $1, "New");
	nodeJoin($$, $2);
	nodeJoinToList($$, $3);
}
		| NEW ClassOrInterfaceType DimExprs Dims {
	$$ = new ASTnode(++nodeNum, "Array Creation Expression");
	nodeToTerminal($$, $1, "New");
	nodeJoin($$, $2);
	nodeJoinToList($$, $3);
	nodeJoinToList($$, $4);
}
		;

DimExprs: DimExpr {
	$$ = new ASTnodes();
	$$->push_back($1);
}
		| DimExprs DimExpr {
			$$ = $1;
			$$->push_back($2);
		}
		;

DimExpr: LB Expression RB {
	$$ = new ASTnode(++nodeNum, "Dim Expression");
	nodeToTerminal($$, $1, "Left Brackets");
	nodeJoin($$, $2);
	nodeToTerminal($$, $3, "Right Brackets");
}
		;

Dims: LB RB  {
	$$ = new ASTnodes();
	$$->push_back(new ASTnode(++nodeNum, $1));
	$$->push_back(new ASTnode(++nodeNum, $2));
}
		| Dims LB RB {
			$$ = $1;
			$$->push_back(new ASTnode(++nodeNum, $2));
			$$->push_back(new ASTnode(++nodeNum, $3));
		}
        ;

FieldAccess: Primary DOT IDENT {
	$$ = new ASTnode(++nodeNum, "Feild Access");
	nodeJoin($$, $1);
	nodeToTerminal($$, $2, "Dot");
	nodeToTerminal($$, $3, "Ident");
}
		| SUPER DOT IDENT {
	$$ = new ASTnode(++nodeNum, "Feild Access");
	nodeToTerminal($$, $1, "Super");
	nodeToTerminal($$, $2, "Dot");
	nodeToTerminal($$, $3, "Ident");
}
        ;

MethodInvocation: Name LP RP {
	$$ = new ASTnode(++nodeNum, "Method Invocation");
	nodeJoin($$, $1);
	nodeToTerminal($$, $2,  "Left Parenthesis");
	nodeToTerminal($$, $3, "Right Parenthesis");
}
		| Name LP ArgumentList RP {
	$$ = new ASTnode(++nodeNum, "Method Invocation");
	nodeJoin($$, $1);
	nodeToTerminal($$, $2,  "Left Parenthesis");
	nodeJoinToList($$, $3);
	nodeToTerminal($$, $4, "Right Parenthesis");
}
		| Primary LP ArgumentList RP {
	$$ = new ASTnode(++nodeNum, "Method Invocation");
	nodeJoin($$, $1);
	nodeToTerminal($$, $2,  "Left Parenthesis");
	nodeJoinToList($$, $3);
	nodeToTerminal($$, $4, "Right Parenthesis");
}
		| SUPER LP ArgumentList RP {
	$$ = new ASTnode(++nodeNum, "Method Invocation");
	nodeToTerminal($$, $1, "Super");
	nodeToTerminal($$, $2,  "Left Parenthesis");
	nodeJoinToList($$, $3);
	nodeToTerminal($$, $4, "Right Parenthesis");
}
		;

ArrayAccess: Name LB Expression RB {
	$$ = new ASTnode(++nodeNum, "Array Access");
	nodeJoin($$, $1);
	nodeToTerminal($$, $2,  "Left block");
	nodeJoin($$, $3);
	nodeToTerminal($$, $4, "Right block");
}
		| PrimaryNoNewArray LB Expression RB {
	$$ = new ASTnode(++nodeNum, "Array Access");
	nodeJoin($$, $1);
	nodeToTerminal($$, $2,  "Left block");
	nodeJoin($$, $3);
	nodeToTerminal($$, $4, "Right block");
}
		;

PostFixExpression: Primary {
	$$ = new ASTnode(++nodeNum, "Post-fix Expression");
	nodeJoin($$, $1);
}
		| Name {
	$$ = new ASTnode(++nodeNum, "Post-fix Expression");
	nodeJoin($$, $1);
}
		| PostIncrementExpression {
	$$ = new ASTnode(++nodeNum, "Post-fix Expression");
	nodeJoin($$, $1);
}
		| PostDecrementExpression {
	$$ = new ASTnode(++nodeNum, "Post-fix Expression");
	nodeJoin($$, $1);
}
		;

PostIncrementExpression: PostFixExpression INC {
	$$ = new ASTnode(++nodeNum, "Post Increment Expression");
	nodeJoin($$, $1);
	nodeToTerminal($$, $2, "Increment");
}
		;

PostDecrementExpression: PostFixExpression DEC {
	$$ = new ASTnode(++nodeNum, "Post Decrement Expression");
	nodeJoin($$, $1);
	nodeToTerminal($$, $2, "Decrement");
}
		;

UnaryExpression: PreIncrementExpression {
	$$ =  new ASTnode(++nodeNum, "Unary Expression");
	nodeJoin($$, $1);
} 
		| PreDecrementExpression {
	$$ =  new ASTnode(++nodeNum, "Unary Expression");
	nodeJoin($$, $1);
}
		| PLUS UnaryExpression {
	$$ =  new ASTnode(++nodeNum, "Unary Expression");
	nodeToTerminal($$, $1, "Plus");
	nodeJoin($$, $2);
}
		| MINUS UnaryExpression {
	$$ =  new ASTnode(++nodeNum, "Unary Expression");
	nodeToTerminal($$, $1, "Minus");
	nodeJoin($$, $2);
}
		| UnaryExpressionNotPlusMinus {
	$$ =  new ASTnode(++nodeNum, "Unary Expression");
	nodeJoin($$, $1);
} 
		;

PreIncrementExpression: INC UnaryExpression {
	$$ = new ASTnode(++nodeNum, "Pre Increment Expression");
	nodeToTerminal($$, $1, "Increment");
	nodeJoin($$, $2);
}
		;

PreDecrementExpression: DEC UnaryExpression {
	$$ = new ASTnode(++nodeNum, "Pre Decrement Expression");
	nodeToTerminal($$, $1, "Decrement");
	nodeJoin($$, $2);
}
		;

UnaryExpressionNotPlusMinus: PostFixExpression {
	$$ = new ASTnode(++nodeNum, "Unary Expression Not Plus Minus");
	nodeJoin($$, $1);
}
		| TILDE UnaryExpression {
	$$ = new ASTnode(++nodeNum, "Unary Expression Not Plus Minus");
	nodeToTerminal($$, $1, "Tilde");
	nodeJoin($$, $2);
}
		| EXCL UnaryExpression {
	$$ = new ASTnode(++nodeNum, "Unary Expression Not Plus Minus");
	nodeToTerminal($$, $1, "Exclaimation");
	nodeJoin($$, $2);
}
		| CastExpression {
	$$ = new ASTnode(++nodeNum, "Unary Expression Not Plus Minus");
	nodeJoin($$, $1);
}
		;

CastExpression: LP PrimitiveType RP UnaryExpression {
	$$ = new ASTnode(++nodeNum, "Cast Expression");
	nodeToTerminal($$, $1, "Left Parenthesis");
	nodeJoin($$, $2);
	nodeToTerminal($$, $3, "Right Parenthesis");
	nodeJoin($$, $4);
}
        | LP PrimitiveType Dims RP UnaryExpression {
	$$ = new ASTnode(++nodeNum, "Cast Expression");
	nodeToTerminal($$, $1, "Left Parenthesis");
	nodeJoin($$, $2);
	nodeJoinToList($$, $3);
	nodeToTerminal($$, $4, "Right Parenthesis");
	nodeJoin($$, $5);
}
		| LP Expression RP UnaryExpressionNotPlusMinus {
	$$ = new ASTnode(++nodeNum, "Cast Expression");
	nodeToTerminal($$, $1, "Left Parenthesis");
	nodeJoin($$, $2);
	nodeToTerminal($$, $3, "Right Parenthesis");
	nodeJoin($$, $4);
}
		| LP Name Dims RP UnaryExpressionNotPlusMinus {
	$$ = new ASTnode(++nodeNum, "Cast Expression");
	nodeToTerminal($$, $1, "Left Parenthesis");
	nodeJoin($$, $2);
	nodeJoinToList($$, $3);
	nodeToTerminal($$, $4, "Right Parenthesis");
	nodeJoin($$, $5);
}
		;

MultiplicativeExpression: UnaryExpression {
	$$ = new ASTnode(++nodeNum, "Multiplicative expression");
	nodeJoin($$, $1);
}
		| MultiplicativeExpression MUL UnaryExpression  {
	$$ = new ASTnode(++nodeNum, "Multiplicative Expression");
	nodeJoin($$, $1);
	nodeToTerminal($$, $2, "MUL");
	nodeJoin($$, $3);
}
		| MultiplicativeExpression DIV UnaryExpression {
	$$ = new ASTnode(++nodeNum, "Multiplicative Expression");
	nodeJoin($$, $1);
	nodeToTerminal($$, $2, "DIV");
	nodeJoin($$, $3);
}
		| MultiplicativeExpression MOD UnaryExpression {
	$$ = new ASTnode(++nodeNum, "Multiplicative Expression");
	nodeJoin($$, $1);
	nodeToTerminal($$, $2, "MOD");
	nodeJoin($$, $3);
}
		;

AdditiveExpression: MultiplicativeExpression {
	$$ = new ASTnode(++nodeNum, "Additive Expression");
	nodeJoin($$, $1);
}
		| AdditiveExpression PLUS MultiplicativeExpression {
	$$ = new ASTnode(++nodeNum, "Additive Expression");
	nodeJoin($$, $1);
	nodeToTerminal($$, $2, "PLUS");
	nodeJoin($$, $3);
}
		| AdditiveExpression MINUS MultiplicativeExpression  {
	$$ = new ASTnode(++nodeNum, "Additive Expression");
	nodeJoin($$, $1);
	nodeToTerminal($$, $2, "MINUS");
	nodeJoin($$, $3);
}
		;

ShiftExpression: AdditiveExpression {
	$$ = new ASTnode(++nodeNum, "Shift Expression");
	nodeJoin($$, $1);
}
		| ShiftExpression SHL AdditiveExpression {
	$$ = new ASTnode(++nodeNum, "Shift Expression");
	nodeJoin($$, $1);
	nodeToTerminal($$, $2, "SHL");
	nodeJoin($$, $3);
}
		| ShiftExpression SHR AdditiveExpression {
	$$ = new ASTnode(++nodeNum, "Shift Expression");
	nodeJoin($$, $1);
	nodeToTerminal($$, $2, "SHR");
	nodeJoin($$, $3);
}
		| ShiftExpression LSHR AdditiveExpression {
	$$ = new ASTnode(++nodeNum, "Shift Expression");
	nodeJoin($$, $1);
	nodeToTerminal($$, $2, "LSHR");
	nodeJoin($$, $3);
}
		;

RelationalExpression: ShiftExpression {
	$$ = new ASTnode(++nodeNum, "Relational Expression");
	nodeJoin($$, $1);
}
		| RelationalExpression LT ShiftExpression {
	$$ = new ASTnode(++nodeNum, "Relational Expression");
	nodeJoin($$, $1);
	nodeToTerminal($$, $2, "LT");
	nodeJoin($$, $3);
}
		| RelationalExpression GT ShiftExpression {
	$$ = new ASTnode(++nodeNum, "Relational Expression");
	nodeJoin($$, $1);
	nodeToTerminal($$, $2, "GT");
	nodeJoin($$, $3);
}
		| RelationalExpression LE ShiftExpression {
	$$ = new ASTnode(++nodeNum, "Relational Expression");
	nodeJoin($$, $1);
	nodeToTerminal($$, $2, "LE");
	nodeJoin($$, $3);
}
		| RelationalExpression GE ShiftExpression {
	$$ = new ASTnode(++nodeNum, "Relational Expression");
	nodeJoin($$, $1);
	nodeToTerminal($$, $2, "GE");
	nodeJoin($$, $3);
}
		| RelationalExpression INSTANCEOF ReferenceType {
	$$ = new ASTnode(++nodeNum, "Relational Expression");
	nodeJoin($$, $1);
	nodeToTerminal($$, $2, "Instance of");
	nodeJoin($$, $3);
}
		;

EqualityExpression: RelationalExpression {
	$$ = new ASTnode(++nodeNum, "Equality Expression");
	nodeJoin($$, $1);
}
		| EqualityExpression EQ RelationalExpression{
	$$ = new ASTnode(++nodeNum, "Equality Expression");
	nodeJoin($$, $1);
	nodeToTerminal($$, $2, "Equal");
	nodeJoin($$, $3);
}
		| EqualityExpression NE RelationalExpression {
	$$ = new ASTnode(++nodeNum, "Equality Expression");
	nodeJoin($$, $1);
	nodeToTerminal($$, $2, "Not equal");
	nodeJoin($$, $3);
}
		;

AndExpression: EqualityExpression {
	$$ = new ASTnode(++nodeNum, "And Expression");
	nodeJoin($$, $1);
}
		| AndExpression AND EqualityExpression {
	$$ = new ASTnode(++nodeNum, "And Expression");
	nodeJoin($$, $1);
	nodeToTerminal($$, $2, "AND");
	nodeJoin($$, $3);
}
		;

ExclusiveOrExpression: AndExpression {
	$$ = new ASTnode(++nodeNum, "Exclusive-or Expression");
	nodeJoin($$, $1);
}
		| ExclusiveOrExpression CARET AndExpression {
	$$ = new ASTnode(++nodeNum, "Exclusive-or Expression");
	nodeJoin($$, $1);
	nodeToTerminal($$, $2, "CARET");
	nodeJoin($$, $3);
}
		;

InclusiveOrExpression: ExclusiveOrExpression  {
	$$ = new ASTnode(++nodeNum, "Inclusive-or Expression");
	nodeJoin($$, $1);
}
		| InclusiveOrExpression OR ExclusiveOrExpression {
	$$ = new ASTnode(++nodeNum, "Inclusive-or Expression");
	nodeJoin($$, $1);
	nodeToTerminal($$, $2, "OR");
	nodeJoin($$, $3);
}
		;

ConditionalAndExpression: InclusiveOrExpression {
	$$ = new ASTnode(++nodeNum, "Conditional-and Expression");
	nodeJoin($$, $1);
}
		| ConditionalAndExpression ANDAND InclusiveOrExpression {
	$$ = new ASTnode(++nodeNum, "Conditional-and Expression");
	nodeJoin($$, $1);
	nodeToTerminal($$, $2, "AndAnd");
	nodeJoin($$, $3);
}
		;

ConditionalOrExpression: ConditionalAndExpression {
	$$ = new ASTnode(++nodeNum, "Conditional-Or Expression");
	nodeJoin($$, $1);
}
		| ConditionalOrExpression OROR ConditionalAndExpression {
	$$ = new ASTnode(++nodeNum, "Conditional-and Expression");
	nodeJoin($$, $1);
	nodeToTerminal($$, $2, "OrOr");
	nodeJoin($$, $3);
}
		;

ConditionalExpression: ConditionalOrExpression {
	$$ = new ASTnode(++nodeNum, "Conditional Expression");
	nodeJoin($$, $1);
}
		| ConditionalOrExpression QUEST Expression COLON ConditionalExpression {
	$$ = new ASTnode(++nodeNum, "Conditional Expression");
	nodeJoin($$, $1);
	nodeToTerminal($$, $2, "Question Mark");
	nodeJoin($$, $3);
	nodeToTerminal($$, $4, "Colon");
	nodeJoin($$, $5);
}
		;

AssignmentExpression: ConditionalExpression {
		$$ = new ASTnode(++nodeNum, "Assignment Expression");
		nodeJoin($$, $1);

}
		| Assignment {
		$$ = new ASTnode(++nodeNum, "Assignment Expression");
		nodeJoin($$, $1);
}
		;

Assignment: LeftHandSide AssignmentOperator AssignmentExpression {
	$$ = new ASTnode(++nodeNum, "Assignment");
	nodeJoin($$, $1);
	nodeJoin($$, $2);
	nodeJoin($$, $3);
}
		;

LeftHandSide: Name {
	$$ = new ASTnode(++nodeNum, "Left Hand Side");
	nodeJoin($$, $1);
}
		| FieldAccess {
	$$ = new ASTnode(++nodeNum, "Left Hand Side");
	nodeJoin($$, $1);
}
		| ArrayAccess {
	$$ = new ASTnode(++nodeNum, "Left Hand Side");
	nodeJoin($$, $1);
}
		;

AssignmentOperator: ASN {
	$$ = new ASTnode(++nodeNum, "Assignment Operator");
	nodeToTerminal($$, $1, "Assignment Operator");
}
		| MUASN{
	$$ = new ASTnode(++nodeNum, "Assignment Operator");
	nodeToTerminal($$, $1, "Assignment Operator");
}
		| DIASN{
	$$ = new ASTnode(++nodeNum, "Assignment Operator");
	nodeToTerminal($$, $1, "Assignment Operator");
}
		| MODASN{
	$$ = new ASTnode(++nodeNum, "Assignment Operator");
	nodeToTerminal($$, $1, "Assignment Operator");
}
		| PLASN{
	$$ = new ASTnode(++nodeNum, "Assignment Operator");
	nodeToTerminal($$, $1, "Assignment Operator");
}
		| MIASN{
	$$ = new ASTnode(++nodeNum, "Assignment Operator");
	nodeToTerminal($$, $1, "Assignment Operator");
}
		| SLASN{
	$$ = new ASTnode(++nodeNum, "Assignment Operator");
	nodeToTerminal($$, $1, "Assignment Operator");
}
		| SRASN{
	$$ = new ASTnode(++nodeNum, "Assignment Operator");
	nodeToTerminal($$, $1, "Assignment Operator");
}
		| LSRASN{
	$$ = new ASTnode(++nodeNum, "Assignment Operator");
	nodeToTerminal($$, $1, "Assignment Operator");
}
		| ANDASN{
	$$ = new ASTnode(++nodeNum, "Assignment Operator");
	nodeToTerminal($$, $1, "Assignment Operator");
}
		| CARETASN{
	$$ = new ASTnode(++nodeNum, "Assignment Operator");
	nodeToTerminal($$, $1, "Assignment Operator");
}
		| ORASN{
	$$ = new ASTnode(++nodeNum, "Assignment Operator");
	nodeToTerminal($$, $1, "Assignment Operator");
}
		;

Expression: AssignmentExpression {
	$$ = new ASTnode(++nodeNum, "Expression");
	nodeJoin($$, $1);
}
		;

ConstantExpression: Expression  {
	$$ = new ASTnode(++nodeNum, "Expression");
	nodeJoin($$, $1);
}
        ;

%%

int yyerror(char *s){
    printf("error: %s\n", s);
	return 0;
}

int main(){
	symTabInit();
    yyparse();
    return 0;
}

