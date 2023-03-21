#include <bits/stdc++.h>
#include "symtab.h"
using namespace std;

symTab* curr;
symTab* root = new symTab;

int scpnum = 0;


attr::attr() {
    this->type = "NULL";
    this->line = 0;
    // this->childptr = NULL;
    this->fi = "NULL";
    this->fo = "NULL";
};


symTab::symTab(){
    this->parentscope = NULL;
}
symTab::symTab(symTab *parent){
    this->parentscope = parent;
}

void symTabInit(void){
    // symTab root;
    curr = root;
    scpnum++;
    curr->scp = "1";
    // cout<<"init done"<<endl;
}

//lookup() returns the type of the variable if found in the symbol table. if not, return "not found"
string lookup(string lexeme){
    symTab* checkptr = curr;
    for (auto entry : checkptr->entries) {
        if(entry.first == lexeme){
            return entry.second.type;
        }
    }
    if(checkptr->parentscope == NULL){
        return "NULL";
    }
    else{
        checkptr = checkptr->parentscope;
        return lookup(lexeme);
    }
}

string sameScopeLookup(string lexeme){
    symTab* checkptr = curr;
    for (auto entry : checkptr->entries) {
        if(entry.first == lexeme){
            return entry.second.type;
        }
    }
    return "NULL";
}

bool editEntry(string lexeme, string type, string fi, string fo){
    symTab* checkptr = curr;
    bool flag = false;
    for (auto entry : checkptr->entries) {
        if(entry.first == lexeme){
            flag = true;
            if(type!="NULL"){
                entry.second.type = type;
            }
            else {
                entry.second.type = "method";
            }
            if(fi!="NULL"){
                entry.second.fi = fi;
            }
            if(fo!="NULL"){
                entry.second.fo = fo;
            }
        }
    }
    // cout<<".......insert working......"<<endl;
    return flag;
}

//insert() inserts the variable in the symbol table
bool insertId(char* templex, int line){
    string sslookup;
    string lexeme(templex);
    sslookup = sameScopeLookup(lexeme);
    if(sslookup=="NULL") {
        attr val;
        val.line = line;
        curr->entries.insert({lexeme,val});
        // cout<<"finally lexeme bhi gya"<<endl;
        return true;
    }
    else {
        return false;
    }
}

bool insertLit(char* templex, string type, int line){
    string sslookup;
    string lexeme(templex);
    sslookup = sameScopeLookup(lexeme);
    if(sslookup=="NULL") {
        attr val;
        val.line = line;
        val.type = type;
        curr->entries.insert({lexeme,val});
        // cout<<"finally lexeme bhi gya"<<endl;
        return true;
    }
    else {
        return false;
    }
}

//insert() inserts the variable in the symbol table
bool insertDeclType(string lexeme, string type){
    return editEntry(lexeme, type, "NULL", "NULL");
}

//insertMethod() inserts the method in the symbol table
bool insertMethodType(string lexeme, string fi, string fo){
    return editEntry(lexeme, "NULL", fi, fo);
}

//insertClass() inserts the class in the symbol table
// bool insertClass(string lexeme, string type, int line, symTab* child){
//     string sslookup;
//     sslookup = this->sameScopeLookup(lexeme);
//     if(sslookup=="NULL") {
//         attr val;
//         val.type = type;
//         val.line = line;
//         val.childptr = child;
//         entries.insert({lexeme,val});
//         return true;
//     }
//     else {
//         return false;
//     }
// }

//insertscope() inserts a new child scope in the symbol table
void addChild(){
    symTab* help = new symTab(curr);
    scpnum++;
    curr->childscopes.push_back(help);
    char suf = 'a' ;
    suf += (int)(curr->childscopes.size() - 1);
    string scp = to_string(scpnum) + suf;
    curr = help;
    curr->scp = scp;
    // cout<<".......added mast child......"<<endl;
}

void goUp(){
    if(curr->parentscope != NULL){
        curr = curr->parentscope;
        scpnum--;
    }
}

// void printSymTab(){
//     symTab* checkptr = curr;
//     for (auto entry : checkptr->entries) {
//         cout<<entry.first<<" "<<entry.second.type<<" "<<entry.second.line<<" "<<entry.second.fi<<" "<<entry.second.fo<<endl;
//     }
//     return ;
//     // if(checkptr->parentscope == NULL){
//     //     return;
//     // }
//     // else{
//     //     checkptr = checkptr->parentscope;
//     //     printSymTab();
//     // }

//     printSB(curr);
// }

void printSB(symTab* helper){
    symTab* helper1 = helper;
    cout<<"\n"<<"This is scope "<<helper1->scp<<":"<<"\n";
    if(!helper1->entries.empty()){
        for(auto entry : helper1->entries){
            cout<<entry.first<<" "<<entry.second.type<<" "<<entry.second.line<<" "<<entry.second.fi<<" "<<entry.second.fo<<endl;
        }
    }
    if(helper1->childscopes.empty()){
        return;
    }
    for(auto childptr : helper1->childscopes){
        printSB(childptr);
    }
    return;
}

void printGSB(){
    // symTab* helper2 = curr;
    // while(helper2->parentscope != NULL){
    //     helper2 = helper2->parentscope;
    // }
    printSB(root);
}