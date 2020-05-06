//
//  CoreDataStack.swift
//  Reciplease
//
//  Created by Levent Bostanci on 02/05/2020.
//  Copyright © 2020 Levent Bostanci. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RecipeElements")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var mainContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    func saveContext() {
        guard mainContext.hasChanges else { return }
        do {
            try mainContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    
}
