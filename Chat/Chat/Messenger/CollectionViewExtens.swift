//
//  CollectionViewExtension.swift
//  Chat
//
//  Created by ktrkathir on 14/02/19.
//  Copyright © 2019 ktrkathir. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    
    /// Is last item visible
    ///
    /// - Parameter items: array of items
    /// - Returns: bool value return
    func isLastItemVisible<T>(items: [T]) -> Bool {
        
        if items.isEmpty {
            return true
        }
        
        let lastIndexPath = IndexPath(item: items.count - 1, section: 0)
        
        guard let cellFrame = self.layoutAttributesForItem(at: lastIndexPath)?.frame else { return true }
        
        // cellFrame?.size.height = (cellFrame?.size.height)!
        
        var cellRect = self.convert(cellFrame, to: superview)
        cellRect.origin.y = cellRect.origin.y - cellFrame.size.height - 100
        // substract 100 to make the "visible" area of a cell bigger
        
        var visibleRect = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.bounds.size.width, height: self.bounds.size.height - self.contentInset.bottom)
        
        visibleRect = self.convert(visibleRect, to: superview)
        
        if visibleRect.contains(cellRect) {
            return true
        }
        
        return false
    }
    
}
