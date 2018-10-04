//
//  ItemManager.swift
//  ToDo
//
//  Created by Michael Pujol on 9/13/18.
//  Copyright © 2018 Michael Pujol. All rights reserved.
//

import UIKit

class ItemManager: NSObject {
 
    var toDoCount: Int {
        return toDoItems.count
    }
    var doneCount: Int {
        return doneItems.count
    }
    private var toDoItems: [ToDoItem] = []
    private var doneItems: [ToDoItem] = []
    
    var todoPathURL: URL {
        let fileURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        guard let documentURL = fileURLs.first else {
            print("Something went wrong. Documents url could not be found")
            fatalError()
        }
        return documentURL.appendingPathComponent("toDoItems.plist")
    }

    override init() {
        super.init()
        if let nsTodoItems = NSArray(contentsOf: todoPathURL) {
            for dict in nsTodoItems {
                if let toDoItem = ToDoItem(dict: dict as! [String: Any]) {
                    toDoItems.append(toDoItem)
                }
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(save), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        save()
    }
    
    @objc func save() {
        let nsToDoItems = toDoItems.map { $0.plistDict }
        guard nsToDoItems.count > 0 else {
            try? FileManager.default.removeItem(at: todoPathURL)
            return
        }
        do {
            let plistData = try PropertyListSerialization.data(fromPropertyList: nsToDoItems, format: PropertyListSerialization.PropertyListFormat.xml, options: PropertyListSerialization.WriteOptions(0))
            try plistData.write(to: todoPathURL, options: Data.WritingOptions.atomic)
        } catch {
            print(error)
        }
    }
    
    func add(_ item: ToDoItem){
        if !toDoItems.contains(item) {
            toDoItems.append(item)
        }
    }
    
    func item(at index: Int) -> ToDoItem {
        return toDoItems[index]
    }
    
    func checkItem(at index: Int) {
        let item = toDoItems.remove(at: index)
        doneItems.append(item)
    }

    func uncheckItem(at index: Int) {
        let item = doneItems.remove(at: index)
        toDoItems.append(item)
    }
    
    func doneItem(at index: Int) -> ToDoItem {
        return doneItems[index]
    }
    
    func removeAllItems() {
        toDoItems.removeAll()
        doneItems.removeAll()
    }
}
