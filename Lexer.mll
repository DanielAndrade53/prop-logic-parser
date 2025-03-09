{
  open Grammar
  exception Error of char
}

let letter = ['A'-'Z'] | ['a'-'z']
let digit = ['0'-'9']
let ident = letter (letter | digit)*

let line_comment = "//" [^ '\n']*

rule token = parse
    | [' ' '\t'] | line_comment
        { token lexbuf }
    | ['\n']
        { Lexing.new_line lexbuf; token lexbuf }
    | ident as str
        { match str with
            | "true" -> TRUE
            | "false" -> FALSE
            | s -> IDENT(s)
        }
    | digit+ as lxm (**  if number found convert string to int*)
        { INT(int_of_string lxm) }
    (** Logical Symbols*)
    | "->"
        { ARROW }
    | "/\\" 
        { CONJ }
    | "\\/"   
        { DISJ }
    | "~"
        { NOT }
    (** Math Symbols*)
    | ['+']
        { ADD }
    | ['-']
        { SUB }
    | ['*']
        { MUL }
    | ['/']
        { DIV }
    (** Miscellaneous *)
    | ['(']
        { LPAREN }
    | [')']
        { RPAREN }
    | eof (** End-of-file*)
        { EOF }
    | _ as c (** Unexpected Characters *)
        { raise (Error c) }