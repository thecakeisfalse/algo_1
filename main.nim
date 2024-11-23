import strutils, sequtils, sets

proc main =
  let
    _ = stdin.readLine.parseInt
    a = stdin.readLine.splitWhitespace.mapIt(it.parseInt)
    k = stdin.readLine.parseInt
    hashed = a.toHashSet
    valid = a.filterIt(k - it in hashed)

  if len(valid) == 0:
    echo "None"
  else:
    echo valid[0], ' ', k-valid[0]

main()
