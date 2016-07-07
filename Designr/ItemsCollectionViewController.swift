//
//  ItemsCollectionViewController.swift
//  Designr
//
//  Created by Akshay Pimprikar on 7/6/16.
//  Copyright © 2016 Akshay Pimprikar. All rights reserved.
//

import UIKit

class ItemsCollectionViewController: UICollectionViewController {

    var itemsList:[Item] = []
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Items"
        self.fetchItemsList()
    }
    
    func fetchItemsList() {
        networkManager.fetchItems {response in
            self.itemsList = response
            self.collectionView?.reloadData()
        }
    }
    
    // MARK: - UICollectionViewDataSource protocol
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.itemsList.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("itemsCell", forIndexPath: indexPath) as! ItemsCell
        
        if itemsList.count > 0 {
            let item = itemsList[indexPath.row] as Item
            cell.item = item
        }
        
        return cell
    }
}
