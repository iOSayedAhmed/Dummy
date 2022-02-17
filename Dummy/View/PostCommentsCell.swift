//
//  PostCommentsCell.swift
//  Dummy
//
//  Created by Develop on 2/14/22.
//  Copyright © 2022 Develop. All rights reserved.
//

import UIKit

class PostCommentsCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var commentMessageLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
