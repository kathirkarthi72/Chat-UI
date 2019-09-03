# Chat UI_iOS
A basic UI setup for Chat screen in swift

![alt text](https://github.com/ktrkathir/Chat-UI/blob/master/Simulator%20Screen%20Shot%20-%20iPhone7%20New%20-%202019-09-03%20at%2012.38.06.png)

## Setup instructions

1. Drag all files in Messenger folder
2. call MessengerViewController class like below
```swift
let chatRoomVC = MessengerViewController.init(collectionViewLayout: UICollectionViewFlowLayout())
self.navigationController?.pushViewController(chatRoomVC, animated: true)
```
