//
//  ViewController.swift
//  Sample
//


import UIKit
import Extensions

class ViewController: UIViewController {

    @IBOutlet weak var uiLabel: UILabel!
    
    class DataSourceColored0: DataSource<DataSourceItem<UIColor>> {
        override init() {
            super.init()
            self.multiselectable = false
        }
    }
    
    class DataSourceColored1: DataSource<DataSourceItem<UIColor>> {
        override init() {
            super.init()
            self.multiselectable = true
        }
    }
    
    class DataSourceString: DataSource<DataSourceItem<String>> {
        override init() {
            super.init()
            self.multiselectable = false
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dsColor0 = DataSourceColored0()
        let dsColor1 = DataSourceColored1()
        let dsString = DataSourceString()
        
        let item0 = DataSourceItem<UIColor>(id: 0, title: "Title0", selected: false)
            item0.value = .red
        dsColor0.append(item0)
        
        let item1 = DataSourceItem<UIColor>(id: 1, title: "Title1", selected: true)
            item1.value = .white
        dsColor0.append(item1)
        
        let item2 = DataSourceItem<UIColor>(id: 2, title: "Title2", selected: true)
            item2.value = .yellow
        dsColor1.append(item2)
        
        let item3 = DataSourceItem<UIColor>(id: 3, title: "Title3", selected: true)
            item3.value = .black
        dsColor1.append(item3)
        
        let itemS0 = DataSourceItem<String>(id: 0, title: "Title0", selected: false)
            itemS0.value = "red"
        dsString.append(itemS0)
        
        let itemS1 = DataSourceItem<String>(id: 0, title: "Title0", selected: false)
            itemS1.value = "reds"
        dsString.append(itemS1)
        
        
        [dsColor0, dsColor1, dsString].forEach({
            if $0.self is DataSourceBaseProtocol {
                print("yes")
            }
        })
        
        print(dsColor1.selectedIds)
        dsColor1.selectedIds = []
        print(dsColor1.selectedIds)
        dsColor1.selectedIds = [2]
        print(dsColor1.selectedIds)
        dsColor1.selectedIds = [2,3]
        print(dsColor1.selectedIds)
    }


}

