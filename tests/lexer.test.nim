import 
  unittest,
  ../lexer/lexer,
  ../token/token

suite "Tests for the lexer module":
  setup:    
    let input = "=+(){},;"
    let lexer = newLexer(input: input, position: 0, nextPosition: 0, character: 0.byte)

    var tokenToTest: lexer.nextToken()

  test "Lexer type assign":
    check(tokenToTest.kind == token.ASSIGN)
    check(tokenToTest.literal == '=')
    tokenToTest = lexer.nextToken()
