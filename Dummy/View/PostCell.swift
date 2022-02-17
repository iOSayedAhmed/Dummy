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
