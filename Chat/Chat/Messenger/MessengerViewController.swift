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
        collectionView.register(TextSentCell.self, forCellWithReuseIdentifier: MessengerCellID.sentText.rawValue)
        collectionView.register(TextReceivedCell.self, forCellWithReuseIdentifier: MessengerCellID.receiveText.rawValue)
        collectionView.register(MediaSentCell.self, forCellWithReuseIdentifier: MessengerCellID.sentMedia.rawValue)
        collectionView.register(MediaReceivedCell.self, forCellWithReuseIdentifier: MessengerCellID.receiveMedia.rawValue)
        collectionView.register(CallCell.self, forCellWithReuseIdentifier: MessengerCellID.call.rawValue)

        let callBarButton = UIBarButtonItem(title: "📞", style: .done, target: self, action: #selector(callButtonClicked))
        
        self.navigationItem.setRightBarButton(callBarButton, animated: true)
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
    
    // MARK: Button action
    @objc func callButtonClicked() {
        presentAlertController(title: "Call", subTitle: nil, style: .actionSheet, options: ["Voice","Video"]) { (clickedOption) in
            if clickedOption == "Voice" {
                self.call(text: "Voice call placed")
                self.collectionViewReload(showLastItem: true)

            } else if clickedOption == "Video" {
                self.call(text: "Video call placed")
                self.collectionViewReload(showLastItem: true)

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
//        return CGSize(width: view.bounds.width, height: viewModel.messages[indexPath.item].height)
        let message = viewModel.messages[indexPath.item]
        
    switch message.type {
        case .call:
            return CGSize(width: view.bounds.width, height: 22)
        default:
            return CGSize(width: view.bounds.width, height: message.height)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let message = viewModel.messages[indexPath.item]
        
        switch message.type {
   /*  case .image:
            if let imageFilePath = message.mediaFilePath, let image = UIImage(contentsOfFile: imageFilePath) {
                let previewVC = PreviewViewController()
                previewVC.loadImage = image
                
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(previewVC, animated: true)
                }
            }
            */
        case .video:
            
            if message.senderID == MessengerConstant.senderID {                
                if let videoFilePath = message.mediaFilePath {
                    self.playVideo(filePath: videoFilePath)
                }
                
            } else {
                if let videoFilePath = message.mediaFilePath {
                    self.playVideo(filePath: videoFilePath)
                }
            }
        default:
            break
        }
    }
    
    
}

// MARK: - ChatInputAccessViewDelegate
extension MessengerViewController: ChatInputAccessViewDelegate {
   
    func textUpdated() {
        justScrollLastItemToTop()
    }
    
    func sendButtonClicked(text: String) {
        
        if viewModel.messages.count % 2  == 0 {
            sent(text: text)
        } else {
            receive(text: text)
        }
        
        inputAccessView.inputText = ""
        
        if !inputAccessView.inputTextView.isFirstResponder {
            inputAccessView.inputTextView.setPlaceHolder()
        }
        
        collectionViewReload(showLastItem: true)
    }
    
    func attachbuttonClicked() {
        presentAlertController(title: "Attach", subTitle: nil, style: .actionSheet, options: ["Shot","Gallery"]) { (clickedOption) in
            if clickedOption == "Shot" {
                self.presentCameraPicker()
            } else if clickedOption == "Gallery" {
                self.presentLibraryPicker()
            }
        }
    }
}

