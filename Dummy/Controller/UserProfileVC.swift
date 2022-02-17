//
//  UserProfileVC.swift
//  Dummy
//
//  Created by Develop on 2/15/22.
//  Copyright © 2022 Develop. All rights reserved.
//

import UIKit



class UserProfileVC: UIViewController {
    
    var user:User!
    
    //MARK:- OUTLET
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userPhoneLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    //MARK:- LIFE CYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        userImageView.makeCircularImage()
        setUpUI()
        UserAPI.getUserInfo(userId: user.id) { userResponse in
            self.user = userResponse
            self.setUpUI()
        }
        
    }
    
    func setUpUI() {
        userImageView.setImageFromStringUrl(stringUrl: user.picture)
        userEmailLabel.text = user.email
        userNameLabel.text = user.firstName + " " + user.lastName
        userPhoneLabel.text = user.phone
        genderLabel.text = user.gender
        countryLabel.text = user.location?.country
        let birthday = user.dateOfBirth
        let seperated = birthday?.split(separator: "T")
        if let birthDay = seperated?.first {
            self.birthdayLabel.text = String(birthDay)
        }
        

    }

}
