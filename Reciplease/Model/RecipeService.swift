//
//  RecipeService.swift
//  Reciplease
//
//  Created by Levent Bostanci on 01/05/2020.
//  Copyright © 2020 Levent Bostanci. All rights reserved.
//

import Foundation


enum RecipeError: Error {
    case noData, incorrectResponse, undecodable
}

class RecipeService {
    
    let session: AlamoSession
    let applicationId = "17234bca"
    let apiKey = "7e4a9a7e6aeaad719787cc4ad4e696d3"
    
    init(session: AlamoSession = RecipeSession()) {
        self.session = session
    }
    
    func getData(ingredients: String, callback: @escaping (Result<RecipSearch, Error>) -> Void) {
        guard let url = getURL(ingredients: ingredients) else { return }
        session.request(url) { (responseData) in
            guard let data = responseData.data else { callback(.failure(RecipeError.noData))
                return
            }
            guard responseData.response?.statusCode == 200 else { callback(.failure(RecipeError.incorrectResponse))
                return
            }
            guard let dataDecoded = try? JSONDecoder().decode(RecipSearch.self, from: data) else {
                callback(.failure(RecipeError.undecodable))
                return
            }
            callback(.success(dataDecoded))
        }
    }
    

        func getURL (ingredients: String) -> URL? {
            let urlAdress = "https://api.edamam.com/search?q=\(ingredients)&app_id=\(applicationId)&app_key=\(apiKey)"
            guard let urlString = urlAdress.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil }
            guard let url = URL(string: urlString) else { return nil }
            return url
        }
        
    }
