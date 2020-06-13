//
//  FavoriteViewController.swift
//  Reciplease
//
//  Created by Levent Bostanci on 19/05/2020.
//  Copyright © 2020 Levent Bostanci. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView! { didSet{tableView.tableFooterView = UIView() } }
    
    //MARK: Variables
    private var coreDataManager: CoreDataManager?
    private var recipeDetail: RecipieDetail?

    //MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "RecipieTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "RecipeCell")
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coreDataStack = appDelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    //Segue to RecipeDetailViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? RecipeDetailViewController else { return }
        vc.recipeDetail = recipeDetail
        vc.isComeFromFavorite = true
    }
}

//MARK: TableViewExtension
extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataManager?.recipeElements.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipieTableViewCell else { return UITableViewCell() }
        let favoriteRecipe = coreDataManager?.recipeElements[indexPath.row]
        cell.favoriteRecipes = favoriteRecipe
        return cell
    }
    
    //Show message when tableView is empty
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "You have no favorite recipes."
        label.font = UIFont(name:"Noteworthy", size: 20)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 123
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return coreDataManager?.recipeElements.isEmpty ?? true ? 123 : 0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let recipeName = coreDataManager?.recipeElements[indexPath.row].title else { return }
        coreDataManager?.deleteFromFavorite(title: recipeName)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let recipe = coreDataManager?.recipeElements[indexPath.row] else { return }
        recipeDetail = RecipieDetail(label: recipe.title ?? "", image: recipe.image, yield: recipe.yield ?? "", url: recipe.url ?? "", calories: recipe.calories ?? "", ingredients: recipe.ingredients ?? [])
        performSegue(withIdentifier: "SegueFavoriteToDescription", sender: nil)
    }
    
    
}

