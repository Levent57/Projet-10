//
//  String.swift
//  Reciplease
//
//  Created by Levent Bostanci on 01/05/2020.
//  Copyright © 2020 Levent Bostanci. All rights reserved.
//

import Foundation

extension String {
    var isBlank: Bool {
        return self.trimmingCharacters(in: .whitespaces) == String() ? true : false
    }
    
    var data: Data? {
        guard let url = URL(string: self) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        return data
    }
}
