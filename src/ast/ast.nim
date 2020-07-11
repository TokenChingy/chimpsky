{.experimental: "codeReordering".}

import ../token/token

type
  Node* = ref object of RootObj

proc getTokenLiteral*(self: Node): string = discard

type
  Expression* = ref object of Node

proc expressionNode*(self: Expression) = discard

type
  Statement* = ref object of Node

proc statementNode*(self: Statement) = discard

type
  Program* = ref object of RootObj
    statements*: seq[Statement]

proc getTokenLiteral*(self: Program): string =
  if len(self.statements) > 0:
    return self.statements[0].getTokenLiteral()
  
  return ""

type
  LetStatment* = ref object of Statement
    Token: token.Token
    Name: Identifier
    Value: Expression

proc getTokenLiteral*(self: LetStatment): string =
  return self.Token.Literal

type
  Identifier = ref object of Expression
    Token: token.Token
    Value: string

proc getTokenLiteral*(self: Identifier): string =
  return self.Token.Literal