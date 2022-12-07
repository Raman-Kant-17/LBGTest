//
//  AppDelegate.swift
//  LBG Test
//
//  Created by Raman Kant on 07/12/22.
//

import UIKit

class TableEmptyView: UIView {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var retryButton: UIButton!
    
    var onRetry: (() -> ())?
    
    @IBAction func retryAction(sender: UIButton) {
        if (self.onRetry != nil) {
            self.onRetry!()
        }
    }
    
    fileprivate func setupView(title: String?, message: String?, enableRetry: Bool) {
        self.title.text = title
        self.message.text = message
        
        if !enableRetry {
            self.retryButton.isHidden = true
        }
    }
    
    deinit {
        debugPrint("TableEmptyView Deinitialized")
    }
    
    class func instanceFromNib(title: String?, message: String?, enableRetry: Bool) -> TableEmptyView {
        let view = UINib(nibName: "TableEmptyView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! TableEmptyView
        view.setupView(title: title, message: message, enableRetry: enableRetry)
        return view
    }
}
