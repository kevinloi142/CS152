%option noyywrap

digit             [0-9]
number         {digit}+
id               [a-zA-Z]([a-zA-Z0-9_]*[a-zA-Z0-9])?
idError    [0-9][a-zA-Z0-9_]*
underscoreLast [a-zA-Z][a-zA-Z0-9_]*_
underscoreFirst _[a-zA-Z0-9]*

%{
        #define YY_DECL int yylex()
        #include "lexer.tab.h"
        int NumLines = 1;
        int NumColumns = 1;
%}


%%

"function"   printf("FUNCTION\n"); NumColumns += yyleng;
"beginparams" printf("BEGIN_PARAMS\n"); NumColumns += yyleng;
"endparams"  printf("END_PARAMS\n"); NumColumns += yyleng;
"beginlocals" printf("BEGIN_LOCALS\n"); NumColumns += yyleng;
"endlocals"  printf("END_LOCALS\n"); NumColumns += yyleng;
"beginbody"  printf("BEGIN_BODY\n"); NumColumns += yyleng;
"endbody"   printf("END_BODY\n"); NumColumns += yyleng;
"integer"   printf("INTEGER\n"); NumColumns += yyleng;
"array"        printf("ARRAY\n"); NumColumns += yyleng;
"of"      printf("OF\n"); NumColumns += yyleng;
"if"      printf("IF\n"); NumColumns += yyleng;
"then"     printf("THEN\n"); NumColumns += yyleng;
"endif"    printf("ENDIF\n"); NumColumns += yyleng;
"else"     printf("ELSE\n"); NumColumns += yyleng;
"while"    printf("WHILE\n"); NumColumns += yyleng;
"do"      printf("DO\n"); NumColumns += yyleng;
"beginloop"  printf("BEGINLOOP\n"); NumColumns += yyleng;
"endloop"   printf("ENDLOOP\n"); NumColumns += yyleng;
"continue"   printf("CONTINUE\n"); NumColumns += yyleng;
"read"     printf("READ\n"); NumColumns += yyleng;
"write"    printf("WRITE\n"); NumColumns += yyleng;
"and"     printf("AND\n"); NumColumns += yyleng;
"or"      printf("OR\n"); NumColumns += yyleng;
"not"     printf("NOT\n"); NumColumns += yyleng;
"true"     printf("TRUE\n"); NumColumns += yyleng;
"false"    printf("FALSE\n"); NumColumns += yyleng;
"return"    printf("RETURN\n"); NumColumns += yyleng;


"-"      printf("SUB\n"); NumColumns += yyleng;
"+"      printf("ADD\n"); NumColumns += yyleng;
"*"      printf("MULT\n"); NumColumns += yyleng;
"/"      printf("DIV\n"); NumColumns += yyleng;
"%"      printf("MOD\n"); NumColumns += yyleng;
"=="      printf("EQ\n"); NumColumns += yyleng;


{id}      printf("IDENT %s\n", yytext); NumColumns += yyleng;
{number}    printf("NUMBER %s\n", yytext); NumColumns += yyleng;


"<>"      printf("NEQ\n"); NumColumns += yyleng;
"<"      printf("LT\n"); NumColumns += yyleng;
">"      printf("GT\n"); NumColumns += yyleng;
"<="      printf("LTE\n"); NumColumns += yyleng;
">="      printf("GTE\n"); NumColumns += yyleng;
";"      printf("SEMICOLON\n"); NumColumns += yyleng;
":"      printf("COLON\n"); NumColumns += yyleng;
","      printf("COMMA\n"); NumColumns += yyleng;
"("      printf("L_PAREN\n"); NumColumns += yyleng;
")"      printf("R_PAREN\n"); NumColumns += yyleng;
"["      printf("L_SQUARE_BRACKET\n"); NumColumns += yyleng;
"]"      printf("R_SQUARE_BRACKET\n"); NumColumns += yyleng;
":="      printf("ASSIGN\n"); NumColumns += yyleng;
"##"[^\n]*   printf(""); NumColumns += yyleng;
" "      printf(""); NumColumns += yyleng;
"\t"      printf(""); NumColumns += yyleng;
"\n"      printf(""); NumLines += yyleng; NumColumns = 1;

{idError}       printf("Error at line %d, column %d: identifier \"%s\" must begin with a letter\n", NumLines, NumColumns, yytext); return;
{underscoreFirst}    printf("Error at line %d, column %d: identifier \"%s\" must begin with a letter\n", NumLines, NumColumns, yytext); return;
{underscoreLast} printf("Error at line %d, column %d: identifier \"%s\" cannot end with an underscore\n", NumLines, NumColumns, yytext); return;
. printf("Error at line %d, column %d: unrecognized symbol \"%s\"\n", NumLines, NumColumns, yytext); return;

%%

main() {
    printf("Input your code\n");
    yylex();
    return;
}