import
  strformat

# A type to store the kind of token.
type
  TokenKind* = string

# Token data structure holding the token kind and the
# value of the token.
type
  Token* = ref object
    kind*: TokenKind
    literal*: string

# Forward declaration
proc newToken*(kind: TokenKind, character: byte): Token

# Define the different kinds of tokens.
const
  # Special
  ILLEGAL* = "ILLEGAL"
  EOF* = "EOF"

  # Identifiers
  IDENT* = "IDENT"

  # Literals
  INT* = "INT"
  FLOAT* = "FLOAT"
  BOOLEAN* = "BOOLEAN"

  # Operators
  ASSIGN* = "="
  ADD* = "+"
  SUBTRACT* = "-"
  MULTIPLY* = "*"
  DIVIDE* = "/"

  # Delimiters
  COMMA* = ","
  SEMICOLON* = ";"

  # Blocks
  LPAREN* = "("
  RPAREN* = ")"
  LBRACE* = "{"
  RBRACE* = "}"

  # Keywords
  FUNCTION* = "FUNCTION"
  LET* = "LET"
 
# Return a new token object based on the token kind and value.
proc newToken*(kind: TokenKind, character: byte): Token =
  return Token(kind: kind, literal: fmt"{character.byte.char}")
