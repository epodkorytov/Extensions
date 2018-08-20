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
    
    init(_ attachTo: AnyObject, closure: @escaping () -> ()) {
        self.closure = closure
        self.selector = #selector(ClosureSelector.target)
        objc_setAssociatedObject(attachTo, "[\(arc4random())]", self, .OBJC_ASSOCIATION_RETAIN)
    }
    
    @objc func target() {
        closure()
    }
}

public extension NotificationCenter {
    public func addObserver(_ observer: Any, name: NSNotification.Name?, withClosure closure : @escaping () -> Void) {
        let closureSelector = ClosureSelector(self, closure: closure)
        
        self.addObserver(closureSelector, selector: closureSelector.selector, name: name, object: nil)
    }
}

public extension UIBarButtonItem {
    public func action(withClosure closure : @escaping () -> Void) {
        let closureSelector = ClosureSelector(self, closure: closure)
        self.target = closureSelector
        self.action = closureSelector.selector
    }
}

public extension UIButton {
    public func action(for event: UIControl.Event, withClosure closure : @escaping () -> Void) {
        let closureSelector = ClosureSelector(self, closure: closure)
        self.addTarget(closureSelector, action: closureSelector.selector, for: event)
    }
}
