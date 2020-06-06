
//  MockCoreData.swift
//  RecipleaseTests
//
//  Created by Levent Bostanci on 03/06/2020.
//  Copyright © 2020 Levent Bostanci. All rights reserved.


import Reciplease
import Foundation
import CoreData

final class MockCoreDataStack: CoreDataStack {

    convenience init() {
        self.init(modelName: "Reciplease")
    }

    override init(modelName: String) {
        super.init(modelName: modelName)
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        let container = NSPersistentContainer(name: modelName)
        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        self.persistentContainer = container
    }
}
