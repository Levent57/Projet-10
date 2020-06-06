//
//  MokeRecipeSearch.swift
//  RecipleaseTests
//
//  Created by Levent Bostanci on 03/06/2020.
//  Copyright © 2020 Levent Bostanci. All rights reserved.
//

@testable import Reciplease
import Foundation
import Alamofire

struct FakeResponse {
    var response: HTTPURLResponse?
    var data: Data?
}

final class MockRecipeSearch: AlamoSession {
    
    private let fakeResponse: FakeResponse
    
    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
    }
    
    func request(_ url: URL, callback: @escaping (DataResponse<Any>) -> Void) {
        let httpResponse = fakeResponse.response
        let data = fakeResponse.data
        
        let result = Request.serializeResponseJSON(options: .fragmentsAllowed, response: httpResponse, data: data, error: nil)
        let urlRequest = URLRequest(url: URL(string: "http://www.google.fr")!)
        callback(DataResponse(request: urlRequest, response: httpResponse, data: data, result: result))
        
    }
}

