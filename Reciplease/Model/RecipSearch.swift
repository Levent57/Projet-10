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
    let recipe: Recipe
}

struct Recipe: Decodable {
    let label: String
    var image: String
    let yield: Int
    let url: String
    let calories: Float
    let ingredients: [Ingredient]
    let ingredientLines: [String]
}

struct Ingredient: Decodable {
    let text: String
}

//struct RecipeRepresentable {
//    let label: String
//    let image: Data?
//    let calories: String
//    let ingredient: [String]
//    let yield: String
//    let data: Data?
//}

