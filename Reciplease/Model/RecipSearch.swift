//
//  RecipSearch.swift
//  Reciplease
//
//  Created by Levent Bostanci on 01/05/2020.
//  Copyright © 2020 Levent Bostanci. All rights reserved.
//

import Foundation

struct RecipSearch: Decodable {
    let hits: [Hit]
}

struct Hit: Decodable {
    var recipe: Recipe
}

struct Recipe: Decodable {
    let label: String
    var image: String?
    let yield: Int
    let url: String
    let calories: Float
    let ingredients: [Ingredient]
    let ingredientLines: [String]
}

struct Ingredient: Decodable {
    let text: String
}

struct RecipieDetail {
    let label: String
    var image: Data?
    let yield: String
    let url: String
    let calories: String
    let ingredients: [String]
}
