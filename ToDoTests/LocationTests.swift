//
//  LocationTests.swift
//  ToDoTests
//
//  Created by Michael Pujol on 9/13/18.
//  Copyright © 2018 Michael Pujol. All rights reserved.
//

import XCTest
@testable import ToDo
import CoreLocation

class LocationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_Init_SetsCoordinate() {
        let coordinate = CLLocationCoordinate2D(latitude: 1, longitude: 2)
        let location = Location(name: "", coordinate: coordinate)
        XCTAssertEqual(location.coordinate?.latitude, coordinate.latitude)
        XCTAssertEqual(location.coordinate?.longitude, coordinate.longitude)
    }
    
    func test_Init_SetsName() {
        let location = Location(name: "Foo")
        XCTAssertEqual(location.name, "Foo")
    }
    
    func test_EqualLocations_AreEqual() {
        let first = Location(name: "Foo")
        let second = Location(name: "Foo")
        
        XCTAssertEqual(first, second)
    }
    
    func test_Locations_WhenLatitudeDiffers_AreNotEqual() {
        
        assertLocationNotEqualWith(firstName: "Foo",
                                   firstLatLong: (1.0,0.0),
                                   secondName: "Foo",
                                   secondLatLong: (0.0,0.0),
                                   line: #line)
        
    }
    
    func test_Locations_WhenLongitudeDiffers_AreNotEqual() {
        
        assertLocationNotEqualWith(firstName: "Foo",
                                   firstLatLong: (0.0,1.0),
                                   secondName: "Foo",
                                   secondLatLong: (0.0,0.0),
                                   line: #line)
        
    }
    
    func test_Location_WhenNamesDiffer_AreNotEqual() {
        assertLocationNotEqualWith(firstName: "Foo",
                                   firstLatLong: nil,
                                   secondName: "Bar",
                                   secondLatLong: nil)
        
    }
    
    // Helper Method to create 2 Location
    
    func assertLocationNotEqualWith(firstName: String, firstLatLong: (Double, Double)?, secondName: String, secondLatLong: (Double, Double)?, line: UInt = #line) {
        var firstCoord: CLLocationCoordinate2D? =  nil
        if let firstLatLong = firstLatLong {
            firstCoord = CLLocationCoordinate2D(latitude: firstLatLong.0, longitude: firstLatLong.1)
        }
        let firstLocation = Location(name: firstName, coordinate: firstCoord)
        
        var secondCoord: CLLocationCoordinate2D? = nil
        if let secondLatLong = secondLatLong {
            secondCoord = CLLocationCoordinate2D(latitude: secondLatLong.0, longitude: secondLatLong.1)
        }
        let secondLocation = Location(name: secondName, coordinate: secondCoord)
        
        XCTAssertNotEqual(firstLocation, secondLocation)
    }
    
}














