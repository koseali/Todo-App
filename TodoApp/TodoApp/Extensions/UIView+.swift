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
    
}
