//
//  CoreDataManagerTests.swift
//  RecipleaseTests
//
//  Created by Levent Bostanci on 03/06/2020.
//  Copyright © 2020 Levent Bostanci. All rights reserved.
//

@testable import Reciplease
import XCTest

final class CoreDataManagerTest: XCTestCase {
    
    var coreDataStack: MockCoreDataStack!
    var coreDataManager: CoreDataManager!
    var data: Data?
    var recipe: Recipe?
    
    override func setUp() {
        super.setUp()
        coreDataStack = MockCoreDataStack()
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        super.tearDown()
        coreDataManager = nil
        coreDataStack = nil
    }
    
    func testRecipeMethode_WhenRecipeIsCreated_ThenShouldBeCorrectlySaved() {
        coreDataManager.creatRecipe(title: "", ingredients: [""], yield: "", calories: "", image: data, url: "")
        XCTAssertFalse(coreDataManager.recipeElements.isEmpty)
        XCTAssertTrue(coreDataManager.recipeElements.count == 1)
    }
    
    func testRecipeMethode_WhenAllRecipeAreDeleted_ThenShouldBeCorrectlyDeleted() {
        coreDataManager.creatRecipe(title: "", ingredients: [""], yield: "", calories: "", image: data, url: "")
        coreDataManager.deleteAllRecipe()
        XCTAssertTrue(coreDataManager.recipeElements.isEmpty)
    }
    
    func testDeleteRecipeMethode_WhenARecipeIsRemoved_ThenShouldCorrectlyDeleted() {
        coreDataManager.creatRecipe(title: "lemon", ingredients: ["lemon"], yield: "2", calories: "100", image: data, url: "www.google.fr")
        coreDataManager.deleteFromFavorite(title: "lemon")
        XCTAssertTrue(coreDataManager.recipeElements.isEmpty)
    }
    
    func testAddedRecipeMethode_WhenRecipeIsAdded_ThenShouldCorrectlyAdded() {
        coreDataManager.creatRecipe(title: "lemon", ingredients: ["lemon"], yield: "2", calories: "100", image: data, url: "www.google.fr")
        XCTAssertTrue(coreDataManager.checkIsFavorite(title: "lemon"))
    }
    
    func testAddedRecipeMethode_WHenRecipeIsAdded_ThenShouldntBeAdded() {
        coreDataManager.creatRecipe(title: "lemon", ingredients: ["lemon"], yield: "2", calories: "100", image: data, url: "www.google.fr")
        coreDataManager.deleteFromFavorite(title: "lemon")
        XCTAssertFalse(coreDataManager.checkIsFavorite(title: "lemon"))
        XCTAssertTrue(coreDataManager.recipeElements.isEmpty)
    }
}

