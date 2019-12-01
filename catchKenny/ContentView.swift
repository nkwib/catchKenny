//
//  ContentView.swift
//  catchKenny
//
//  Created by nepta on 01/12/2019.
//  Copyright © 2019 nkiwb. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var score = 0
    @State var timeLeft = 10.0
    @State var xPosition = 50.0
    @State var yPosition = 65.0
    @State var showAlert = false
    @State var playing = false
    @State var clicked = false

    var counterTime: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.timeLeft < 0.5 {
                self.playing = false
                self.showAlert = true
                self.xPosition = Double(207)
                self.yPosition = Double(430)
            } else {
                self.timeLeft -= 1
            }
        }
    }
    
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.playing {
                self.xPosition = Double(arc4random_uniform(314) + 50)
                self.yPosition = Double(arc4random_uniform(542) + 65)
                self.clicked = false
            }
        }
    }

    var body: some View {
        VStack{
            Spacer().frame(height: 20)
            Text("Catch Kenny")
                .font(.largeTitle)
            
            Text("Time Left: \(String(timeLeft))")
                .font(.title)
            
            Text("Score: \(score)")
                .font(.title)
            Spacer()
            Image("kenny")
            .resizable()
                .frame(width:100, height:130)
                .position(x: CGFloat(xPosition), y: CGFloat(yPosition))
                .gesture(TapGesture(count: 1).onEnded({
                    if !self.clicked{
                        self.score += 1
                        self.clicked = true
                    }
                }))
                .onAppear{
                    _ = self.timer
                    _ = self.counterTime
                    self.playing = true
            }
            Spacer().frame(height: 10)
            
        }.alert(isPresented: $showAlert) { () -> Alert in
            return Alert(title: Text("Game Ended"), message: Text("Do you want to play again?"), primaryButton: Alert.Button.default(Text("OK"), action: {
                self.timeLeft = 10.0
                self.score = 0
                self.playing = true
            }), secondaryButton: Alert.Button.cancel())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
