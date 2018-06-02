//
//  UIPickerView+Extension.swift
//  Extensions
//

import UIKit

public extension UIPickerView {
    public func reloadData(_ completion: @escaping ()->()) {
        self.reloadAllComponents()
        
        DispatchQueue.main.async {
            completion()
        }
    }
}
