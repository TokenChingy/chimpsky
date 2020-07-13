import repl/repl

proc handle_sigint() {.noconv.} =
  echo("\r\nNow quitting...")
  quit()

when isMainModule:
  setControlCHook(handle_sigint)

  try:
    repl()
  finally:
    quit()
