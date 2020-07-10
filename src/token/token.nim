import tables

type
    TokenType* = string

    Token* = ref object of RootObj
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

var keywords = {
    "fn": FUNCTION,
    "let": LET,
}.newTable()

proc newToken*(tokenType: TokenType, character: char): Token {.inline.} =
    new result

    result.Type = tokenType
    result.Literal = $character

    return result

proc lookupKeyword*(identifier: string): TokenType =
    if keywords.hasKey(identifier):
        return keywords[identifier]

    return IDENT