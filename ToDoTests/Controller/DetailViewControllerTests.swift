//
//  DetailViewControllerTests.swift
//  ToDoTests
//
//  Created by Michael Pujol on 9/21/18.
//  Copyright © 2018 Michael Pujol. All rights reserved.
//

import XCTest
import CoreLocation
@testable import ToDo

class DetailViewControllerTests: XCTestCase {

    var sut: DetailViewController!
    
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = (storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController)
        sut.loadViewIfNeeded()
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut.itemInfo?.0.removeAllItems()
        super.tearDown()
    }

    func test_HasTitleLabel() {
        let titleLabelIsSubView = sut.titleLabel.isDescendant(of: sut.view)
        XCTAssertTrue(titleLabelIsSubView)
    }
    
    func test_HasDateLabel() {
        let dateLabelIsSubView = sut.titleLabel.isDescendant(of: sut.view)
        XCTAssertTrue(dateLabelIsSubView)
    }
    
    func test_HasLocationNameLabel() {
        let locationNameLabelIsSubView = sut.locationNameLabel.isDescendant(of: sut.view)
            XCTAssertTrue(locationNameLabelIsSubView)
    }
    
    func test_HasDescriptionLabel() {
        let descriptionLabelIsSubView = sut.descriptionLabel.isDescendant(of: sut.view)
        XCTAssertTrue(descriptionLabelIsSubView)
    }
    
    func test_HasMapView() {
        let mapViewIsSubView = sut.mapView.isDescendant(of: sut.view)
        XCTAssertTrue(mapViewIsSubView)
    }

    func test_SettingItemInfo_SetsTextsToLabels() {
        let coordinate = CLLocationCoordinate2D(latitude: 51.2277, longitude: 6.7735)
        let location = Location(name: "Foo", coordinate: coordinate)
        let item = ToDoItem(title: "Bar", itemDescription: "Baz", timestamp: 1456150025, location: location)
        let itemManager = ItemManager()
        itemManager.add(item)
        
        sut.itemInfo = (itemManager,0)
        
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        XCTAssertEqual(sut.titleLabel.text, "Bar")
        XCTAssertEqual(sut.dateLabel.text, "02/22/2016")
        XCTAssertEqual(sut.locationNameLabel.text, "Foo")
        XCTAssertEqual(sut.descriptionLabel.text, "Baz")
        XCTAssertEqual(sut.mapView.centerCoordinate.latitude, coordinate.latitude, accuracy: 0.001)
        XCTAssertEqual(sut.mapView.centerCoordinate.longitude, coordinate.longitude, accuracy: 0.001)
    }
    
    func test_CheckItem_ChecksItemInItemManager() {
        let itemManager = ItemManager()
        itemManager.add(ToDoItem(title: "Foo"))
        
        sut.itemInfo = (itemManager, 0)
        sut.checkItem()
        
        XCTAssertEqual(itemManager.toDoCount, 0)
        XCTAssertEqual(itemManager.doneCount, 1)
    }
}
