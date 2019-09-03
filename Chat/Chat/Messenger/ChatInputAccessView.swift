//
//  InputAccessView.swift
//  Chat
//
//  Created by ktrkathir on 13/02/19.
//  Copyright © 2019 ktrkathir. All rights reserved.
//

import UIKit

/// Chat input access view delegate
protocol ChatInputAccessViewDelegate {
    
    /// Text updated on text view
    func textUpdated()
    
    /// Send button clicked
    func sendButtonClicked(text: String)
    
    func attachbuttonClicked()
}


/// Chat input accessory view
class ChatInputAccessView: UIVisualEffectView {
    
    /// Delegate
    var delegate: ChatInputAccessViewDelegate?
    
    /// Custom Text view
    var inputTextView: ChatTextInputView = {
        let textView = ChatTextInputView()
        textView.enablesReturnKeyAutomatically = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    var attachButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 26)
        button.setTitle("↑", for: .normal)
        
        return button
    }()
    
    /// Send button
    let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(UIColor.gray, for: .disabled)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        button.setTitle("Send", for: .normal)
        
        return button
    }()
    
    /// text of textview
    public var inputText: String! {
        get {
            return inputTextView.text
        }
        set {
            inputTextView.text = newValue
            update()
        }
    }
  
    override init(effect: UIVisualEffect?) {
        super.init(effect: effect)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var sendButtonWidthConstrains: NSLayoutConstraint!

    fileprivate func setLayout() {
        sendButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        sendButtonWidthConstrains = sendButton.widthAnchor.constraint(equalToConstant: 0)
        sendButtonWidthConstrains.isActive = true
        sendButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        
        attachButton.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -10).isActive = true
        attachButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        attachButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        attachButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        
        inputTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        inputTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        inputTextView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        inputTextView.trailingAnchor.constraint(equalTo: attachButton.leadingAnchor, constant: -10).isActive = true
        inputTextView.layer.cornerRadius = 20
        inputTextView.layer.masksToBounds = true
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        if #available(iOS 11.0, *) {
            if self.window?.safeAreaLayoutGuide != nil {
                self.bottomAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: (self.window?.safeAreaLayoutGuide.bottomAnchor)!, multiplier: 1.0).isActive = true
            }
        }
    }
    
    /// Setting up subviews
    private func setup() {
        
        inputTextView.delegate = self
        
        sendButton.addTarget(self, action: #selector(sendButtonClicked), for: .touchUpInside)
        attachButton.addTarget(self, action: #selector(attachButtonClicked), for: .touchUpInside)
        
        contentView.addSubview(inputTextView)
        contentView.addSubview(attachButton)
        contentView.addSubview(sendButton)
        
        contentView.addShadow()
        setLayout()
    }
    
    override var intrinsicContentSize: CGSize {
        
        let textSize = inputTextView.sizeThatFits(CGSize(width: inputTextView.bounds.width, height: CGFloat.greatestFiniteMagnitude))
        
        if textSize.height > 20 {
            let newHeight = textSize.height + 25
            
            if newHeight > ContainerViewHeight.maximum.rawValue {
                return CGSize(width: self.bounds.width, height: ContainerViewHeight.maximum.rawValue)
            } else {
                return CGSize(width: self.bounds.width, height: newHeight)
            }
        } else {
            return CGSize(width: self.bounds.width, height: ContainerViewHeight.minimum.rawValue)
        }
    }
    
    /// Update state of subviews
    private  func update() {
        invalidateIntrinsicContentSize()
        
        if inputText.isEmpty {
            sendButton.isEnabled = false
            sendButtonWidthConstrains.constant = 0
            layoutIfNeeded()

            inputTextView.enablesReturnKeyAutomatically = false
        } else {
            sendButton.isEnabled = true
            sendButtonWidthConstrains.constant = 40
            layoutIfNeeded()

            inputTextView.enablesReturnKeyAutomatically = true
        }
    }
    
    // MARK: - Button action
    @objc func sendButtonClicked() {
        
        sendButton.springAnimation {
            if let text = self.inputTextView.text, let delegate = self.delegate {
                let trimmed = text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                delegate.sendButtonClicked(text: trimmed)
            }
        }
    }
    
    @objc func attachButtonClicked() {
        
        attachButton.springAnimation {
            if let delegate = self.delegate {
                delegate.attachbuttonClicked()
            }
        }
    }
}

// MARK: - UITextViewDelegate
extension ChatInputAccessView : UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        update()
        if let delegate = delegate {
            delegate.textUpdated()
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        inputTextView.enablesReturnKeyAutomatically = false
        
        if let delegate = delegate {
            delegate.textUpdated()
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let currentText = textView.text ?? ""
        
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
        
        return changedText.count <= MessengerConstant.maximumCharCount
    }
}
