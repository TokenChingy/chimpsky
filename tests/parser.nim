import unittest
import ../chimpsky/ast/ast
import ../chimpsky/lexer/lexer
import ../chimpsky/parser/parser

proc test*() {.inline.} =
  suite "Parser":
    test "It should parse the let statement":
      let input = """
        let x = 5;
        let y = 10;
        let foobar = 838383;
      """
      let tests = @[
        "x",
        "y",
        "foobar",
      ]

      let
        tokenizer = lexer.create(input)
        analyzer = parser.create(tokenizer)
        program = analyzer.parseProgram()

      check(not isNil(program))
      check(len(program.statements) == 3)
      
      for index, test in tests:
        let statement = program.statements[index]

        check(statement.getTokenLiteral() == "let")
        check(statement.Name.Value == test)