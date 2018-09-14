//
//  ToDoItem.swift
//  ToDo
//
//  Created by Michael Pujol on 9/13/18.
//  Copyright © 2018 Michael Pujol. All rights reserved.
//

import Foundation

struct ToDoItem: Equatable {
    static func == (lhs: ToDoItem, rhs: ToDoItem) -> Bool {
        return true
    }
    
    let title: String
    let itemDescription: String?
    let timestamp: Double?
    let location: Location?
    
    init(title: String, itemDescription: String? = nil, timestamp: Double? = nil, location: Location? = nil) {
        self.title = title
        self.itemDescription = itemDescription
        self.timestamp = timestamp
        self.location = location
    }
}
