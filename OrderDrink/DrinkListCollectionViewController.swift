//
//  DrinkListCollectionViewController.swift
//  OrderDrink
//
//  Created by Una Lee on 2020/8/13.
//  Copyright © 2020 una.lee. All rights reserved.
//

import UIKit

class DrinkListCollectionViewController: UICollectionViewController {
    
    var fullScreenSize: CGSize!
    let imgList = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "11", "11", "11", "11", "11", "11", ]

    override func viewDidLoad() {
        super.viewDidLoad()

        //取得螢幕尺寸
        fullScreenSize = UIScreen.main.bounds.size
        
        let layout = UICollectionViewFlowLayout()
        
        // 設置 section 的間距 四個數值分別代表 上、左、下、右 的間距
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        // 設置每一行的間距
        layout.minimumLineSpacing = 5
        // 設置每個 cell 的尺寸
        layout.itemSize = CGSize(width: CGFloat(fullScreenSize.width)/3 - 10.0, height: CGFloat(fullScreenSize.width)/3 - 10.0)
        
        //添加layout設定
        collectionView.collectionViewLayout = layout
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return imgList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(DrinkListCollectionViewCell.self)", for: indexPath) as! DrinkListCollectionViewCell
    
        cell.drinkImg.image = UIImage(named: "\(imgList[indexPath.item])")
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
