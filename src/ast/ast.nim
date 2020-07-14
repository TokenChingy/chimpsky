{.experimental: "codeReordering".}

import ../token/token

type
  ExpressionType* = enum
    IdentifierExpression

  Expression* = ref object of RootObj    
    case Kind*: ExpressionType
      of IdentifierExpression:
        Identifier*: Identifier

proc getTokenLiteral*(self: Expression): void = discard

type
  Identifier* = ref object of RootObj
    Token*: token.Token
    Value*: string

proc getTokenLiteral*(self: Identifier): string =
  return self.Token.Literal

proc getString*(self: Identifier): string =
  return self.Value

type
  StatementType* = enum 
    LetStatement
    ReturnStatement
    ExpressionStatement

  Statement* = ref object of RootObj
    Token*: token.Token

    case Kind*: StatementType
      of LetStatement:
        Name*: Identifier
        Value*: Identifier
      of ReturnStatement:
        ReturnValue*: Expression
      of ExpressionStatement:
        Expression*: Expression

proc getTokenLiteral*(self: Statement): string =
  return self.Token.Literal

proc getString*(self: Statement): string =
  var value: string

  case self.Kind:
    of LetStatement:
      value &= self.getTokenLiteral() 
      value &= " "
      value &= self.Name.getString() 
      value &= " = " 
      value &= self.Value.getString()
    of ReturnStatement:
      discard
    of ExpressionStatement:
      discard

  value &= ";"

  return value

type
  Program* = ref object of RootObj
    statements*: seq[Statement]

proc getTokenLiteral*(self: Program): string =
  if len(self.statements) > 0:
    return self.statements[0].getTokenLiteral()

  return ""

proc getString*(self: Program): string =
  var value = ""

  for statement in self.statements:
    value &= statement.getString()

  return value