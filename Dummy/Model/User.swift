//
//  User.swift
//  Dummy
//
//  Created by Develop on 2/9/22.
//  Copyright © 2022 Develop. All rights reserved.
//

import UIKit

struct User: Decodable {
    var id: String
    var firstName:String
    var lastName: String
    var picture:String?
    var email:String?
    var phone:String?
    var dateOfBirth: String?
    var location:Location?
    var gender:String?
    
    
}

