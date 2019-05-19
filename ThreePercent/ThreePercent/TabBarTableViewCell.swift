//
//  TabBarTableViewCell.swift
//  ThreePercent
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 19/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

protocol TabViewDelegate: class {
    func scrollToTab(_ index: Int)
}

class TabBarTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    weak var delegate: TabViewDelegate?
    
    static let identifier = "TabBarTableViewCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var indicator: UIView!
    
    @IBOutlet weak var alcLeadingOfIndicatorView: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.dataSource = self as UICollectionViewDataSource
        collectionView.delegate = self as UICollectionViewDelegate
        registerCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    //  MARK : - CollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabBarCollectionViewCell.identifier, for: indexPath) as! TabBarCollectionViewCell
        
        switch indexPath.item {
        case 0:
            cell.tabBarCollectionViewLabel.text = "실시간 3%"
        default:
            cell.tabBarCollectionViewLabel.text = "호감 3%"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 이건 고치고 싶다...
        print("\(indexPath.item)")
        delegate?.scrollToTab(indexPath.item)
        
        let cell = collectionView.cellForItem(at: indexPath) as! TabBarCollectionViewCell
        cell.tabBarCollectionViewLabel.textColor = .black
        alcLeadingOfIndicatorView.constant = (collectionView.frame.width / 2) * CGFloat((indexPath.item))
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    // MARK : - CollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.width/2, height: self.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // MARK : - Scroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        alcLeadingOfIndicatorView.constant = scrollView.contentOffset.x / 2
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let itemAt = Int(targetContentOffset.pointee.x / self.frame.width)
        let indexPath = IndexPath(item: itemAt, section: 0)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
    }
    
    // MARK : - Private Method
    func registerCell() {
        collectionView.register(UINib.init(nibName: TabBarCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TabBarCollectionViewCell.identifier)
    }
}
