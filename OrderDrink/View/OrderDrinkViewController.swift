//
//  OrderDrinkViewController.swift
//  OrderDrink
//
//  Created by Una Lee on 2020/8/10.
//  Copyright © 2020 una.lee. All rights reserved.
//

import UIKit

class OrderDrinkViewController: UIViewController {
    
    @IBOutlet weak var drinkImg: UIImageView!
    @IBOutlet weak var descriptionLab: UILabel!
    @IBOutlet weak var mediumPriceLab: UILabel!
    @IBOutlet weak var largePriceLab: UILabel!
    @IBOutlet weak var iceBtn: UIButton!
    @IBOutlet weak var sugarBtn: UIButton!
    @IBOutlet weak var mediumView: UIView!
    @IBOutlet weak var largeView: UIView!
    @IBOutlet weak var orderPersonText: UITextField!
    @IBOutlet weak var pearlSwitch: UISwitch!
    @IBOutlet weak var shoppingCarBtn: UIButton!
    
    let commonFunc = CommonFunc.share
    var drinkInfo: DrinkModel?
    var indexInt = 0
    let imgList = ["c_1", "c_2", "c_3", "sale", "sale", "c_6", "c_7", "c_8", "c_9", "c_10", "c_11", "c_12", "c_13", "sale", "sale", "c_16", "sale"]
    let iceList = ["完全去冰", "去冰", "微冰", "少冰", "正常冰", "多冰"]
    let sugarList = ["無糖", "微糖", "半糖", "少糖", "正常糖", "多糖"]
    
    var drinkName = ""
    var iceLevel = ""
    var sugarLevel = ""
    var drinkSize = ""
    var drinkPrice = ""
    var addPearl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("drinkInfo: \(drinkInfo)")
        
        //圖片初始化
        imgViewInit()
        
        //按鈕初始化
        btnInit()
        
        //手勢初始化
        tapGestureInit()
        
        //設定commonfunc
        commonFunc.setViewController(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
        
        viewInit()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    
    @IBAction func iceSelect(_ sender: Any) {
        let alertView = UIAlertController(title: "請選擇冰度", message: "", preferredStyle: .actionSheet)
        for ice in iceList {
            alertView.addAction(UIAlertAction(title: ice, style: .default, handler: { (action) in
                if let iceStr = action.title {
                    print("冰塊量: \(iceStr)")
                    self.iceLevel = iceStr
                    self.iceBtn.setTitle("\(iceStr)", for: .normal)
                }
            }))
        }
        present(alertView, animated: true, completion: nil)
    }
    
    
    @IBAction func sugarSelect(_ sender: Any) {
        let alertView = UIAlertController(title: "請選擇糖度", message: "", preferredStyle: .actionSheet)
        for sugar in sugarList {
            alertView.addAction(UIAlertAction(title: sugar, style: .default, handler: { (action) in
                if let sugarStr = action.title {
                    print("糖度: \(sugarStr)")
                    self.sugarLevel = sugarStr
                    self.sugarBtn.setTitle("\(sugarStr)", for: .normal)
                }
            }))
        }
        present(alertView, animated: true, completion: nil)
    }
    
    
    @IBAction func addPearlChanged(_ sender: UISwitch) {
        
        if sender.isOn {
            addPearl = "加珍珠"
        } else {
            addPearl = ""
        }
    }
    
    @IBAction func orderBtnPressed(_ sender: Any) {
        let orderPerson = orderPersonText.text ?? ""
        
        //確認該有的資訊都有
        if "".elementsEqual(orderPerson) {
            commonFunc.showAlert(message: "請留下訂購者名字喔！")
            return
        }
        
        if "".elementsEqual(drinkSize) {
            commonFunc.showAlert(message: "請確定飲料大小喔！")
            return
        }
        
        if "".elementsEqual(iceLevel) {
            commonFunc.showAlert(message: "請確定冰塊量喔！")
            return
        }
        
        if "".elementsEqual(sugarLevel) {
            commonFunc.showAlert(message: "請確定糖度喔！")
            return
        }
        
        if addPearl != "" {
            let drinkPriceInt = Int(drinkPrice)! + 10
            drinkPrice = "\(drinkPriceInt)"
        }
        
        //將訂購資訊匯入OrderDrink
        var orderDrink = OrderDrinkModel(orderPerson: orderPerson, drinkName: drinkName, drinkSize: drinkSize, drinkIce: iceLevel, drinkSugar: sugarLevel, addPearl: addPearl, drinkPrice: drinkPrice)
        
        //帶回上一頁
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "DrinkListCollectionView") as! DrinkListCollectionViewController
        DrinkListCollectionViewController.orderDrinkList.append(orderDrink)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func viewInit() {
        drinkName = drinkInfo?.drinkName ?? ""
        navigationItem.title = drinkName
        drinkImg.image = UIImage(named: imgList[indexInt])
        descriptionLab.text = drinkInfo?.description
        mediumPriceLab.text = drinkInfo?.mediumPrice
        largePriceLab.text = drinkInfo?.largePrice
    }
    
    func imgViewInit() {
        drinkImg.layer.cornerRadius = 5
    }
    
    func btnInit() {
        iceBtn.layer.cornerRadius = 5
        sugarBtn.layer.cornerRadius = 5
        shoppingCarBtn.layer.cornerRadius = 5
    }
    
    func tapGestureInit() {
        //點擊中杯
        mediumView.isUserInteractionEnabled = true
        let mediumTapGesture = UITapGestureRecognizer(target: self, action: #selector(mediumPressed))
        mediumTapGesture.cancelsTouchesInView = false
        mediumView.addGestureRecognizer(mediumTapGesture)
        
        //點擊大杯
        largeView.isUserInteractionEnabled = true
        let largeTapGesture = UITapGestureRecognizer(target: self, action: #selector(largePressed))
        largeTapGesture.cancelsTouchesInView = false
        largeView.addGestureRecognizer(largeTapGesture)
    }
    
    //MARK: objc func
    @objc func mediumPressed() {
        print("點擊mediumView")
        drinkSize = "中杯"
        drinkPrice = drinkInfo!.mediumPrice
        
        mediumView.setPressed()
        largeView.setUnPressed()
    }
    
    @objc func largePressed() {
        print("點擊largeView")
        
        if "no".elementsEqual(drinkInfo!.largePrice) {
            commonFunc.showAlert(message: "沒有賣大杯喔，中杯如何？")
        } else {
            drinkSize = "大杯"
            drinkPrice = drinkInfo!.largePrice
            
            largeView.setPressed()
            mediumView.setUnPressed()
        }
    }
}

extension UIView {
    func setPressed() {
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 7
    }
    
    func setUnPressed() {
        self.layer.borderWidth = 0
    }
    
}
