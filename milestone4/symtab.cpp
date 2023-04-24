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

char* TOC(string s)
{
	char* newchr = new char[s.length() + 1];
	strcpy(newchr, s.c_str());
	return newchr;

}

unordered_map<string,string> arrayaccess;


attr::attr() {
    this->type = "NULL";
    this->line = 0;
    this->childindex = 0;
    this->fi = "NULL";
    this->fo = "NULL";
    this->modifiers = 1;
    this->size = 0;
    this->offset = 0;
};


symTab::symTab(){
    this->parentscope = NULL;
    this->name = "root";
    this->fieldOrLocalOffset = 0;
    this->formalParamOffset = 16; // 16 bytes for return address and base pointer address (ebp)
}
symTab::symTab(symTab *parent){
    this->parentscope = parent;
    this->name = "NULL";
    this->fieldOrLocalOffset = 0;
    this->formalParamOffset = 16; // 16 bytes for return address and base pointer address (ebp)
}
symTab::symTab(symTab *parent, string name){
    this->parentscope = parent;
    this->name = name;
    this->fieldOrLocalOffset = 0;
    this->formalParamOffset = 16; // 16 bytes for return address and base pointer address (ebp)
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

int helperByteSize(string type){
    if(type == "int"){
        return 8;
    }
    if(type == "float"){
        return 8;
    }
    if(type == "double"){
        return 8;
    }
    if(type == "char"){
        return 8;
    }
    if(type == "boolean"){
        return 8;
    }
    if(type == "string"){
        return 8;
    }
    return 8;
}

int findMth(symTab* checkptr, int size){
    if(checkptr->name.substr(0,3) == "mth"){
        checkptr->fieldOrLocalOffset -= size;
        return checkptr->fieldOrLocalOffset;
    }
    else{
        return findMth(checkptr->parentscope, size);
    }
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
        val.size = helperByteSize(type);
        if(string(type) != "int"){
            val.offset = 0;
        }
        else if(curr->name.substr(0,5) == "class"){
            val.offset = curr->fieldOrLocalOffset;
            curr->fieldOrLocalOffset += val.size;
        }
        else if(curr->name.substr(0,3) == "mth"){
            curr->fieldOrLocalOffset -= val.size;
            val.offset = curr->fieldOrLocalOffset;
        }
        else{
            int temp = findMth(curr->parentscope, val.size);
            val.offset = temp;
        }
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

bool insertFPId(char* templex, char* type, int line, int pps){
    string sslookup;
    string lexeme(templex);
    sslookup = sameScopeLookup(lexeme);
    if(sslookup=="NULL") {
        attr val;
        val.line = line;
        val.type = type;
        val.modifiers = pps;
        val.size = helperByteSize(type);
        val.offset = curr->formalParamOffset;
        curr->formalParamOffset += val.size;
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
    for(auto entry : root->entries){
        if(entry.first == lexeme){
            entry.second.fi = fi;
            entry.second.fo = fo;
        }
    }
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

void addChildwithName(string name){
    symTab* help = new symTab(curr, name);
    scpnum++;
    curr->childscopes.push_back(help);
    char suf = 'a' ;
    suf += (int)(curr->childscopes.size() - 1);
    string pref = curr->scp + "_";
    string scp = pref + to_string(scpnum) + suf;
    curr = help;
    curr->scp = scp;
}

void addClassChild(char* str, int pps, int line){
    symTab* help = new symTab(curr, "class_"+string(str));
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
    val.fi= "void";
    val.fo = string(str);
    val.childindex = n;
    curr->entries.insert({string(str), val});
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
    
    csvFile << "Name, Type, Line, Function Input Type, Function Output Type, Modifierpps, Size, Offset" << "\n";
    
    cout<<"\n"<<"This is scope "<<helper1->scp<<" (name : "<<helper->name<<") -"<<"\n";
    if(!helper1->entries.empty()){
        for(auto entry : helper1->entries){
            cout<<entry.first<<" "<<entry.second.type<<" "<<entry.second.line<<" "<<entry.second.fi<<" "<<entry.second.fo <<" "<<entry.second.modifiers<<" "<<entry.second.size<<" "<<entry.second.offset<<endl;
            csvFile << entry.first << "," << entry.second.type << "," << entry.second.line << "," << entry.second.fi << "," << entry.second.fo <<"," <<entry.second.modifiers<<","<<entry.second.size<<","<<entry.second.offset<< "\n";
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
    if(type1 == "class" || type2 == "class" || type1 == "null" || type2 == "null" || type1 == "NULL" || type2 == "NULL"){
        return;
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
            if(entry.second.fi == fi){
                return entry.second.fo;
            }
            else{
                cout<<"err : Method "<<lexeme<<" with input type "<<fi<<" not found in scope" <<checkptr->scp <<". Required Input type is "<< entry.second.fi<<endl;
                return "NULL";
            }
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
    symTab* checkptr = curr->parentscope;
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
        // cout<<"correct fieldaccess for a class!!!!! searching for "<<ident<<"!!! \n";
        for (auto entry : helper->entries) {
            // cout<<"now checking comparision for "<<entry.first<<"!!! \n";
            if(entry.first == ident){
                // cout<<"correct fieldaccess for a member!!!!!"<<"\n";
                if(entry.second.modifiers % 3 ==0){
                    cout<<" err : Member " + string(ident) + " is private. Cannot access it."<<endl;
                    return "ERROR";
                }
                if(entry.second.type == "method" || entry.second.type == "class"){
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

void helpoffsetmembLookup(string primary, symTab* checkptr, string& classtype){
    for (auto entry : checkptr->entries) {
        if(entry.first == primary ){
            classtype = entry.second.type;
        }
    }
    if(checkptr->childscopes.size() == 0){
        return;
    }
    else {
        for(auto itr: checkptr->childscopes){
            if(classtype == ""){
                return helpoffsetmembLookup(primary, itr, classtype);
            }
            else break;
        }
    }
}

int offsetmembLookup(string primary, string ident, vector<string> scope){
    string classtype = "";
    for(auto itr: root->childscopes){
        if(itr->name == "class_"+scope[0]){
            for(auto itr2: itr->childscopes){
                if((itr2->name) == "mth_"+scope[1]){
                    // cout<<"yuss2"<<endl;
                    helpoffsetmembLookup(primary, itr2, classtype);
                    if(classtype != "") break;
                }
            }
        }
    }
    if(root->entries.count(classtype)!=0) {
        if(root->entries[classtype].modifiers % 3 == 0){
            return 69;
        }
        int n = root->entries[classtype].childindex;
        symTab* helper = root->childscopes[n];
        // cout<<"correct fieldaccess for a class!!!!! searching for "<<ident<<"!!! \n";
        for (auto entry : helper->entries) {
            // cout<<"now checking comparision for "<<entry.first<<"!!! \n";
            if(entry.first == ident){
                // cout<<"correct fieldaccess for a member!!!!!"<<"\n";
                if(entry.second.modifiers % 3 ==0){
                    return 70;
                }
                return entry.second.offset;
            }   
        }
        return 71;
    }
    return 72; 
}


int localvarspace(string name){

    for (auto &entry : root->entries) {
        if(entry.first == name ){
            if(entry.second.type == "class"){
                entry.second.size = (-1)*curr->fieldOrLocalOffset;
                break;
            }
        }
    }
    return ((-1)*curr->fieldOrLocalOffset);
    // return 69;
}

int classSize(string name){
    for (auto entry : root->entries) {
        if(entry.first == name ){
            if(entry.second.type == "class"){
                return entry.second.size;
            }
        }
    }
    return 69;
}


// 

vector<vector<string>> readIR(const string& filename) {
    vector<vector<string>> result;
    ifstream file(filename);
    string line;
    while (getline(file, line)) {
        stringstream ss(line);
        vector<string> tokens;
        string token;
        while (getline(ss, token, ';')) {
            tokens.push_back(token);
        }
        result.push_back(tokens);
    }
    return result;
}

void printIR_alt(){
    string fnv_alt = "output3AC/3acvector_alt.txt";
    std::ofstream irvFile_alt(fnv_alt);
    int lines = -1;
    vector<vector<string>> IRvec = readIR("output3AC/3acvector.txt");
    
    irvFile_alt<<IRvec.size()<<endl;
    irvFile_alt<<IRvec[7].size()<<endl;
    for(auto itr : IRvec){
        lines++;
        irvFile_alt << itr[0] << ", " << itr[1] << ", " << itr[2] << ", " << itr[3] << endl;
    }
}

string insertLabel(){
    static int count = 0;
    string label = "label_" + to_string(count);
    count++;
    return label;
}

string getreg(){
    static int count = -1;
    count++;
    if(count%8 == 0){
        return "%r8";
    }
    if(count%8 == 1){
        return "%r9";
    }
    if(count%8 == 2){
        return "%r10";
    }
    if(count%8 == 3){
        return "%r11";
    }
    if(count%8 == 4){
        return "%r12";
    }
    if(count%8 == 5){
        return "%r13";
    }
    if(count%8 == 6){
        return "%r14";
    }
    else{
        return "%r15";
    }
}

void helplookuponstack(string var, symTab* checkptr, string& offset){
    for (auto entry : checkptr->entries) {
        if(entry.first == var ){
            offset = to_string(entry.second.offset) + "(%rbp)";
        }
    }
    if(checkptr->childscopes.size() == 0){
        return;
    }
    else {
        for(auto itr: checkptr->childscopes){
            if(offset == ""){
                return helplookuponstack(var, itr, offset);
            }
            else break;
        }
    }
}

string lookuponstack(string var, vector<string>& scope){
    if(var.substr(0,1) == "#" || var.substr(0,1) == "~"){
        return "(%rdi,%rax)";
    }
    for(auto itr: root->childscopes){
        if(itr->name == "class_"+scope[0]){
            for(auto itr2: itr->childscopes){
                if((itr2->name) == "mth_"+scope[1]){
                    // cout<<"yuss2"<<endl;
                    string offset = "";
                    helplookuponstack(var, itr2, offset);
                    if(offset != "") return offset;
                }
            }
        }
    }
    return "$" + var;
}

//the following function reads the ir[][] which is 3ac code and generates the assembly code (x86) and stores it in the file "assembly.txt"
void generateAssembly(){

    vector<vector<string>> codeIR = readIR("output3AC/3acvector.txt");
    vector<string> scope;
    int flagreturn =0;

    //first iteration through the codeIR to find labels for goto statements
    unordered_map<int, string> labelMap;
    for(int i=0; i<codeIR.size(); i++){
        vector<string> it = codeIR[i];
        if(it[0] == "goto"){
            if(labelMap.count(stoi(it[2])) == 0){
                labelMap[stoi(it[2])] = insertLabel();
            }
        }
    }

    unordered_map<string, string> allotreg;
    unordered_map<string, int> arrsize;
    unordered_set<string> classcall;

    ofstream asmFile;
    asmFile.open("assembly.s");
    string cmpvar;
    string ident = "\t";

    asmFile << "format:" << endl;
    asmFile << ident << ".string \"%ld\\n\"" << endl;

    asmFile << ".data" << endl;
    for(int i=0; i<codeIR.size();i++){
        vector<string> it = codeIR[i];
        if(it[2] == "new"){
            arrsize[codeIR[i+1][3]] = stoi(it[1].substr(4));
            asmFile << ident << "ptr_" + codeIR[i+1][3] << ": .quad 0" << endl;
        }
        if(it[1] == "return object from eax"){
            asmFile << ident << "objptr_" + codeIR[i+1][3] << ": .quad 0" << endl;
        }
    }

    asmFile << ".text" << endl;
    // asmFile << ident << ".globl _factorial" << endl;

    for(int i=0; i<codeIR.size(); i++){
        vector<string> it = codeIR[i];
        if(it[3] == "call"){
            if(it[1]!="System.out.println" && it[1]!="System.out.print" && it[1]!="malloc"){
                asmFile << ident << ".globl " << it[1] << endl;
                if(root->entries.count(it[1]) == 1){
                    classcall.insert(it[1]);
                }
            }
        
        }
    }
    asmFile << ident << ".globl main" << endl;
    asmFile << ident << ".globl start" << endl;

    asmFile << "start:" << endl;
    asmFile << ident << "jmp main" << endl;

    for(int i=0; i<codeIR.size(); i++){
        vector<string> it = codeIR[i];
        ///arrayaccesschudap
        if(it[1].substr(0,1)=="#"){
            cout<<"here"<<endl;
            auto chu = it[1].find('[');
            cout << "-----" << chu << endl;
            string tempname = it[1].substr(chu+1, it[1].length()-chu-2);
            asmFile << ident << "movq ptr_" << it[1].substr(1,chu-1) << ", %rdi" << endl;
            asmFile << ident << "movq " << allotreg[tempname] << ", %rax" << endl;
        }
        if(it[2].substr(0,1)=="#"){
            cout<<"here"<<endl;
            auto chu = it[2].find('[');
            cout << "-----" << chu << endl;
            string tempname = it[2].substr(chu+1, it[2].length()-chu-2);
            asmFile << ident << "movq ptr_" << it[2].substr(1,chu-1) << ", %rdi" << endl;
            asmFile << ident << "movq " << allotreg[tempname] << ", %rax" << endl;
        }
        if(it[3].substr(0,1)=="#"){
            cout<<"here"<<endl;
            auto chu = it[3].find('[');
            cout << "-----" << chu << endl;
            string tempname = it[3].substr(chu+1, it[3].length()-chu-2);
            asmFile << ident << "movq ptr_" << it[3].substr(1,chu-1) << ", %rdi" << endl;
            asmFile << ident << "movq " << allotreg[tempname] << ", %rax" << endl;
        }
        ///
        ///classobjectkachudap
        if(it[1].substr(0,1)=="~"){
            auto chu = it[1].find('.');
            string membname = it[1].substr(chu+1, it[1].length()-chu-1);
            string objname = it[1].substr(1,chu-1);
            asmFile << ident << "movq objptr_" << objname << ", %rdi" << endl;
            asmFile << ident << "movq $" << offsetmembLookup(objname,membname,scope)<< ", %rax" << endl;
        }
        if(it[2].substr(0,1)=="~"){
            auto chu = it[2].find('.');
            string membname = it[2].substr(chu+1, it[2].length()-chu-1);
            string objname = it[2].substr(1,chu-1);
            asmFile << ident << "movq objptr_" << objname << ", %rdi" << endl;
            asmFile << ident << "movq $" << offsetmembLookup(objname,membname,scope)<< ", %rax" << endl;
        }
        if(it[3].substr(0,1)=="~"){
            auto chu = it[3].find('.');
            string membname = it[3].substr(chu+1, it[3].length()-chu-1);
            string objname = it[3].substr(1,chu-1);
            asmFile << ident << "movq objptr_" << objname << ", %rdi" << endl;
            asmFile << ident << "movq $" << offsetmembLookup(objname,membname,scope)<< ", %rax" << endl;
        }
        ///

        if(labelMap.count(i) == 1){
            asmFile << labelMap[i] << ":\n";
        }
        if(it[0] == "classstart"){
            // asmFile << ident << it[1] << ":" << endl;
            scope.push_back(it[1]);
            continue;
        }
        if(it[0] == "classend"){
            asmFile << ident << endl;
            scope.pop_back();
            continue;
        }
        if(it[0] == "PROC"){
            asmFile << it[1] << ":" << endl;
            if(classcall.find(it[1]) != classcall.end()) {
                classcall.erase(classcall.find(it[1]));
            }
            scope.push_back(it[1]);
            continue;
        }
        if(it[0] == "ENDP"){
            asmFile << ident << endl;
            scope.pop_back();
            continue;
        }
        if(it[3] == "ret"){
            if(flagreturn==1){
                asmFile << ident << "ret" << endl;
                flagreturn=0;
                continue;
            }
            asmFile << ident << "movq $0, %rax" << endl;
            asmFile << ident << "ret" << endl;
            continue;
        }
        if(it[0] == "goto"){
            if(it[3]!="if")asmFile << ident << "jmp " << labelMap[stoi(it[2])] << endl;
            else{
                asmFile << ident << cmpvar << " " << labelMap[stoi(it[2])] << endl;
            }
            continue;
        }
        
        // remove the creation of a new variable because of use of cmp directly
        // comparators:
        // je <label> (jump when equal)
        // jne <label> (jump when not equal)
        // jz <label> (jump when last result was zero)
        // jg <label> (jump when greater than)
        // jge <label> (jump when greater than or equal to)
        // jl <label> (jump when less than)
        // jle <label> (jump when less than or equal to)

        if(it[0] == "=="){
            cmpvar = "je";
            asmFile << ident << "cmpq ";
            if(it[2].substr(0,2)=="t_"){
                asmFile << allotreg[it[2]] << ",";
            }
            else{
                asmFile << lookuponstack(it[2],scope) << ",";
            }

            if(it[1].substr(0,2)=="t_"){
                asmFile << allotreg[it[1]] << endl;
            }
            else{
                asmFile << lookuponstack(it[1],scope) << endl;
            }
            continue;
        }
        if(it[0] == "!="){
            cmpvar = "jne";
            asmFile << ident << "cmpq ";
            if(it[2].substr(0,2)=="t_"){
                asmFile << allotreg[it[2]] << ",";
            }
            else{
                asmFile << lookuponstack(it[2],scope) << ",";
            }

            if(it[1].substr(0,2)=="t_"){
                asmFile << allotreg[it[1]] << endl;
            }
            else{
                asmFile << lookuponstack(it[1],scope) << endl;
            }
            continue;
        }
        if(it[0] == ">"){
            cmpvar = "jg";
            asmFile << ident << "cmpq ";
            if(it[2].substr(0,2)=="t_"){
                asmFile << allotreg[it[2]] << ",";
            }
            else{
                asmFile << lookuponstack(it[2],scope) << ",";
            }

            if(it[1].substr(0,2)=="t_"){
                asmFile << allotreg[it[1]] << endl;
            }
            else{
                asmFile << lookuponstack(it[1],scope) << endl;
            }
            continue;
        }
        if(it[0] == "<"){
            cmpvar = "jl";
            asmFile << ident << "cmpq ";
            if(it[2].substr(0,2)=="t_"){
                asmFile << allotreg[it[2]] << ",";
            }
            else{
                asmFile << lookuponstack(it[2],scope) << ",";
            }

            if(it[1].substr(0,2)=="t_"){
                asmFile << allotreg[it[1]] << endl;
            }
            else{
                asmFile << lookuponstack(it[1],scope) << endl;
            }
            continue;
        }
        if(it[0] == ">="){
            cmpvar = "jge";
            asmFile << ident << "cmpq ";
            if(it[2].substr(0,2)=="t_"){
                asmFile << allotreg[it[2]] << ",";
            }
            else{
                asmFile << lookuponstack(it[2],scope) << ",";
            }

            if(it[1].substr(0,2)=="t_"){
                asmFile << allotreg[it[1]] << endl;
            }
            else{
                asmFile << lookuponstack(it[1],scope) << endl;
            }
            continue;
        }
        if(it[0] == "<="){
            cmpvar = "jle";
            asmFile << ident << "cmpq ";
            if(it[2].substr(0,2)=="t_"){
                asmFile << allotreg[it[2]] << ",";
            }
            else{
                asmFile << lookuponstack(it[2],scope) << ",";
            }

            if(it[1].substr(0,2)=="t_"){
                asmFile << allotreg[it[1]] << endl;
            }
            else{
                asmFile << lookuponstack(it[1],scope) << endl;
            }
            continue;
        }

        // if(it[3]=="pushparam"){
        //     if(it[1].substr(0,2) == "t_"){
        //         asmFile << ident << "push " << allotreg[it[1]] << endl;
        //         continue;
        //     }
        //     else{
        //         asmFile << ident << "push " << lookuponstack(it[1],scope) << endl;
        //         continue;
        //     }
        // }
        // if(it[3]=="call"){
        //     asmFile << ident << "call " << it[1] << endl;
        //     continue;
        // }
        if(it[3] == "push ebp"){
            asmFile << ident << "push %rbp" << endl;
            continue;
        }
        if(it[3] == "pop ebp (restore original basepointer)"){
            asmFile << ident << "pop %rbp" << endl;
            continue;
        }
        if(it[3] == "push esi,edi (saving the values of the register the function might modify)"){
            asmFile << ident << "push %rdi" << endl;
            asmFile << ident << "push %rsi" << endl;
            continue;
        }

        if(it[3] == "mov ebp,esp"){
            asmFile << ident << "movq %rsp, %rbp" << endl;
            continue;
        }
        if(it[3] == "mov esp,ebp"){
            asmFile << ident << "movq %rbp, %rsp" << endl;
            continue;
        }
        if(it[3] == "pop to recover register values esi,edi"){
            asmFile << ident << "pop %rsi" << endl;
            asmFile << ident << "pop %rdi" << endl;
            continue;
        }

        if(it[0] == "=" && it[2] == "new"){
            asmFile << ident << "movq $" << arrsize[codeIR[i+1][3]] << ", %rdi" << endl;
            asmFile << ident << "imulq $8, %rdi" << endl;
            asmFile << ident << "call malloc" << endl;
            asmFile << ident << "movq %rax, ptr_" << codeIR[i+1][3] << endl;
            continue;
        }
        if(it[0] == "=" && it[2] == "new obj incoming"){
            asmFile << ident << "movq $" << it[1] << ", %rdi" << endl;
            continue;
        }

        // perform lookup for location of it[3] and it[1] on stack
        if(it[0] == "=" && it[2] == " "){
            if(arrsize.count(it[3])==1){
                continue;
            }
            if(it[1]=="return value from eax"){
                // flagreturn =1;
                if(allotreg.count(it[3]) == 0){
                    allotreg[it[3]] = getreg();
                }
                asmFile << ident << "movq " << "%rax, " << allotreg[it[3]] << endl;
                continue;
            }
            if(it[1] == "return object from eax"){
                if(allotreg.count(it[3]) == 0){
                    allotreg[it[3]] = getreg();
                }
                asmFile << ident << "movq " << "%rax, objptr_" << codeIR[i+1][3] << endl;
                i++;
                continue;
            }
            if(it[1] == "return object reference on heap"){
                // if(allotreg.count(it[3]) == 0){
                //     allotreg[it[3]] = getreg();
                // }
                asmFile << ident << "movq " << "%rax, %rdi" << endl;
                continue;
            }
            if(it[3] == "set eax to return value"){
                flagreturn =1;
                if(it[1].substr(0,2) == "t_"){
                    asmFile << ident << "movq " << allotreg[it[1]] << ", %rax" << endl;
                    continue;
                }
                else{
                    asmFile << ident << "movq " << lookuponstack(it[1],scope) << ", %rax" << endl;
                    continue;
                }
                asmFile << ident << "pop %rsi" << endl;
                asmFile << ident << "pop %rdi" << endl;
                asmFile << ident << "movq %rbp, %rsp" << endl;
                asmFile << ident << "pop %rbp" << endl;
                asmFile << ident << "ret" << endl;
                continue;
            }
            else{
                if(it[1].substr(0,2) == "t_" && it[3].substr(0,2) == "t_"){
                    if(allotreg.count(it[3]) == 0){
                        allotreg[it[3]] = getreg();
                    }
                    asmFile << ident << "movq " << allotreg[it[1]] << ", " << allotreg[it[3]] << endl;
                    continue;
                }
                if(it[1].substr(0,2) == "t_" && it[3].substr(0,2) != "t_"){
                    asmFile << ident << "movq " << allotreg[it[1]] << ", " << lookuponstack(it[3],scope) << endl;
                    continue;
                }
                if(it[1].substr(0,2) != "t_" && it[3].substr(0,2) == "t_"){
                    if(allotreg.count(it[3]) == 0){
                        allotreg[it[3]] = getreg();
                    }
                    asmFile << ident << "movq " << lookuponstack(it[1],scope) << ", " << allotreg[it[3]] << endl;
                    continue;
                }
                else{
                    string tempregvar = getreg();
                    asmFile << ident << "movq " << lookuponstack(it[1],scope) << ", " << tempregvar << endl;
                    asmFile << ident << "movq " << tempregvar << ", " << lookuponstack(it[3],scope) << endl;
                    continue;
                }
            }
        }

        //stack pointer manpulation
        if(it[3] == "stackptr"){
            if(it[0] == "+"){
                asmFile << ident << "addq $" << it[2] << ", %rsp" << endl;
                continue;
            }
            if(it[0] == "-"){
                asmFile << ident << "subq $" << it[2] << ", %rsp" << endl;
                continue;
            }
            else{
                asmFile<<"stackptr me gochi"<<endl;
            }
        }


        //arithmetic operations
        if(it[0] == "+"){
            if(it[1].substr(0,2) == "t_" && it[2].substr(0,2) == "t_" && it[3].substr(0,2) == "t_"){
                if(allotreg.count(it[3]) == 0){
                    allotreg[it[3]] = getreg();
                }
                asmFile << ident << "movq " << allotreg[it[1]] << ", " << allotreg[it[3]] << endl;
                asmFile << ident << "addq " << allotreg[it[2]] << ", " << allotreg[it[3]] << endl;
                continue;
            }
            if(it[1].substr(0,2) == "t_" && it[2].substr(0,2) != "t_" && it[3].substr(0,2) == "t_"){
                if(allotreg.count(it[3]) == 0){
                    allotreg[it[3]] = getreg();
                }
                asmFile << ident << "movq " << allotreg[it[1]] << ", " << allotreg[it[3]] << endl;
                asmFile << ident << "addq " << lookuponstack(it[2],scope) << ", " << allotreg[it[3]] << endl;
                continue;
            }
            if(it[1].substr(0,2) != "t_" && it[2].substr(0,2) == "t_" && it[3].substr(0,2) == "t_"){
                if(allotreg.count(it[3]) == 0){
                    allotreg[it[3]] = getreg();
                }
                asmFile << ident << "movq " << lookuponstack(it[1],scope) << ", " << allotreg[it[3]] << endl;
                asmFile << ident << "addq " << allotreg[it[2]] << ", " << allotreg[it[3]] << endl;
                continue;
            }
            if(it[1].substr(0,2) != "t_" && it[2].substr(0,2) != "t_" && it[3].substr(0,2) == "t_"){
                string tempregvar = getreg();
                if(allotreg.count(it[3]) == 0){
                    allotreg[it[3]] = getreg();
                }
                asmFile << ident << "movq " << lookuponstack(it[1],scope) << ", " << tempregvar << endl;
                asmFile << ident << "addq " << lookuponstack(it[2],scope) << ", " << tempregvar << endl;
                asmFile << ident << "movq " << tempregvar << ", " << allotreg[it[3]] << endl;
                continue;
            }
            if(it[1].substr(0,2) != "t_" && it[2].substr(0,2) == "t_" && it[3].substr(0,2) != "t_"){
                // asmFile << ident << "mov dword " << lookuponstack(it[3]) << ", " << allotreg[it[1]] << endl;
                asmFile << ident << "addq " << allotreg[it[2]] << ", " << lookuponstack(it[3],scope) << endl;
                continue;
            }
            if(it[1].substr(0,2) != "t_" && it[2].substr(0,2) != "t_" && it[3].substr(0,2) != "t_"){
                string tempregvar = getreg();
                asmFile << ident << "movq " << lookuponstack(it[1],scope) << ", " << tempregvar << endl;
                asmFile << ident << "addq " << lookuponstack(it[2],scope) << ", " << tempregvar << endl;
                asmFile << ident << "movq " << tempregvar << ", " << lookuponstack(it[3],scope) << endl;
                continue;
            }
            else{
                asmFile << ident <<"not handleled +" << endl;
                continue;
            }
        }
        if(it[0] == "-"){
            if(it[1].substr(0,2) == "t_" && it[2].substr(0,2) == "t_" && it[3].substr(0,2) == "t_"){
                if(allotreg.count(it[3]) == 0){
                    allotreg[it[3]] = getreg();
                }
                asmFile << ident << "movq " << allotreg[it[1]] << ", " << allotreg[it[3]] << endl;
                asmFile << ident << "subq " << allotreg[it[2]] << ", " << allotreg[it[3]] << endl;
                continue;
            }
            if(it[1].substr(0,2) == "t_" && it[2].substr(0,2) != "t_" && it[3].substr(0,2) == "t_"){
                if(allotreg.count(it[3]) == 0){
                    allotreg[it[3]] = getreg();
                }
                asmFile << ident << "movq " << allotreg[it[1]] << ", " << allotreg[it[3]] << endl;
                asmFile << ident << "subq " << lookuponstack(it[2],scope) << ", " << allotreg[it[3]] << endl;
                continue;
            }
            if(it[1].substr(0,2) != "t_" && it[2].substr(0,2) == "t_" && it[3].substr(0,2) == "t_"){
                if(allotreg.count(it[3]) == 0){
                    allotreg[it[3]] = getreg();
                }
                asmFile << ident << "movq " << lookuponstack(it[1],scope) << ", " << allotreg[it[3]] << endl;
                asmFile << ident << "subq " << allotreg[it[2]] << ", " << allotreg[it[3]] << endl;
                continue;
            }
            if(it[1].substr(0,2) != "t_" && it[2].substr(0,2) != "t_" && it[3].substr(0,2) == "t_"){
                string tempregvar = getreg();
                if(allotreg.count(it[3]) == 0){
                    allotreg[it[3]] = getreg();
                }
                asmFile << ident << "movq " << lookuponstack(it[1],scope) << ", " << tempregvar << endl;
                asmFile << ident << "subq " << lookuponstack(it[2],scope) << ", " << tempregvar << endl;
                asmFile << ident << "movq " << tempregvar << ", " << allotreg[it[3]] << endl;
                continue;
            }
            if(it[1].substr(0,2) != "t_" && it[2].substr(0,2) == "t_" && it[3].substr(0,2) != "t_"){
                // asmFile << ident << "mov dword " << lookuponstack(it[3]) << ", " << allotreg[it[1]] << endl;
                asmFile << ident << "subq " << allotreg[it[2]] << ", " << lookuponstack(it[3],scope) << endl;
                continue;
            }
            if(it[1].substr(0,2) != "t_" && it[2].substr(0,2) != "t_" && it[3].substr(0,2) != "t_"){
                string tempregvar = getreg();
                asmFile << ident << "movq " << lookuponstack(it[1],scope) << ", " << tempregvar << endl;
                asmFile << ident << "subq " << lookuponstack(it[2],scope) << ", " << tempregvar << endl;
                asmFile << ident << "movq " << tempregvar << ", " << lookuponstack(it[3],scope) << endl;
                continue;
            }
            else{
                asmFile << ident <<"not handleled +" << endl;
                continue;
            }
        }

        if(it[0] == "*"){
            if(it[1].substr(0,2) == "t_" && it[2].substr(0,2) == "t_" && it[3].substr(0,2) == "t_"){
                //
                if(allotreg.count(it[3]) == 0){
                    allotreg[it[3]] = getreg();
                }
                asmFile << ident << "movq " << allotreg[it[1]] << ", " << allotreg[it[3]] << endl;
                asmFile << ident << "imulq " << allotreg[it[2]] << ", " << allotreg[it[3]] << endl;
                continue;
            }
            if(it[1].substr(0,2) == "t_" && it[2].substr(0,2) != "t_" && it[3].substr(0,2) == "t_"){
                //
                if(allotreg.count(it[3]) == 0){
                    allotreg[it[3]] = getreg();
                }
                asmFile << ident << "movq " << allotreg[it[1]] << ", " << allotreg[it[3]] << endl;
                asmFile << ident << "imulq " << lookuponstack(it[2],scope) << ", " << allotreg[it[3]] << endl;
                continue;
            }
            if(it[1].substr(0,2) != "t_" && it[2].substr(0,2) == "t_" && it[3].substr(0,2) == "t_"){
                //
                if(allotreg.count(it[3]) == 0){
                    allotreg[it[3]] = getreg();
                }
                asmFile << ident << "movq " << lookuponstack(it[1],scope) << ", " << allotreg[it[3]] << endl;
                asmFile << ident << "imulq " << allotreg[it[2]] << ", " << allotreg[it[3]] << endl;
                continue;
            }
            if(it[1].substr(0,2) != "t_" && it[2].substr(0,2) != "t_" && it[3].substr(0,2) == "t_"){
                //
                string tempregvar = getreg();
                if(allotreg.count(it[3]) == 0){
                    allotreg[it[3]] = getreg();
                }
                asmFile << ident << "movq " << lookuponstack(it[1],scope) << ", " << tempregvar << endl;
                asmFile << ident << "imulq " << lookuponstack(it[2],scope) << ", " << tempregvar << endl;
                asmFile << ident << "movq " << tempregvar << ", " << allotreg[it[3]] << endl;
                continue;
            }
            if(it[1].substr(0,2) != "t_" && it[2].substr(0,2) == "t_" && it[3].substr(0,2) != "t_"){
                // asmFile << ident << "mov dword " << lookuponstack(it[3]) << ", " << allotreg[it[1]] << endl;
                asmFile << ident << "movq " << lookuponstack(it[1],scope) << ", " << "%rax" << endl;
                asmFile << ident << "mulq " << allotreg[it[2]] << endl;
                asmFile << ident << "movq " << "%rax" << ", " << lookuponstack(it[3],scope) << endl;
                continue;
            }
            if(it[1].substr(0,2) != "t_" && it[2].substr(0,2) != "t_" && it[3].substr(0,2) != "t_"){
                string tempregvar1 = getreg();
                asmFile << ident << "movq " << lookuponstack(it[1],scope) << ", " << tempregvar1 << endl;
                asmFile << ident << "movq " << lookuponstack(it[2],scope) << ", " << "%rax" << endl;
                asmFile << ident << "imulq " << tempregvar1 << endl;
                asmFile << ident << "movq " << "%rax" << ", " << lookuponstack(it[3],scope) << endl; 
                continue;
            }
            else{
                asmFile << ident <<"not handleled +" << endl;
                continue;
            }
        }

        if(it[0] == "/"){
            if(it[1].substr(0,2) == "t_" && it[2].substr(0,2) == "t_" && it[3].substr(0,2) == "t_"){
                if(allotreg.count(it[3]) == 0){
                    allotreg[it[3]] = getreg();
                }
                asmFile << ident << "movq " << allotreg[it[1]] << ", " << allotreg[it[3]] << endl;
                asmFile << ident << "idivq " << allotreg[it[2]] << ", " << allotreg[it[3]] << endl;
                continue;
            }
            if(it[1].substr(0,2) == "t_" && it[2].substr(0,2) != "t_" && it[3].substr(0,2) == "t_"){
                if(allotreg.count(it[3]) == 0){
                    allotreg[it[3]] = getreg();
                }
                asmFile << ident << "movq " << allotreg[it[1]] << ", " << allotreg[it[3]] << endl;
                asmFile << ident << "idivq " << lookuponstack(it[2],scope) << ", " << allotreg[it[3]] << endl;
                continue;
            }
            if(it[1].substr(0,2) != "t_" && it[2].substr(0,2) == "t_" && it[3].substr(0,2) == "t_"){
                if(allotreg.count(it[3]) == 0){
                    allotreg[it[3]] = getreg();
                }
                asmFile << ident << "movq " << lookuponstack(it[1],scope) << ", " << allotreg[it[3]] << endl;
                asmFile << ident << "idivq " << allotreg[it[2]] << ", " << allotreg[it[3]] << endl;
                continue;
            }
            if(it[1].substr(0,2) != "t_" && it[2].substr(0,2) != "t_" && it[3].substr(0,2) == "t_"){
                string tempregvar = getreg();
                if(allotreg.count(it[3]) == 0){
                    allotreg[it[3]] = getreg();
                }
                asmFile << ident << "movq " << lookuponstack(it[1],scope) << ", " << tempregvar << endl;
                asmFile << ident << "idivq " << lookuponstack(it[2],scope) << ", " << tempregvar << endl;
                asmFile << ident << "movq " << tempregvar << ", " << allotreg[it[3]] << endl;
                continue;
            }
            if(it[1].substr(0,2) != "t_" && it[2].substr(0,2) == "t_" && it[3].substr(0,2) != "t_"){
                // asmFile << ident << "mov dword " << lookuponstack(it[3]) << ", " << allotreg[it[1]] << endl;
                asmFile << ident << "idivq " << allotreg[it[2]] << ", " << lookuponstack(it[3],scope) << endl;
                continue;
            }
            if(it[1].substr(0,2) != "t_" && it[2].substr(0,2) != "t_" && it[3].substr(0,2) != "t_"){
                string tempregvar = getreg();
                asmFile << ident << "movq " << lookuponstack(it[1],scope) << ", " << tempregvar << endl;
                asmFile << ident << "idivq " << lookuponstack(it[2],scope) << ", " << tempregvar << endl;
                asmFile << ident << "movq " << tempregvar << ", " << lookuponstack(it[3],scope) << endl;
                continue;
            }
            else{
                asmFile << ident <<"not handleled +" << endl;
                continue;
            }
        }

        if(it[0] == "return"){
            asmFile << ident << "movq "<<it[1] << ", %rax" << endl;
            continue;
        }
        if(it[3] == "call"){
            if(it[1]=="System.out.println" || it[1]=="System.out.print"){
                asmFile << ident <<"call printf" << endl;
                continue;
            }
            asmFile << ident << "call " << it[1] << endl;
            continue;
        }
        if(it[3] == "pushparam"){
            if(codeIR[i+1][1]=="System.out.println" || codeIR[i+1][1]=="System.out.print"){
                if(it[1].substr(0,2) == "t_"){
                    asmFile << ident << "movq " << allotreg[it[1]] << ", %rsi" << endl;
                }
                else{
                    asmFile << ident << "movq " << lookuponstack(it[1],scope) << ", %rsi" << endl;
                }
                asmFile << ident << "movq $format, %rdi" << endl;
                asmFile << ident << "xorq %rax, %rax" << endl;
                continue;
            }
            if(it[1].substr(0,2) == "t_"){
                asmFile << ident << "push " << allotreg[it[1]] << endl;
                continue;
            }
            else{
                asmFile << ident << "push " << lookuponstack(it[1],scope) << endl;
                continue;
            }
        }
        asmFile << ident << "not handleled "<<it[0]<<it[1]<<it[2]<<it[3]<< endl;

    }
    for(auto itr: classcall) {
        asmFile << itr << ":" << endl;
        asmFile << ident << "push %rbp" << endl;
        asmFile << ident << "movq %rsp, %rbp" << endl;
        asmFile << ident << "movq 16(%rbp), %rax" << endl;
        asmFile << ident << "pop %rbp" << endl;
        asmFile << ident << "ret" << endl;
    }
    asmFile.close();
}



////////////

string arrOffset(char* name, int idx) {
    string offset = "";
    string atype = lookup(name);
    vector<int> nidx = {4,7,10,13,16,19};
    int limit = (atype.length()/3)-1;
    int ans = 8;
    for(int i = idx; i<limit; i++){
        ans = ans * stoi(atype.substr(nidx[i],1));
    }
    // atype.substr(4,1);
    offset = to_string(ans);
    return offset;
}

int checkArrSize(char* name) {
    string atype = lookup(name);
    int limit = (atype.length()/3)-1;
    return limit;
}

symTab* helpthislookup(symTab* checkptr, symTab* prevptr) {
    if(checkptr->parentscope == NULL){
        return prevptr;
    }
    else{
        prevptr = checkptr;
        checkptr = checkptr->parentscope;
        return helpthislookup(checkptr, prevptr);
    }
}

string thisLookup(char* ident){
    symTab* classEntry = helpthislookup(curr, NULL);
    if(classEntry != NULL){
        for (auto entry : classEntry->entries) {
            // cout<<"now checking comparision for "<<entry.first<<"!!! \n";
            if(entry.first == ident){
                if(entry.second.type == "method"){
                    // cout<<"correct fieldaccess for a method/constructor"<<"\n";
                    return entry.second.fo;
                }
                else{
                    // cout<<"correct fieldaccess for a member"<<"\n";
                    return entry.second.type;
                } 
            }   
        }
        cout<<" err : Parent class has no member called "<<string(ident)<<"\n";
        return "ERROR";
    }
    cout<<" err : Inappropriate use of this \n";
    return "ERROR"; 
}