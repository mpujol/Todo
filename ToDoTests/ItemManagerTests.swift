//
//  ManagerTests.swift
//  ToDoTests
//
//  Created by Michael Pujol on 9/13/18.
//  Copyright © 2018 Michael Pujol. All rights reserved.
//

import XCTest
@testable import ToDo

class ItemManagerTests: XCTestCase {

    var sut: ItemManager!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = ItemManager()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut.removeAllItems()
        sut = nil
        super.tearDown()
        
    }
    
    func test_ToDoCount_Initially_IsZero() {
        XCTAssertEqual(sut.toDoCount, 0)
    }
    
    func test_DoneCount_Initially_IsZero() {
        XCTAssertEqual(sut.doneCount, 0)
    }
    
    func test_AddItem_IncreasesToDoCountToOne() {
        sut.add(ToDoItem(title: ""))
        XCTAssertEqual(sut.toDoCount, 1)
    }
    
    func test_ItemAt_ReturnsAddedItem(){
        let item = ToDoItem(title: "Foo")
        sut.add(item)
        
        let returnedItem = sut.item(at: 0)
        
        XCTAssertEqual(returnedItem.title, item.title)
    }
    
    func test_CheckItemAt_ChangesCounts() {
        sut.add(ToDoItem(title: ""))
        sut.checkItem(at: 0)
        XCTAssertEqual(sut.toDoCount, 0)
        XCTAssertEqual(sut.doneCount, 1)
    }
    
    func test_CheckItemAt_RemovesItFromToDoItems() {
        let first = ToDoItem(title: "First")
        let second = ToDoItem(title: "Second")
        sut.add(first)
        sut.add(second)
        
        sut.checkItem(at: 0)
        
        XCTAssertEqual(sut.item(at: 0).title, "Second")
    }
    
    func test_DoneItemAt_ReturnsCheckedItem() {
        let item = ToDoItem(title: "Foo")
        sut.add(item)
        
        sut.checkItem(at: 0)
        let returnedItem = sut.doneItem(at: 0)
        
        XCTAssertEqual(returnedItem.title, item.title)
    }
    
    func test_EqualItems_AreEqual() {
        let first = ToDoItem(title: "Foo")
        let second = ToDoItem(title: "Foo")
        
        XCTAssertEqual(first, second)
    }
    
    func test_Items_WhenLocationDiffers_AreNoteEqual() {
        let first = ToDoItem(title: "", location: Location(name: "Foo"))
        let second = ToDoItem(title: "", location: Location(name: "Bar"))
        XCTAssertNotEqual(first, second)
    }
    
    func test_RemoveAll_ResultsInCountsBeZero() {
        sut.add(ToDoItem(title: "Foo"))
        sut.add(ToDoItem(title: "Bar"))
        sut.checkItem(at: 0)
        
        XCTAssertEqual(sut.toDoCount, 1)
        XCTAssertEqual(sut.doneCount, 1)
        
        sut.removeAllItems()
        
        XCTAssertEqual(sut.toDoCount, 0)
        XCTAssertEqual(sut.doneCount, 0)
    }
    
    func test_Add_WhenItemIsAlreadyAdded_DoesNotIncreaseCount() {
        sut.add(ToDoItem(title: "Foo"))
        sut.add(ToDoItem(title: "Foo"))
        
        XCTAssertEqual(sut.toDoCount, 1)
    }
    
    func test_ToDoItemsGetSerialized() {
        var itemManager: ItemManager? = ItemManager()
        
        let firstItem = ToDoItem(title: "First")
        let secondItem = ToDoItem(title: "Second")
        
        if let itemManager = itemManager {
            itemManager.add(firstItem)
            itemManager.add(secondItem)
        }
        
        NotificationCenter.default.post(name: UIApplication.willResignActiveNotification, object: nil)
        
        itemManager = nil
        
        XCTAssertNil(itemManager)
        
        itemManager = ItemManager()
        XCTAssertEqual(itemManager?.toDoCount, 2)
        XCTAssertEqual(itemManager?.item(at: 0), firstItem)
        XCTAssertEqual(itemManager?.item(at: 1), secondItem)
        
    }
}











