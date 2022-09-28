//
//  File.swift
//  Guess by emoji
//
//  Created by Kurbatov Artem on 16.04.2022.
//

import SwiftUI

struct GameResult: View {
    
    @EnvironmentObject var model: ContentModel
    
    @State var showAnswers = false
    
    @Binding var isActive: Bool
    @Binding var disabled: Bool
    @Binding var showResult: Bool
    @Binding var score: Int
    
    var numberCorrect: Int
    var moviesCount: Int
    
    var body: some View {
        
        VStack {
            
            Text("You guessed")
                .bold()
                .font(.title)
                .padding(.top)
            
            Text("\(numberCorrect) out of \(moviesCount) movies!")
                .bold()
                .font(.title)
            
            if showAnswers {
                
                List(0..<moviesCount) { index in
                    
                    HStack {
                        Text(model.movies[index].emojis)
                        Text(" - ")
                        Text(model.movies[index].title)
                    }
                }
            }
            else {
                Spacer()
            }
            
            HStack {
                
                Spacer()
                
                Button {
                    showAnswers.toggle()
                } label: {
                    Text(showAnswers == false ? "Show answers" : "Hide answers")
                }
                
                Spacer()
                
                Button {
                    model.movies.shuffle()
                    model.resetGuessed()
                    model.timeRemaining = 60
                    isActive = true
                    disabled = false
                    showResult = false
                    score = 0
                } label: {
                    Text("Play again")
                }
                
                Spacer()
            }
            .padding()
        }
    }
}
