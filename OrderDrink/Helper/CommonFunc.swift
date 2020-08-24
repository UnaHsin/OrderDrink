//
//  CommonFunc.swift
//  OrderDrink
//
//  Created by Una Lee on 2020/8/17.
//  Copyright © 2020 una.lee. All rights reserved.
//

import UIKit

class CommonFunc {
    static let share = CommonFunc()
    
    var nowCV: UIViewController?
    
    func setViewController(_ nowCV: UIViewController) {
        self.nowCV = nowCV
    }
    
    func showAlert(title: String? = nil, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "確定", style: .default)

        alert.addAction(ok)
        nowCV!.present(alert, animated: true)
    }
    
    func showAlertAction(title: String? = nil, message: String, showCancelBtn: Bool, hander: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "確定", style: .default, handler: hander)
        let cancel = UIAlertAction(title: "取消", style: .destructive)
        
        //true = 顯示取消鍵
        if showCancelBtn {
           alert.addAction(cancel)
        }
        alert.addAction(ok)
        
        nowCV!.present(alert, animated: true)
    }
}
