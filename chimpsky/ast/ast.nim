{.experimental: "codeReordering".}

import ../token/token

type
  Node* = ref object of RootObj
    getTokenLiteral*: proc: string

type
  Statement* = ref object of Node

proc statementNode*(self: Statement): void = discard

type
  Expression* = ref object of Node

proc expessionNode*(self: Expression): void = discard

type
  Program* = ref object of Node
    statements*: seq[Statement]

proc getTokenLiteral*(self: Program): string =
  if len(self.statements) > 0:
    return self.statements[0].getTokenLiteral()

  return ""

type
  LetStatement* = ref object of Statement
    Token*: token.Token
    Name*: Identifier
    Value*: Expression

proc getTokenLiteral*(self: LetStatement): string =
  return self.Token.Literal

type
  Identifier* = ref object of Expression
    Token*: token.Token
    Value*: string

proc getTokenLiteral*(self: Identifier): string =
  return self.Token.Literal