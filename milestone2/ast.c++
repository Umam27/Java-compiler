#include<bits/stdc++.h>
#include "ast.h"

using namespace std;


void nodeJoin(ASTnode *parent, ASTnode *child){
    cout << "\"[" << parent->num << "] " << parent->alpha << "\"--\"[" << child->num << "] " << child-> alpha <<"\"" << endl;
}
void nodeToTerminal(ASTnode *node, string lexeme, string token){
    cout << "\"[" << node->num << "] " << node->alpha << "\"--\"[" << ++nodeNum << "] " << token <<"\"" << endl;
}

void nodeJoinToList(ASTnode *parent, list<ASTnode*> *lst){
    if(lst->size() == 0){
        return ;
    }
    for(auto it : *lst){
        cout << "\"[" << parent->num << "] " << parent->alpha << "\"--\"[" << it->num << "] " << it-> alpha <<"\"" << endl;
    }
}

void listJoin(ASTnodes *l1, ASTnodes *l2){
    for(auto it : *l2){
        l1->push_back(it);
    }
}

