import unittest
import ../src/ast/ast
import ../src/lexer/lexer
import ../src/parser/parser

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

  test "It should capture errors":
    let input = """
      let x 5;
      let = 10;
      let 838383;
    """
    let tests = @[
      "expected next token to be = got INT instead",
      "expected next token to be IDENT got = instead",
      "expected next token to be IDENT got INT instead"
    ]

    let
      tokenizer = lexer.create(input)
      analyzer = parser.create(tokenizer)
    
    discard analyzer.parseProgram()

    let errors = analyzer.getErrors()

    check(len(errors) > 0)

    for index, test in tests:
      check(errors[index] == test)

  test "It should parse the return statement":
    let input = """
      return 5;
      return 10;
      return 993322;
    """

    let
      tokenizer = lexer.create(input)
      analyzer = parser.create(tokenizer)
      program = analyzer.parseProgram()
      errors = analyzer.getErrors()

    check(len(errors) == 0)
    check(len(program.statements) == 3)

  test "It should parse the identifier expression":
    let input = "foobar;"

    let
      tokenizer = lexer.create(input)
      analyzer = parser.create(tokenizer)
      program = analyzer.parseProgram()
      errors = analyzer.getErrors()

    check(len(errors) == 0)
    check(len(program.statements) == 1)
    check(program.statements[0].Kind == ast.ExpressionStatement)
    check(program.statements[0].Expression.Kind == ast.IdentifierExpression)
    check(program.statements[0].Expression.Identifier.Value == "foobar")
    check(program.statements[0].Expression.Identifier.getTokenLiteral() == "foobar")