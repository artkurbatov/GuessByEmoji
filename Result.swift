//
//  File.swift
//  Guess by emoji
//
//  Created by Kurbatov Artem on 09.04.2022.
//

import Foundation

struct Result: Identifiable, Codable {
    
    var id = UUID()
    var numberCorrect: Int
    var percentCorrect: Double
    var moviesCount: Int
    var level: String
}
