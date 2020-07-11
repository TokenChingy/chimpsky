{.experimental: "codeReordering".}

type
  Node* = ref object of RootObj

proc getTokenLiteral*(self: var Node): string =
  discard

type
  Statement* = ref object of RootObj

proc getTokenLiteral*(self: var Statement): string =
  discard

type
  Program* = ref object of RootObj
    statements*: seq[Statement]

proc getTokenLiteral*(self: var Program): string =
  if len(self.statements) > 0:
    return self.statements[0].getTokenLiteral()

  return ""