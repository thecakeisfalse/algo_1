import strutils
import sequtils
import algorithm
import sets
import random

const INF = 10_000_000

proc slow(n: int, a: seq[int], k: int): (int, int) =
  for i in 0 .. n:
    for j in i+1 .. n:
      if a[i] + a[j] == k:
        return (a[i], a[j])
  
  return (-INF, -INF)

proc fast1(n: int, a: seq[int], k: int): (int, int) =
  var values = toHashSet(a)
  var x = a.filterIt(k - it in values)

  if len(x) == 0:
    return (-INF, -INF)
  return (x[0], k-x[0])

proc fast2(n: int, a: seq[int], k: int): (int, int) =
  var x = toSeq(0..n-1)
          .mapIt((a[it], a.lowerBound(k-a[it])))
          .filterIt(it[1] < len(a) and a[it[1]] + it[0] == k)

  if len(x) == 0:
    return (-INF, -INF)
  return (x[0][0], a[x[0][1]])

type T = proc (n: int, a: seq[int], k: int): (int, int)

proc correct(correctF: T, testF: T): bool =
  for _ in 0..10_000:
    let
      n = rand(10..50)
      k = (int)rand(-2e5..2e5)
    var a = toSeq(0..n-1).mapIt((int)rand(-1e5..1e5))
    a.sort()

    if correctF(n, a, k) != testF(n, a, k):
      return false

  return true

proc main =
  let n = stdin.readLine.parseInt
  let a = stdin.readLine.splitWhitespace.mapIt(it.parseInt)
  let k = stdin.readLine.parseInt

  var (x, y) = fast2(n, a, k)
  if x == -INF:
    echo "None"
  else:
    echo x, ' ', y

randomize()

assert correct(slow, fast1)
assert correct(slow, fast2)

main()
