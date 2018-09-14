//
//  ItemManager.swift
//  ToDo
//
//  Created by Michael Pujol on 9/13/18.
//  Copyright © 2018 Michael Pujol. All rights reserved.
//

import Foundation

class ItemManager {
 
    var toDoCount: Int {
        return toDoItems.count
    }
    var doneCount: Int {
        return doneItems.count
    }
    private var toDoItems: [ToDoItem] = []
    private var doneItems: [ToDoItem] = []
    
    func add(_ item: ToDoItem){
        toDoItems.append(item)
    }
    
    func item(at index: Int) -> ToDoItem {
        return toDoItems[index]
    }
    
    func checkItem(at index: Int) {
        let item = toDoItems.remove(at: index)
        doneItems.append(item)
    }
    
    func doneItem(at index: Int) -> ToDoItem {
        return doneItems[index]
    }
}
