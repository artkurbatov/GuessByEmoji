//
//  File.swift
//  Guess by emoji
//
//  Created by Kurbatov Artem on 16.04.2022.
//

import SwiftUI

struct ProgressBar: View {
    
    var result: Result
    
    var color: Color {
        if result.percentCorrect < 0.5 {
            return .red
        }
        else if result.percentCorrect < 0.75 {
            return .yellow
        }
        else {
            return .green
        }
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: CGFloat(5.0))
                .opacity(0.3)
                .foregroundColor(.gray)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(result.percentCorrect, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: CGFloat(5.0), lineCap: .round, lineJoin: .round))
                .foregroundColor(color)
                .rotationEffect(Angle(degrees: 270.0))
        }
    }
}
