//
//  File.swift
//  Guess by emoji
//
//  Created by Kurbatov Artem on 09.04.2022.
//

import SwiftUI

struct ResultView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        VStack {
            
            Text("Results")
                .bold()
                .font(.title)
            
            if model.results.isEmpty {
                
                Spacer()
                
                Text("You don't have results yet")
                    .foregroundColor(.gray)
                
                Spacer()
            }
            else {
                VStack {
                    List(model.results) { result in
                        
                        HStack {
                            
                            ZStack {
                                
                                ProgressBar(result: result)
                                
                                Text("\(result.numberCorrect)/\(result.moviesCount)")
                                    .bold()
                            }
                            .frame(width: 50, height: 50)
                            
                            Divider()
                            
                            Text("Level: \(result.level)")
                                .padding(.leading, 5)
                            Spacer()
                        }
                    }
                    Spacer()
                    
                    Button {
                        model.results.removeAll()
                        model.save()
                    } label: {
                        ZStack {
                            
                            Rectangle()
                                .cornerRadius(10)
                                .foregroundColor(.red)
                                .frame(maxWidth: 200, maxHeight: 48)
                            
                            Text("Clear results")
                                .bold()
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                }
            }
        }
    }
}
