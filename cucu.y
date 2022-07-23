%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
extern FILE *yyin, *yyout;
FILE *yout;

%}
%union
{
    int num;
    char* string;
}
%token plus minus multiply divide semi lft_brcket rght_brcket mainn print 
%token lft_crly_brcket rght_crly_brcket comma retrn assign iff wwhile els eq_op neq_op lt gt_eq gt
%token <string> ident type strings
%token <num> number

%%


program :  basic   
           |func_def 
           |func_decl
           |func_decl program
           |func_def program

basic: type mainn lft_brcket rght_brcket lft_crly_brcket func_body rght_crly_brcket  {fprintf(yout,"main function executed\n");}
          

var_decl : type ident semi      {fprintf(yout,"Variable name: %s \n",$2);}
           | type ident assign expr semi      {fprintf(yout,"Variable name: %s\n",$2);}
            | type ident assign strings semi      {fprintf(yout,"String name: %s\n",$2);}


func_decl :   type ident lft_brcket rght_brcket semi   {fprintf(yout,"Function name %s is declared\n",$2);}
            |type ident lft_brcket func_args rght_brcket semi   {fprintf(yout,"Function name %s is declared\n",$2);}
func_def : type ident lft_brcket func_args rght_brcket lft_crly_brcket  rght_crly_brcket  {fprintf(yout,"Function Name %s is defined \n",$2);}
           |type ident lft_brcket func_args rght_brcket lft_crly_brcket func_body rght_crly_brcket  {fprintf(yout,"Function Name %s is defined\n",$2);}
           |type ident lft_brcket rght_brcket lft_crly_brcket  rght_crly_brcket  {fprintf(yout,"Function Name %s \n",$2);}
           |type ident lft_brcket rght_brcket lft_crly_brcket func_body rght_crly_brcket  {fprintf(yout,"Function Name %s \n",$2);}
func_args : type ident    {fprintf(yout,"Function argument: %s \n",$2);}
            | type ident comma func_args    {fprintf(yout,"Function argument: %s \n",$2);}
func_para : ident   {fprintf(yout,"Function parameter: %s \n",$1);}
            |number  {fprintf(yout,"Function parameter: %d \n",$1);}
            |ident comma func_para {fprintf(yout,"Function parameter: %s \n",$1);}
            |number comma func_para {fprintf(yout,"Function parameter: %d \n",$1);}


func_body :    {fprintf(yout,"Function body:\n");}  stmts
printing: print lft_brcket strings rght_brcket semi  {fprintf(yout,"prints:%s\n",$3);}
stmts :     stmt    
            |stmt stmts 

stmt:       ident assign expr semi {fprintf(yout," Variable name: %s\n", $1);}
            |func_call
            |func_def
            | var_decl  
            | retrn expr semi {fprintf(yout," Return keyword\n");}
            | iff lft_brcket expr rght_brcket stmt {fprintf(yout,"If statement\n");}
            | iff lft_brcket expr rght_brcket lft_crly_brcket stmts rght_brcket {fprintf(yout,"If statement\n");}
            | iff lft_brcket expr rght_brcket stmt els stmt {fprintf(yout,"If else statements\n");} 
            | iff lft_brcket expr rght_brcket lft_crly_brcket stmts rght_crly_brcket els lft_crly_brcket stmts rght_crly_brcket {fprintf(yout,"If else statements\n");} 
            | wwhile lft_brcket expr rght_brcket stmt {fprintf(yout,"While statement\n");} 
            | wwhile lft_brcket expr rght_brcket lft_crly_brcket stmts rght_crly_brcket {fprintf(yout,"While statement\n");}  
            | expr;
            |printing
            

func_call:   ident lft_brcket rght_brcket semi  {fprintf(yout,"Function %s is called\n",$1);}
            |ident lft_brcket func_para rght_brcket semi  {fprintf(yout,"Function %s is called\n",$1);}

expr : bexpr
       | bexpr assign expr ;

bexpr : eexpr 
        | bexpr eq_op eexpr 
        | bexpr neq_op eexpr ;

eexpr : tsepr 
        | eexpr gt_eq tsepr

tsepr : addexpr
        | tsepr gt addexpr
        | tsepr lt addexpr ;

addexpr : pexpr
          | addexpr plus pexpr
          | addexpr minus pexpr
          | addexpr multiply pexpr
          | addexpr divide pexpr ;

pexpr : ident {fprintf(yout,"Variable Name:%s ",$1);} | number {fprintf(yout,"Variable Name:%d ",$1);} | lft_brcket expr rght_brcket ; 


%%
int main(int argc, char *argv[])
{
    yyin=fopen(argv[1], "r");
    yyout=fopen("Lexer.txt", "w");
    yout=fopen("Parser.txt", "w");
    yyparse();
    return 0;
}

int yyerror(char* s){
    fprintf(yout,"Error: %s\n",s);
    return 0;
}

int yywrap()
{
    return 1;
}