//
//  RecipeTableViewController.swift
//  Reciplease
//
//  Created by Levent Bostanci on 04/05/2020.
//  Copyright © 2020 Levent Bostanci. All rights reserved.
//

import UIKit

class RecipeListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    var recipes: RecipSearch?
    private var recipe: Recipe?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "RecipieTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "RecipeCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToDescription" {
            guard let resultVC = segue.destination as? RecipeDetailViewController else { return }
            guard let recipe = recipe else { return }
            let recipieDetail = RecipieDetail(label: recipe.label, image: recipe.image?.data, yield: String(recipe.yield), url: recipe.url, calories: String(recipe.calories), ingredients: recipe.ingredientLines)
            resultVC.recipeDetail = recipieDetail
            resultVC.isComeFromFavorite = false
        }
    }
}

extension RecipeListViewController: UITableViewDelegate ,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes?.hits.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipieTableViewCell else { return UITableViewCell() }
        cell.recipes = recipes?.hits[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 123
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let recipes = recipes else { return }
        recipe = recipes.hits[indexPath.row].recipe
        performSegue(withIdentifier: "SegueToDescription", sender: recipe)
    }




}
