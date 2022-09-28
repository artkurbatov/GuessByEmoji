//
//  Movie.swift
//  Guess by emoji
//
//  Created by Kurbatov Artem on 28.09.2022.
//

import Foundation

struct Movie {
    
    var id: UUID
    var emojis: String
    var title: String
    var validAnswer: String?
    var guessed: Bool = false
}
