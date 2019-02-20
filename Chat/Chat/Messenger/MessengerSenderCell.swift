//
//  MessengerSenderCell.swift
//  Chat
//
//  Created by ktrkathir on 20/02/19.
//  Copyright © 2019 ktrkathir. All rights reserved.
//

import Foundation
import UIKit

/// Messenger Sender Cell
class MessengerSenderCell: UICollectionViewCell {
    
    /// Show view
    var showView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// Message label
    var messageLabel: UILabel  = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    /// send time label
    var timeLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// Sent flag
    var sentFlag: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    /// Re use id
    override var reuseIdentifier: String? {
        return MessengerCellID.sender.rawValue
    }
    
    /// Setup UI
    fileprivate func setup() {
        showView.addSubview(timeLabel)
        showView.addSubview(messageLabel)
        showView.addSubview(sentFlag)
        contentView.addSubview(showView)
        
        setLayout()
    }
    
    fileprivate func setLayout() {
        
        let space:CGFloat = 60.0
        
        showView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        showView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        showView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: space).isActive = true
        showView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        showView.widthAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
        showView.backgroundColor = MessengerColors.senderColor
        
        sentFlag.trailingAnchor.constraint(equalTo: showView.trailingAnchor, constant: -2).isActive = true
        sentFlag.bottomAnchor.constraint(equalTo: showView.bottomAnchor, constant: -2).isActive = true
        sentFlag.heightAnchor.constraint(equalToConstant: 15).isActive = true
        sentFlag.widthAnchor.constraint(equalToConstant: 20).isActive = true
        sentFlag.backgroundColor = UIColor.lightGray
        
        timeLabel.trailingAnchor.constraint(equalTo: sentFlag.leadingAnchor, constant: -1).isActive = true
        timeLabel.bottomAnchor.constraint(equalTo: showView.bottomAnchor, constant: -2).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        timeLabel.font = UIFont.systemFont(ofSize: 10.0)
    }
    
    func setMessage(text: String) {
        
        messageLabel.text = text
        
        //  let space = (self.frame.width - 60) - 15
        //  let textSize = messageLabel.sizeThatFits(CGSize(width: space, height: CGFloat.greatestFiniteMagnitude))
        
        //   if textSize.height <= 18 {
        messageLabel.topAnchor.constraint(equalTo: showView.topAnchor, constant: 0).isActive = true
        messageLabel.leadingAnchor.constraint(equalTo: showView.leadingAnchor, constant: 10).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: timeLabel.leadingAnchor, constant: -10).isActive = true
        messageLabel.bottomAnchor.constraint(equalTo: showView.bottomAnchor, constant: -2).isActive = true
        //        } else {
        //            messageLabel.topAnchor.constraint(equalTo: showView.topAnchor, constant: 0).isActive = true
        //            messageLabel.leadingAnchor.constraint(equalTo: showView.leadingAnchor, constant: 10).isActive = true
        //            messageLabel.trailingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 0).isActive = true
        //            messageLabel.bottomAnchor.constraint(equalTo: timeLabel.topAnchor, constant: 4).isActive = true
        //        }
        
        setCornerRadius()
    }
    
    func setCornerRadius() {
        
        showView.clipsToBounds = false
        showView.layer.cornerRadius = 10
        showView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        showView.addShadow()
    }
    
}
