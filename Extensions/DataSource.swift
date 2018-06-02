//
//  DataSource.swift
//  Extensions
//

import Foundation

public typealias DataSourceBaseItemDidSelectionChange = (Int, Bool) -> Swift.Void

public protocol DataSourceBaseItemProtocol {
    var id: Int { get set }
    var title: String { get set }
    var selected: Bool { get set }
    var didSelectionChange: DataSourceBaseItemDidSelectionChange? { get set }
    
    func store()
}

open class DataSourceBaseItem: DataSourceBaseItemProtocol {
    public var id: Int
    public var title: String
    
    public var selected: Bool {
        didSet {
            if self.selected != oldValue {
                self.didSelectionChange?(self.id, self.selected)
            }
        }
    }
    public var didSelectionChange: DataSourceBaseItemDidSelectionChange?
    
    public required init(id: Int, title: String, selected: Bool) {
        self.id = id
        self.title = title
        self.selected = selected
    }
    
    public func store() { }
}

open class DataSourceItem<T>: DataSourceBaseItem {
    public var value: T?
}

//
public protocol DataSourceBaseProtocol {
    var multiselectable: Bool { get set }
    var selectedIndexes: [Int]? { get set }
    var selectedIds: [Int]? { get set }
}

open class DataSource<T: DataSourceBaseItem>: DataSourceBaseProtocol {
    public var multiselectable: Bool = false {
        didSet{
            if !multiselectable {
                self.items.forEach{ $0.didSelectionChange = { id, selected in
                    self.change(id, selected: selected)
                    }
                }
            } else {
                self.items.forEach{ $0.didSelectionChange = nil }
            }
        }
    }
    
    private var _items = Array<T>()
    public var items: Array<T> {
        set {
            setItems(newValue)
        }
        get {
            return getItems()
        }
    }
    
    public var selectedItems: Array<T> { return items.filter{$0.selected} }
    
    public var selectedIndexes: [Int]? {
        set {
            self.selectItems(indexes: newValue ?? [])
        }
        get {
            return items.indexes{ $0.selected }
        }
     }
     
    public var selectedIds: [Int]? {
        set {
            self.selectItems(ids: newValue ?? [])
        }
        get {
            return items.filter{ $0.selected }.map{ $0.id }
        }
    }
    
    public init() {
        self.items = Array<T>()
    }
    
    public init(items: Array<T>) {
        self.items = items
    }
    
    //setter/getter
    open func setItems(_ elements: Array<T>){
        _items = elements
        
        if !multiselectable {
            self.items.forEach{ $0.didSelectionChange = { id, selected in
                self.change(id, selected: selected)
                }
            }
        }
    }
    open func getItems() -> Array<T> {
        return _items
    }
    //
    public func append(_ element: T) {
        let item = element
        if !multiselectable {
            item.didSelectionChange = { id, selected in
                self.change(id, selected: selected)
            }
            self.change(item.id, selected: item.selected)
        }
        self._items.append(item)
    }
    //
    private func change(_ id: Int,  selected: Bool){
        if !selected { return }
        items.filter({$0.id != id}).forEach({
            let didSelectionChange = $0.didSelectionChange
            $0.didSelectionChange = nil
            $0.selected = false
            $0.didSelectionChange = didSelectionChange
        })
    }
    
    private func selectItems(indexes: [Int]){
        var value: [Int] = indexes
        if !multiselectable {
            if let idx = indexes.first {
                value = [idx]
            }
        }
     
        for (idx, item) in self.items.enumerated(){
            item.selected = value.contains(idx)
        }
     }
     
    func selectItems(ids:[Int]){
        var value: [Int] = ids
        if !multiselectable {
            if let idx = ids.first {
                value = [idx]
            }
        }
     
        for (_, item) in self.items.enumerated(){
            item.selected = value.contains(item.id)
        }
    }
}
