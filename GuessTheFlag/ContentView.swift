//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Ritsu on 07/12/2019.
//  Copyright © 2019 Ritsu. All rights reserved.
//

import SwiftUI

// Flag image's View
struct FlagImage: View {
    var img: String
    
    var body: some View {
        Image(img)
        .renderingMode(.original)
        .clipShape(Capsule())
        .overlay(Capsule().stroke(Color.black, lineWidth: 1))
        .shadow(color: .black, radius: 2)
    }
}

struct ContentView: View {
    // Variables
    @State private var countries = ["Estonia", "Francia", "Alemania", "Irlanda", "Italia", "Nigeria", "Polonia", "Russia", "España", "Reino Unido", "EEUU", "Monaco"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var answerAlertTitle = ""
    @State private var answerAlertMesage = ""
    @State private var score = 0
    
    var body: some View {
        // ZStack to put a background color
        ZStack {
            // Background Gradient
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                // Top text VStack
                VStack {
                    Text("¿Qual es la bandera de")
                        .foregroundColor(.white)
                    Text("\(countries[correctAnswer])?")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                // A stack of 3 flags to choose from to anwer
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        FlagImage(img: self.countries[number])
                    }
                }
                Text("Puntos: \(score)")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.black)
                Spacer()
            }
        }
        // Displays an alert
        .alert(isPresented: $showingScore) {
            Alert(title: Text(answerAlertTitle), message: Text(answerAlertMesage), dismissButton: .default(Text("Continuar")) {
                self.askQuestion()
                })
        }
    }
    
    // Checks if your answer is right or wrong
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            answerAlertTitle = "¡Correcto!"
            answerAlertMesage = "¡Efectivamente! Esa es la bandera de \(self.countries[number])"
            score += 1
        } else {
            answerAlertTitle = "¡Incorrecto!"
            answerAlertMesage = "¡No! Esa es la bandera de \(self.countries[number])"
            score -= 1
        }
        
        showingScore = true
    }
    
    // Play again
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
