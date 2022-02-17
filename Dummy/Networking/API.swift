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
      static let appID = "62036cf6322f55adfd3ba956"
      static let headers: HTTPHeaders = [
          "app-id": appID
      ]
}
