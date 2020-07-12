type
  A* = ref object of RootObj
    getLetter*: proc: string

type
  B* = ref object of A
    getLetter*: proc: string
    letter: string

proc getLetter*(self: B): string =
  return self.letter

var b = B(letter: "a")
echo b.getLetter()