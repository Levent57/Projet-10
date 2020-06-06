//
//  ErrorAlert.swift
//  Reciplease
//
//  Created by Levent Bostanci on 19/05/2020.
//  Copyright © 2020 Levent Bostanci. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showErrorPopup(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}
