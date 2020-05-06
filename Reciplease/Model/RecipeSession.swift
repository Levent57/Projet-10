//
//  RecipeSession.swift
//  Reciplease
//
//  Created by Levent Bostanci on 01/05/2020.
//  Copyright © 2020 Levent Bostanci. All rights reserved.
//

import Foundation
import Alamofire

protocol AlamoSession {
    func request(_ url: URL, callback: @escaping (DataResponse<Any>) -> Void)
}

class RecipeSession: AlamoSession {
    func request(_ url: URL, callback: @escaping (DataResponse<Any>) -> Void) {
        Alamofire.request(url).responseJSON { responseData in
            callback(responseData)
        }
    }
    
    
}
