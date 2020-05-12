//
//  RecipieTableViewCell.swift
//  Reciplease
//
//  Created by Levent Bostanci on 06/05/2020.
//  Copyright © 2020 Levent Bostanci. All rights reserved.
//

import UIKit

class RecipieTableViewCell: UITableViewCell {

    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var YieldLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var recipes: Hit? {
        didSet {
            titleLabel.text = recipes?.recipe.label
            ingredientsLabel.text = recipes?.recipe.ingredientLines.joined(separator: ", ")
            YieldLabel.text = String(recipes?.recipe.yield ?? 0)
            caloriesLabel.text = String(recipes?.recipe.calories ?? 0)
            recipeImageView.image = UIImage(named: (recipes?.recipe.image) ?? "Diabetes-Superfoods-min.jpg")
        }
    }

}
