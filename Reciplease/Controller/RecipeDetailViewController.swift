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
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView! { didSet{tableView.tableFooterView = UIView() } }
    @IBOutlet weak var getDirectionButton: UIButton!
    @IBOutlet weak var detailYieldLabel: UILabel!
    @IBOutlet weak var detailCaloriesLabel: UILabel!
    
    private var coreDataManager: CoreDataManager?
    var recipeDetail: RecipieDetail?
    var isComeFromFavorite: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        coreDataManager = CoreDataManager(coreDataStack: appDelegate.coreDataStack)
        viewSetting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateFavoriteIcon()
    }

    private func viewSetting() {
        guard let recipeDetail = recipeDetail else { return }
        detailTitleLabel.text = recipeDetail.label
        detailYieldLabel.text = recipeDetail.yield
        detailCaloriesLabel.text = recipeDetail.calories
        detailImageView.image = recipeDetail.image != nil ? UIImage(data: recipeDetail.image!) : UIImage(named: "")
    }

    private func updateFavoriteIcon() {
        guard let coreDataManager = coreDataManager else { return }
        if coreDataManager.checkIsFavorite(title: recipeDetail?.label ?? "") {
            favoriteButton.tintColor = .orange
        } else {
            favoriteButton.tintColor = .black
        }
    }
    
    private func addFavorite() {
        guard let recipieDetail = recipeDetail else { return }
        let name = recipieDetail.label
        let ingredients = recipieDetail.ingredients
        let url = recipieDetail.url
        let yield = recipieDetail.yield
        let image = recipieDetail.image
        let calories = recipieDetail.calories
        coreDataManager?.creatRecipe(title: name, ingredients: ingredients, yield: yield, calories: calories, image: image, url: url)
    }
 
    @IBAction func getDirectionButton(_ sender: UIButton) {
        guard let url = URL(string: recipeDetail?.url ?? "") else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func addFavoriteButton(_ sender: UIBarButtonItem) {
        guard let coreDataManager = coreDataManager else { return }
        if coreDataManager.checkIsFavorite(title: recipeDetail?.label ?? "") {
            coreDataManager.deleteFromFavorite(title: recipeDetail?.label ?? "")
            favoriteButton.tintColor = .black
        } else {
            addFavorite()
            favoriteButton.tintColor = .orange
        }
        if isComeFromFavorite {
            navigationController?.popViewController(animated: true)
        }
    } 
}

extension RecipeDetailViewController: UITableViewDelegate ,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeDetail?.ingredients.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
        let ingredient = recipeDetail?.ingredients[indexPath.row]
        cell.textLabel?.text = ingredient
        return cell
    }
}
