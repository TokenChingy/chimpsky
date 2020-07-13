import unittest
import ../chimpsky/ast/ast
import ../chimpsky/token/token

proc test*(): void {.inline.} =
  suite "AST":
    test "The stringified AST should be the same as the code":
      let test = "let myVar = anotherVar;"
      let program = ast.Program(
        statements: @[
          ast.Statement(
            Kind: ast.LetStatement,
            Token: token.Token(Type: token.LET, Literal: "let"),
            Name: ast.Identifier(
              Token: token.Token(Type: token.IDENT, Literal: "myVar"),
              Value: "myVar",
            ),
            Value: ast.Identifier(
              Token: token.Token(Type: token.IDENT, Literal: "anotherVar"),
              Value: "anotherVar",
            ),
          )
        ]
      )

      check(program.getString() == test)