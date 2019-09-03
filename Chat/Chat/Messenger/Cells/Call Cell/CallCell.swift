//
//  CallInfoCell.swift
//  RiotChatBase
//
//  Created by Premkumar  on 02/08/19.
//  Copyright © 2019 Kathiresan. All rights reserved.
//

import Foundation
import UIKit

/// Call info cell
class CallCell: UICollectionViewCell {
    
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
        return MessengerCellID.call.rawValue
    }
    
    /// Message label
   fileprivate var messageLabel: UILabel  = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    /// Show view
    var showView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// Setup UI
    fileprivate func setup() {
        
        contentView.addSubview(messageLabel)
        
        setLayout()
    }
    
    fileprivate func setLayout() {
        messageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        messageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        messageLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    func setMessage(text: String) {
        messageLabel.text = text
    }
}
