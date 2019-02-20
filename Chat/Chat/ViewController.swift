//
//  ViewController.swift
//  Chat
//
//  Created by ktrkathir on 07/02/19.
//  Copyright © 2019 ktrkathir. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addChatButton()
    }

    func addChatButton() {
        let chatButton = UIButton(type: .system)
        chatButton.setTitle("Chat room", for: .normal)
        chatButton.translatesAutoresizingMaskIntoConstraints = false
        chatButton.addTarget(self, action: #selector(clickAction), for: .touchUpInside)
        view.addSubview(chatButton)
        
        chatButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        chatButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        chatButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        chatButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    @objc func clickAction() {
        let chatRoomVC = MessengerViewController.init(collectionViewLayout: UICollectionViewFlowLayout())
        self.navigationController?.pushViewController(chatRoomVC, animated: true)
    }
    
}

