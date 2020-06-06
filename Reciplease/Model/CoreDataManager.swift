//
//  CoreDataManager.swift
//  Reciplease
//
//  Created by Levent Bostanci on 02/05/2020.
//  Copyright © 2020 Levent Bostanci. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let coreDataStack: CoreDataStack
    let managedObjectContext: NSManagedObjectContext
    
    var recipeElements: [RecipeEntity] {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        guard let tasks = try? managedObjectContext.fetch(request) else { return [] }
        return tasks
    }
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.mainContext
    }
    
    func creatRecipe(title: String, ingredients: [String], yield: String, calories: String, image: Data?, url: String) {
        let recipe = RecipeEntity(context: managedObjectContext)
        recipe.title = title
        recipe.ingredients = ingredients
        recipe.calories = calories
        recipe.yield = yield
        recipe.image = image
        recipe.url = url
        coreDataStack.saveContext()
    }
    
    func deleteAllRecipe() {
        recipeElements.forEach { managedObjectContext.delete($0) }
        coreDataStack.saveContext()
    }
    
    func checkIsFavorite(title: String) -> Bool {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", title)
        guard let recipies = try? managedObjectContext.fetch(request) else { return false}
        if recipies.isEmpty {
            return false
        }
        return true
    }
    
    func deleteFromFavorite(title: String) {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", title)
        if let recipies = try? managedObjectContext.fetch(request) {
            recipies.forEach { managedObjectContext.delete($0) }
            }
        coreDataStack.saveContext()
        }
        
    }
