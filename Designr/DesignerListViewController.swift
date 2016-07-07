//
//  DesignerListViewController.swift
//  Designr
//
//  Created by Akshay Pimprikar on 7/6/16.
//  Copyright © 2016 Akshay Pimprikar. All rights reserved.
//

import UIKit

class DesignerListViewController: UITableViewController {

    var designersList = [String]()
    var favoriteDesignersList = [String]()
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = NSUserDefaults.standardUserDefaults()
        if ((defaults.objectForKey("favorites") as? [String]) != nil) {
            favoriteDesignersList = (defaults.objectForKey("favorites") as? [String])!
        }
        self.fetchDesignersList()
    }
    
    func fetchDesignersList() {
        networkManager.fetchAccesoriesDesigners {responseArray in
            for response in responseArray {
                self.designersList.append(response as! String)
            }
            
            self.networkManager.fetchDressesDesigners {responseArray in
                for response in responseArray {
                    if !self.designersList.contains(response as! String) {
                        self.designersList.append(response as! String)
                    }
                }
                self.designersList = self.designersList.sort(){$0 < $1}
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if designersList.count != 0 {
            return designersList.count
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("designerCell", forIndexPath: indexPath)
        
        if designersList.count > 0 {
            cell.textLabel?.text = designersList[indexPath.row]
            let button : UIButton = UIButton(type: UIButtonType.ContactAdd)
            button.frame = CGRectMake(315, 11, 22, 22)
            button.tag = indexPath.row
            button.addTarget(self, action: #selector(DesignerListViewController.buttonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            cell.addSubview(button)
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        [self.tableView .deselectRowAtIndexPath(indexPath, animated: false)]
    }
    
    func buttonClicked(sender: UIButton!) {
        if !favoriteDesignersList.contains(designersList[sender.tag]) {
            favoriteDesignersList.append(designersList[sender.tag])
        }
        let indexPath = NSIndexPath(forRow: sender.tag, inSection: 0)
        [self.tableView .selectRowAtIndexPath(indexPath, animated: false, scrollPosition: .None)]
        self.tableView(self.tableView, didSelectRowAtIndexPath: indexPath);
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(self.favoriteDesignersList, forKey: "favorites")
        defaults.synchronize()
        
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showFavorites" {
            if let favoriteTableViewController = segue.destinationViewController as? FavoriteDesignersTableViewController {
                
                self.favoriteDesignersList = self.favoriteDesignersList.sort(){$0 < $1}
                favoriteTableViewController.favoriteDesigners = self.favoriteDesignersList
            }
        }
    }
}
