//
//  EditProfileVC.swift
//  Dummy
//
//  Created by Develop on 3/5/22.
//  Copyright © 2022 Develop. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
class EditProfileVC: UIViewController {

    //MARK:- OUTLETS
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var userPhoneNumerTextField: UITextField!
    
    @IBOutlet weak var loaderIndecator: NVActivityIndicatorView!
    @IBOutlet weak var userImageURlTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }
    func setUpUI() {
        if let user = UserManager.loggedInUser
        {
            if let image = user.picture {
                userImageView.makeCircularImage()
                userImageView.setImageFromStringUrl(stringUrl: image)
            }
            userNameLabel.text = user.firstName + " " + user.lastName
            firstNameTextField.text = user.firstName
            userPhoneNumerTextField.text = user.phone
            userImageURlTextField.text = user.picture
        }
    }
    //MARK:- IBACTIONS
    
    @IBAction func submitButtonClicked(_ sender: UIButton) {
        guard let userlogged = UserManager.loggedInUser else {return}
                loaderIndecator.startAnimating()

        UserAPI.updateUser(userId: userlogged.id, firstName: firstNameTextField.text!, phone: userPhoneNumerTextField.text!, imageURL: userImageURlTextField.text!) { (responseUser, error) in
            self.loaderIndecator.stopAnimating()

            if let user = responseUser {
                if let image = user.picture {
                    self.userImageView.makeCircularImage()
                    self.userImageView.setImageFromStringUrl(stringUrl: image)
                }
                self.userNameLabel.text = user.firstName
                self.userPhoneNumerTextField.text = user.phone
            }
            
        }
    }
    
}
