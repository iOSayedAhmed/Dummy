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
   
    var page:Int = 0
    var total:Int = 0
    var posts : [Post] = []
    var tag : String?
    
    
    @IBOutlet weak var postHeaderConstraint: NSLayoutConstraint!
    @IBOutlet weak var TagNameContaner: UIView!
    @IBOutlet weak var tagNameLabel: UILabel!
    @IBOutlet weak var loggedUserNameLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    @IBOutlet weak var addNewPostContainerView: ShadowView!
    //MARK:- OUTLET
    @IBOutlet weak var postTableView: UITableView!
    @IBOutlet weak var dismissButton: UIButton!
    
    
    //MARK:- LIFE CYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserManager.loggedInUser == nil {
            addNewPostContainerView.isHidden = true
            postHeaderConstraint.constant = 100
        }
        postTableView.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "PostCell")
        navigationController?.navigationBar.prefersLargeTitles = true
        // New Way to delegate DataSourse
        [postTableView].forEach{
            $0?.delegate = self
            $0?.dataSource = self
        }
        activityIndicatorView.color = #colorLiteral(red: 0.2588235294, green: 0.6235294118, blue: 0.6666666667, alpha: 1)
        activityIndicatorView.type = .ballPulseSync
        
        //Check there are tag or Not
        if let myTag = tag?.trimmingCharacters(in: .whitespacesAndNewlines){
            self.tagNameLabel.text = myTag
        }
        else {
            self.TagNameContaner.isHidden = true
            self.dismissButton.isHidden = true
           
        }

        // Check if User Logged in or Skip 
        if let user = UserManager.loggedInUser {
            loggedUserNameLabel.text = "Hi,\(user.firstName)"
            
        }else {
            loggedUserNameLabel.isHidden = true
        }
         
        //Getting Posts from API
            getPosts()
        
        //Subscribing in userStackView Notification
        
        NotificationCenter.default.addObserver(self, selector: #selector(userStackViewTapped), name: NSNotification.Name.init("userStackViewTapped"), object: nil)
       //Subscribing in NewPostAdded Notification
        NotificationCenter.default.addObserver(self, selector: #selector(newPostAdded), name: NSNotification.Name("newPostAdded"), object: nil)
       
    }
    //MARK:- IBACTIONS
    
    @IBAction func addNewPostButtonClicked(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "AddNewPostViewController") as! AddNewPostViewController
        present(vc, animated: true)
        
    }
    @IBAction func dismissButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func LogOutButtonClicked(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "SignInUserVC") as! SignInUserVC
        UserManager.loggedInUser = nil
        present(vc, animated: true)
        
    }
    
    
    @objc func userStackViewTapped(notification:Notification){
        
        if let cell = notification.userInfo?["cell"] as? UITableViewCell {
            if let indexPath = postTableView.indexPath(for: cell)  {
                let post = posts[indexPath.row]
                let vc = storyboard?.instantiateViewController(identifier: "UserProfileVC") as! UserProfileVC
                vc.user = post.owner
                present(vc, animated: true)
            }
        }
        

    }
    
    //MARK:- Functions
    @objc func newPostAdded(){
        self.posts = []
        self.page = 0
        getPosts()
    }
    
    func getPosts()  {
        self.activityIndicatorView.startAnimating()
        PostAPI.getAllPosts(page: page, tag: tag) { postResponse,total  in
             self.total = total
            self.posts.append(contentsOf: postResponse)
            self.postTableView.reloadData()
            self.activityIndicatorView.stopAnimating()
        }
    }
}

extension  PostsVC : UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = posts[indexPath.row]


        cell.postImageView.setImageFromStringUrl(stringUrl: post.image)
        
//        if let userImage = cell.userImageView {
//            Helpers.getImageFromURL(url: post.owner.picture, image: userImage)
//        }
        if let picture = post.owner.picture{
            cell.userImageView.setImageFromStringUrl(stringUrl: picture)
        }
        
        cell.userNameLabel.text = post.owner.firstName + " " + post.owner.lastName
        cell.postTextLabel.text = post.text
        cell.likesLabel.text = String(post.likes)
        cell.tags = post.tags ?? []
       
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 550
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "PostDetailsVC") as! PostDetailsVC
        let selectedPost = posts[indexPath.row]
        vc.post = selectedPost
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == posts.count - 1 && posts.count < total{
            page = page + 1
            self.getPosts()
            print(indexPath.row)
            


        }


    }
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let scroll = scrollView.contentOffset.y
//        if scroll > (postTableView.contentSize.height - 100 - scrollView.frame.size.height) && posts.count < total{
//            page = page + 1
//            self.getPosts()
//
//
//        }
//    }
}

    


