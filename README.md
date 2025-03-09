# Logic Expression Parser & Calculator in OCaml  

This project is a parser for both logical expressions and simple mathematical calculations written in OCaml.  

## Features  
- Parses logical expressions with operators like implication (`->`), conjunction (`/\`), disjunction (`\/`), and negation (`~`).
- Parses simple arithmetic expressions such as addition (`+`), subtraction (`-`), multiplication (`*`), and division (`/`).

## Build and Run Instructions  

### 1. Generate the Lexer and Parser  
```sh
ocamllex lexer.mll
menhir Grammar.mly
```
### 2. Compile the project
```sh
ocamlc -o main.byte ast.ml grammar.ml lexer.ml main.ml
```
### 3. Compile the Interface File
```sh
ocamlc -c grammar.mli
```
### 4. Recompile and Run
```sh
ocamlc -o main.byte ast.ml grammar.ml lexer.ml main.ml
ocamlrun main.byte
```

## Examples of use

```py
p0 -> ((p0 -> p1) -> p1)
- EBinOp(->, EVar(p0), EBinOp(->, EBinOp(->, EVar(p0), EVar(p1)), EVar(p1)))

p0 \/ (p1 /\ p2)  
- EBinOp(\/, EVar(p0), EBinOp(/\, EVar(p1), EVar(p2)))

~p3
- EUnOp(~, EVar(p3))

~(p0 -> ((p1 \/ p2) /\ p3))
- EUnOp(~, EBinOp(->, EVar(p0), EBinOp(/\, EBinOp(\/, EVar(p1), EVar(p2)), EVar(p3))))

3 * 4 + 5
- EBinOp(+, EBinOp(*, EInt(3), EInt(4)), EInt(5))

3 * (4 + 5)
- EBinOp(*, EInt(3), EBinOp(+, EInt(4), EInt(5)))
```
