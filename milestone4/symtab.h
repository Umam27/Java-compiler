#include <bits/stdc++.h>
using namespace std;


class attr {
    public: 
        string type;
        int line;
        int childindex;
        string fi;
        string fo;
        int modifiers; //multiplicative divisibility
        int size;
        int offset;

        attr(void);
};

class symTab {
    public:
        unordered_map<string, attr> entries;
        vector<symTab*> childscopes;
        symTab* parentscope;
        string scp;
        string name;
        int fieldOrLocalOffset;
        int formalParamOffset;

        
        //constructor
        symTab(void);
        symTab(symTab *parent);
        symTab(symTab *parent, string name);
};

void symTabInit(void);


//lookup() returns the type of the variable if found in the symbol table. if not, return "NULL"
string helplookup(string lexeme);
string lookup(char* templexeme);
string sameScopeLookup(string lexeme);

bool insertId(char* templex, string type, int line, int modifiers);
// bool insertLit(char* templex, string type, int line);

//insertMethod() inserts the method in the symbol table
bool insertMethodType(string lexeme, string fi, string fo, int line, int modifiers);
bool insertConsType(string lexeme, string fi, string fo, int line);

//insertscope() inserts a new child scope in the symbol table
void addChild();
void addChildwithName(string name);
void addClassChild(char* str, int pps, int line);

void goUp();

// void printSymTab();
void printSB(symTab* helper);
void printGSB();

void checkType(string type1, string type2, int line);

//returns the type higher in type heirarchy
string max(string a, string b);

string helpmethodlookup(string lexeme, string fi, symTab* checkptr);

string methodLookup(string lexeme, string fi);
string membLookup(char* primary, char* ident);

string thisLookup(char* ident);

int localvarspace(string name);

string arrOffset(char* name, int idx);
int checkArrSize(char* name);