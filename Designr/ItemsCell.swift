//
//  ItemsCell.swift
//  Designr
//
//  Created by Akshay Pimprikar on 7/6/16.
//  Copyright © 2016 Akshay Pimprikar. All rights reserved.
//

import UIKit

class ItemsCell: UICollectionViewCell {
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var designer: UILabel!
    @IBOutlet weak var rentalFee: UILabel!
    @IBOutlet weak var productDetail: UITextView!
    
    var item: Item! {
        didSet {
            name.text = item.name
            designer.text = item.designer
            let fee = item.rentalFee
            rentalFee.text = String.init(format: "Rent: $\(fee!)")
            productDetail.text = item.productDetail
            
            self.imageForLocation(item.image1URL!) { cellImage in
                self.image1.image = cellImage
            }
            self.imageForLocation(item.image2URL!) { cellImage in
                self.image2.image = cellImage
            }
            self.imageForLocation(item.image3URL!) { cellImage in
                self.image3.image = cellImage
            }
            self.imageForLocation(item.image4URL!) { cellImage in
                self.image4.image = cellImage
            }
        }
    }
    
    func imageForLocation(imageURL:String, completion: (UIImage) -> Void) -> ()
    {
        
        let session = NSURLSession.sharedSession()
        let imageDownloadTask:NSURLSessionDownloadTask  = session.downloadTaskWithURL(NSURL(string: imageURL)!) {
            (location, response, error) -> Void in
            
            if ((error) != nil) {
                print("Request failed with error: \(error)")
                dispatch_async(dispatch_get_main_queue()) {
                    let image = UIImage.init()
                    completion(image)
                }
            } else {
                let httpResponse = response as! NSHTTPURLResponse
                let statusCode = httpResponse.statusCode
                
                if (statusCode == 200) {
                    let data = NSData(contentsOfURL: location!)
                    let image = UIImage(data: data!)
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        completion(image!)
                    }
                } else {
                    print("Request failed with error: \(error)")
                    dispatch_async(dispatch_get_main_queue()) {
                        let image = UIImage.init()
                        completion(image)
                    }
                }
            }
        }
        
        imageDownloadTask.resume()
    }
}
