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
    MINUS* = "-"
    ASTERIK* = "*"
    SLASH* = "/"
    BANG* = "!"

    LT* = "<"
    GT* = ">"
    EQ* = "=="
    NOT_EQ* = "!="

    COMMA* = ","
    SEMICOLON* = ";"

    LPAREN* = "("
    RPAREN* = ")"
    LBRACE* = "{"
    RBRACE* = "}"

    FUNCTION* = "FUNCTION"
    LET* = "LET"
    TRUE* = "TRUE"
    FALSE* = "FALSE"
    IF* = "IF"
    ELSE* = "ELSE"
    RETURN* = "RETURN"

var keywords = {
    "fn": FUNCTION,
    "let": LET,
    "true": TRUE,
    "false": FALSE,
    "if": IF,
    "else": ELSE,
    "return": RETURN,
}.newTable()

proc newToken*(tokenType: TokenType, character: char): Token {.inline.} =
    new result

    result.Type = tokenType
    result.Literal = $character

proc lookupKeyword*(identifier: string): TokenType =
    if keywords.hasKey(identifier):
        return keywords[identifier]

    return IDENT