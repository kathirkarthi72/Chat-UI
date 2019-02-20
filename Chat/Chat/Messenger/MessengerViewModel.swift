//
//  ChatroomViewModel.swift
//  Chat
//
//  Created by ktrkathir on 12/02/19.
//  Copyright © 2019 ktrkathir. All rights reserved.
//

import UIKit

/// Messenger viewmodel is a chat room model class
class MessengerViewModel: NSObject {
    
    /// Message history
    var messages: [Message] = []
    
    var cache: [CGFloat] = []
    
    /// Send Message
    ///
    /// - Parameter newElement: new message
    func sendMessage(newElement: Message) {
        messages.append(newElement)
    }
    
    func deleteAllMessages() {
        messages.removeAll()
    }
    
  // lazy var sampleTextLabel = UILabel()

    /*
    func sizeForItem(message: String, preferredWidth: CGFloat) -> CGSize {
        
        // let message = messages[index.row].data as! String
        let space = preferredWidth - 200
        
//        sampleTextLabel.frame = CGRect(x: 0, y: 0, width:  space, height: CGFloat.greatestFiniteMagnitude)
//        sampleTextLabel.text = message
//
//        var rect = sampleTextLabel.sizeThatFits(CGSize(width: space, height: CGFloat.greatestFiniteMagnitude))
        
       var height = message.height(withConstrainedWidth: space, font: UIFont.systemFont(ofSize: 15.0))
        
       // height += 15
     //   return CGSize(width: preferredWidth, height: height)
        
        if height <= 25 {
            return CGSize(width: preferredWidth, height: 35)
        } else {
           height += 10
            return CGSize(width: preferredWidth, height: height)
        }
    }
 
    */
    
    func designItem(index: IndexPath, collectionView: UICollectionView) -> UICollectionViewCell {
        
       let chat = messages[index.row]
        
        if chat.sender == MessengerConstant.senderID {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessengerCellID.sender.rawValue, for: index) as! MessengerSenderCell

            if chat.message_type == .text {
                cell.setMessage(text: chat.data as! String)
            }
            
            cell.timeLabel.text = chat.timestamp
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessengerCellID.receiver.rawValue, for: index) as! MessengerReceiverCell
            
            if chat.message_type == .text {
                cell.setMessage(text: chat.data as! String)
            }
            
            cell.timeLabel.text = chat.timestamp!
            return cell
        }
    }
}

