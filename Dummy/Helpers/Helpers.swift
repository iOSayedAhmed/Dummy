//
//  Helpers.swift
//  Dummy
//
//  Created by Develop on 2/14/22.
//  Copyright © 2022 Develop. All rights reserved.
//

import UIKit
class Helpers {
    
   static func getImageFromURL(url:String,image:UIImageView) {
        if let imageUrl = URL(string: url){
            if let imageData = try? Data(contentsOf: imageUrl){
                image.image = UIImage(data: imageData)
            }
        }
    }
}


