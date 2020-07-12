type
  Node* = ref object of RootObj
    getTokenLiteral*: proc: string

proc getTokenLiteral*(self: Node): string =
  discard

type
  Expression* = ref object of Node

proc expessionNode*(self: Expression): void = discard

type
  Statement* = ref object of Node

proc statementNode*(self: Statement): void = discard

type
  Program* = ref object of RootObj
    statements*: seq[Statement]
    getTokenLiteral*: proc: string

proc getTokenLiteral*(self: Program): string =
  if len(self.statements) > 0:
    return self.statements[0].getTokenLiteral()

  return ""