import unittest
import ../src/lexer/lexer
import ../src/token/token

proc test*() =
    suite "Lexer":
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

            var tokenizer = lexer.create(input)

            for test in tests:
                let currentToken = tokenizer.getNextToken()

                check(test[0] == currentToken.Type)
                check(test[1] == currentToken.Literal)

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
                (token.INT, "5"),
                (token.SEMICOLON, ";"),

                (token.LET, "let"),
                (token.IDENT, "ten"),
                (token.ASSIGN, "="),
                (token.INT, "10"),
                (token.SEMICOLON, ";"),

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
                (token.SEMICOLON, ";"),
                (token.EOF, "\0")
            ]

            var tokenizer = lexer.create(input)

            for test in tests:
                let currentToken = tokenizer.getNextToken()

                check(test[0] == currentToken.Type)
                check(test[1] == currentToken.Literal)

        test "It should correctly analyse mixed tokens":
            let input = """
                !-/*5;
                5 < 10 > 5;
            """
            let tests = @[
                (token.BANG, "!"),
                (token.MINUS, "-"),
                (token.SLASH, "/"),
                (token.ASTERIK, "*"),
                (token.INT, "5"),
                (token.SEMICOLON, ";"),

                (token.INT, "5"),
                (token.LT, "<"),
                (token.INT, "10"),
                (token.GT, ">"),
                (token.INT, "5"),
                (token.SEMICOLON, ";"),
            ]

            var tokenizer = lexer.create(input)

            for test in tests:
                let currentToken = tokenizer.getNextToken()

                check(test[0] == currentToken.Type)
                check(test[1] == currentToken.Literal)

        test "It should correctly analyse conditional and return keywords":
            let input = """
                if (5 < 10) {
                    return true;
                } else {
                    return false;
                }
            """
            let tests = @[
                (token.IF, "if"),
                (token.LPAREN, "("),
                (token.INT, "5"),
                (token.LT, "<"),
                (token.INT, "10"),
                (token.RPAREN, ")"),
                (token.LBRACE, "{"),
                (token.RETURN, "return"),
                (token.TRUE, "true"),
                (token.SEMICOLON, ";"),
                (token.RBRACE, "}"),
                (token.ELSE, "else"),
                (token.LBRACE, "{"),
                (token.RETURN, "return"),
                (token.FALSE, "false"),
                (token.SEMICOLON, ";"),
                (token.RBRACE, "}"),
            ]

            var tokenizer = lexer.create(input)

            for test in tests:
                let currentToken = tokenizer.getNextToken()

                check(test[0] == currentToken.Type)
                check(test[1] == currentToken.Literal)

        test "It should correctly analyse comparators":
            let input = """
                10 == 10;
                10 != 9;
            """
            let tests = @[
                (token.INT, "10"),
                (token.EQ, "=="),
                (token.INT, "10"),
                (token.SEMICOLON, ";"),
                (token.INT, "10"),
                (token.NOT_EQ, "!="),
                (token.INT, "9"),
                (token.SEMICOLON, ";"),
            ]

            var tokenizer = lexer.create(input)

            for test in tests:
                let currentToken = tokenizer.getNextToken()

                check(test[0] == currentToken.Type)
                check(test[1] == currentToken.Literal)