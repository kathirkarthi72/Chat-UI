//
//  ChatroomViewModel.swift
//  Chat
//
//  Created by ktrkathir on 12/02/19.
//  Copyright © 2019 ktrkathir. All rights reserved.
//

import UIKit

import AVFoundation
import AVKit

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
    
    /// Design item with indexPath and with collectionView
    func designItem(index: IndexPath, collectionView: UICollectionView) -> UICollectionViewCell {
        
        let chat = messages[index.row]
        
        if chat.senderID == MessengerConstant.senderID {
            
            switch chat.type {
            case .text:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessengerCellID.sentText.rawValue, for: index) as! TextSentCell
                cell.timeLabel.text = chat.timestamp
                
                cell.setMessage(text: chat.text)
                return cell
            case .call:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessengerCellID.call.rawValue, for: index) as! CallCell
                cell.setMessage(text: chat.text)
                return cell
            case .image:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessengerCellID.sentMedia.rawValue, for: index) as! MediaSentCell
                
                if let filePath = chat.mediaFilePath {
                    //let image = UIImage(contentsOfFile: filePath.absoluteString)
                    do {
                        if let image = try UIImage(data: Data(contentsOf: filePath)) {
                            cell.setImage(image)
                        }
                    } catch let error {
                        print(error.localizedDescription)
                    }
                }
                
                cell.playImageView.isHidden = true
                
                return cell
            case .video:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessengerCellID.sentMedia.rawValue, for: index) as! MediaSentCell
                
                if let filePath = chat.mediaFilePath {
                    
                    if let image =  videoThumbnail(localFile: filePath) {
                        cell.setImage(UIImage(cgImage: image))
                    }
                }
                
                cell.playImageView.isHidden = false
                
                return cell
            }
            
        } else {
            
            switch chat.type {
            case .text:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessengerCellID.receiveText.rawValue, for: index) as! TextReceivedCell
                
                cell.setMessage(text: chat.text)
                cell.timeLabel.text = chat.timestamp!
                return cell
            case .call:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessengerCellID.call.rawValue, for: index) as! CallCell
                cell.setMessage(text: chat.text)
                return cell
            case .image:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessengerCellID.receiveMedia.rawValue, for: index) as! MediaReceivedCell
                
                if let filePath = chat.mediaFilePath {
                    do {
                        if let image = try UIImage(data: Data(contentsOf: filePath)) {
                            cell.setImage(image)
                        }
                    } catch let error {
                        print(error.localizedDescription)
                    }
                }
                cell.playImageView.isHidden = true
                
                return cell
            case .video:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessengerCellID.receiveMedia.rawValue, for: index) as! MediaReceivedCell
                
                if let filePath = chat.mediaFilePath {
                    
                    if let image =  videoThumbnail(localFile: filePath) {
                        cell.setImage(UIImage(cgImage: image))
                    }
                }
                
                cell.playImageView.isHidden = false
                
                return cell
            }
        }
    }
}


extension MessengerViewController {
    
    // MARK: Config
    func sent(text: String) {
        
        
        
        var msg = Message(text: text, sender: MessengerConstant.senderID, timestamp: sentTimeStamp())
        
        let space = self.view.bounds.width - 200
        var height = text.height(withConstrainedWidth: space, font: UIFont.systemFont(ofSize: 14.0))
        
        if height <= 25 {
            msg.height = 35
        } else {
            height += 10
            msg.height = height
        }
        
        viewModel.sendMessage(newElement: msg)
    }
    
    func receive(text: String) {
        var msg = Message(text: text, sender: MessengerConstant.receiverID, timestamp: sentTimeStamp())
        
        let space = self.view.bounds.width - 190
        
        var height = text.height(withConstrainedWidth: space, font: UIFont.systemFont(ofSize: 14.0))
        
        if height <= 25 {
            msg.height = 35
        } else {
            height += 10
            msg.height = height
        }
        
        viewModel.sendMessage(newElement: msg)
    }
    
    func call(text: String) {
        self.viewModel.sendMessage(newElement: Message(call: text, sender: MessengerConstant.senderID, timestamp: sentTimeStamp()))
    }
    
    func sent(image: URL) {
        self.viewModel.sendMessage(newElement: Message(image: image, sender: MessengerConstant.senderID, timestamp: sentTimeStamp()))
        collectionViewReload(showLastItem: true)
        
    }
    
    func receive(image: URL) {
        self.viewModel.sendMessage(newElement: Message(image: image, sender: MessengerConstant.receiverID, timestamp: sentTimeStamp()))
        collectionViewReload(showLastItem: true)
        
    }
    
    func sent(video: URL) {
        self.viewModel.sendMessage(newElement: Message(video: video, sender: MessengerConstant.senderID, timestamp: sentTimeStamp()))
        collectionViewReload(showLastItem: true)
        
    }
    
    func receive(video: URL) {
        self.viewModel.sendMessage(newElement: Message(video: video, sender: MessengerConstant.receiverID, timestamp: sentTimeStamp()))
        collectionViewReload(showLastItem: true)
        
    }
    
    /// Present Media library picker
    func presentLibraryPicker() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.mediaTypes = ["public.image", "public.movie"]
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        DispatchQueue.main.async {
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    /// Present camera picker
    func presentCameraPicker() {
        
        let cameraPicker = UIImagePickerController()
        cameraPicker.mediaTypes = ["public.image", "public.movie"]
        cameraPicker.sourceType = .camera
        cameraPicker.delegate = self
        DispatchQueue.main.async {
            self.present(cameraPicker, animated: true, completion: nil)
        }
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension MessengerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if info[.mediaType] as! String == "public.image" {
            
            picker.dismiss(animated: true) {
                
                if self.viewModel.messages.count % 2  == 0 {
                    self.sent(image: info[.imageURL] as! URL)
                } else {
                    self.receive(image: info[.imageURL] as! URL)
                }
            }
            
        } else if info[.mediaType] as! String == "public.movie" {
            if let videoUrl = info[.mediaURL] as? URL {
                
                picker.dismiss(animated: true) {
                    
                    if self.viewModel.messages.count % 2  == 0 {
                        self.sent(video: videoUrl)
                    } else {
                        self.receive(video: videoUrl)
                    }
                }
            }
        }
    }
    
    /// Play a local video
    ///
    /// - Parameter filePath: Local video file path
    func playVideo(filePath: URL) {
        let player = AVPlayer(url: filePath)
        let playerController = AVPlayerViewController()
        playerController.player = player
        self.present(playerController, animated: true) {
            player.play()
        }
    }
}

// MARK: - Supporting methods for Video upload and play
extension MessengerViewModel {
    
    /// Generat thumbnail for Video file
    ///
    /// - Parameter path: local video file path
    /// - Returns: CGImage
    func videoThumbnail(localFile path: URL) -> CGImage? {
        do {
            let asset = AVURLAsset(url: path, options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
            //            let thumbnail = UIImage(cgImage: cgImage)
            return cgImage
        } catch let error {
            print("Error: \(error.localizedDescription)")
            return nil
        }
    }
}

func sentTimeStamp() -> String {
    
    let formatter = DateFormatter()
    formatter.dateFormat = "hh:mm a"
    return formatter.string(from: Date())
}
