//
//  PostDetailsVC.swift
//  Dummy
//
//  Created by Develop on 2/10/22.
//  Copyright © 2022 Develop. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class PostDetailsVC: UIViewController {
    var post:Post!
    var comments:[Comment] = []
    
    
    //MARK:- OUTLET
    
    @IBOutlet weak var addCommentSV: UIStackView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var userNameLabel: UILabel!{
        didSet{
            userImageView.layer.cornerRadius = userImageView.frame.size.width / 2
        }
    }
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var PostTextLabel: UILabel!
    @IBOutlet weak var PostImageView: UIImageView!
    @IBOutlet weak var postLikesLabel: UILabel!
    
    //MARK:- LIFE CYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        commentTableView.register(UINib(nibName: "PostCommentsCell", bundle: nil), forCellReuseIdentifier: "PostCommentsCell")
        
        PostTextLabel.text = post.text
        userNameLabel.text = post.owner.firstName + " " + post.owner.lastName
        postLikesLabel.text = String(post.likes)
        if let userImage = userImageView , let picture = post.owner.picture
        {
                Helpers.getImageFromURL(url: picture, image: userImage)
        }
        if let postImage = PostImageView
               {
                   Helpers.getImageFromURL(url: post.image, image: postImage)
               }
        // Configure ActitvityIndecator (Loader )
        activityIndicatorView.color = #colorLiteral(red: 0.2588235294, green: 0.6235294118, blue: 0.6666666667, alpha: 1)
        activityIndicatorView.type = .ballPulseSync
        //Getting Post Comments from API
        getAllComments()
    }
    
    func getAllComments() {
        if UserManager.loggedInUser == nil {
            addCommentSV.isHidden = true
        }
        activityIndicatorView.startAnimating()
        PostAPI.getAllPostComments(postId: post.id) { commentResponce in
            self.comments = commentResponce
            self.commentTableView.reloadData()
            self.activityIndicatorView.stopAnimating()
        }
    }
    
    
    //MARK:- IBACTIONS
    @IBAction func backButtonClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendCommentClicked(_ sender: UIButton) {
        if let comment = commentTextField.text  {
            if let user = UserManager.loggedInUser?.id{
                PostAPI.createNewCommment(postId: post.id, userId: user, message: comment) {
                    self.getAllComments()
                    self.commentTextField.text = ""
                    
                }
            }
            
        }
    }
    
}
extension PostDetailsVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCommentsCell", for: indexPath) as! PostCommentsCell
        cell.userNameLabel.text = comments[indexPath.row].owner.firstName + " " + comments[indexPath.row].owner.lastName
        cell.commentMessageLabel.text = comments[indexPath.row].message
        if let userImage = cell.userImageView {
            if let image = comments[indexPath.row].owner.picture
            {
                Helpers.getImageFromURL(url:image , image: userImage)
            }
            
        }
            
       
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
   
}
