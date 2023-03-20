//
//  ContentView.swift
//  Memorize
//
//  Created by Wegriny on 2023-03-09.
//


import SwiftUI

struct ContentView: View {
    
    @State var emojis = ["🚁","✈️","🚗","🚀","🚕","🚌","🏎️","🚓",
                         "🚒","🚐","🛻","🚚","🚛","🚜","🚲","🛵",
                         "🚝","🚆","🛩️","⛵️","🛶","🚤","🛳️","🛺"]
    
    let carEmojis = ["🚁","✈️","🚗","🚀","🚕","🚌","🏎️","🚓",
                     "🚒","🚐","🛻","🚚","🚛","🚜","🚲","🛵",
                     "🚝","🚆","🛩️","⛵️","🛶","🚤","🛳️","🛺"]
    
    let animalEmojis = ["🐶","🐱","🐭","🐰","🦊","🐻","🐼","🐻‍❄️",
                        "🐨","🐯","🦁","🐮","🐷","🐸","🐵","🐔",
                        "🐧","🦄","🐝","🪲","🐠","🐳","🐉","🦚"]
    
    let foodEmojis = ["🍏","🍐","🍌","🍋","🍉","🍍","🍒","🍑",
                      "🍆","🥑","🍅","🥦","🌶️","🌽","🥕","🧅",
                      "🍔","🍟","🍕","🌮","🍜","🍣","🥓","🥟"]
    
    //minWidth = screen width - total padding (padding * cards in the row + padding) / cards in the row.
    //padding = lazyVgrid padding
    //e.g. when less or equal to 9 total cards, there will be 3 cards in a row
    @State var emojiCount = 8
    @State var minWidth = (UIScreen.main.bounds.width-15.0*4.0)/3.0
    
    
    var body: some View {
        VStack {
            HStack {
                Text("Memorize!").foregroundColor(.blue)
            }.font(.largeTitle)
            
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive (minimum: minWidth))]) {
                    ForEach(emojis[0..<emojiCount], id: \.self){ emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }.padding(15)
                .foregroundColor(.red)
            
            Spacer ()
            
            HStack {
                remove
                Spacer ()
                animal
                Spacer ()
                car
                Spacer ()
                food
                Spacer ()
                add
            }
            .padding(.horizontal)
            .font(.largeTitle)
            .padding(.horizontal)
        }
    }
    
    var remove: some View{
        VStack {
            Button {
                if emojiCount > 1{
                    emojiCount -= 1
                    widthThatWorksBest (cardCount: emojiCount)
                }
            } label: { Image(systemName: "minus.circle")
            }
            Text("Remove").font(.footnote).foregroundColor(.blue)
        }
    }
    
    var animal: some View{
        VStack{
            Button {
                populateEmojis(arry: animalEmojis)
            } label: { Image(systemName: "pawprint.circle")
            }
            Text("Animals").font(.footnote).foregroundColor(.blue)
        }
    }
    
    var car: some View{
        VStack {
            Button {
                populateEmojis(arry: carEmojis)
            } label: { Image(systemName: "car.circle")
            }
            Text("Vehicles").font(.footnote).foregroundColor(.blue)
        }
    }
    
    var food: some View{
        VStack {
            Button {
                populateEmojis(arry: foodEmojis)
            } label: { Image(systemName: "car.circle")
            }
            Text("Food").font(.footnote).foregroundColor(.blue)
        }
    }
    
    var add: some View{
        VStack {
            Button  {
                if emojiCount < emojis.count{
                    emojiCount += 1
                    widthThatWorksBest (cardCount: emojiCount)
                }
            } label: { Image(systemName: "plus.circle")
            }
            Text("Add").font(.footnote).foregroundColor(.blue)
        }
        
    }
    
    func populateEmojis(arry: [String]) -> Void {
        emojis = arry.shuffled()
        emojiCount = Int.random(in: 4...24)
        widthThatWorksBest (cardCount: emojiCount)
    }
    
    func widthThatWorksBest (cardCount: Int) -> Void {
       
        
        let screenSize = UIScreen.main.bounds.width
        var padding: Double
        
        if (cardCount == 1){
            padding = Double(1 * 15 + 15)
            minWidth = (screenSize - padding)
        }
        else if (cardCount <= 4){
            padding = Double(2 * 15 + 15)
            minWidth = (screenSize - padding) / 2
        }
        else if (cardCount <= 9){
            padding = Double(3 * 15 + 15)
            minWidth = (screenSize - padding) / 3
        }
        else if (cardCount <= 16){
            padding = Double(4 * 15 + 15)
            minWidth = (screenSize - padding) / 4
        }
        else {
            padding = Double(5 * 15 + 15)
            minWidth = (screenSize - padding) / 5
        }
        
    }
    
    
}



struct CardView: View {
    
    @State var isFaceUp:Bool = true
    var content: String
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 25)
            if isFaceUp{
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content)
                    .font(.largeTitle)
            }
            else{
                shape.fill()
                Text(content)
                    .font(.largeTitle)
                    .opacity(0.0)
            }
        }
        .onTapGesture{
            isFaceUp = !isFaceUp
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            .preferredColorScheme(.light)
        
    }
}

