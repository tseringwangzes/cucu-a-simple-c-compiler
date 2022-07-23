%{
#include <stdio.h>
#include<stdlib.h> 
#include "cucu.tab.h"

%}


%%

"void"|"int"|"char*" {yylval.string=strdup(yytext);  fprintf(yyout, "TYPE : %s\n", yytext); return type;}
main  {fprintf(yyout, "_KEYWORD : %s\n", yytext); return mainn;}
return {fprintf(yyout, "_KEYWORD : %s\n", yytext); return retrn;}
while {fprintf(yyout, "WHILE_KEYWORD : %s\n", yytext); return wwhile;}
if {fprintf(yyout, "IF_KEYWORD : %s\n", yytext); return iff;}
else {fprintf(yyout, "ELSE_KEYWORD : %s\n", yytext); return els;}
printf {fprintf(yyout, "_KEYWORD : %s\n", yytext); return print;}
[0-9]+ {yylval.num=atoi(yytext);  fprintf(yyout,"NUM : %s\n", yytext); return number;}
[a-zA-Z_][a-zA-Z0-9_]* {yylval.string = strdup(yytext);  fprintf(yyout,"ID : %s\n", yytext); return ident;}
= {fprintf(yyout, "ASSIGN : %s\n", yytext); return assign;}
== {fprintf(yyout, "RELATIONAL_EQUAL : %s\n", yytext); return eq_op;}
!= {fprintf(yyout, "RELATIONAL_NOT_EQUAL : %s\n", yytext); return neq_op;}
[,] {fprintf(yyout, "COMMA : %s\n", yytext); return comma;}
[\>]\[=]  {fprintf(yyout, "GREATER_THAN_EQUAL:%s",yytext); return gt_eq ;}
[\<]  {fprintf(yyout, "LESS_THAN_EQUAL:%s",yytext); return lt ;}
[\>]  {fprintf(yyout, "LESS_THAN_EQUAL:%s",yytext); return gt ;}
\+ {fprintf(yyout, "PLUS : %s\n", yytext);  return plus;}
\- {fprintf(yyout, "MINUS : %s\n", yytext); return minus;}
\* {fprintf(yyout, "MULTIPLY : %s\n", yytext); return multiply;}
\/ {fprintf(yyout, "DIVIDE : %s\n", yytext); return divide;}
\{ {fprintf(yyout, "LEFT_CURLY_BRACKET : %s\n", yytext); return lft_crly_brcket;}
\} {fprintf(yyout, "RIGHT_CURLY_BRACKET : %s\n", yytext); return rght_crly_brcket;}
\( {fprintf(yyout, "0PEN_BRACKET : %s\n", yytext); return lft_brcket;}
\) {fprintf(yyout, "CLOSE_BRACKET : %s\n", yytext); return rght_brcket;}
[;] {fprintf(yyout, "SEMI : %s\n", yytext); return semi;}
["].*["] {yylval.string=strdup(yytext); fprintf(yyout, "STRINGS : %s\n", yytext); return strings;}
[ \t\n]   {;}
\/\/.* {;}
\/\*(.*\n)*.*\*\/  {;}
%%
