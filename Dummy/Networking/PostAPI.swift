//
//  PostAPI.swift
//  Dummy
//
//  Created by Develop on 2/16/22.
//  Copyright © 2022 Develop. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PostAPI : API {
  
    
  static  func getAllPosts(completionHandler: @escaping ([Post])->()) {
        let url = "\(baseURL)/post"
        
        
        AF.request(url,headers: headers ).responseJSON { (response) in
            let jsonData = JSON(response.value)
            let data = jsonData["data"]
            let decoder = JSONDecoder()
            do {
                let post = try decoder.decode([Post].self, from: data.rawData())
                completionHandler(post)
                
            } catch {
                print(error.localizedDescription)
            }
            
            
        }
    }
    
    static func getAllPostComments(postId:String,completionHandler: @escaping ([Comment])->()) {
                let url = "\(baseURL)/post/\(postId)/comment"
                let headers : HTTPHeaders = [
                    "app-id":"62036cf6322f55adfd3ba956"
                ]
            AF.request(url,headers: headers).responseJSON { response in
                   
                     let jsonData = JSON(response.value)
                    let data = jsonData["data"]
                        let decoder = JSONDecoder()
                        do {
                            let comments = try decoder.decode([Comment].self, from: try! data.rawData())
                            completionHandler(comments)
                        }catch let error {
                            print(error.localizedDescription)
                        }
                }
    }
}

