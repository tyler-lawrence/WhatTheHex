//
//  GameView.swift
//  WhatTheHex
//
//  Created by Tyler Lawrence1 on 4/6/24.
//

import SwiftUI

struct TimedGameBaseView: View {
    
    @State var vm: TimedGameViewModel
    let sqareSize: CGFloat = 150
    var body: some View {
        
        VStack{
            TimerView(vm: vm)
            HStack{
                ColorSquareView(title: "Target", hexcode: vm.targetHexcode, size: sqareSize, showingCode: vm.gameOver)
                ColorSquareView(title: "Your guess", hexcode: vm.playerHexcode, size: sqareSize, showingCode: true)
            }
//            Spacer()
            RGBSlidersView(hexcode: $vm.playerHexcode)
            Spacer()
            Button("Guess"){
                vm.submitGuess()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .onAppear{
            startBackgroundSound(sound: "GameplayLoop", type: "mp3")
        }
        .onDisappear{
            stopBackgroundSound()
        }
    }
}

#Preview {
    TimedGameBaseView(vm: SurvivalGameViewModel())
}
