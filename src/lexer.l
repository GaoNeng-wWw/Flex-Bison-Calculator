%{
#include "parser.tab.h"
%}

%%
[0-9]+                  { yylval.NUM = atoi(yytext); return NUMBER; }
[ \t]                   ; /* 忽略空格和制表符 */
\n                      { return EOL; }
.                       { return yytext[0]; }
%%

int yywrap() {
    return 1;
}