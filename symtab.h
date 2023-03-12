#include <bits/stdc++.h>
using namespace std;


class attr {
    public: 
        string type;
        int line;
};

class symTab {
    public:
        unordered_map<string, attr> entries;
        vector<symTab*> childscopes;
        symTab* parentscope;
        
        //constructor
        symTab(){
            this->parentscope = NULL;
        }
        symTab(symTab *parent){
            this->parentscope = parent;
        }

        //lookup() returns the type of the variable if found in the symbol table. if not, return "not found"
        string lookup(string lexeme){
            for (auto entry : entries) {
                if(entry.first == lexeme){
                    return entry.second.type;
                }
            }
            if(parentscope == NULL){
                return "NULL";
            }
            else{
                return parentscope->lookup(lexeme);
            }
        }

        string sameScopeLookup(string lexeme){
            for (auto entry : entries) {
                if(entry.first == lexeme){
                    return entry.second.type;
                }
            }
            return "NULL";
        }

        //insert() inserts the variable in the symbol table
        bool insert(string lexeme, string type, int line){
            string sslookup;
            sslookup = this->sameScopeLookup(lexeme);
            if(sslookup=="NULL") {
                attr val;
                val.type = type;
                val.line = line;
                entries.insert({lexeme,val});
                return true;
            }
            else {
                return false;
            }
        }

        //insertscope() inserts a new child scope in the symbol table
        void addChild(symTab* newChild){
            childscopes.push_back(newChild);
        }


};