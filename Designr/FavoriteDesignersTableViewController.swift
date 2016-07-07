//
//  FavoriteDesignersTableViewController.swift
//  Designr
//
//  Created by Akshay Pimprikar on 7/6/16.
//  Copyright © 2016 Akshay Pimprikar. All rights reserved.
//

import UIKit

class FavoriteDesignersTableViewController: UITableViewController {

    var favoriteDesigners = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Favorites"
    }
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if favoriteDesigners.count != 0 {
            return favoriteDesigners.count
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("favoritesCell", forIndexPath: indexPath)
        
        if favoriteDesigners.count > 0 {
        cell.textLabel?.text = favoriteDesigners[indexPath.row]
        }
        return cell
    }
}
