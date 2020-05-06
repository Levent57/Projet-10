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
    let uri: String
    let label: String
    let image: String
    let source: String
    let url: String
    let yield: String
    let calories: String
    let totalWeight: Float
    let ingredients: [Ingredient]
}

struct Ingredient: Decodable {
    let foodId: String
    let quantity: Float
    let measure: [Measure]
    let weight: Float
    let food: [Food]
}

struct Measure: Decodable {
    let uri: String
    let label: String
}

struct Food: Decodable {
    let foodId: String
    let label: String
}
