//
//  UserAPI.swift
//  Dummy
//
//  Created by Develop on 2/16/22.
//  Copyright © 2022 Develop. All rights reserved.
//

//
//  ProfileAPI.swift
//  Dummy
//
//  Created by Develop on 2/16/22.
//  Copyright © 2022 Develop. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class UserAPI : API{
    static func getUserInfo (userId:String, completionHandler: @escaping (User)->()){
        let url = "\(baseURL)/user/\(userId)"
        
        
        AF.request(url,headers: headers ).responseJSON { (response) in
            let jsonData = JSON(response.value)
            let decoder = JSONDecoder()
            do {
                let user = try decoder.decode(User.self, from: jsonData.rawData())
                completionHandler(user)
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }
}

