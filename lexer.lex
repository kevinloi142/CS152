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

"function"    {NumColumns += yyleng; return FUNCTION;}
"beginparams" {NumColumns += yyleng; return BEGIN_PARAMS;}
"endparams"  {NumColumns += yyleng; return END_PARAMS;}
"beginlocals" {NumColumns += yyleng; return BEGIN_LOCALS;}
"endlocals"  {NumColumns += yyleng; return END_LOCALS;}
"beginbody" {NumColumns += yyleng; return BEGIN_BODY;}
"endbody"  {NumColumns += yyleng; return END_BODY;}
"integer"  {NumColumns += yyleng; return INTEGER;}
"array"  {NumColumns += yyleng; return ARRAY;}
"of"      {NumColumns += yyleng; return OF;}
"if"      {NumColumns += yyleng; return IF;}
"then"     {NumColumns += yyleng; return THEN;}
"endif"    {NumColumns += yyleng; return ENDIF;}
"else"     {NumColumns += yyleng; return ELSE;}
"while"    {NumColumns += yyleng; return WHILE;}
"do"       {NumColumns += yyleng; return DO;}
"beginloop" {NumColumns += yyleng; return BEGINLOOP;}
"endloop"   {NumColumns += yyleng; return ENDLOOP;}
"continue"   {NumColumns += yyleng; return CONTINUE;}
"read"      {NumColumns += yyleng; return READ;}
"write"    {NumColumns += yyleng; return WRITE;}
"and"     {NumColumns += yyleng; return AND;}
"or"      {NumColumns += yyleng; return OR;}
"not"     {NumColumns += yyleng; return NOT;}
"true"     {NumColumns += yyleng; return TRUE;}
"false"    {NumColumns += yyleng; return FALSE;}
"return"    {NumColumns += yyleng; return RETURN;}


"-"      {NumColumns += yyleng; return SUB;}
"+"      {NumColumns += yyleng; return PLUS;}
"*"      {NumColumns += yyleng; return MULT;}
"/"      {NumColumns += yyleng; return DIV;}
"%"      {NumColumns += yyleng; return MOD;}
"=="     {NumColumns += yyleng; return EQ;}


{id}      { /*yylval.op_val = new std::string(yytext);*/ printf("ident -> IDENT %s\n",yytext); return IDENT; NumColumns += yyleng;}
{number}    { /*yylval.int_val = atoi(yytext);*/ return NUMBER; NumColumns += yyleng;}


"<>"     {NumColumns += yyleng; return NEQ;}
"<"       {NumColumns += yyleng; return LT;}
">"       {NumColumns += yyleng; return GT;}
"<="      {NumColumns += yyleng; return LTE;}
">="      {NumColumns += yyleng; return GTE;}
";"       {NumColumns += yyleng; return SEMICOLON;}
":"       {NumColumns += yyleng; return COLON;}
","       {NumColumns += yyleng; return COMMA;}
"("       {NumColumns += yyleng; return L_PAREN;}
")"       {NumColumns += yyleng; return R_PAREN;}
"["       {NumColumns += yyleng; return L_SQUARE_BRACKET;}
"]"       {NumColumns += yyleng; return R_SQUARE_BRACKET;}
":="      {NumColumns += yyleng; return ASSIGN;}
"##"[^\n]*   printf(""); NumColumns += yyleng;
" "      printf(""); NumColumns += yyleng;
"\t"      printf(""); NumColumns += yyleng;
"\n"      printf(""); NumLines += yyleng; NumColumns = 1;

{idError}       printf("Error at line %d, column %d: identifier \"%s\" must begin with a letter\n", NumLines, NumColumns, yytext); return;
{underscoreFirst}    printf("Error at line %d, column %d: identifier \"%s\" must begin with a letter\n", NumLines, NumColumns, yytext); return;
{underscoreLast} printf("Error at line %d, column %d: identifier \"%s\" cannot end with an underscore\n", NumLines, NumColumns, yytext); return;
. printf("Error at line %d, column %d: unrecognized symbol \"%s\"\n", NumLines, NumColumns, yytext); return;

%%