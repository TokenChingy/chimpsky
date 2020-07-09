import
  ../token/token,
  ../utilities/utilities

# Lexer data structure to enable us to generate tokens based on
# the input. The input holds the sequence of characters to process,
# the position holds the current index of the current character,
# the nextPosition hold the position of the "next" character,
# the character holds the current character to be analysed.
type
  Lexer* = ref object
    input*: string
    position*: int
    nextPosition*: int
    character*: byte

# Forward declarations
proc newLexer*(input: string): Lexer
proc readChar*(lexer: Lexer): void {.inline.}
proc nextToken*(lexer: Lexer): token.Token
proc readIdentifier*(lexer: Lexer): string

# Creates and returns a new Lexer.
proc newLexer*(input: string): Lexer =
  let lexer = Lexer(input: input, position: 0, nextPosition: 0, character: 0.byte)
  
  lexer.readChar()

  return lexer

# Provide the next character and advance the "read" pointers.
proc readChar*(lexer: Lexer): void {.inline.} =
  if lexer.nextPosition >= lexer.input.len():
    lexer.character = 0.byte
  else:
    lexer.character = lexer.input[lexer.nextPosition].byte

  lexer.position = lexer.nextPosition
  lexer.nextPosition += 1

proc nextToken*(lexer: Lexer): token.Token =
  var tokenToReturn: token.Token

  case lexer.character:
    of '='.byte:
      tokenToReturn = token.newToken(token.ASSIGN, lexer.character)
    of ','.byte:
      tokenToReturn = token.newToken(token.COMMA, lexer.character)
    of ';'.byte:
      tokenToReturn = token.newToken(token.SEMICOLON, lexer.character)
    of '('.byte:
      tokenToReturn = token.newToken(token.LPAREN, lexer.character)
    of ')'.byte:
      tokenToReturn = token.newToken(token.RPAREN, lexer.character)
    of '{'.byte:
      tokenToReturn = token.newToken(token.LBRACE, lexer.character)
    of '}'.byte:
      tokenToReturn = token.newToken(token.RBRACE, lexer.character)
    of 0.byte:
      tokenToReturn.kind = token.EOF
      tokenToReturn.literal = ""
    else:
      if isLetter(lexer.character):
        tokenToReturn.literal = lexer.readIdentifier()

        return tokenToReturn

      tokenToReturn = newToken(token.ILLEGAL, lexer.character)

  lexer.readChar()

  return tokenToReturn

proc readIdentifier*(lexer: Lexer): string =
  let startPosition = lexer.position

  while utilities.isLetter(lexer.character):
    lexer.readChar()

  return lexer.input[startPosition..(lexer.position - 1)]