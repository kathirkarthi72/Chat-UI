//
//  ChatroomViewController.swift
//  Chat
//
//  Created by ktrkathir on 07/02/19.
//  Copyright © 2019 ktrkathir. All rights reserved.
//

import Foundation
import UIKit

/// Messenger Viewcontroller is a chat room screen
class MessengerViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    /// View model
    let viewModel = MessengerViewModel()
    
    @objc var isReceiverTyping: Bool = false
    
    /// Input Container access view
    var inputAccessView: ChatInputAccessView = {
        
        let accessView = ChatInputAccessView(effect: UIBlurEffect(style: .light))

//        let accessView = ChatInputAccessView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: ContainerViewHeight.minimum.rawValue))
//        accessView.backgroundColor = MessengerColors.bgColor
        return accessView
    }()
    
    override func viewDidLoad() {
        setup()
    }
    
    /// Basic setup
    func setup() {
        
        inputAccessView.delegate = self
        
        title = "Chat"
        
        view.backgroundColor = MessengerColors.bgColor //UIColor(patternImage: MessengerConstant.bgPatternImage)
        
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        
        collectionView.backgroundColor = UIColor.clear
        collectionView.keyboardDismissMode = .interactive
        collectionView.register(MessengerSenderCell.self, forCellWithReuseIdentifier: MessengerCellID.sender.rawValue)
        collectionView.register(MessengerReceiverCell.self, forCellWithReuseIdentifier: MessengerCellID.receiver.rawValue)
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override var inputAccessoryView: UIView? {
        // Setting input access view as Bottom textview
        inputAccessView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: ContainerViewHeight.maximum.rawValue)
        inputAccessView.autoresizingMask = .flexibleHeight
        return inputAccessView
    }
    
    /// Collectionview reload with last item scroll
    ///
    /// - Parameter showLastItem: show Last Item on collectionview
    func collectionViewReload(showLastItem: Bool = false) {
        
        if showLastItem {
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                
                if self.collectionView.numberOfItems(inSection: 0) > 5 {
                    let index = IndexPath(item: self.collectionView.numberOfItems(inSection: 0) - 1, section: 0)
                    self.collectionView.scrollToItem(at: index, at: .bottom, animated: false)
                }
            }
        } else {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    /// Collectionview last item scroll to top
    func justScrollLastItemToTop() {
        if !collectionView.isLastItemVisible(items: viewModel.messages) {
            DispatchQueue.main.async {
                self.collectionView.scrollToItem(at: self.viewModel.messages.lastItemIndex, at: .bottom, animated: true)
            }
        }
    }
    
    // MARK: Collectionview
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return viewModel.designItem(index: indexPath, collectionView: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: viewModel.messages[indexPath.item].height)
    }
    
}

// MARK: - ChatInputAccessViewDelegate
extension MessengerViewController: ChatInputAccessViewDelegate {
    
    func textUpdated() {
        justScrollLastItemToTop()
    }
    
    func sendButtonClicked(text: String) {
        
        if viewModel.messages.count % 2  == 0 {
                        
            var msg = Message(data: text, from: MessengerConstant.senderID, timestamp: "10:30 AM")
            
            let space = self.view.bounds.width - 200
            var height = text.height(withConstrainedWidth: space, font: UIFont.systemFont(ofSize: 14.0))
            
            if height <= 25 {
                msg.height = 35
            } else {
                height += 10
                msg.height = height
            }
            
            // msg.height = viewModel.sizeForItem(message: text, preferredWidth: space).height
            
            viewModel.sendMessage(newElement: msg)
        } else {
            
            var msg = Message(data: text, from: MessengerConstant.receiverID, timestamp: "10:31 AM")
            
            let space = self.view.bounds.width - 190
            
            var height = text.height(withConstrainedWidth: space, font: UIFont.systemFont(ofSize: 14.0))
            
            if height <= 25 {
                msg.height = 35
            } else {
                height += 10
                msg.height = height
            }
            
            viewModel.sendMessage(newElement: msg)
        }
        
        inputAccessView.inputText = ""
        
        if !inputAccessView.inputTextView.isFirstResponder {
            inputAccessView.inputTextView.setPlaceHolder()
        }
        
        collectionViewReload(showLastItem: true)
    }
}

