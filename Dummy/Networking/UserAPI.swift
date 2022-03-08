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
    
    static func registerNewUser(firstName:String, lastName:String ,email:String, completionHandler: @escaping (User?,String?)->()) {
        let url = "\(baseURL)/user/create"
        let params = [
            
                "firstName" :  firstName,
                "lastName" :  lastName,
                "email"  : email
            
        ]
        AF.request(url,method: .post,parameters: params,encoder:JSONParameterEncoder.default,headers: headers).validate().responseJSON { response in
            
            switch response.result {
            case .success :
             
                do {
                    let jsonData = JSON(response.value)
                    let decoder = JSONDecoder()
                    let user = try decoder.decode(User.self, from: jsonData.rawData())
                    completionHandler(user,nil)
                }catch let error {
                    print(error.localizedDescription)
                }
            case .failure :
                 let errorJSON = JSON(response.data)
                    let data = errorJSON["data"]
                 let emailError = data["email"].stringValue
                 let firstNameErorr = data["firstName"].stringValue
                 let lastNameErorr = data["lastName"].stringValue
                 let errorMSG = emailError + " " + firstNameErorr + " " + lastNameErorr

                    completionHandler(nil,errorMSG)
            }
            
        }
        
    }
    
    static func signInUser(firstName:String, lastName:String , completionHandler: @escaping (User?,String?)->()) {
        let url = "\(baseURL)/user"
        let params = [
            "created":"1"
        ]
        AF.request(url,method: .get,parameters: params, encoder: URLEncodedFormParameterEncoder.default,headers: headers).validate().responseJSON { response in
            
            switch response.result {
            case .success :
             
                do {
                    let jsonData = JSON(response.value)
                    let data = jsonData["data"]
                    let decoder = JSONDecoder()
                    let users = try decoder.decode([User].self, from: data.rawData())
                    
                    var foundUser:User?
                    for user in users {
                        if user.firstName == firstName && user.lastName == lastName {
                            foundUser = user
                            break
                        }
                    }
                    
                    if let user = foundUser{
                        completionHandler(user,nil)
                    }else {
                        completionHandler(nil,"The FirstName and LastName Not matched any User .. ")
                    }
                    
                }catch let error {
                    print(error.localizedDescription)
                }
            case .failure :
                 let errorJSON = JSON(response.data)
                    let data = errorJSON["data"]
                 let errorMSG = data["email"].stringValue
                    completionHandler(nil,errorMSG)
            }
            
        }
        
    }
    
//Update User
    static func updateUser(userId: String,firstName:String, phone:String ,imageURL:String, completionHandler: @escaping (User?,String?)->()) {
        let url = "\(baseURL)/user/\(userId)"
        let params = [
            
                "firstName" :  firstName,
                "phone" :  phone,
                "picture"  : imageURL
            
        ]
        AF.request(url,method: .put,parameters: params,encoder:JSONParameterEncoder.default,headers: headers).validate().responseJSON { response in
            
            switch response.result {
            case .success :
             
                do {
                    let jsonData = JSON(response.value)
                    let decoder = JSONDecoder()
                    let user = try decoder.decode(User.self, from: jsonData.rawData())
                    completionHandler(user,nil)
                }catch let error {
                    print(error.localizedDescription)
                }
            case .failure :
                 let errorJSON = JSON(response.data)
                    let data = errorJSON["data"]
                 let emailError = data["email"].stringValue
                 let firstNameErorr = data["firstName"].stringValue
                 let lastNameErorr = data["lastName"].stringValue
                 let errorMSG = emailError + " " + firstNameErorr + " " + lastNameErorr

                    completionHandler(nil,errorMSG)
            }
            
        }
        
    }
}


