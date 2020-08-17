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
    
    
    var drinkInfo: DrinkModel?
    var indexInt = 0
    let imgList = ["c_1", "c_2", "c_3", "sale", "sale", "c_6", "c_7", "c_8", "c_9", "c_10", "c_11", "c_12", "c_13", "sale", "sale", "c_16", "sale"]
    let iceList = ["完全去冰", "去冰", "微冰", "少冰", "正常冰", "多冰"]
    let sugarList = ["無糖", "微糖", "半糖", "少糖", "正常糖", "多糖"]
    
    var iceLevel = ""
    var sugarLevel = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("drinkInfo: \(drinkInfo)")
        
        imgViewInit()
        
        btnInit()
        
        tapGestureInit()
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
    
    
    @IBAction func orderBtnPressed(_ sender: Any) {
        
    }
    
    func viewInit() {
        navigationItem.title = "\(drinkInfo?.drinkName ?? "")" 
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
        mediumView.setPressed()
        largeView.setUnPressed()
    }
    
    @objc func largePressed() {
        print("點擊largeView")
        largeView.setPressed()
        mediumView.setUnPressed()
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
