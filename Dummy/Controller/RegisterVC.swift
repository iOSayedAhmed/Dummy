//
//  RegisterVC.swift
//  Dummy
//
//  Created by Develop on 2/18/22.
//  Copyright © 2022 Develop. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {
    var user:User!
    //MARK:- OUTLET
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    //MARK:- IBACTION
    
    @IBAction func haveAccountButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func registerButtonClicked(_ sender: Any) {
        
        UserAPI.registerNewUser(firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, email: emailTextField.text!) { (user, error) in
            if let  error = error  {
                //Failure
                self.alertMSG(alertTitle: "Error", alertMessage: error, actionTitle: "OK")
                
            }else {
                //Success
                self.alertMSG(alertTitle: "Success", alertMessage: "User Registered Successfully", actionTitle: "OK")
               self.user = user

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
