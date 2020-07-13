{.experimental: "codeReordering".}

import ../ast/ast
import ../lexer/lexer
import ../token/token

type
  Parser* = ref object of RootObj
    tokenizer: lexer.Lexer
    errors: seq[string]
    currentToken: token.Token
    nextToken: token.Token

proc create*(tokenizer: lexer.Lexer): Parser =
  new result
  
  result.tokenizer = tokenizer
  result.getNextToken()
  result.getNextToken()

proc getErrors*(self: Parser): seq[string] =
  return self.errors

proc addError(self: Parser, expectedToken: token.TokenType): void =
  self.errors.add("expected next token to be " & expectedToken & " got " & self.nextToken.Type & " instead")

proc getNextToken(self: Parser) =
  self.currentToken = self.nextToken
  self.nextToken = self.tokenizer.getNextToken()

proc peekNextToken(self: Parser, expectedToken: token.TokenType): bool =
  return self.nextToken.Type == expectedToken

proc expectNextToken(self: Parser, expectedToken: token.TokenType): bool =
  if self.peekNextToken(expectedToken):
    self.getNextToken()

    return true

  self.addError(expectedToken)
  
  return false

proc parseProgram*(self: Parser): ast.Program =
  new result

  var statements: seq[ast.Statement]

  while self.currentToken.Type != token.EOF:
    let statement = self.parseStatement()

    if not isNil(statement):
      statements.add(statement)

    self.getNextToken()

  result.statements = statements

proc parsePrefix(): ast.Expression = discard

proc parseIndix(leftSide: ast.Expression): ast.Expression = discard

proc parseStatement(self: Parser): ast.Statement =
  case self.currentToken.Type:
    of token.LET:
      return self.parseLetStatement(ast.LetStatement)
    of token.RETURN:
      return self.parseReturnStatement(ast.ReturnStatement)
    else:
      return nil

proc parseLetStatement(self: Parser, kind: enum): ast.Statement =
  new result

  result.Token = self.currentToken
  result.Kind = kind

  if not self.expectNextToken(token.IDENT):
    return nil

  result.Name = Identifier(Token: self.currentToken, Value: self.currentToken.Literal)
  
  if not self.expectNextToken(token.ASSIGN):
    return nil

  while self.currentToken.Type != token.SEMICOLON:
    self.getNextToken()

proc parseReturnStatement(self: Parser, kind: enum): ast.Statement =
  new result

  result.Token = self.currentToken
  self.getNextToken()

  while self.currentToken.Type != token.SEMICOLON:
    self.getNextToken();