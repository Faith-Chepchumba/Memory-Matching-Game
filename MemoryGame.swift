import SwiftUI

struct ContentView: View {

@State private var cards = ["🐶", "🐱", "🐶", "🐱"].shuffled()

@State private var flippedIndex: Int? = nil

@State private var matchedIndices: [Int] = []

var body: some View {

VStack {

Text("Memory Matching Game").font(.largeTitle).padding()

GridView(items: cards.indices, columns: 2) { index in

CardView(content: self.cards[index], isFlipped: self.isFlipped(at: index))

.onTapGesture {

self.flipCard(at: index)

}

}

}

}

func isFlipped(at index: Int) -> Bool {

return flippedIndex == index || matchedIndices.contains(index)

}

func flipCard(at index: Int) {

if let flippedIndex = flippedIndex {

if cards[flippedIndex] == cards[index] {

matchedIndices += [flippedIndex, index]

}

self.flippedIndex = nil

} else {

self.flippedIndex = index

}

}

}

struct CardView: View {

var content: String

var isFlipped: Bool

var body: some View {

ZStack {

if isFlipped {

Text(content).font(.largeTitle)

} else {

RoundedRectangle(cornerRadius: 10).fill(Color.blue)

}

}

.frame(width: 100, height: 100)

}

}

struct GridView<Content: View>: View {

var items: [Int]

var columns: Int

var content: (Int) -> Content

var body: some View {

let rows = items.count / columns

return ForEach(0..<rows, id: \.self) { rowIndex in

HStack {

ForEach(0..<self.columns, id: \.self) { columnIndex in

self.content(self.items[rowIndex * self.columns + columnIndex])

}

}

}

}

}
