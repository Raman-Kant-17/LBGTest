//
//  AppDelegate.swift
//  LBG Test
//
//  Created by Raman Kant on 07/12/22.
//

import UIKit
import Foundation

extension UITableView {
    
    func setIndicator() {
        
        let indicator = UIActivityIndicatorView()
        indicator.startAnimating()
        indicator.color = .darkGray
        indicator.style = .medium
        
        self.backgroundView = indicator
        self.separatorStyle = .none
    }
    
    func setEmptyView(title: String?, message: String?, enableRetry: Bool, onRetry: @escaping () -> ()) {
        
        let emptyView = TableEmptyView.instanceFromNib(title: title, message: message, enableRetry: enableRetry)
        emptyView.onRetry = {
            onRetry()
        }
        emptyView.frame = CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height)
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .none
    }
}

