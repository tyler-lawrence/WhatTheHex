//
//  TimerBackgroundView.swift
//  WhatTheHex
//
//  Created by Tyler Lawrence1 on 4/2/24.
//

import SwiftUI

struct TimerView: View {
    
    @State var vm: TimedGameViewModel
    @State var lowTimeTrigger: Bool = false
    let lowTimeCounter = 5
    let circleFrameSize: CGFloat = 80
    
    var circleColor: Color {
        vm.timeRemaining <= 5 ? .red : .gray
    }
    
    var circleGradient: RadialGradient {
        RadialGradient(
            colors: [circleColor.opacity(0.2), circleColor],
            center: .center,
            startRadius: 0,
            endRadius: 40
        )
    }
    
    var body: some View {
        
        Text("\(vm.timeRemaining)")
            .font(.largeTitle)
            .foregroundStyle(.white)
            .shadow(radius: 1)
            .bold()
            .padding()
            .background(
                Circle()
                    .frame(width: circleFrameSize, height: circleFrameSize)
                    .foregroundStyle(circleGradient)
                    .shadow(radius: 10)
                    .phaseAnimator([1, 1.5], trigger: lowTimeTrigger){ content, phase in
                        content
                            .scaleEffect(phase)
                    }
            )
            .padding(5)
        
        // correct guess animation
            .overlay{
                    Circle()
                        .foregroundStyle(.green)
                        .overlay{
                            Text("+10")
                                .font(.largeTitle)
                                .foregroundStyle(.white)
                        }
                        .phaseAnimator([0, 1], trigger: vm.bonusTimeAnimationTrigger){ content, phase in
                            content
                                .opacity(phase)
                        }
            }
            .sensoryFeedback(.warning, trigger: lowTimeTrigger)
            .onReceive(vm.timer){ _ in
                vm.timeRemaining -= 1
                if vm.timeRemaining <= lowTimeCounter {
                    lowTimeTrigger.toggle()
                }
                if vm.timeRemaining <= 0 {
                    vm.gameOver = true
                    vm.timerSubscription?.cancel()
                }
            }
    }
}

#Preview {
    TimerView(vm: SurvivalGameViewModel())
}
