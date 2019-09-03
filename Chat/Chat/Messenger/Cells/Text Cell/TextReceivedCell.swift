//
//  MessengerReceiverCell.swift
//  Chat
//
//  Created by ktrkathir on 20/02/19.
//  Copyright © 2019 ktrkathir. All rights reserved.
//

import Foundation
import UIKit

class TextReceivedCell: UICollectionViewCell {
    
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
        return MessengerCellID.receiveText.rawValue
    }
    
    /// Setup UI
    fileprivate func setup() {
        
        showView.addSubview(timeLabel)
        showView.addSubview(messageLabel)
        contentView.addSubview(showView)
        
        setLayout()
    }
    
    fileprivate func setLayout() {
        let space: CGFloat = 60
        
        showView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        showView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        showView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        showView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -space).isActive = true
        showView.widthAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
        showView.backgroundColor = MessengerColors.receiverColor
        
        timeLabel.trailingAnchor.constraint(equalTo: showView.trailingAnchor, constant: -1).isActive = true
        timeLabel.bottomAnchor.constraint(equalTo: showView.bottomAnchor, constant: -2).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        timeLabel.font = UIFont.systemFont(ofSize: 10.0)
    }
    
    func setMessage(text: String) {
        
        messageLabel.text = text
        
        messageLabel.topAnchor.constraint(equalTo: showView.topAnchor, constant: 0).isActive = true
        messageLabel.leadingAnchor.constraint(equalTo: showView.leadingAnchor, constant: 10).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: timeLabel.leadingAnchor, constant: -10).isActive = true
        messageLabel.bottomAnchor.constraint(equalTo: showView.bottomAnchor, constant: -2).isActive = true
        
        setCornerRadius()
    }
    
    func setCornerRadius() {
        showView.clipsToBounds = false
        showView.layer.cornerRadius = 10
        showView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        
        showView.addShadow()
    }
    
}

