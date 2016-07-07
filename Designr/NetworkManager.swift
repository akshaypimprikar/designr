//
//  NetworkManager.swift
//  Designr
//
//  Created by Akshay Pimprikar on 7/6/16.
//  Copyright © 2016 Akshay Pimprikar. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class NetworkManager {

    func fetchAccesoriesDesigners(completion: (NSArray) -> Void) -> () {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        let accesoriesURL: NSURL = NSURL(string: "http://static.sqvr.co/designer-accesories.json")!
        let accesoriesURLRequest: NSMutableURLRequest = NSMutableURLRequest(URL: accesoriesURL)
        
        let session = NSURLSession.sharedSession()
        let accesoriesTask = session.dataTaskWithRequest(accesoriesURLRequest) {
            (data, response, error) -> Void in
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                let json:JSON = JSON(data: data!)
                
                var responseArray = [String]()
                if let results = json["designer"].array {
                    for entry in results {
                        responseArray.append(entry.description)
                    }
                }
                dispatch_async(dispatch_get_main_queue()) {
                    completion(responseArray)
                }
            } else {
                print("Request failed with error: \(error)")
            }
        }
        
        accesoriesTask.resume()
        
    }
    
    func fetchDressesDesigners(completion: (NSArray) -> Void) -> () {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        let dressesURL: NSURL = NSURL(string: "http://static.sqvr.co/designer-dresses.json")!
        let dressesURLRequest: NSMutableURLRequest = NSMutableURLRequest(URL: dressesURL)
        
        let session = NSURLSession.sharedSession()
        let dressesTask = session.dataTaskWithRequest(dressesURLRequest) {
            (data, response, error) -> Void in
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                let json:JSON = JSON(data: data!)
                
                var responseArray = [String]()
                if let results = json["designer"].array {
                    for entry in results {
                        responseArray.append(entry.description)
                    }
                }
                dispatch_async(dispatch_get_main_queue()) {
                    completion(responseArray)
                }
            } else {
                print("Request failed with error: \(error)")
            }
        }
        
        dressesTask.resume()
        
    }
    
    func fetchItems(completion: ([Item]) -> Void) -> () {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        let itemsURL: NSURL = NSURL(string: "http://static.sqvr.co/random-items.json")!
        let itemsURLRequest: NSMutableURLRequest = NSMutableURLRequest(URL: itemsURL)
        
        let session = NSURLSession.sharedSession()
        let itemsTask = session.dataTaskWithRequest(itemsURLRequest) {
            (data, response, error) -> Void in
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false

            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            var itemsArray = [Item]()
            if (statusCode == 200) {
                let json:JSON = JSON(data: data!)
                
                if let results = json["products"].array {
                    for itemEntry in results {
                        
                        let images = itemEntry["imagesBySize"]
                        let selectedImages = images["183x"]
                        let item = Item(name: itemEntry["displayName"].description, designer: itemEntry["designer"].description, rentalFee: itemEntry["rentalFee"].description, productDetail: itemEntry["productDetail"].description, image1URL: selectedImages[0].description, image2URL: selectedImages[1].description, image3URL: selectedImages[2].description, image4URL: selectedImages[3].description) 
                        itemsArray.append(item)
                    }
                }
                    dispatch_async(dispatch_get_main_queue()) {
                    completion(itemsArray)
                }
                
            } else {
                print("Request failed with error: \(error)")
            }
        }
        
            itemsTask.resume()
    }
}