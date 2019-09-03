//
//  MediaSentcell.swift
//  Chat
//
//  Created by Premkumar  on 31/08/19.
//  Copyright © 2019 ktrkathir. All rights reserved.
//

import Foundation
import UIKit

class MediaSentCell: UICollectionViewCell {
    
    /// Show view
    var showView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = MessengerColors.senderColor
        
        return view
    }()
    
    /// Show view
    fileprivate var imageView: UIImageView = {
        let imageV = UIImageView()
        imageV.translatesAutoresizingMaskIntoConstraints = false
        return imageV
    }()
    
    var playImageView: UIImageView = {
        let playButton = UIImageView()
        playButton.image = UIImage(named: "play_icon") // .setTitle("", for: .normal)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.contentMode = .center
        playButton.isHidden = true
        return playButton
    }()
    
    fileprivate var indicator: UIActivityIndicatorView = {
        
        let indicate = UIActivityIndicatorView()
        //        indicate.color = .black
        indicate.hidesWhenStopped = true
        indicate.isHidden = true
        indicate.translatesAutoresizingMaskIntoConstraints = false
        return indicate
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
        return MessengerCellID.sentMedia.rawValue
    }
    
    /// Setup UI
    fileprivate func setup() {
        showView.addSubview(imageView)
        showView.addSubview(playImageView)
        showView.addSubview(indicator)
        
        contentView.addSubview(showView)
        
        setLayout()
    }
    
    fileprivate func setLayout() {
        
        let space:CGFloat = 60.0
        
        showView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        showView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        showView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: space).isActive = true
        showView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        showView.widthAnchor.constraint(lessThanOrEqualToConstant: 200).isActive = true
        showView.heightAnchor.constraint(lessThanOrEqualToConstant: 100).isActive = true
        
        imageView.topAnchor.constraint(equalTo: showView.topAnchor, constant: 5).isActive = true
        imageView.leadingAnchor.constraint(equalTo: showView.leadingAnchor, constant: 5).isActive = true
        imageView.trailingAnchor.constraint(equalTo: showView.trailingAnchor, constant: -5).isActive = true
        imageView.bottomAnchor.constraint(equalTo: showView.bottomAnchor, constant: -5).isActive = true
        
        playImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        playImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        playImageView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        playImageView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        
        indicator.widthAnchor.constraint(equalToConstant: 40).isActive = true
        indicator.heightAnchor.constraint(equalToConstant: 40).isActive = true
        indicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
    }
    
    func setImage(_ image: UIImage) {
        imageView.image = image
        setCornerRadius()
    }
    
    func startLoading() {
        playImageView.isHidden = true
        indicator.isHidden = false
        indicator.startAnimating()
    }
    
    func stopLoading() {
        indicator.isHidden = true
        playImageView.isHidden = false
        indicator.stopAnimating()
    }
    
    fileprivate func setCornerRadius() {
        
        showView.clipsToBounds = false
        showView.layer.cornerRadius = 10
        
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        
        playImageView.layer.cornerRadius = 20
        playImageView.layer.masksToBounds = true
        
        
        if #available(iOS 11.0, *) {
            showView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
        showView.addShadow()
    }
    
}
