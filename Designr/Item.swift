//
//  Item.swift
//  Designr
//
//  Created by Akshay Pimprikar on 7/6/16.
//  Copyright © 2016 Akshay Pimprikar. All rights reserved.
//

import Foundation

class Item {
    let name: String
    let designer: String?
    let rentalFee: String?
    let productDetail: String?
    let image1URL: String?
    let image2URL: String?
    let image3URL: String?
    let image4URL: String?
    
    init(name: String?, designer: String?, rentalFee: String?, productDetail: String?, image1URL: String?, image2URL: String?, image3URL: String?, image4URL: String?) {
        
        self.name = name!
        self.designer = designer
        self.rentalFee = rentalFee
        self.productDetail = productDetail
        self.image1URL = image1URL
        self.image2URL = image2URL
        self.image3URL = image3URL
        self.image4URL = image4URL
    }
}