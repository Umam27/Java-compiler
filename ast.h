#include<bits/stdc++.h>
using namespace std;


extern int nodeNum;

class ASTnode{
    public:
        int num; // used in join
        string alpha;
        string id;

        ASTnode(int n, string s) : num(n), alpha(s), id("") {}
        ASTnode(int n, string s, string i_d) : num(n), alpha(s), id(i_d) {}
};

typedef list<ASTnode *> ASTnodes;

void nodeJoin(ASTnode *parent, ASTnode *child);

void nodeJoinToList(ASTnode *child, list<ASTnode*> *lst);

void listJoin(list<ASTnode*>* l1, list<ASTnode*> *l2);

void nodeToTerminal(ASTnode *node, string lexeme, string token);

