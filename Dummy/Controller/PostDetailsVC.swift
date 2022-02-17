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
    
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var userNameLabel: UILabel!
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
        if let userImage = userImageView
        {
            Helpers.getImageFromURL(url: post.owner.picture, image: userImage)
        }
        if let postImage = PostImageView
               {
                   Helpers.getImageFromURL(url: post.image, image: postImage)
               }
        // Configure ActitvityIndecator (Loader )
        activityIndicatorView.color = #colorLiteral(red: 0.2588235294, green: 0.6235294118, blue: 0.6666666667, alpha: 1)
        activityIndicatorView.type = .ballPulseSync
        activityIndicatorView.startAnimating()
        //Getting Post Comments from API
        PostAPI.getAllPostComments(postId: post.id) { commentResponce in
            self.comments = commentResponce
            self.commentTableView.reloadData()
            self.activityIndicatorView.stopAnimating()
        }
    }
    
    //MARK:- Functions
//
//    func getAllPostComments() {
//        let url = "https://dummyapi.io/data/v1/post/\(post.id)/comment"
//        let headers : HTTPHeaders = [
//            "app-id":"62036cf6322f55adfd3ba956"
//        ]
//        AF.request(url,headers: headers).responseJSON { response in
//            self.activityIndicatorView.stopAnimating()
//             let jsonData = JSON(response.value)
//            let data = jsonData["data"]
//                let decoder = JSONDecoder()
//                do {
//                    self.comments = try decoder.decode([Comment].self, from: try! data.rawData())
//
//                    self.commentTableView.reloadData()
//
//                }catch let error {
//                    print(error.localizedDescription)
//                }
//
//        }
//
//    }

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
            Helpers.getImageFromURL(url: comments[indexPath.row].owner.picture, image: userImage)
        }
            
       
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
   
}
