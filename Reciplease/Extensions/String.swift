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
}
