import ../token/token
import ../utils/utils

type
    Lexer* = ref object of RootObj
        input: string
        currentPosition: int
        nextPosition: int
        character: char

proc newLexer*(input: string): Lexer
proc eatWhiteSpace(self: var Lexer) {.inline.}
proc readNextCharacter(self: var Lexer) {.inline.}
proc readIdentifier(self: var Lexer): string
proc readNumber(self: var Lexer): string
proc nextToken*(self: var Lexer): token.Token

proc newLexer*(input: string): Lexer =
    new result

    result.input = input
    result.readNextCharacter()

proc eatWhiteSpace(self: var Lexer) =
    while self.character == ' ' or self.character == '\t' or self.character == '\n' or self.character == '\r':
        self.readNextCharacter()

proc readNextCharacter(self: var Lexer) =
    if self.nextPosition >= len(self.input):
        self.character = '\0'
    else:
        self.character = self.input[self.nextPosition]

    self.currentPosition = self.nextPosition
    self.nextPosition += 1

proc readIdentifier(self: var Lexer): string =
    let startPosition = self.currentPosition

    while utils.isLetter(self.character):
        self.readNextCharacter()

    return self.input[startPosition..<self.currentPosition]

proc readNumber(self: var Lexer): string =
    let startPosition = self.currentPosition

    while utils.isDigit(self.character):
        self.readNextCharacter()

    return self.input[startPosition..<self.currentPosition]

proc nextToken*(self: var Lexer): token.Token =
    var resultingToken: token.Token

    self.eatWhiteSpace()

    case self.character:
        of '=':
            resultingToken = token.newToken(token.ASSIGN, self.character)
        of '+':
            resultingToken = token.newToken(token.PLUS, self.character)
        of '-':
            resultingToken = token.newToken(token.MINUS, self.character)
        of '*':
            resultingToken = token.newToken(token.ASTERIK, self.character)
        of '/':
            resultingToken = token.newToken(token.SLASH, self.character)
        of '!':
            resultingToken = token.newToken(token.BANG, self.character)
        of '<':
            resultingToken = token.newToken(token.LT, self.character)
        of '>':
            resultingToken = token.newToken(token.GT, self.character)
        of ',':
            resultingToken = token.newToken(token.COMMA, self.character)
        of ';':
            resultingToken = token.newToken(token.SEMICOLON, self.character)
        of '(':
            resultingToken = token.newToken(token.LPAREN, self.character)
        of ')':
            resultingToken = token.newToken(token.RPAREN, self.character)
        of '{':
            resultingToken = token.newToken(token.LBRACE, self.character)
        of '}':
            resultingToken = token.newToken(token.RBRACE, self.character)
        of '\0':
            resultingToken =  token.newToken(token.EOF, self.character)
        else:
            if utils.isLetter(self.character):
                let tokenLiteral = self.readIdentifier()
                let tokenType = token.lookupKeyword(tokenLiteral)
                
                return token.Token(Type: tokenType, Literal: tokenLiteral)
            elif utils.isDigit(self.character):
                let tokenLiteral = self.readNumber()

                return token.Token(Type: token.INT, Literal: tokenLiteral)

            resultingToken = token.newToken(token.ILLEGAL, self.character)    
    
    self.readNextCharacter()
    
    return resultingToken
