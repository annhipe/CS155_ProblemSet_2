%option noyywrap

%{
#include <stdlib.h>
#include <stdio.h>
int lineno = 1;
void ret_print(char *token_type);
void yyerror();
%}
RESERVED_PROCEDURE	    (procedure)
RESERVED_DECLARATION	(array|node)
RESERVED_UNCONDITIONAL_TRANSFER  (go[ ]to|exit)
RESERVED_CONDITIONAL_TRANSFER	(case|else|if|then)
RESERVED_ITERATION	    (while|repeat|loop|for)
RESERVED_TO             (to)
RESERVED_BY             (by)
RESERVED_DO             (do)
RESERVED_UNTIL             (until)
RESERVED_FOREVER            (forever)
RESERVED_ENDING_BLOCKS      (endcase|endwhile|endfor)
RESERVED_IO		        (input|output)
RESERVED_CONTROL	    (call|return|stop|end)
RESERVED_BOOL	        (true|false)

OPERATOR_ASSIGNMENT    (=)
OPERATOR_ARITHMETIC	  (\+|-|\/|\*|\^)
OPERATOR_LOGICAL	    (and|or|not)
OPERATOR_RELATIONAL	  (<=|>=|!=|>|<|==)
OPERATOR_MOD		      (mod)

STRING                '([^']*)'
DELIMITER	            (\(|\)|,|;|:|'|\[|\])
INTEGER	              ([1-9][0-9]*|0)
IDENTIFIER	          ([a-zA-Z_][a-zA-Z_0-9]*)

%%
{RESERVED_PROCEDURE}     {ret_print("RESERVED_PROCEDURE"); }
{RESERVED_DECLARATION}  {ret_print("RESERVED_DECLARATION"); }
{RESERVED_UNCONDITIONAL_TRANSFER} {ret_print("RESERVED_UNCONDITIONAL_TRANSFER"); }
{RESERVED_CONDITIONAL_TRANSFER}  {ret_print("RESERVED_CONDITIONAL"); }
{RESERVED_ITERATION}    {ret_print("RESERVED_ITERATION"); }
{RESERVED_TO}    {ret_print("RESERVED_TO"); }
{RESERVED_BY}    {ret_print("RESERVED_BY"); }
{RESERVED_DO}    {ret_print("RESERVED_DO"); }
{RESERVED_UNTIL}    {ret_print("RESERVED_UNTIL"); }
{RESERVED_FOREVER}    {ret_print("RESERVED_FOREVER"); }
{RESERVED_ENDING_BLOCKS}    {ret_print("RESERVED_ENDING_BLOCKS"); }
{RESERVED_IO}           {ret_print("RESERVED_IO"); }
{RESERVED_CONTROL}      {ret_print("RESERVED_CONTROL"); }
{RESERVED_BOOL}         {ret_print("RESERVED_BOOL"); }

{OPERATOR_ASSIGNMENT}     {ret_print("OPERATOR_ASSIGNMENT"); }
{OPERATOR_ARITHMETIC}   {ret_print("OPERATOR_ARITHMETIC"); }
{OPERATOR_LOGICAL}      {ret_print("OPERATOR_LOGICAL"); }
{OPERATOR_RELATIONAL}   {ret_print("OPERATOR_RELATIONAL"); }
{OPERATOR_MOD}         {ret_print("OPERATOR_MISC"); }

{STRING}                {ret_print("STRING"); }
{DELIMITER}             {ret_print("DELIMITER"); }
{INTEGER}               {ret_print("INTEGER"); }
{IDENTIFIER}            {ret_print("IDENTIFIER"); }
"\n"                    {lineno += 1; }
[ \t\r\f]+      
.                       {yyerror("Unrecognized character"); }    
%%

void ret_print(char *token_type){
    printf("<%s,%s>\n", token_type, yytext);
}

void yyerror(char *message){
    printf("########## TOKEN NOT RECOGNIZED \"%s\" ##########\n", yytext);

}


int main(int argc, char *argv[]){
  yyin = fopen(argv[1], "r");
  yylex();
  fclose(yyin);
  return 0;
}
