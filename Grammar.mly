
%{
   open Ast
%}

%token <int> INT
%token <string> IDENT

%token ARROW "->"
%token CONJ "/\\"
%token DISJ "\\/"   
%token NOT "~"

%token ADD "+"
%token SUB "-"
%token MUL "*"
%token DIV "/"

%token LPAREN "("
%token RPAREN ")"

%token TRUE
%token FALSE

%token EOF

%right ARROW
%left CONJ DISJ
%left NOT

%left ADD SUB
%left MUL DIV
%nonassoc UMINUS

%type <Ast.expr> main
%type <Ast.expr> expr
%start main
(**
%type <expr> main
%type <expr> expr
%type <expr> let_expr
*)


%%

main:
  | expr EOF { $1 }

expr:
  | TRUE            { EBool(true) }
  | FALSE           { EBool(false) }
  | INT             { EInt($1) }
  | IDENT           { EVar($1) }
  | expr ADD expr   { EBinOp(BopAdd, $1, $3) }
  | expr SUB expr   { EBinOp(BopSub, $1, $3) }
  | expr MUL expr   { EBinOp(BopMul, $1, $3) }
  | expr DIV expr   { EBinOp(BopDiv, $1, $3) }
  | NOT expr        { EUnOp(UnopNot, $2) }
  | expr CONJ expr  { EBinOp(BopAnd, $1, $3) }
  | expr DISJ expr  { EBinOp(BopOr, $1, $3) }
  | expr ARROW expr { EBinOp(BopImp, $1, $3) }
  | LPAREN expr RPAREN { $2 }
  | SUB expr %prec UMINUS { EUnOp(UnopNeg, $2) }