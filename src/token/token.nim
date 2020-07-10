type
    TokenType* = string

    Token* = ref object
        Type*: TokenType
        Literal*: string

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

proc newToken*(tokenType: TokenType, character: char): Token

proc newToken*(tokenType: TokenType, character: char): Token =
    return Token(Type: tokenType, Literal: $character)
