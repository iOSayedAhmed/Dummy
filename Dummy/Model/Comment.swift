//
//  Comment.swift
//  Dummy
//
//  Created by Develop on 2/14/22.
//  Copyright © 2022 Develop. All rights reserved.
//

import UIKit
struct Comment : Decodable{
    var id:String
    var message:String
    var owner:User
}
