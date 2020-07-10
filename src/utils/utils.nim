const
  CHARACTER_SET: set[char] = {
    'a'..'z',
    'A'..'Z',
    '_'
  }
  DIGIT_SET: set[char] = {
    '0'..'9'
  }

proc isLetter*(character: char): bool =
  return character in CHARACTER_SET

proc isDigit*(digit: char): bool =
  return digit in DIGIT_SET