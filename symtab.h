#include <bits/stdc++.h>
using namespace std;


class attr {
    public: 
        string type;
        int line;
        // symTab* childptr;
        string fi;
        string fo;

        attr(void);
};

class symTab {
    public:
        unordered_map<string, attr> entries;
        vector<symTab> childscopes;
        symTab* parentscope;
        
        //constructor
        symTab(void);
        symTab(symTab *parent);
};

void symTabInit(void);

//lookup() returns the type of the variable if found in the symbol table. if not, return "NULL"
string lookup(string);
string sameScopeLookup(string lexeme);

//helper function
bool editEntry(string lexeme, string type, string fi, string fo);


bool insertId(char* templex, int line);
bool insertLit(char* templex, string type, int line);

//insertDeclType() inserts the variable in the symbol table
bool insertDeclType(string lexeme, string type);

//insertMethod() inserts the method in the symbol table
bool insertMethodType(string lexeme, string fi, string fo);

//insertClass() inserts the class in the symbol table
// bool insertClass(string lexeme, string type, int line, symTab* child);

//insertscope() inserts a new child scope in the symbol table
void addChild();



