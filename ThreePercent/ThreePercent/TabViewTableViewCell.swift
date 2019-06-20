//
//  TabViewTableViewCell.swift
//  ThreePercent
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 19/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class TabViewTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, TabViewDelegate {
    
    static let identifier = "TabViewTableViewCell"
    
    // MARK : - IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    var tabBar = TabBarTableViewCell()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.dataSource = self as UICollectionViewDataSource
        collectionView.delegate = self as UICollectionViewDelegate
        tabBar.delegate = self
        registerCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK : - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RealtimeCollectionViewCell.identifier, for: indexPath)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SendLoverCollectionViewCell.identifier, for: indexPath)
            return cell
        }
    }
    
    // MARK : - UiCollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // MARK : - TabViewDelegate
    func scrollToTab(_ index: Int) {
        print("scroll!!!")
        let indexPath = IndexPath(row: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    // MARK : - Register Nib
    func registerCell() {
        collectionView.register(UINib.init(nibName: RealtimeCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: RealtimeCollectionViewCell.identifier)
        collectionView.register(UINib.init(nibName: SendLoverCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: SendLoverCollectionViewCell.identifier)
    }
    
}
