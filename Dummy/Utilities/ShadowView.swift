//
//  ShadowView.swift
//  Dummy
//
//  Created by Develop on 2/15/22.
//  Copyright © 2022 Develop. All rights reserved.
//

import UIKit

class ShadowView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setShadowToView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setShadowToView()
    }
    
    func setShadowToView() {
        self.layer.shadowRadius = 10
        self.shadowColor = .lightGray
        self.shadowOpacity = 0.3
        self.shadowOffset = CGSize(width: 0, height: 10)
    }
    
}
