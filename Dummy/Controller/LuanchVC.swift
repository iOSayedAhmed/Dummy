//
//  LuanchVC.swift
//  Dummy
//
//  Created by Develop on 3/7/22.
//  Copyright © 2022 Develop. All rights reserved.
//

import UIKit
import Lottie

class LuanchVC: UIViewController {

    private let animationView = AnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            let vc = self.storyboard?.instantiateViewController(identifier: "SignInUserVC") as! SignInUserVC
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true)
        }
    }

    //MARK:- FUNCTIONS
    private func setupAnimation(){
       
        animationView.frame = CGRect(x: 0, y: 0, width: view.frame.width - 100, height: 400)
        animationView.center = view.center
        //animationView.backgroundColor = .red
        view.addSubview(animationView)
        animationView.animation = Animation.named("SocialMedia")
        animationView.loopMode = .playOnce
        animationView.contentMode = .scaleAspectFill
        animationView.play()

    }
}
