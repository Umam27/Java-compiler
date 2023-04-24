#include <bits/stdc++.h>
using namespace std;

vector<vector<string>> codeIR;

void printIR(){
    string fn = "output3AC/3ac.txt";
    std::ofstream irFile(fn);
    string fnv = "output3AC/3acvector.txt";
    std::ofstream irvFile(fnv);
    cout<<"\n\nIR Code:"<<endl;
    string temp;
    temp = "";
    int line = -1;
    for(auto it : codeIR){
        line++;
        if(it[0] == ""){
            it[0] = " ";
        }
        if(it[1] == ""){
            it[1] = " ";
        }
        if(it[2] == ""){
            it[2] = " ";
        }
        if(it[3] == ""){
            it[3] = " ";
        }
        irvFile << it[0] << ";" << it[1] << ";" << it[2] << ";" << it[3] << endl;

        if(it[0] == "="){
            cout << line << ":" << temp << it[3] << " = " << it[1] << endl;
            irFile << temp << it[3] << " = " << it[1] << endl;
            continue;
        }
        if(it[0] == "!"){
            cout << line << ":" << temp << it[3] << " = " << it[0] << " " << it[1] << endl;
            irFile << temp << it[3] << " = " << it[0] << " " << it[1] << endl;
            continue;
        }
        if(it[0] == "~"){
            cout << line << ":" << temp << it[3] << " = " << it[0] << " " << it[1] << endl;
            irFile << temp << it[3] << " = " << it[0] << " " << it[1] << endl;
            continue;
        }
        if(it[0] == "+ve"){
            cout << line << ":" << temp << it[3] << " = " << "+" << " " << it[1] << endl;
            irFile << temp << it[3] << " = " << "+" << " " << it[1] << endl;
            continue;
        }
        if(it[0] == "-ve"){
            cout << line << ":" << temp << it[3] << " = " << "-" << " " << it[1] << endl;
            irFile << temp << it[3] << " = " << "-" << " " << it[1] << endl;
            continue;
        }
        if(it[3] == "if"){
            cout << line << ":" << temp << it[3] << " " << it[1] << " " << it[0] << " " << it[2] << endl;
            irFile << temp << it[3] << " " << it[1] << " " << it[0] << " " << it[2] << endl;
            continue;
        }
        if(it[0] == "goto"){
            cout << line << ":" << temp << it[0] << " " << it[2] << endl;
            irFile << temp << it[0] << " " << it[2] << endl;
            continue;
        }
        if(it[0] == "classend" || it[0] == "ENDP") {
            temp = temp.substr(0,temp.length()-4);
            cout << line << ":" << temp << it[0] << " " << it[1] << endl;
            irFile << temp << it[0] << " " << it[1] << endl;
            continue;
        }
        if(it[0] == "classstart" || it[0] == "PROC" ) {
            cout << line << ":" << temp << it[0] << " " << it[1] << endl;
            irFile << temp << it[0] << " " << it[1] << endl;
            temp = temp + "    ";
            continue;
        }
        if(it[0] == "" && it[1] == "" && it[2] == ""){
            cout << line << ":" << temp << it[3] << endl;
            irFile << temp << it[3] << endl;
            continue;
        }
        if(it[0] == "return"){
            cout << line << ":" << temp << it[0] <<" "<< it[1] << endl;
            irFile << temp << it[0] <<" "<< it[1] << endl;
            continue;
        }
        if(it[3] == "call"){
            cout << line << ":" << temp << it[3] << " " << it[1] << endl;
            irFile << temp << it[3] << " " << it[1] << endl;
            continue;
        }
        if(it[3]=="pushparam"){
            cout << line << ":" << temp << it[3] << " " << it[1] << endl;
            irFile << temp << it[3] << " " << it[1] << endl;
            continue;
        }
        cout << line << ":" << temp << it[3] << " = " << it[1] << " " << it[0] << " " << it[2] << endl;
        irFile << temp << it[3] << " = " << it[1] << " " << it[0] << " " << it[2] << endl;
    }
    irFile.close();
    irvFile.close();
}

