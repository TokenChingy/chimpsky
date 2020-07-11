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

type
    TokenType* = string
    
    Token* = ref object of RootObj
        Type*: TokenType
        Literal*: string

proc create*(tokenType: TokenType, character: char): Token =
    new result

    result.Type = tokenType
    result.Literal = $character

proc create*(tokenType: TokenType, character: string): Token =
    new result

    result.Type = tokenType
    result.Literal = character

proc lookupKeyword*(identifier: string): TokenType =
    case identifier:
        of "fn":
            return FUNCTION
        of "let":
            return LET
        of "true":
            return TRUE
        of "false":
            return FALSE
        of "if":
            return IF
        of "else":
            return ELSE
        of "return":
            return RETURN
        else:
            return IDENT