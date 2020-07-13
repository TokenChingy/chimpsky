
import ../token/token

type  
  Expression* = ref object of RootObj

proc getTokenLiteral*(self: Expression): void = discard

type
  Identifier* = ref object of RootObj
    Token*: token.Token
    Value*: string

proc getTokenLiteral*(self: Identifier): string =
  return self.Token.Literal

type
  StatementType* = enum 
    LetStatement
    Nil

  Statement* = ref object of RootObj
    Token*: token.Token

    case Kind*: StatementType
      of LetStatement:
        Name*: Identifier
        Value*: string
      of Nil:
        nil

proc getTokenLiteral*(self: Statement): string =
  return self.Token.Literal

type
  Program* = ref object of RootObj
    statements*: seq[Statement]

proc getTokenLiteral*(self: Program): string =
  if len(self.statements) > 0:
    return self.statements[0].getTokenLiteral()

  return ""