//
//  ArrayExtension.swift
//  Extensions
//

import Foundation

public protocol Copyable {
    init(copy: Self)
}

public extension Copyable {
    public func copy() -> Self {
        return Self.init(copy: self)
    }
}

public extension Array where Element: Copyable {
    public func clone() -> Array {
        var copiedArray = Array<Element>()
        for element in self {
            copiedArray.append(element.copy())
        }
        return copiedArray
    }
}

public extension Array {
    public func indexes(where predicate: (Element) -> Bool) -> [Int]? {
        var result = [Int]()
        for (idx, element) in self.enumerated() {
            if predicate(element) {
                result.append(idx)
            }
        }
        return result.isEmpty ? nil : result
    }
}
