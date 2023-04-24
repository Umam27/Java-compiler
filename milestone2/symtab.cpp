#include <bits/stdc++.h>
#include "symtab.h"
#include <iostream>
#include <fstream>
#include <sys/stat.h>
#include <sys/types.h>
using namespace std;

symTab* curr;
symTab* root = new symTab;

int scpnum = 0;


attr::attr() {
    this->type = "NULL";
    this->line = 0;
    this->childindex = 0;
    this->fi = "NULL";
    this->fo = "NULL";
    this->modifiers = 1;
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
    insertMethodType("System.out.print","string","void",0,1);
    insertMethodType("System.out.println","string","void",0,1);
    }

//lookup() returns the type of the variable if found in the symbol table. if not, return "not found"
string helplookup(string lexeme, symTab* checkptr){
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
        return helplookup(lexeme, checkptr);
    }
}

string lookup(char* templexeme){
    string lexeme(templexeme);
    symTab* checkptr = curr;
    return helplookup(lexeme, checkptr);
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

//insert() inserts the variable in the symbol table
bool insertId(char* templex, char* type, int line, int pps){
    string sslookup;
    string lexeme(templex);
    sslookup = sameScopeLookup(lexeme);
    if(sslookup=="NULL") {
        attr val;
        val.line = line;
        val.type = type;
        val.modifiers = pps;
        curr->entries.insert({lexeme,val});
        if(pps%5 == 0){
            root->entries.insert({lexeme,val});
        }
        return true;
    }
    else {
        return false;
    }
}

// bool insertLit(char* templex, string type, int line){
//     string sslookup;
//     string lexeme(templex);
//     sslookup = sameScopeLookup(lexeme);
//     if(sslookup=="NULL") {
//         attr val;
//         val.line = line;
//         val.type = type;
//         curr->entries.insert({lexeme,val});
//         return true;
//     }
//     else {
//         return false;
//     }
// }

//insertMethod() inserts the method in the symbol table
bool insertMethodType(string lexeme, string fi, string fo, int line, int pps){
    int ovld_counter = 1;
    string sslookup;
    sslookup = sameScopeLookup(lexeme);
    if(sslookup=="NULL") {
        attr val;
        val.type = "method";
        val.fi = fi;
        val.fo = fo;
        val.line = line;
        val.modifiers = pps;
        curr->entries.insert({lexeme,val});
        if(pps % 5 == 0){
            root->entries.insert({lexeme,val});
        }
        return true;
    }
    else return false;
}

bool insertConsType(string lexeme, string fi, string fo, int line){
    attr val;
    val.type = "constructor";
    val.fi = fi;
    val.fo = fo;
    val.line = line;
    curr->entries.insert({lexeme,val});
    return true;
}

//addChild() inserts a new child scope in the symbol table
void addChild(){
    symTab* help = new symTab(curr);
    scpnum++;
    curr->childscopes.push_back(help);
    char suf = 'a' ;
    suf += (int)(curr->childscopes.size() - 1);
    string pref = curr->scp + "_";
    string scp = pref + to_string(scpnum) + suf;
    curr = help;
    curr->scp = scp;
}

void goUp(){
    if(curr->parentscope != NULL){
        curr = curr->parentscope;
        scpnum--;
    }
}

void printSB(symTab* helper){
    
    symTab* helper1 = helper;
    
    string fn;
    fn = "outputSymTabs/SCOPE_" + helper->scp + ".csv";
    
    std::ofstream csvFile(fn);
    
    csvFile << "Name, Type, Line, Function Input Type, Function Output Type, Modifierpps" << "\n";
    
    cout<<"\n"<<"This is scope "<<helper1->scp<<":"<<"\n";
    if(!helper1->entries.empty()){
        for(auto entry : helper1->entries){
            cout<<entry.first<<" "<<entry.second.type<<" "<<entry.second.line<<" "<<entry.second.fi<<" "<<entry.second.fo <<" "<<entry.second.modifiers<<endl;
            csvFile << entry.first << "," << entry.second.type << "," << entry.second.line << "," << entry.second.fi << "," << entry.second.fo <<"," <<entry.second.modifiers<< "\n";
        }
    }
    
    csvFile.close();
    
    if(helper1->childscopes.empty()){
        return;
    }
    for(auto childptr : helper1->childscopes){
        printSB(childptr);
    }
    return;
}

void printGSB(){
    string directoryName = "outputSymTabs";

    int result = mkdir(directoryName.c_str(), S_IRWXU | S_IRWXG | S_IRWXO);

    if (result == 0) {
        std::cout << "output directory created successfully!" << std::endl;
    }
    else {
        std::cerr << "Error creating directory: " << strerror(errno) << std::endl;
    }

    printSB(root);
}

void checkType(string type1, string type2, int line){
    if(type1 == type2){
        return;
    }
    if(type2 == "booleannumeric"){
        if(type1 == "boolean" || type1 == "int" || type1 == "float" || type1 == "double" || type1 == "long" || type1 == "short" || type1 == "char" || type1 == "byte"){
            return;
        }
        else{
            cout<<"Type : "<<type1<<" is not a boolean or numeric on line "<<line<<"\n";
            return;
        }
    }
    if(type2 == "numeric"){
        if(type1 == "int" || type1 == "float" || type1 == "double" || type1 == "long" || type1 == "short" || type1 == "char" || type1 == "byte"){
            return;
        }
        else{
            cout<<"Type : "<<type1<<" is not a numeric on line "<<line<<"\n";
            return;
        }
    }
    else{
        cout<<"Type : "<<type1<<" and Type : "<<type2<<" are not compatible on line "<<line<<"\n";
        return;
    }
}

string max(string a, string b){
    if(a=="double" || b=="double"){
        return "double";
    }
    else if(a=="float" || b=="float"){
        return "float";
    }
    else if(a=="long" || b=="long"){
        return "long";
    }
    else if(a=="int" || b=="int"){
        return "int";
    }
    else if(a=="short" || b=="short"){
        return "short";
    }
    else if(a=="byte" || b=="byte"){
        return "byte";
    }
    else{
        return "NULL";
    }
}

string helpmethodlookup(string lexeme, string fi, symTab* checkptr){
    for (auto entry : checkptr->entries) {
        if(entry.first == lexeme ){
            return entry.second.fo;
        }
    }
    for (auto entry : root->entries) {
        if(entry.first == lexeme ){
            return entry.second.fo;
        }
    }
    return "NULL";
}

string methodLookup(string lexeme, string fi){
    symTab* checkptr = curr;
    return helpmethodlookup(lexeme,fi,checkptr);
}

string membLookup(char* primary, char* ident){
    string cl = lookup(primary);
    if(root->entries.count(cl)) {
        if(root->entries[cl].modifiers % 3 == 0){
            cout<<" err : Class " + cl + " is private. Cannot access its members"<<endl;
            return "ERROR";
        }
        int n = root->entries[cl].childindex;
        symTab* helper = root->childscopes[n];
        for (auto entry : helper->entries) {
            if(entry.first == string(ident)){
                if(entry.second.modifiers % 3 ==0){
                    cout<<" err : Member " + string(ident) + " is private. Cannot access it."<<endl;
                    return "ERROR";
                }
                if(entry.second.type == "method" || entry.second.type == "constructor"){
                    // cout<<"correct fieldaccess for a method/constructor"<<"\n";
                    return entry.second.fo;
                }
                else{
                    // cout<<"correct fieldaccess for a member"<<"\n";
                    return entry.second.type;
                } 
            }   
        }
        cout<<" err : Class "<<cl<<" has no member called "<<string(ident)<<"\n";
        return "ERROR";
    }
    cout<<" err : No class named "<<cl<<" exists \n";
    return "ERROR"; 
}

void addClassChild(char* str, int pps, int line){
    symTab* help = new symTab(curr);
    scpnum++;
    int n = curr->childscopes.size();
    curr->childscopes.push_back(help);
    char suf = 'a' ;
    suf += (int)(curr->childscopes.size() - 1);
    string pref = curr->scp + "_";
    string scp = pref + to_string(scpnum) + suf;
    attr val;
    val.type = "class";
    val.line = line;
    val.modifiers = pps;
    val.childindex = n;
    curr->entries.insert({string(str), val});
    curr = help;
    curr->scp = scp;
}