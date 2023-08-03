// The Swift Programming Language
// https://docs.swift.org/swift-books

func addNums(a: Int, b: Int) -> Int {
  return a + b
}

func foo() {
  let max = arr.sorted().last // trivia
  let min = /* trivia */ arr.sorted().first
}

func foo1() {
  // SW-P1012
  if name.range(of: "Jane") == nil {
    // SW-R1012
    var _: Int? = nil
    // SW-P1011
    let max = arr.sorted().last
    // SW-P1012
  } else if name.range(of: "Jane") != nil {
    // SW-P1011
    let min = arr.sorted().first
  }

  // SW-P1007
  let firstEvenNumber = numbers.filter { $0 % 2 == 0 }.first

  // SW-P1009
  let lastEvenNumber = arr.filter { $0 % 2 == 0 }.last

  // SW-P1006
  myString == ""
  // SW-P1006
  myString != ""

  // SW-R1000
  seq.map { $0 }

  // SW-R1003
  if 10 == num {}

  // SW-R1007
  setA.intersection(setB).isEmpty
}
