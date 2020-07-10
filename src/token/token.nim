const
    ILLEGAL* = "ILLEGAL"
    EOF* = "EOF"

    IDENT* = "IDENT"

    INT* = "INT"

    ASSIGN* = "="
    PLUS* = "+"

    COMMA* = ","
    SEMICOLON* = ";"

    LPAREN* = "("
    RPAREN* = ")"
    LBRACE* = "{"
    RBRACE* = "}"

    FUNCTION* = "FUNCTION"
    LET* = "LET"

type
    TokenType* = string

    Token* = ref object of RootObj
        Type*: TokenType
        Literal*: string

proc newToken*(tokenType: TokenType, character: char): Token {.inline.}

proc newToken*(tokenType: TokenType, character: char): Token {.inline.} =
    new result
    result.Type = tokenType
    result.Literal = $character
