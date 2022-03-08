//
//  Post.swift
//  Dummy
//
//  Created by Develop on 2/9/22.
//  Copyright © 2022 Develop. All rights reserved.
//

import UIKit

struct Post: Decodable {
    var id: String
    var image: String
    var text:String
    var likes:Int
    var owner: User
    var tags:[String]?
}
