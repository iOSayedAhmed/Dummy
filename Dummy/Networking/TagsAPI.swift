//
//  TagsAPI.swift
//  Dummy
//
//  Created by Develop on 2/28/22.
//  Copyright © 2022 Develop. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TagAPI: API {
    static  func getAllTags(completionHandler: @escaping ([String])->()) {
        let url = "\(baseURL)/tag"
        
        
        AF.request(url,headers: headers ).responseJSON { (response) in
            let jsonData = JSON(response.value)
            let data = jsonData["data"]
            let decoder = JSONDecoder()
            do {
                let tags = try decoder.decode([String].self, from: data.rawData())
                completionHandler(tags)
                
            } catch {
                print(error.localizedDescription)
            }
            
            
        }
    }
    
}
