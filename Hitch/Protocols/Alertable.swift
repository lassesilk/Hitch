//
//  Alertable.swift
//  Hitch
//
//  Created by Lasse Silkoset on 28.06.2018.
//  Copyright © 2018 Lasse Silkoset. All rights reserved.
//

import UIKit

protocol Alertable {}

//whenever we conform to this protocol on a uiviewcontroller we have access to all the funcs inside this
extension Alertable where Self: UIViewController {
    
    func showAlert(_ message: String) {
        let alertController = UIAlertController(title: "Error:", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(action)
        
        present(alertController, animated: true, completion: nil)
    }
}
