//
//  FakeReponseData.swift
//  RecipleaseTests
//
//  Created by Levent Bostanci on 03/06/2020.
//  Copyright © 2020 Levent Bostanci. All rights reserved.
//

import Foundation

final class FakeReponseData {
    static let responseOK = HTTPURLResponse(url: URL(string: "http://www.google.fr")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "http://www.google.fr")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    class NetworkError: Error {}
    static let networkError = NetworkError()
    
    static var correctData: Data {
        let bundle = Bundle(for: FakeReponseData.self)
        let url = bundle.url(forResource: "Recipe", withExtension: "json")
        let data = try! Data(contentsOf: url! )
        return data
    }
    
    static let incorrectData = "error".data(using: .utf8)!
}
