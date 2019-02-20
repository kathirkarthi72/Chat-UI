# Chat UI_iOS
A basic UI setup for Chat screen in swift

## Setup instructions

1. Drag all files in Messenger folder
2. call MessengerViewController class like below
```swift
let chatRoomVC = MessengerViewController.init(collectionViewLayout: UICollectionViewFlowLayout())
self.navigationController?.pushViewController(chatRoomVC, animated: true)
```
