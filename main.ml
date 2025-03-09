open Printf
open Ast

let main =
  let lexbuf = Lexing.from_channel stdin in
  let res =
    try Grammar.main Lexer.token lexbuf
    with
    | Lexer.Error c ->
       fprintf stderr "Lexical error at line %d: Unknown character '%c'\n"
         lexbuf.lex_curr_p.pos_lnum c;
       exit 1
    | Grammar.Error ->
       fprintf stderr "Parse error at line %d:\n" lexbuf.lex_curr_p.pos_lnum;
       exit 1
  in
    Printf.printf "%s\n" (pprint_expr res)