import java_cup.runtime.*;

%%
/* ----------------- Options and Declarations Section----------------- */

/*
   The name of the class JFlex will create will be Scanner.
   Will write the code to the file Scanner.java.
*/
%class Scanner

/*
  The current line number can be accessed with the variable yyline
  and the current column number with the variable yycolumn.
*/
%line
%column

/*
   Will switch to a CUP compatibility mode to interface with a CUP
   generated parser.
*/
%cup
%unicode

/*
  Declarations
*/

%{
    /* The following two methods create java_cup.runtime.Symbol objects */
    private Symbol symbol(int type) {
       return new Symbol(type, yyline, yycolumn);
    }
    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }
%}

/*
  Macro Declarations

  These declarations are regular expressions that will be used latter
  in the Lexical Rules Section.
*/

WhiteSpace     = [ \t\r\n\f]  //classic regexes for common entities
Letter         = [a-zA-Z]
Digit          = [0-9]
Id             = {Letter}({Letter}|{Digit})*
EscapeChars    = \"([^\"\\]|\\.)*\"

%%
/* ------------------------Lexical Rules Section---------------------- */

<YYINITIAL> {

/* operators */
    "+"            { return symbol(sym.PLUS); }
    "("            { return symbol(sym.LPAREN); }
    ")"            { return symbol(sym.RPAREN); }
    ";"            { return symbol(sym.SEMI); }
    ","            { return symbol(sym.COMMA); }
    "="            { return symbol(sym.EQ); }
    "{"            { return symbol(sym.LBRACE); }
    "}"            { return symbol(sym.RBRACE); }

    /* keywords */
    "def"          { return symbol(sym.DEF); }
    "if"           { return symbol(sym.IF); }
    "else"         { return symbol(sym.ELSE); }
    "reverse"      { return symbol(sym.REV); }
    "prefix"       { return symbol(sym.PRE); }
    "suffix"       { return symbol(sym.SUF); }


    {Id}           { return symbol(sym.ID, yytext()); }
    {EscapeChars} { return symbol(sym.STRING, yytext()); }

    {WhiteSpace} { /* just skip what was found, do nothing */ }

    /* No token was found for the input so through an error.  Print out an
    Illegal character message with the illegal character that was found. */
    [^]                    { throw new Error("Illegal character <"+yytext()+">"); }
}
