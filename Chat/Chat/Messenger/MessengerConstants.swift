//
//  MessengerConstants.swift
//  Chat
//
//  Created by ktrkathir on 14/02/19.
//  Copyright © 2019 ktrkathir. All rights reserved.
//

import Foundation
import UIKit

/// Messenger constant
struct MessengerConstant {
    
    /// Sender id
    static let senderID = "1"
    
    /// Receiver id
    static let receiverID = "2"
    
    /// Place holder
    static let textViewPlaceHodler = "Type a message.."
    
    /// Pattern image
    static let bgPatternImage: UIImage = UIImage(named: "ChatBgPattern")!
    
    /// Maximum number of character in textView
    static let maximumCharCount: Int = 250
}

/// Messenger cell ids
///
/// - sender: sender
/// - receiver: receiver
enum MessengerCellID: String {
    case sentText = "MessengerSenderCell"
    case receiveText = "MessengerReceiverCell"
    case sentMedia = "MessagerSendMediaCell"
    case receiveMedia = "MessagerReceiveMediaCell"
    case call = "MessengerCallCell"
}

/// Container view height
///
/// - minimum: Minimum height = 50.0
/// - maximum: Maximum height = 150.0
enum ContainerViewHeight: CGFloat {
    case minimum = 100.0
    case maximum = 150.0
}


struct MessengerColors {
    
    static let bgColor = UIColor(red: 237.0/255.0, green: 238.0/255.0, blue: 239.0/255.0, alpha: 1.0)
    
    static let senderColor = UIColor(red: 238.0/255.0, green: 209.0/255.0, blue: 242.0/255.0, alpha: 1.0)
    
    static let receiverColor = UIColor(red: 255.0/255.0, green: 231.0/255.0, blue: 204.0/255.0, alpha: 1.0)
}
