//
//  PostCell.swift
//  Dummy
//
//  Created by Develop on 2/9/22.
//  Copyright © 2022 Develop. All rights reserved.
//

import UIKit

protocol UserProfileDelegate {
    func cellSelected(cellIndex:UITableViewCell)
   }
class PostCell: UITableViewCell {

    var tags:[String] = []
    @IBOutlet weak var postTagCollectionView: UICollectionView!{
        didSet{
            postTagCollectionView.delegate = self
            postTagCollectionView.dataSource = self
            postTagCollectionView.register(UINib(nibName: "postTagCell", bundle: nil), forCellWithReuseIdentifier: "postTagCell")
        }
    }
    var userProfile : UserProfileDelegate?
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var likesImageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var userStackView:UIStackView!{
        didSet{
            self.userStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userStackViewTapped)))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
  
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @objc func userStackViewTapped() {
       //  To Present userProfileVC Should send Notificaton to PostVC And Present userProfileVC From There

        NotificationCenter.default.post(name: NSNotification.Name.init("userStackViewTapped"), object: nil, userInfo: ["cell":self])
        //userProfile?.cellSelected(cellIndex: self)
        
    }
}
extension PostCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postTagCell", for: indexPath) as! postTagCell
        cell.tagNameLabel.text = tags[indexPath.item]
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 45)
    }
    
    
    
}
