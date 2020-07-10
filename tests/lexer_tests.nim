import
    unittest,
    ../src/token/token

suite "Lexer Tests.":
    test "It performs lexical analysis on a simple input.":
        let input = "=+(){},;"
        let tests = @[
            (token.ASSIGN, "="),
            (token.PLUS, "+"),
            (token.LPAREN, "("),
            (token.RPAREN, ")"),
            (token.LBRACE, "{"),
            (token.RBRACE, "}"),
            (token.COMMA, ","),
            (token.SEMICOLON, ";")
        ]

        var testLexer = lexer.newLexer(input)

        for test in tests:
            let testToken = testLexer.nextToken()

            check(test[0], testToken.Type)
            check(test[1], testToken.Literal)