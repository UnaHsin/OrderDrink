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
    let imgList = ["loading", "2", "3", "loading", "loading", "6", "7", "8", "9", "10", "11", "12", "13", "loading", "loading", "16", "loading"]
    
    var drinkList: [DrinkModel] = []
    var drinkInfo: DrinkModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        viewInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    func viewInit() {
        
        //取得螢幕尺寸
        fullScreenSize = UIScreen.main.bounds.size
        
        let layout = UICollectionViewFlowLayout()
        
        // 設置 section 的間距 四個數值分別代表 上、左、下、右 的間距
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        // 設置每一行的間距
        layout.minimumLineSpacing = 10
        // 設置每個 cell 的尺寸
        layout.itemSize = CGSize(width: CGFloat(fullScreenSize.width)/2 - 10.0, height: CGFloat(fullScreenSize.width)/2 - 10.0)
        
        //添加layout設定
        collectionView.collectionViewLayout = layout
    }

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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let drinkNumber = "\(indexPath.item + 1)"
        //比對index number 和 drinkNumber後，取出單筆drink資訊
        drinkList.forEach { (drink) in
            if drinkNumber == drink.drinkNumber {
                //print("drinkInfo: \(drink)")
                drinkInfo = drink
            }
        }
        
        //將drink資訊，帶入下一頁
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "OrderDrinkView") as! OrderDrinkViewController
        controller.indexInt = indexPath.item
        controller.drinkInfo = drinkInfo
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
