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
    
    
    var recipSearch: Hit?
    var recipe: RecipSearch?
    
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
}

extension RecipeListViewController: UITableViewDelegate ,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe?.hits.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipieTableViewCell else { return UITableViewCell() }
        cell.recipes = recipe?.hits[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 123
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        recipSearch = recipe?.hits[indexPath.row]
        
        performSegue(withIdentifier: "SegueToDescription", sender: nil)
    }




}
