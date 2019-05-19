//
//  RealtimeCollectionViewCell.swift
//  ThreePercent
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 19/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class RealtimeCollectionViewCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    
    static let identifier = "RealtimeCollectionViewCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var hearButton: UIButton!
    @IBOutlet weak var heartImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.dataSource = self as UICollectionViewDataSource
        collectionView.delegate = self as UICollectionViewDelegate
        registerCell()
    }
    
    // MARK : - IBAction
    @IBAction func didTouchButtonLikeThisPersion(_ sender: Any) {
        print("work")
        heartImage.image = UIImage(named: "heart_red_btn")
    }
    

    // MARK : - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PickImageCollectionViewCell.identifier, for: indexPath) as! PickImageCollectionViewCell
        
        switch indexPath.item {
        case 0:
            cell.imageView.image = UIImage(named: "original-\(indexPath.item+1)")
        case 1:
            cell.imageView.image = UIImage(named: "original-\(indexPath.item+1)")
        default:
            cell.imageView.image = UIImage(named: "original-\(indexPath.item+1)")
            
        }
        return cell
    }
    
    // MARK : - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl.currentPage = indexPath.item
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        heartImage.image = UIImage(named: "heart_gry_btn")
    }
    
    // MARK : - Register Nib
    func registerCell() {
        collectionView.register(UINib.init(nibName: PickImageCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: PickImageCollectionViewCell.identifier)
    }
    
}
