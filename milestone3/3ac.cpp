#include <bits/stdc++.h>
using namespace std;

vector<vector<string>> codeIR;

void printIR(){
    string fn;
    fn = "output3AC/3ac.txt";
    std::ofstream irFile(fn);
    cout<<"\n\nIR Code:"<<endl;
    string temp;
    temp = "";
    int line = -1;
    for(auto it : codeIR){
        line++;
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
        return 4;
    }
    if(type == "float"){
        return 4;
    }
    if(type == "double"){
        return 8;
    }
    if(type == "char"){
        return 1;
    }
    if(type == "boolean"){
        return 1;
    }
    if(type == "string"){
        return 4;
    }
    return 0;
}

string insertLabel(){
    static int count = 0;
    string label = "l_" + to_string(count);
    vector<string> temp;
    temp.push_back("label");
    temp.push_back("");
    temp.push_back(label);
    temp.push_back("");
    codeIR.push_back(temp);
    return label;
}