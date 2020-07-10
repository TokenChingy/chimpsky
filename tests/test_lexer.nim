import unittest
import ../src/lexer/lexer
import ../src/token/token

suite "Test lexer":
    test "It should correctly analyse simple tokens":
        let input = "=+(){},;"
        let tests = @[
            (token.ASSIGN, "="),
            (token.PLUS, "+"),
            (token.LPAREN, "("),
            (token.RPAREN, ")"),
            (token.LBRACE, "{"),
            (token.RBRACE, "}"),
            (token.COMMA, ","),
            (token.SEMICOLON, ";"),
        ]

        var testLexer = lexer.newLexer(input)

        for test in tests:
            let testToken = testLexer.nextToken()

            check(test[0] == testToken.Type)
            check(test[1] == testToken.Literal)

    test "It should correctly analyse simple code":
        let input = """
            let five = 5;
            let ten = 10;
            
            let add = fn(x, y) {
                x + y;
            };
            
            let result = add(five, ten);
        """

        let tests = @[
            (token.LET, "let"),
            (token.IDENT, "five"),
            (token.ASSIGN, "="),
            (token.INT, "10"),
            (token.SEMICOLON, ";"),

            (token.LET, "let"),
            (token.IDENT, "ten"),
            (token.ASSIGN, "="),
            (token.INT, "10"),

            (token.LET, "let"),
            (token.IDENT, "add"),
            (token.ASSIGN, "="),
            (token.FUNCTION, "fn"),
            (token.LPAREN, "("),
            (token.IDENT, "x"),
            (token.COMMA, ","),
            (token.IDENT, "y"),
            (token.RPAREN, ")"),
            (token.LBRACE, "{"),
            (token.IDENT, "x"),
            (token.PLUS, "+"),
            (token.IDENT, "y"),
            (token.SEMICOLON, ";"),
            (token.RBRACE, "}"),
            (token.SEMICOLON, ";"),

            (token.LET, "let"),
            (token.IDENT, "result"),
            (token.ASSIGN, "="),
            (token.IDENT, "add"),
            (token.LPAREN, "("),
            (token.IDENT, "five"),
            (token.COMMA, ","),
            (token.IDENT, "ten"),
            (token.RPAREN, ")"),
            (token.SEMICOLON, ";")
        ]

        var testLexer = lexer.newLexer(input)

        for test in tests:
            let testToken = testLexer.nextToken()

            check(test[0] == testToken.Type)
            check(test[1] == testToken.Literal)