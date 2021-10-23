//
//  UIView+.swift
//  TodoApp
//
//  Created by Ali Kose on 23.10.2021.
//

import Foundation
import UIKit

extension UIView {
    
    @IBInspectable
    var cornerRadius : CGFloat{
        get { return self.cornerRadius}
        set { self.layer.cornerRadius = newValue}
    }
    
    func moveKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(changeKeyboard(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func  changeKeyboard(_ notification : NSNotification){
        
    }
    
}
