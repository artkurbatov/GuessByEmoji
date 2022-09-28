//
//  File.swift
//  Guess by emoji
//
//  Created by Kurbatov Artem on 06.04.2022.
//

import SwiftUI

struct GameView: View {
    
    @EnvironmentObject var model: ContentModel
    @Environment(\.scenePhase) var scenePhase
    
    @State var show = false
    @State var guess = ""
    @State var showResults = false
    @State var disabled = false
    @State var score = 0
    @State var isActive = true
    @State var currentMovieIndex: Int?
    
    let level: String
    
    var moviesCount: Int {
        
        switch level{
        case "Easy":
            return 10
        case "Medium":
            return 15
        default:
            return 20
        }
    }
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        ZStack {
            
            VStack {
                
                List(0..<moviesCount) { index in
                    
                    Button {
                        show = true
                        disabled = true
                        isActive = false
                        currentMovieIndex = model.findMovie(model.movies[index].id)
                    } label: {
                        HStack {
                            
                            Text(show ? "🤔🤔🤔" : model.movies[index].emojis)
                            
                            Spacer()
                            
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(model.movies[index].guessed ? .green : .gray)
                        }
                    }.disabled(model.movies[index].guessed)
                        .disabled(disabled)
                }
            }
            .onReceive(timer) { time in
                
                guard isActive else {
                    return
                }
                
                if model.timeRemaining > 0 {
                    model.timeRemaining -= 1
                }
                else {
                    isActive = false
                    disabled = true
                    showResults = true
                }
            }
            .onChange(of: scenePhase, perform: { newPhase in
                if newPhase == .active {
                    isActive = true
                }
                else {
                    isActive = false
                }
            })
            
            Rectangle()
                .foregroundColor(.black)
                .opacity(show ? 0.5 : 0)
            
            if show {
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.white)
                        .shadow(radius: 1)
                    
                    VStack(spacing: 15) {
                        Text("Make a guess")
                            .bold()
                            .foregroundColor(.black)
                        
                        TextField("", text: $guess)
                            .textFieldStyle(.roundedBorder)
                            .shadow(radius: 1)
                            .padding(.horizontal)
                        
                        HStack(spacing: 20) {
                            
                            Button {
                                show = false
                                guess = ""
                                disabled = false
                                isActive = true
                            } label: {
                                Text("Cancel")
                            }
                            
                            Button {
                                if currentMovieIndex != nil {
                                    if guess.lowercased().trimmingCharacters(in: .whitespaces) == model.movies[currentMovieIndex!].title.lowercased() || (model.movies[currentMovieIndex!].validAnswer != nil && guess.lowercased().trimmingCharacters(in: .whitespaces).contains(model.movies[currentMovieIndex!].validAnswer!.lowercased())){
                                        
                                        model.movies[currentMovieIndex!].guessed = true
                                        score += 1
                                        
                                        if score == moviesCount {
                                            isActive = false
                                            disabled = true
                                            showResults = true
                                        }
                                    }
                                }
                                show = false
                                disabled = false
                                isActive = true
                                guess = ""
                            } label: {
                                Text("Guess")
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .frame(maxWidth: 400, maxHeight: 200)
            }
        }
        .sheet(isPresented: $showResults, onDismiss: {
            showResults = false
        }, content: {
            GameResult(isActive: $isActive, disabled: $disabled, showResult: $showResults, score: $score, numberCorrect: score, moviesCount: moviesCount).onAppear {
                model.results.append(Result(numberCorrect: score, percentCorrect: Double(score)/Double(moviesCount), moviesCount: moviesCount, level: level))
                model.save()
            }
        })
        .navigationTitle("Time remaining: \(model.timeRemaining)")
        .navigationBarTitleDisplayMode(.inline)        
    }
}
