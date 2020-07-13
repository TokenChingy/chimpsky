import ../lexer/lexer
import ../token/token

const
  PROMPT = ">> "

proc repl*() =
  while true:
    stdout.write(PROMPT)
    
    let line: string = stdin.readLine()
    
    var replLexer = lexer.create(line)
    var tokenRead = replLexer.getNextToken()

    while tokenRead.Type != token.EOF:
      echo("{ Type: " & $tokenRead.Type & " Literal: " & $tokenRead.Literal & " }")
      tokenRead = replLexer.getNextToken()