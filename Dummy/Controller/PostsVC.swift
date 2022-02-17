//
//  ViewController.swift
//  Dummy
//
//  Created by Develop on 2/9/22.
//  Copyright © 2022 Develop. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class PostsVC: UIViewController {
   
    
    var posts : [Post] = []
    
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    //MARK:- OUTLET
    @IBOutlet weak var postTableView: UITableView!
    
    //MARK:- LIFE CYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        postTableView.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "PostCell")
        navigationController?.navigationBar.prefersLargeTitles = true
        
         activityIndicatorView.color = #colorLiteral(red: 0.2588235294, green: 0.6235294118, blue: 0.6666666667, alpha: 1)
        activityIndicatorView.type = .ballPulseSync
        activityIndicatorView.startAnimating()
        //Getting Posts from API

        PostAPI.getAllPosts { postResponse in
            self.posts = postResponse
            self.postTableView.reloadData()
            self.activityIndicatorView.stopAnimating()
        }
        
        
        
        //Subscribing in userStackView Notification
        
        NotificationCenter.default.addObserver(self, selector: #selector(userStackViewTapped), name: NSNotification.Name.init("userStackViewTapped"), object: nil)
       
       
    }
    
    @objc func userStackViewTapped(notification:Notification){
        
        if let cell = notification.userInfo?["cell"] as? UITableViewCell {
            if let indexPath = postTableView.indexPath(for: cell)  {
                let post = posts[indexPath.row]
                let vc = storyboard?.instantiateViewController(identifier: "UserProfileVC") as! UserProfileVC
                vc.user = post.owner
                navigationController?.pushViewController(vc, animated: true)
            }
        }
        

    }
    
  
    
//
//    func getAllPost(){
//
//        let url = "https://dummyapi.io/data/v1/post"
//        let headers: HTTPHeaders = [
//            "app-id":"62036cf6322f55adfd3ba956"
//            ]
//
//            AF.request(url,headers: headers ).responseJSON { (response) in
//            let jsonData = JSON(response.value)
//            let data = jsonData["data"]
//            let decoder = JSONDecoder()
//            do {
//            self.posts = try decoder.decode([Post].self, from: data.rawData())
//                self.activityIndicatorView.stopAnimating()
//                self.postTableView.reloadData()
//
//            } catch {
//            print(error.localizedDescription)
//            }
//
//
//        }
//    }


}
extension  PostsVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = posts[indexPath.row]

//        if let postImage = cell.postImageView  {
//            Helpers.getImageFromURL(url: post.image, image: postImage)
//        }
        cell.postImageView.setImageFromStringUrl(stringUrl: post.image)
        
//        if let userImage = cell.userImageView {
//            Helpers.getImageFromURL(url: post.owner.picture, image: userImage)
//        }
        cell.userImageView.setImageFromStringUrl(stringUrl: post.owner.picture)
        
        cell.userNameLabel.text = post.owner.firstName + " " + post.owner.lastName
        cell.postTextLabel.text = post.text
        cell.likesLabel.text = String(post.likes)  
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 480
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "PostDetailsVC") as! PostDetailsVC
        let selectedPost = posts[indexPath.row]
        vc.post = selectedPost
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

