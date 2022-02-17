//
//  UIImageView+StringUrlToImage.swift
//  Dummy
//
//  Created by Develop on 2/15/22.
//  Copyright © 2022 Develop. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImageFromStringUrl(stringUrl:String) {
        if let imageUrl = URL(string: stringUrl) {
            if let imageData = try? Data(contentsOf: imageUrl)
            {
                self.image = UIImage(data: imageData)
            }
        }
    }
    
    func makeCircularImage() {
        self.layer.cornerRadius = self.frame.width / 2
    }
    
}
