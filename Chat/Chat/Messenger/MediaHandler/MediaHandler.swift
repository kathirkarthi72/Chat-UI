//
//  MediaHandler.swift
//  Chat
//
//  Created by Premkumar  on 31/08/19.
//  Copyright © 2019 ktrkathir. All rights reserved.
//

import Foundation
import UIKit

struct MediaHandler {
    static let instance: MediaHandler = MediaHandler()
    
    func download(image path: String) {
        
        if FileManager.default.fileExists(atPath: path) {
            
            UIImage()
            
            let data = FileManager.default.contents(atPath: path)
        }
        
    }
}
