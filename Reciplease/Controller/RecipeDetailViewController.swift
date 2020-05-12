//
//  RecipeDetailViewController.swift
//  Reciplease
//
//  Created by Levent Bostanci on 04/05/2020.
//  Copyright © 2020 Levent Bostanci. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var DetailImageLabel: UIImageView!
    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var detailIngredientLabel: UITextView!
    @IBOutlet weak var getDirectionButton: UIButton!
    @IBOutlet weak var detailYieldLabel: UILabel!
    @IBOutlet weak var detailCaloriesLabel: UILabel!
    
    var recipe: RecipSearch?
    var recipeSearch: Hit?
    var recipes: Recipe?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetting()
    }
    
    
    func viewSetting() {
        detailTitleLabel.text = recipeSearch?.recipe.label
        detailIngredientLabel.text = recipeSearch?.recipe.ingredientLines.joined(separator: "\n" + "- ")
    }
}
