import ../token/token

type
    Lexer* = ref object
        input: string
        currentPosition: int
        nextPosition: int
        character: char

proc newLexer*(input: string): Lexer
proc readNextCharacter(self: var Lexer)
proc nextToken*(self: var Lexer): token.Token

proc newLexer*(input: string): Lexer =
    var lexer = Lexer(input: input, currentPosition: 0, nextPosition: 0, character: '\0')

    lexer.readNextCharacter()

    return lexer

proc readNextCharacter(self: var Lexer) =
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
            resultingToken.Type = token.EOF
            resultingToken.Literal = ""
        else:
            discard
    
    self.readNextCharacter()
    
    return resultingToken