string makeNew(){
    static int count = 0;
    string temp = "t_" + to_string(count);
    count++;
    return temp;
}

string insertIR(string op, string arg1, string arg2, string res){
    vector<string> temp;
    temp.push_back(op);
    temp.push_back(arg1);
    temp.push_back(arg2);
    if(res=="newvar"){
        res = makeNew();
        temp.push_back(res);
    }
    else {
        temp.push_back(res);
    } 
    codeIR.push_back(temp);
    return res;
}

int lineIR(){
    return codeIR.size();
}

void fillGoto(int line, int label){
    codeIR[line][2] = to_string(label);
}

int byteSize(string type){
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

// string insertLabel(){
//     static int count = 0;
//     string label = "label_" + to_string(count);
//     count++;
//     return label;
// }

// string getreg(){
//     static int count = -1;
//     count++;
//     if(count%12 == 0){
//         return "rax";
//     }
//     if(count%12 == 1){
//         return "rbx";
//     }
//     if(count%12 == 2){
//         return "rcx";
//     }
//     if(count%12 == 3){
//         return "rdx";
//     }
//     if(count%12 == 4){
//         return "r8";
//     }
//     if(count%12 == 5){
//         return "r9";
//     }
//     if(count%12 == 6){
//         return "r10";
//     }
//     if(count%12 == 7){
//         return "r11";
//     }
//     if(count%12 == 8){
//         return "r12";
//     }
//     if(count%12 == 9){
//         return "r13";
//     }
//     if(count%12 == 10){
//         return "r14";
//     }
//     else{
//         return "r15";
//     }
// }

// string lookuponstack(string var){
//     return "[69 " + var + " ]";
// }

// //the following function reads the ir[][] which is 3ac code and generates the assembly code (x86) and stores it in the file "assembly.txt"
// void generateAssembly(){
//     //first iteration through the codeIR to find labels for goto statements
//     unordered_map<int, string> labelMap;
//     for(int i=0; i<codeIR.size(); i++){
//         vector<string> it = codeIR[i];
//         if(it[0] == "goto"){
//             if(labelMap.count(stoi(it[2])) == 0){
//                 labelMap[stoi(it[2])] = insertLabel();
//             }
//         }
//     }

//     unordered_map<string, string> allotreg;

//     ofstream asmFile;
//     asmFile.open("assembly.txt");
//     string cmpvar;
    
//     for(int i=0; i<codeIR.size(); i++){
//         vector<string> it = codeIR[i];
//         if(labelMap.count(i) == 1){
//             asmFile << labelMap[i] << ":\n";
//         }
//         if(it[0] == "classstart"){
//             asmFile << it[1] << ":" << endl;
//             continue;
//         }
//         if(it[0] == "classend"){
//             asmFile << endl;
//             continue;
//         }
//         if(it[0] == "PROC"){
//             asmFile << it[1] << ":" << endl;
//             continue;
//         }
//         if(it[0] == "ENDP"){
//             asmFile << endl;
//             continue;
//         }
//         if(it[3] == "ret"){
//             asmFile << "ret" << endl;
//             continue;
//         }
//         if(it[0] == "goto"){
//             if(it[3]!="if")asmFile << "jmp " << labelMap[stoi(it[2])] << endl;
//             else{
//                 asmFile << cmpvar << " " << labelMap[stoi(it[2])] << endl;
//             }
//             continue;
//         }
        
//         // remove the creation of a new variable because of use of cmp directly
//         // comparators:
//         // je <label> (jump when equal)
//         // jne <label> (jump when not equal)
//         // jz <label> (jump when last result was zero)
//         // jg <label> (jump when greater than)
//         // jge <label> (jump when greater than or equal to)
//         // jl <label> (jump when less than)
//         // jle <label> (jump when less than or equal to)

//         if(it[0] == "=="){
//             cmpvar = "je";
//             asmFile << "cmp " << it[1] << "," << it[2] << endl;
//             continue;
//         }
//         if(it[0] == "!="){
//             cmpvar = "jne";
//             asmFile << "cmp " << it[1] << "," << it[2] << endl;
//             continue;
//         }
//         if(it[0] == ">"){
//             cmpvar = "jg";
//             asmFile << "cmp " << it[1] << "," << it[2] << endl;
//             continue;
//         }
//         if(it[0] == "<"){
//             cmpvar = "jl";
//             asmFile << "cmp " << it[1] << "," << it[2] << endl;
//             continue;
//         }
//         if(it[0] == ">="){
//             cmpvar = "jge";
//             asmFile << "cmp " << it[1] << "," << it[2] << endl;
//             continue;
//         }
//         if(it[0] == "<="){
//             cmpvar = "jle";
//             asmFile << "cmp " << it[1] << "," << it[2] << endl;
//             continue;
//         }
        
//         if(it[3] == "push ebp"){
//             asmFile << "push ebp" << endl;
//             continue;
//         }
//         if(it[3] == "pop ebp (restore original basepointer)"){
//             asmFile << "pop ebp" << endl;
//             continue;
//         }
//         if(it[3] == "push esi,edi (saving the values of the register the function might modify)"){
//             asmFile << "push edi" << endl;
//             asmFile << "push esi" << endl;
//             continue;
//         }

//         if(it[3] == "mov ebp,esp"){
//             asmFile << "mov ebp, esp" << endl;
//             continue;
//         }
//         if(it[3] == "mov esp,ebp"){
//             asmFile << "mov esp, ebp" << endl;
//             continue;
//         }
//         if(it[3] == "pop to recover register values esi,edi"){
//             asmFile << "pop esi" << endl;
//             asmFile << "pop edi" << endl;
//             continue;
//         }

//         // perform lookup for location of it[3] and it[1] on stack
//         if(it[0] == "=" && it[2] == ""){
//             if(it[3] == "set eax to return value"){
//                 asmFile << "mov dword eax, " << allotreg[it[1]] << endl;
//                 continue;
//             }
//             else{
//                 if(it[1].substr(0,2) == "t_" && it[3].substr(0,2) == "t_"){
//                     if(allotreg.count(it[3]) == 0){
//                         allotreg[it[3]] = getreg();
//                     }
//                     asmFile << "mov dword " << allotreg[it[3]] << ", " << allotreg[it[1]] << endl;
//                     continue;
//                 }
//                 if(it[1].substr(0,2) == "t_" && it[3].substr(0,2) != "t_"){
//                     asmFile << "mov dword " << lookuponstack(it[3]) << ", " << allotreg[it[1]] << endl;
//                     continue;
//                 }
//                 if(it[1].substr(0,2) != "t_" && it[3].substr(0,2) == "t_"){
//                     if(allotreg.count(it[3]) == 0){
//                         allotreg[it[3]] = getreg();
//                     }
//                     asmFile << "mov dword " << allotreg[it[3]] << ", " << lookuponstack(it[1]) << endl;
//                     continue;
//                 }
//                 else{
//                     asmFile << "mov dword " << lookuponstack(it[3]) << ", " << lookuponstack(it[1]) << endl;
//                     continue;
//                 }
//             }
//         }

//         //stack pointer manpulation
//         if(it[3] == "stackptr"){
//             if(it[0] == "+"){
//                 asmFile << "add esp, " << it[2] << endl;
//                 continue;
//             }
//             if(it[0] == "-"){
//                 asmFile << "sub esp, " << it[2] << endl;
//                 continue;
//             }
//             else{
//                 asmFile<<"stackptr me gochi"<<endl;
//             }
//         }


//         //arithmetic operations
//         if(it[0] == "+"){
//             if(it[1].substr(0,2) == "t_" && it[2].substr(0,2) == "t_" && it[3].substr(0,2) == "t_"){
//                 if(allotreg.count(it[3]) == 0){
//                     allotreg[it[3]] = getreg();
//                 }
//                 asmFile << "mov dword " << allotreg[it[3]] << ", " << allotreg[it[1]] << endl;
//                 asmFile << "add dword " << allotreg[it[3]] << ", " << allotreg[it[2]] << endl;
//                 continue;
//             }
//             if(it[1].substr(0,2) == "t_" && it[2].substr(0,2) != "t_" && it[3].substr(0,2) == "t_"){
//                 if(allotreg.count(it[3]) == 0){
//                     allotreg[it[3]] = getreg();
//                 }
//                 asmFile << "mov dword " << allotreg[it[3]] << ", " << allotreg[it[1]] << endl;
//                 asmFile << "add dword " << allotreg[it[3]] << ", " << lookuponstack(it[2]) << endl;
//                 continue;
//             }
//             if(it[1].substr(0,2) != "t_" && it[2].substr(0,2) == "t_" && it[3].substr(0,2) == "t_"){
//                 if(allotreg.count(it[3]) == 0){
//                     allotreg[it[3]] = getreg();
//                 }
//                 asmFile << "mov dword " << allotreg[it[3]] << ", " << lookuponstack(it[1]) << endl;
//                 asmFile << "add dword " << allotreg[it[3]] << ", " << allotreg[it[2]] << endl;
//                 continue;
//             }
//             if(it[1].substr(0,2) != "t_" && it[2].substr(0,2) != "t_" && it[3].substr(0,2) == "t_"){
//                 if(allotreg.count(it[3]) == 0){
//                     allotreg[it[3]] = getreg();
//                 }
//                 asmFile << "mov dword " << allotreg[it[3]] << ", " << lookuponstack(it[1]) << endl;
//                 asmFile << "add dword " << allotreg[it[3]] << ", " << lookuponstack(it[2]) << endl;
//                 continue;
//             }
//             if(it[1].substr(0,2) != "t_" && it[2].substr(0,2) == "t_" && it[3].substr(0,2) != "t_"){
//                 // asmFile << "mov dword " << lookuponstack(it[3]) << ", " << allotreg[it[1]] << endl;
//                 asmFile << "add dword " << lookuponstack(it[3]) << ", " << allotreg[it[2]] << endl;
//                 continue;
//             }
//             if(it[1].substr(0,2) != "t_" && it[2].substr(0,2) != "t_" && it[3].substr(0,2) != "t_"){
//                 string tempregvar = getreg();
//                 asmFile << "mov dword " << tempregvar << ", " << lookuponstack(it[1]) << endl;
//                 asmFile << "add dword " << tempregvar << ", " << lookuponstack(it[2]) << endl;
//                 asmFile << "mov dword " << lookuponstack(it[3]) << ", " << tempregvar << endl;
//                 continue;
//             }
//             else{
//                 asmFile <<"not handleled +" << endl;
//                 continue;
//             }
//         }
//         if(it[0] == "-"){
//             if(it[1].substr(0,2) == "t_" && it[2].substr(0,2) == "t_" && it[3].substr(0,2) == "t_"){
//                 if(allotreg.count(it[3]) == 0){
//                     allotreg[it[3]] = getreg();
//                 }
//                 asmFile << "mov dword " << allotreg[it[3]] << ", " << allotreg[it[1]] << endl;
//                 asmFile << "sub dword " << allotreg[it[3]] << ", " << allotreg[it[2]] << endl;
//                 continue;
//             }
//             if(it[1].substr(0,2) == "t_" && it[2].substr(0,2) != "t_" && it[3].substr(0,2) == "t_"){
//                 if(allotreg.count(it[3]) == 0){
//                     allotreg[it[3]] = getreg();
//                 }
//                 asmFile << "mov dword " << allotreg[it[3]] << ", " << allotreg[it[1]] << endl;
//                 asmFile << "sub dword " << allotreg[it[3]] << ", " << lookuponstack(it[2]) << endl;
//                 continue;
//             }
//             if(it[1].substr(0,2) != "t_" && it[2].substr(0,2) == "t_" && it[3].substr(0,2) == "t_"){
//                 if(allotreg.count(it[3]) == 0){
//                     allotreg[it[3]] = getreg();
//                 }
//                 asmFile << "mov dword " << allotreg[it[3]] << ", " << lookuponstack(it[1]) << endl;
//                 asmFile << "sub dword " << allotreg[it[3]] << ", " << allotreg[it[2]] << endl;
//                 continue;
//             }
//             if(it[1].substr(0,2) != "t_" && it[2].substr(0,2) != "t_" && it[3].substr(0,2) == "t_"){
//                 if(allotreg.count(it[3]) == 0){
//                     allotreg[it[3]] = getreg();
//                 }
//                 asmFile << "mov dword " << allotreg[it[3]] << ", " << lookuponstack(it[1]) << endl;
//                 asmFile << "sub dword " << allotreg[it[3]] << ", " << lookuponstack(it[2]) << endl;
//                 continue;
//             }
//             if(it[1].substr(0,2) != "t_" && it[2].substr(0,2) == "t_" && it[3].substr(0,2) != "t_"){
//                 // asmFile << "mov dword " << lookuponstack(it[3]) << ", " << allotreg[it[1]] << endl;
//                 asmFile << "sub dword " << lookuponstack(it[3]) << ", " << allotreg[it[2]] << endl;
//                 continue;
//             }
//             if(it[1].substr(0,2) != "t_" && it[2].substr(0,2) != "t_" && it[3].substr(0,2) != "t_"){
//                 string tempregvar = getreg();
//                 asmFile << "mov dword " << tempregvar << ", " << lookuponstack(it[1]) << endl;
//                 asmFile << "sub dword " << tempregvar << ", " << lookuponstack(it[2]) << endl;
//                 asmFile << "mov dword " << lookuponstack(it[3]) << ", " << tempregvar << endl;
//                 continue;
//             }
//             else{
//                 asmFile <<"not handleled -" << endl;
//                 continue;
//             }
//         }

//         if(it[0] == "*"){
//             if(it[1].substr(0,2) == "t_" && it[2].substr(0,2) == "t_" && it[3].substr(0,2) == "t_"){
//                 if(allotreg.count(it[3]) == 0){
//                     allotreg[it[3]] = getreg();
//                 }
//                 asmFile << "mov dword " << allotreg[it[3]] << ", " << allotreg[it[1]] << endl;
//                 asmFile << "imul dword " << allotreg[it[3]] << ", " << allotreg[it[2]] << endl;
//                 continue;
//             }
//             if(it[1].substr(0,2) == "t_" && it[2].substr(0,2) != "t_" && it[3].substr(0,2) == "t_"){
//                 if(allotreg.count(it[3]) == 0){
//                     allotreg[it[3]] = getreg();
//                 }
//                 asmFile << "mov dword " << allotreg[it[3]] << ", " << allotreg[it[1]] << endl;
//                 asmFile << "imul dword " << allotreg[it[3]] << ", " << lookuponstack(it[2]) << endl;
//                 continue;
//             }
//             if(it[1].substr(0,2) != "t_" && it[2].substr(0,2) == "t_" && it[3].substr(0,2) == "t_"){
//                 if(allotreg.count(it[3]) == 0){
//                     allotreg[it[3]] = getreg();
//                 }
//                 asmFile << "mov dword " << allotreg[it[3]] << ", " << lookuponstack(it[1]) << endl;
//                 asmFile << "imul dword " << allotreg[it[3]] << ", " << allotreg[it[2]] << endl;
//                 continue;
//             }
//             if(it[1].substr(0,2) != "t_" && it[2].substr(0,2) != "t_" && it[3].substr(0,2) == "t_"){
//                 if(allotreg.count(it[3]) == 0){
//                     allotreg[it[3]] = getreg();
//                 }
//                 asmFile << "mov dword " << allotreg[it[3]] << ", " << lookuponstack(it[1]) << endl;
//                 asmFile << "imul dword " << allotreg[it[3]] << ", " << lookuponstack(it[2]) << endl;
//                 continue;
//             }
//             if(it[1].substr(0,2) != "t_" && it[2].substr(0,2) == "t_" && it[3].substr(0,2) != "t_"){
//                 // asmFile << "mov dword " << lookuponstack(it[3]) << ", " << allotreg[it[1]] << endl;
//                 asmFile << "imul dword " << lookuponstack(it[3]) << ", " << allotreg[it[2]] << endl;
//                 continue;
//             }
//             if(it[1].substr(0,2) != "t_" && it[2].substr(0,2) != "t_" && it[3].substr(0,2) != "t_"){
//                 string tempregvar = getreg();
//                 asmFile << "mov dword " << tempregvar << ", " << lookuponstack(it[1]) << endl;
//                 asmFile << "imul dword " << tempregvar << ", " << lookuponstack(it[2]) << endl;
//                 asmFile << "mov dword " << lookuponstack(it[3]) << ", " << tempregvar << endl;
//                 continue;
//             }
//             else{
//                 asmFile <<"not handleled *" << endl;
//                 continue;
//             }
//         }

//         if(it[0] == "/"){
//             if(it[1].substr(0,2) == "t_" && it[2].substr(0,2) == "t_" && it[3].substr(0,2) == "t_"){
//                 if(allotreg.count(it[3]) == 0){
//                     allotreg[it[3]] = getreg();
//                 }
//                 asmFile << "mov dword " << allotreg[it[3]] << ", " << allotreg[it[1]] << endl;
//                 asmFile << "idiv dword " << allotreg[it[3]] << ", " << allotreg[it[2]] << endl;
//                 continue;
//             }
//             if(it[1].substr(0,2) == "t_" && it[2].substr(0,2) != "t_" && it[3].substr(0,2) == "t_"){
//                 if(allotreg.count(it[3]) == 0){
//                     allotreg[it[3]] = getreg();
//                 }
//                 asmFile << "mov dword " << allotreg[it[3]] << ", " << allotreg[it[1]] << endl;
//                 asmFile << "idiv dword " << allotreg[it[3]] << ", " << lookuponstack(it[2]) << endl;
//                 continue;
//             }
//             if(it[1].substr(0,2) != "t_" && it[2].substr(0,2) == "t_" && it[3].substr(0,2) == "t_"){
//                 if(allotreg.count(it[3]) == 0){
//                     allotreg[it[3]] = getreg();
//                 }
//                 asmFile << "mov dword " << allotreg[it[3]] << ", " << lookuponstack(it[1]) << endl;
//                 asmFile << "idiv dword " << allotreg[it[3]] << ", " << allotreg[it[2]] << endl;
//                 continue;
//             }
//             if(it[1].substr(0,2) != "t_" && it[2].substr(0,2) != "t_" && it[3].substr(0,2) == "t_"){
//                 if(allotreg.count(it[3]) == 0){
//                     allotreg[it[3]] = getreg();
//                 }
//                 asmFile << "mov dword " << allotreg[it[3]] << ", " << lookuponstack(it[1]) << endl;
//                 asmFile << "idiv dword " << allotreg[it[3]] << ", " << lookuponstack(it[2]) << endl;
//                 continue;
//             }
//             if(it[1].substr(0,2) != "t_" && it[2].substr(0,2) == "t_" && it[3].substr(0,2) != "t_"){
//                 // asmFile << "mov dword " << lookuponstack(it[3]) << ", " << allotreg[it[1]] << endl;
//                 asmFile << "idiv dword " << lookuponstack(it[3]) << ", " << allotreg[it[2]] << endl;
//                 continue;
//             }
//             if(it[1].substr(0,2) != "t_" && it[2].substr(0,2) != "t_" && it[3].substr(0,2) != "t_"){
//                 string tempregvar = getreg();
//                 asmFile << "mov dword " << tempregvar << ", " << lookuponstack(it[1]) << endl;
//                 asmFile << "idiv dword " << tempregvar << ", " << lookuponstack(it[2]) << endl;
//                 asmFile << "mov dword " << lookuponstack(it[3]) << ", " << tempregvar << endl;
//                 continue;
//             }
//             else{
//                 asmFile <<"not handleled /" << endl;
//                 continue;
//             }
//         }

//         if(it[0] == "return"){
//             asmFile << "mov eax, " << it[1] << endl;
//             continue;
//         }
//         if(it[0] == "call"){
//             asmFile << "call " << it[1] << endl;
//             continue;
//         }
//         if(it[0] == "pushparam"){
//             asmFile << "push " << it[1] << endl;
//             continue;
//         }
//         asmFile << "not handleled "<<it[0]<<it[1]<<it[2]<<it[3]<< endl;

//     }
//     asmFile.close();
// }


