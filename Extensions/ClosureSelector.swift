//
//  ClosureSelector.swift
//  DataServices
//

import Foundation
import UIKit

//Parameter is the type of parameter passed in the selector
public class ClosureSelector {
    
    public let selector : Selector
    private let closure : () -> ()
    
    init(withClosure closure : @escaping () -> ()){
        self.selector = #selector(ClosureSelector.target)
        self.closure = closure
    }
    
    @objc func target() {
        closure()
    }
}

var handle: Int = 0

public extension NotificationCenter {
    public func addObserver(_ observer: Any, name: NSNotification.Name?, withClosure closure : @escaping () -> Void) {
        let closureSelector = ClosureSelector(withClosure: closure)
        objc_setAssociatedObject(self, &handle, closureSelector, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        self.addObserver(closureSelector, selector: closureSelector.selector, name: name, object: nil)
    }
}

public extension UIBarButtonItem {
    public func action(withClosure closure : @escaping () -> Void) {
        let closureSelector = ClosureSelector(withClosure: closure)
        objc_setAssociatedObject(self, &handle, closureSelector, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        self.target = closureSelector
        self.action = closureSelector.selector
    }
}

public extension UIButton {
    public func action(for event: UIControlEvents,withClosure closure : @escaping () -> Void) {
        let closureSelector = ClosureSelector(withClosure: closure)
        objc_setAssociatedObject(self, &handle, closureSelector, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        self.addTarget(closureSelector, action: closureSelector.selector, for: event)
    }
}
