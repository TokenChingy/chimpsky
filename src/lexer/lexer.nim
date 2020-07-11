{.experimental: "codeReordering".}

import ../token/token
import ../utils/utils

type
    Lexer* = ref object of RootObj
        input: string
        currentPosition: int
        nextPosition: int
        character: char

proc create*(input: string): Lexer =
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

proc peekNextCharacter(self: var Lexer): char =
    if (self.nextPosition >= len(self.input)):
        return '\0'
    
    return self.input[self.nextPosition]


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
            if (self.peekNextCharacter() == '='):
                let initialCharacter = self.character

                self.readNextCharacter()
                resultingToken = token.create(token.EQ, initialCharacter & self.character);
            else:
                resultingToken = token.create(token.ASSIGN, self.character)
        of '+':
            resultingToken = token.create(token.PLUS, self.character)
        of '-':
            resultingToken = token.create(token.MINUS, self.character)
        of '*':
            resultingToken = token.create(token.ASTERIK, self.character)
        of '/':
            resultingToken = token.create(token.SLASH, self.character)
        of '!':
            if (self.peekNextCharacter() == '='):
                let initialCharacter = self.character

                self.readNextCharacter()
                resultingToken = token.create(token.NOT_EQ, initialCharacter & self.character)
            else:
                resultingToken = token.create(token.BANG, self.character)
        of '<':
            resultingToken = token.create(token.LT, self.character)
        of '>':
            resultingToken = token.create(token.GT, self.character)
        of ',':
            resultingToken = token.create(token.COMMA, self.character)
        of ';':
            resultingToken = token.create(token.SEMICOLON, self.character)
        of '(':
            resultingToken = token.create(token.LPAREN, self.character)
        of ')':
            resultingToken = token.create(token.RPAREN, self.character)
        of '{':
            resultingToken = token.create(token.LBRACE, self.character)
        of '}':
            resultingToken = token.create(token.RBRACE, self.character)
        of '\0':
            resultingToken = token.create(token.EOF, self.character)
        else:
            if utils.isLetter(self.character):
                let tokenLiteral = self.readIdentifier()
                let tokenType = token.lookupKeyword(tokenLiteral)
                
                return token.create(tokenType, tokenLiteral)
            elif utils.isDigit(self.character):
                let tokenLiteral = self.readNumber()

                return token.create(token.INT, tokenLiteral)

            resultingToken = token.create(token.ILLEGAL, self.character)
    
    self.readNextCharacter()

    return resultingToken
