//
//  ViewController.swift
//  Chat
//
//  Created by ktrkathir on 07/02/19.
//  Copyright © 2019 ktrkathir. All rights reserved.
//

import UIKit

typealias Finished = (() -> ())

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func chatRoomButtonClickedAction(_ sender: Any) {
        (sender as! UIButton).springAnimation {
            self.enterChatRoom()
        }
    }
    
    func enterChatRoom() {
        let chatRoomVC = MessengerViewController.init(collectionViewLayout: UICollectionViewFlowLayout())
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(chatRoomVC, animated: true)
        }
    }
}

