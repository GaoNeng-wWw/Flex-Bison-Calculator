%{
#include <stdio.h>
#include <stdlib.h>
%}

%union {
    long long NUM;
}

%token<NUM> NUMBER
%token EOL
%type<NUM> expression

%left '+' '-'
%left '*' '/'

%%

program:
    | program statement EOL
    ;

statement:
    expression { printf("Result: %d\n", $1); }
    ;

expression:
    NUMBER
    | expression '+' expression { $$=$1 + $3; }
    | expression '-' expression { $$=$1 - $3; }
    | expression '*' expression { $$=$1 * $3; }
    | expression '/' expression { $$=$1 / $3; }
    ;

%%

void yyerror(const char* s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    yyparse();
    return 0;
}