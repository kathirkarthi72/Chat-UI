//
//  ViewExtens.swift
//  Chat
//
//  Created by ktrkathir on 20/02/19.
//  Copyright © 2019 ktrkathir. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
   
    func addShadow() {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 1, height: 0)
        layer.masksToBounds = false
    }
    
}


extension UIViewController {
    
    typealias AlertClicked = ((String) -> ())
    
    func presentAlertController(title: String?, subTitle: String?, style: UIAlertController.Style, options: [String], alertClicked: @escaping AlertClicked) {
        
        let alertController = UIAlertController(title: title, message: subTitle, preferredStyle: style)
        
        for option in options {
            
            let action = UIAlertAction(title: option, style: .default) { (action) in
                alertClicked(action.title!)
            }
            alertController.addAction(action)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancel)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}


extension UIView {
    
    func springAnimation(_ finished: @escaping Finished) {
        
        let spring = CASpringAnimation(keyPath: "transform.scale")
        spring.fromValue = 0.95
        spring.toValue = 1.0
        spring.duration = 0.1
        layer.add(spring, forKey: "spring_scale")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            finished()
        }
    }
    
}
