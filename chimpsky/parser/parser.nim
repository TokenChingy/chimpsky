{.experimental: "codeReordering".}

import ../ast/ast
import ../lexer/lexer
import ../token/token

type
  Parser* = ref object of RootObj
    tokenizer: lexer.Lexer
    currentToken: token.Token
    nextToken: token.Token

proc create*(tokenizer: lexer.Lexer): Parser =
  new result
  
  result.tokenizer = tokenizer
  result.getNextToken()
  result.getNextToken()

proc getNextToken(self: Parser) =
  self.currentToken = self.nextToken
  self.nextToken = self.tokenizer.getNextToken()

proc parseProgram*(self: Parser): ast.Program =
  return nil