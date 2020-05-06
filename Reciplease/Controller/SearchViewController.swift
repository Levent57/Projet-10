//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Levent Bostanci on 02/05/2020.
//  Copyright © 2020 Levent Bostanci. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    
    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var tableView: UITableView! { didSet{tableView.tableFooterView = UIView() } }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchButton: UIButton!
    
    let recipeService = RecipeService()
    var ingredients = [String]()
    var recipSearch = [Hit]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        addIngredients()
        tableView.reloadData()
        print(ingredients.count)
    }
    
    @IBAction func clearButtonPressed(_ sender: Any) {
        ingredients.removeAll()
        tableView.reloadData()
    }
    
    
    func addIngredients() {
        guard let ingredient = ingredientTextField?.text, !ingredient.isBlank else { return }
        ingredients.append(ingredient)
        tableView.reloadData()
    }
    
    
    
}

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
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return ingredients.isEmpty ? 200 : 0
    }
    
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

