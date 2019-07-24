//
//  Alerts.swift
//  phoneBook
//
//  Created by mymac on 24/07/19.
//  Copyright © 2019 mymac. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, handlerOK:((UIAlertAction) -> Void)?, handlerCancle: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .destructive, handler: handlerOK)
        let actionCanel = UIAlertAction(title: "Cancle", style: .cancel, handler: handlerCancle)
        alert.addAction(action)
        alert.addAction(actionCanel)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
