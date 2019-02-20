# Chat UI_iOS
A basic UI setup for Chat screen in swift

![alt text](https://github.com/ktrkathir/Chat-UI/blob/master/Screen%20Shot%202019-02-20%20at%205.44.44%20PM.png)

## Setup instructions

1. Drag all files in Messenger folder
2. call MessengerViewController class like below
```swift
let chatRoomVC = MessengerViewController.init(collectionViewLayout: UICollectionViewFlowLayout())
self.navigationController?.pushViewController(chatRoomVC, animated: true)
```
