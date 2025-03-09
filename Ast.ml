open Printf
(** open Js_of_ocaml *)

type bop = BopAdd | BopSub | BopMul | BopDiv | BopAnd | BopOr | BopImp
type uop = UnopNot | UnopNeg

type expr =
  | EInt   of int
  | EBool  of bool
  | EBinOp of bop * expr * expr
  | EUnOp  of uop * expr
  | EVar   of string
  | ELet   of string * expr * expr

let pprint_bop = function
  | BopAdd -> "+"
  | BopSub -> "-"
  | BopMul -> "*"
  | BopDiv -> "/"
  | BopAnd -> "/\\"
  | BopOr  -> "\\/"
  | BopImp -> "->"

let pprint_uop = function
  | UnopNot -> "~"
  | UnopNeg -> "-"

let rec pprint_expr = function
  | EInt(i) -> sprintf "EInt(%d)" i
  | EBool(b) -> sprintf "EBool(%b)" b
  | EVar(x) -> sprintf "EVar(%s)" x
  | EBinOp(bop, e1, e2) -> sprintf "EBinOp(%s, %s, %s)" (pprint_bop bop) (pprint_expr e1) (pprint_expr e2)
  | EUnOp(uop, e) -> sprintf "EUnOp(%s, %s)" (pprint_uop uop) (pprint_expr e)
  | ELet(x, e1, e2) -> sprintf "ELet(%s, %s, %s)" x (pprint_expr e1) (pprint_expr e2)

(**
  let _ =
    Js.export "Printer"
      (object%js
        method pprint_expr expr = Js.string (pprint_expr expr)
        method pprint_expr str = Js.string (pprint_expr (my_parser (my_lexer str)))
      end)
*)
  