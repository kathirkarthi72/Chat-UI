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
