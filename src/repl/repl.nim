import strformat
import ../lexer/lexer
import ../token/token

const
  PROMPT = ">> "

proc repl*() =
  while true:
    stdout.write(PROMPT)
    
    let line = stdin.readLine()
    
    var replLexer = lexer.newLexer(line)
    var readToken = replLexer.nextToken()

    while readToken.Type != token.EOF:
      echo(fmt"(Type: {$readToken.Type}, Literal: {$readToken.Literal})")
      readToken = replLexer.nextToken()