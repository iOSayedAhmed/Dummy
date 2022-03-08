//
//  API.swift
//  Dummy
//
//  Created by Develop on 2/16/22.
//  Copyright © 2022 Develop. All rights reserved.
//

import UIKit
import Alamofire

class API {
    
      static let baseURL = "https://dummyapi.io/data/v1"
      static let appID = "621de8b850039ea4915c4c79"
      static let headers: HTTPHeaders = [
          "app-id": appID
      ]
}
