//
//  ContentView.swift
//  Slots Game
//
//  Created by Blake Rocheleau on 6/27/20.
//  Copyright © 2020 Blake Rocheleau. All rights reserved.
//

//The main view of the Slots Game app

import SwiftUI

struct ContentView: View {
    
    //ContentView is the Source of Truth
    @State private var symbols  = ["apple", "star", "cherry"]
    
    //use Array() to make larger arrays that are initialized with same value
    @State private var backColor = Array(repeating: Color.white, count: 9)
    @State private var numbers = Array(repeating: 0, count: 9)
    @State private var credits  = 1000
    
    private var winnings = 5
    
    var body: some View {
        
        ZStack {
            //design the background
            Rectangle()
                .foregroundColor(Color(red: 200/255, green: 143/255, blue: 32/255))
                .edgesIgnoringSafeArea(.all)
            
            Rectangle()
                .foregroundColor(Color(red: 228/255, green: 195/255, blue: 76/255))
                .rotationEffect(Angle(degrees: 45))
                .edgesIgnoringSafeArea(.all)
            
            //now handle all the elements that sit on top of the background
            VStack {
                //Spacer()
                //Title
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.pink)
                    
                    Text("Slots in SwiftUI")
                        .bold()
                        .foregroundColor(.white)
                    
                    Image(systemName: "star.fill")
                        .foregroundColor(.pink)
                }
                .scaleEffect(2).padding(.all, 20.0)
                
                //Spacer()
                
                //credits counter
                Text("Credits: " + String(credits))
                    .foregroundColor(.black)
                    .padding(.all, 10)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(20)
                
                Spacer()
                
                //Slot symbols
                VStack {
                    HStack {
                        
                        Spacer()
                        
                        //pass the state symbol variable into the Card View
                        CardView(symbol: $symbols[numbers[0]], backColor: $backColor[0])
                        CardView(symbol: $symbols[numbers[1]], backColor: $backColor[1])
                        CardView(symbol: $symbols[numbers[2]], backColor: $backColor[2])
                        
                        Spacer()
                        
                    }
                    HStack {
                        
                        Spacer()
                        
                        //pass the state symbol variable into the Card View
                        CardView(symbol: $symbols[numbers[3]], backColor: $backColor[3])
                        CardView(symbol: $symbols[numbers[4]], backColor: $backColor[4])
                        CardView(symbol: $symbols[numbers[5]], backColor: $backColor[5])
                        
                        Spacer()
                        
                    }
                    HStack {
                        
                        Spacer()
                        
                        //pass the state symbol variable into the Card View
                        CardView(symbol: $symbols[numbers[6]], backColor: $backColor[6])
                        CardView(symbol: $symbols[numbers[7]], backColor: $backColor[7])
                        CardView(symbol: $symbols[numbers[8]], backColor: $backColor[8])
                        
                        Spacer()
                        
                    }
                }.padding(.bottom, 80)
                
                
                //the button allows the user to play a round of slots
                HStack {
                    VStack {
                        Button(action: {
                            //process a single spin
                            self.processResults(false)
                            
                        }) {
                            Text("Spin")
                                .bold()
                                .foregroundColor(.white)
                                .padding(.all, 10)
                                .padding([.leading, .trailing], 30)
                                .background(Color.pink)
                                .cornerRadius(20)
                        }
                        Text("\(winnings) Credits")
                            .font(.headline)
                            .padding(.top, 10)
                        
                    }
                    VStack {
                        Button(action: {
                            //process a single spin
                            self.processResults(true)
                            
                        }) {
                            Text("Max Spin")
                                .bold()
                                .foregroundColor(.white)
                                .padding(.all, 10)
                                .padding([.leading, .trailing], 30)
                                .background(Color.pink)
                                .cornerRadius(20)
                        }
                        Text("\(winnings * 5) Credits")
                            .font(.headline)
                            .padding(.top, 10)
                        
                    }
                    
                }
                
                Spacer()
                
            }
        }
        
    }
    
    //function to determine if the player won a spin
    func processResults(_ isMax: Bool = false) {
        //set symbol background color to white
        self.backColor = self.backColor.map {_ in Color.white}
        
        if isMax {
            //spin all the cards
            
            //generate a random symbol for each slot
            //CONCISE WAY TO GENERATE RANDOM SYMBOL FOR EACH SLOT:
            self.numbers = self.numbers.map {_ in Int.random(in: 0...self.symbols.count - 1)}
        }
        else {
            //spin the middle row
            self.numbers[3] = Int.random(in: 0...self.symbols.count - 1)
            self.numbers[4] = Int.random(in: 0...self.symbols.count - 1)
            self.numbers[5] = Int.random(in: 0...self.symbols.count - 1)
        }
        
        //check winnings
        processWin(isMax)
        
    }
    
    //function to check winnings
    //handles winnings for both types of spins
    func processWin(_ isMax:Bool = false) {
        
        var matches = 0
        
        if !isMax {
            //processing for a single spin
            if self.numbers[3] == self.numbers[4] && self.numbers[4] == self.numbers[5] {
                //win
                matches += 1
                
                //set background colors of the symbols to green
                self.backColor[3] = Color.green
                self.backColor[4] = Color.green
                self.backColor[5] = Color.green
            }
            
        }
            
        else {
            //processing for max spin
            
            //top row
            if self.numbers[0] == self.numbers[1] && self.numbers[1] == self.numbers[2] {
                //win
                matches += 1
                
                //set background colors of the symbols to green
                self.backColor[0] = Color.green
                self.backColor[1] = Color.green
                self.backColor[2] = Color.green
            }
            
            //middle row
            if self.numbers[3] == self.numbers[4] && self.numbers[4] == self.numbers[5] {
                //win
                matches += 1
                
                //set background colors of the symbols to green
                self.backColor[3] = Color.green
                self.backColor[4] = Color.green
                self.backColor[5] = Color.green
            }
            
            //bottom row
            if self.numbers[6] == self.numbers[7] && self.numbers[7] == self.numbers[8] {
                //win
                matches += 1
                
                //set background colors of the symbols to green
                self.backColor[6] = Color.green
                self.backColor[7] = Color.green
                self.backColor[8] = Color.green
            }
            
            //diagonal top left to bottom right
            if self.numbers[0] == self.numbers[4] && self.numbers[4] == self.numbers[8] {
                //win
                matches += 1
                
                //set background colors of the symbols to green
                self.backColor[0] = Color.green
                self.backColor[4] = Color.green
                self.backColor[8] = Color.green
            }
            
            //diagonal top right to bottom left
            if self.numbers[2] == self.numbers[4] && self.numbers[4] == self.numbers[6] {
                //win
                matches += 1
                
                //set background colors of the symbols to green
                self.backColor[2] = Color.green
                self.backColor[4] = Color.green
                self.backColor[6] = Color.green
            }
            
        }
        
        //check matches and award credits or penalty
        if matches > 0 {
            //at least 1 win
            self.credits += 2 * winnings * matches
        }
        else if !isMax{
            //no wins, single spin
            self.credits -= winnings
        }
        else {
            //no wins, max spin
            self.credits -= 5 * winnings
        }
        
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
