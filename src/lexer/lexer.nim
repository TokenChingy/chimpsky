import ../token/token

type
    Lexer* = ref object of RootObj
        input: string
        currentPosition: int
        nextPosition: int
        character: char

proc newLexer*(input: string): Lexer
proc readNextCharacter(self: var Lexer) {.inline.}
proc nextToken*(self: var Lexer): token.Token

proc newLexer*(input: string): Lexer =
    new result
    result.input = input
    result.readNextCharacter()

proc readNextCharacter(self: var Lexer) {.inline.} =
    if self.nextPosition >= len(self.input):
        self.character = '\0'
    else:
        self.character = self.input[self.nextPosition]

    self.currentPosition = self.nextPosition
    self.nextPosition += 1

proc nextToken*(self: var Lexer): token.Token =
    var resultingToken: token.Token

    case self.character:
        of '=':
            resultingToken = token.newToken(token.ASSIGN, self.character)
        of '+':
            resultingToken = token.newToken(token.PLUS, self.character)
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
            resultingToken = token.newToken(token.ILLEGAL, self.character)
    
    self.readNextCharacter()
    
    return resultingToken
