//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Levent Bostanci on 02/05/2020.
//  Copyright © 2020 Levent Bostanci. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var ingredientTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var tableView: UITableView! { didSet{tableView.tableFooterView = UIView() } }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchButton: UIButton!
    
    //MARK: Variables
    private let recipeService = RecipeService()
    private var ingredients = [String]()
    private var recipes: RecipSearch?
    
    //MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        ingredientTextField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //Hidden Keyborard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //Segue to RecipeListViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToRecipeList" {
            guard let resultVC = segue.destination as? RecipeListViewController else { return }
            resultVC.recipes = recipes
        }
    }
    
    //MARK: Functions
    private func addIngredients() {
        guard let ingredient = ingredientTextField?.text, !ingredient.isBlank else { return showErrorPopup(title: "Empty", message: "Please add your ingredients") }
        ingredients.append(ingredient)
        ingredientTextField.text = ""
        tableView.reloadData()
    }
    
    private func getRecipe() {
        if !ingredients.isEmpty {
            activityIndicator.isHidden = false
            recipeService.getData(ingredients: ingredients) { result in
                self.activityIndicator.isHidden = true
                switch result {
                case .success(let data):
                    self.recipes = data
                    self.performSegue(withIdentifier: "SegueToRecipeList", sender: nil)
                case .failure(_):
                    self.showErrorPopup(title: "No data", message: "No data")
                }
            }
        } else {
            showErrorPopup(title: "Empty", message: "Please add your ingredients")
        }
    }
    
    //MARK: Actions
    @IBAction private func searchButtonPressed(_ sender: Any) {
        getRecipe()
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        addIngredients()
    }
    
    @IBAction func clearButtonPressed(_ sender: Any) {
        ingredients.removeAll()
        tableView.reloadData()
    }
}

//MARK: TableView Extension
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)
        cell.textLabel?.text = ingredients[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ingredients.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Add some ingredients in the list"
        label.font = UIFont(name:"Noteworthy", size: 20)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return ingredients.isEmpty ? 200 : 0
    }
}

//MARK: TextField Extension
extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

