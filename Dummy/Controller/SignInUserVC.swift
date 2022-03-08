//
//  SignInUserVC.swift
//  Dummy
//
//  Created by Develop on 2/20/22.
//  Copyright © 2022 Develop. All rights reserved.
//

import UIKit

class SignInUserVC: UIViewController {
//MARK:- OUTLET
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.firstNameTextField.text! = "sayed1"
        self.lastNameTextField.text! = "Ahmed"
        
        animateIn()
    }
    
    func animateIn() {
        
    }
    //MARK:- IBACTION
    
    @IBAction func DontHaveAccountButtonClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "RegisterVC") as! RegisterVC
        present(vc, animated: true)
    }
    @IBAction func signInButtonClicked(_ sender: UIButton) {
        UserAPI.signInUser(firstName: firstNameTextField.text!, lastName: lastNameTextField.text!) { (userResponse, errorMSG) in
            if let error = errorMSG {
                self.alertMSG(alertTitle: "Error", alertMessage: error, actionTitle: "OK")
            }else {
                if let user = userResponse {
                    //TODO:- present Home Page (All Posts Page)
                    let vc = self.storyboard?.instantiateViewController(identifier: "MainTabBarController")
                    UserManager.loggedInUser = user
                    self.present(vc!, animated: true)
                }
            }
            
        }
        
    }
    func alertMSG(alertTitle:String,alertMessage:String,actionTitle:String) {
               let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
               let action = UIAlertAction(title: actionTitle, style: .cancel, handler: nil)
               alert.addAction(action)
       
       self.present(alert, animated: true)
       }
    
}
