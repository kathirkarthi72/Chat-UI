//
//  Message.swift
//  Chat
//
//  Created by ktrkathir on 12/02/19.
//  Copyright © 2019 ktrkathir. All rights reserved.
//

import Foundation
import UIKit

enum MessageType: Int {
    case text = 1
    case image = 2
    case video = 3
    case call = 4
}

enum MessageReadState: Int {
    case waitingToSend = 0
    case sent = 1
    case delivered = 2
    case readed = 3
}

/// Message
struct Message {
    /// Message type
    var type: MessageType = .text
    
    /// Text
    var text: String = ""
    
    // Media file path
    var mediaFilePath: URL?
        
    /// sender ID
    var senderID: String?
    
    /// Timestamp
    var timestamp: String?
    
    /// Read state
    var readState: MessageReadState = .sent
    
    var height: CGFloat = 20
    
    
    init(text: String, sender: String, timestamp: String, readState: MessageReadState = .sent) {
        
        self.type = .text
        self.text = text
        self.senderID = sender
        self.timestamp = timestamp
        self.readState = readState
    }
    
    init(call text: String, sender: String, timestamp: String) {
        
        self.type = .call
        self.text = text
        self.senderID = sender
        self.timestamp = timestamp
    }
    
    init(image mediaFilePath: URL, sender: String, timestamp: String, readState: MessageReadState = .sent) {
        
        self.type = .image
        self.senderID = sender
        self.timestamp = timestamp
        self.readState = readState
        self.mediaFilePath = mediaFilePath
        
        self.height = 180
    }
    
    init(video mediaFilePath: URL, sender: String, timestamp: String, readState: MessageReadState = .sent) {
        
        self.type = .video
        self.senderID = sender
        self.timestamp = timestamp
        self.readState = readState
        self.mediaFilePath = mediaFilePath

        self.height = 180
    }
}

extension Array where Element == Message {
    
    var lastItemIndex: IndexPath {
        return IndexPath(item: self.count - 1, section: 0)
    }
}
