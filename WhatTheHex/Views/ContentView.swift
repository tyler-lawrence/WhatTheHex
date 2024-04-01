//
//  ContentView.swift
//  WhatTheHex
//
//  Created by Tyler Lawrence1 on 3/29/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var vm = GameViewModel()
    @State var showingAlert = false
    
    var alertMessage: String {
        let guessDifference = String(format: "%.1f", vm.calculateScore())
        return "Score: \(guessDifference)"
    }
    
    var body: some View {
        VStack {
            HStack{
                ColorSquareView(title: "Target", hexcode: vm.targetHexcode, showingCode: $showingAlert)
                ColorSquareView(title: "Your guess", hexcode: vm.playerHexcode, showingCode: $showingAlert)
            }
            Spacer()
            Divider()
            HStack{
                HexComponentPickerView(component: $vm.playerHexcode.red)
                HexComponentPickerView(component: $vm.playerHexcode.green)
                HexComponentPickerView(component: $vm.playerHexcode.blue)
            }
            Spacer()
            Button("Guess"){
                showingAlert.toggle()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .alert(alertMessage, isPresented: $showingAlert){
            Button("Play Again"){ vm.reset() }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 15")
        ContentView()
            .previewDevice("My Mac")
    }
}
