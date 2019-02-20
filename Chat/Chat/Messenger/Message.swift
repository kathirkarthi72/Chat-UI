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
    var message_type: MessageType = MessageType.text
    
    var data: Any?
    
    var sender: String?
    
    var timestamp: String?
    
    var read_state: MessageReadState = MessageReadState.sent
    
    var height: CGFloat = 0
    
    init(type: MessageType = MessageType.text, data: Any, from: String, timestamp: String, readState: MessageReadState = MessageReadState.sent) {
        
        self.message_type = type
        self.data = data
        self.sender = from
        self.timestamp = timestamp
        self.read_state = readState
    }
    
}

extension Array where Element == Message {
    
    var lastItemIndex: IndexPath {
        return IndexPath(item: self.count - 1, section: 0)
    }
    
}

/*
 {
 "Taxiye": {
 "messages": {
 "D100|P100": {
 "D100_state": 0,
 "P100_state": 1,
 "P_unread": 0,
 "D_unread": 2,
 "chat1": {
 "message_type": 1,
 "data": "text",
 "sender": "D100",
 "timestamp": "10:05 PM",
 "read_state": 0
 },
 "chat2": {
 "message_type": 1,
 "data": "text",
 "sender": "D100",
 "timestamp": "10:10 PM",
 "read_state": 1
 },
 "chat3": {
 "message_type": 1,
 "data": "text",
 "sender": "P100",
 "timestamp": "10:15 PM",
 "read_state": 2
 }
 },
 "D101|P101": {}
 }
 }
 }
 
 */
