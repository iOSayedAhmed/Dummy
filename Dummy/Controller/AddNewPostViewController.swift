//
//  AddNewPostViewController.swift
//  Dummy
//
//  Created by Develop on 3/1/22.
//  Copyright © 2022 Develop. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
class AddNewPostViewController: UIViewController {
    @IBOutlet weak var addButtonOutlet: UIButton!
    @IBOutlet weak var loaderIndicatorView: NVActivityIndicatorView!
    @IBOutlet weak var postTextTextField: UITextField!
    @IBOutlet weak var postImageURLTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        loaderIndicatorView.type = .ballPulseSync
        
    }
   
//MARK:- IBACTIONS
    
    @IBAction func addNewPostButtonClicked(_ sender: UIButton) {
        if let user = UserManager.loggedInUser, let text = postTextTextField.text ,let imageURL = postImageURLTextField.text {
            addButtonOutlet.setTitle("", for: .normal)
            loaderIndicatorView.startAnimating()
            PostAPI.createNewPost(imageURL: imageURL, text: text, userId: user.id) {
                NotificationCenter.default.post(name: NSNotification.Name("newPostAdded"), object: nil, userInfo: nil)
                print(imageURL)
                self.loaderIndicatorView.stopAnimating()
                self.addButtonOutlet.setTitle("Add", for: .normal)
                self.dismiss(animated: true, completion: nil)
                
                
                
            }
        }
    }
    @IBAction func closeButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
