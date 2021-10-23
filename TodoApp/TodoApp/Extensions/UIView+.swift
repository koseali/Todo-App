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
        
        let time = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        
        let curve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        
        let startPosition = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let endPosition = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let different =  endPosition.origin.y - startPosition.origin.y
        UIView.animateKeyframes(withDuration: time, delay: 0.0, options: KeyframeAnimationOptions.init(rawValue: curve), animations: {self.frame.origin.y += different}, completion: nil)
        
    }
    
}
