//
//  RecipeSearchTests.swift
//  RecipleaseTests
//
//  Created by Levent Bostanci on 03/06/2020.
//  Copyright © 2020 Levent Bostanci. All rights reserved.
//

import XCTest
@testable import Reciplease

class RecipeSearchTests: XCTestCase {
    
    func testGetData_WhenNoDataIsPassed_ThenShouldReturnFailCallback() {
        let session = MockRecipeSearch(fakeResponse: FakeResponse(response: nil, data: nil))
        let requestService = RecipeService(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        requestService.getData(ingredients: [""]) { result in
            guard case .failure(let error) = result else {
                XCTFail("Test getData method with no data failed. ")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
