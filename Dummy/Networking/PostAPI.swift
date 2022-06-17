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
  
    
    static  func getAllPosts <T:Decodable>(page:Int,tag:String?,completionHandler: @escaping ([T]?,Int)->()) {
        var url = "\(baseURL)/post"
        if let tag = tag?.trimmingCharacters(in: .whitespaces) {
             url = "\(baseURL)/tag/\(tag)/post"
         }
        let params = [
            "page":"\(page)",
            "limit":"5"
        ]
        
        
        
        AF.request(url,parameters: params,encoder: URLEncodedFormParameterEncoder.default,headers: headers ).responseJSON { (response) in
            let jsonData = JSON(response.value)
            let data = jsonData["data"]
            let total = jsonData["total"].intValue
            let decoder = JSONDecoder()
            do {
                let post = try decoder.decode([T].self, from: data.rawData())
                completionHandler(post,total)
                
            } catch {
                print(error.localizedDescription)
            }
            
            
        }
    }
    
    static func getAllPostComments(postId:String,completionHandler: @escaping ([Comment])->()) {
                let url = "\(baseURL)/post/\(postId)/comment"
                let headers : HTTPHeaders = [
                    "app-id": appID
                ]
            AF.request(url,headers: headers).responseJSON { response in
                   
                     let jsonData = JSON(response.value)
                    let data = jsonData["data"]
                        let decoder = JSONDecoder()
                        do {
                            let comments = try decoder.decode([Comment].self, from: data.rawData())
                            completionHandler(comments)
                        }catch let error {
                            print(error.localizedDescription)
                        }
                }
    }
    
    //MARK:- Create New Comment
    
    static func createNewCommment(postId:String, userId:String,message:String , completionHandler: @escaping ()->()) {
        let url = "\(baseURL)/comment/create"
        let params = [
            "post":postId,
            "owner":userId,
            "message":message
        ]
        AF.request(url,method: .post,parameters: params, encoder: JSONParameterEncoder.default,headers: headers).validate().responseJSON { response in
            
            switch response.result {
            case .success :
                completionHandler()
            case .failure :
                completionHandler()
            }
            
        }
        
    }
    
    
    static func createNewPost(imageURL:String ,text:String,userId:String, completionHandler: @escaping ()->()) {
        let url = "\(baseURL)/post/create"
        let params = [
            "text":text,
            "owner":userId,
            "image":imageURL
        ]
        AF.request(url,method: .post,parameters: params, encoder: JSONParameterEncoder.default,headers: headers).validate().responseJSON { response in
            
            switch response.result {
            case .success :
                completionHandler()
            case .failure :
                completionHandler()
            }
            
        }
        
    }
}

