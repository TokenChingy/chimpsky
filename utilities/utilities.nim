proc isLetter*(character: byte): bool =
  return ('a'.byte <= character and character <= 'z'.byte) or
         ('A'.byte <= character and character <= 'Z'.byte) or
         ('_'.byte == character)