//
//  ItemListViewControllerTest.swift
//  ToDoTests
//
//  Created by Michael Pujol on 9/14/18.
//  Copyright © 2018 Michael Pujol. All rights reserved.
//

import XCTest
@testable import ToDo

class ItemListViewControllerTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_TableViewIsNotNilAfterViewDidLoad(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ItemListViewController")
        let sut = viewController as! ItemListViewController
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.tableView.dataSource is ItemListDataProvider)
    }
    
}
