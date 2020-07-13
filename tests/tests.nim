import lexer
import parser
import ast

when isMainModule:
  lexer.test()
  parser.test()
  ast.test()