//
//  GameSelectionView.swift
//  WhatTheHex
//
//  Created by Tyler Lawrence1 on 4/2/24.
//

import SwiftUI

struct GameSelectionView: View {
    
    @State var showingScoreSheet = false
    @State var showingHexcodeSheet = false
    @Environment(DataController.self) var dataController
    
    var body: some View {
        NavigationStack{
            ZStack{
                BackgroundView()
                ScrollView{
                    NavigationLink{
                        ColorOfTheDayView(vm: ColorOfTheDayViewModel(service: CloudKitService(), dataController: dataController))
                    } label: {
                        GameModeButtonView(title: "Color of the Day", streak: dataController.colorOfTheDayStreak)
                    }
                    .disabled(dataController.completedColorOfTheDay)
                    
                    NavigationLink{
                        PracticeModeView(vm: PracticeModeViewModel())
                    } label: {
                        GameModeButtonView(title: "Practice")
                    }
                    
                    NavigationLink{
                        RapidGameView()
                    } label: {
                        GameModeButtonView(title: "Rapid")
                    }
                    
                    NavigationLink{
                        SurvivalGameView()
                    } label: {
                        GameModeButtonView(title: "Survival")
                    }
                    
                }
                .padding()
                .buttonStyle(GameSelectionButton())
            }
            .toolbar{
                ToolbarItem{
                    Button{
                        showingScoreSheet.toggle()
                    } label: {
                        Image(systemName: "trophy")
                    }
                }
                ToolbarItem{
                    Button{
                        showingHexcodeSheet.toggle()
                    } label: {
                        Image(systemName: "doc.text.magnifyingglass")
                    }
                }
            }
            .font(.largeTitle)
            .sheet(isPresented: $showingScoreSheet){
                ScoreExplanationView()
            }
            .sheet(isPresented: $showingHexcodeSheet){
                HexcodeExplanationView()
            }
        }
        
        
    }
}

#if DEBUG
#Preview {
    GameSelectionView()
        .environment(DataController.sample1DayStreak)
}
#endif
