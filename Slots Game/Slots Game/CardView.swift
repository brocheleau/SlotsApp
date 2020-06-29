//
//  CardView.swift
//  Slots Game
//
//  Created by Blake Rocheleau on 6/29/20.
//  Copyright © 2020 Blake Rocheleau. All rights reserved.
//

//Contains the code for an individual Card view

import SwiftUI

struct CardView: View {
    
    //Binding variables so the data passed in points back to Source of Truth
    @Binding var symbol:String
    @Binding var backColor:Color
    
    var body: some View {
        
        //use the binding variable that was passed in from ContentView.swift
        Image(symbol)
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .background(backColor.opacity(0.5))
            .cornerRadius(20)
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        //pass in dummy Binding variables for the Preview
        CardView(symbol: Binding.constant("cherry"),backColor: Binding.constant(Color.white))
    }
}
