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
    
    var recipeElements: [RecipeElements] {
        let request: NSFetchRequest<RecipeElements> = RecipeElements.fetchRequest()
        guard let tasks = try? managedObjectContext.fetch(request) else { return [] }
        return tasks
    }
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.mainContext
    }
    
    func creatRecipe(title: String, ingredients: String, likes: Int16, totalTime: Int16, image: String, url: String) {
        let recipe = RecipeElements(context: managedObjectContext)
        recipe.title = title
        recipe.ingredients = ingredients
        recipe.likes = likes
        recipe.totalTime = totalTime
        recipe.image = image
        recipe.url = url
        coreDataStack.saveContext()
    }
    
    func deleteAllRecipe() {
        recipeElements.forEach { managedObjectContext.delete($0) }
        coreDataStack.saveContext()
    }
    
    
    
}
