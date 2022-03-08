//
//  TagsVC.swift
//  Dummy
//
//  Created by Develop on 2/21/22.
//  Copyright © 2022 Develop. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class TagsVC: UIViewController {

    var tags:[String] = []
    @IBOutlet weak var TagsCollectionView: UICollectionView!
    @IBOutlet weak var loaderIndecator: NVActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [TagsCollectionView].forEach{
            $0?.delegate = self
            $0?.dataSource = self
        }
        self.loaderIndecator.color = #colorLiteral(red: 0.2588235294, green: 0.6235294118, blue: 0.6666666667, alpha: 1)
        self.loaderIndecator.type = .ballPulseSync
        self.loaderIndecator.startAnimating()
        TagAPI.getAllTags { (response) in
            self.tags = response
            self.loaderIndecator.stopAnimating()
            self.TagsCollectionView.reloadData()
        }
//        let screenWidth = TagsCollectionView.frame.width
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
//        layout.itemSize = CGSize(width: screenWidth/3, height: screenWidth/3)
//        layout.minimumInteritemSpacing = 0
//        layout.minimumLineSpacing = 0
//        TagsCollectionView!.collectionViewLayout = layout
        
        
    }
    
    //MARK:- IBACTIONS
    
    @IBAction func loggedOutButtonClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
extension TagsVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCollectionViewCell", for: indexPath) as! TagCollectionViewCell
        cell.tagNameLabel.text = tags[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2, height:collectionView.frame.width/2 )
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tagSelected = tags[indexPath.item]
        let vc = storyboard?.instantiateViewController(identifier: "PostsVC") as! PostsVC
        vc.tag = tagSelected
        present(vc, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
    

    
    
}
