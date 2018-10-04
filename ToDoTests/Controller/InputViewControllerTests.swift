//
//  InputViewControllerTests.swift
//  ToDoTests
//
//  Created by Michael Pujol on 9/24/18.
//  Copyright © 2018 Michael Pujol. All rights reserved.
//

import XCTest
import CoreLocation
@testable import ToDo

class InputViewControllerTests: XCTestCase {

    var sut: InputViewController!
    var placemark: MockPlacemark!
    var itemManager: ItemManager?
    
    lazy var dateFormatter:DateFormatter = {
        var dF = DateFormatter()
        dF.dateFormat = "MM/dd/yyyy"
        return dF
    }()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "InputViewController") as? InputViewController
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut.itemManager?.removeAllItems()
        super.tearDown()
    }
    
    func test_HasTitleTextField() {
        let titleTextFieldIsSubView = sut.titleTextField.isDescendant(of: sut.view)
        XCTAssertTrue(titleTextFieldIsSubView)
    }
    
    func test_HasDateTextField() {
        let dateTextFieldIsSubView = sut.dateTextField.isDescendant(of: sut.view)
        XCTAssertTrue(dateTextFieldIsSubView)
    }
    
    func test_HasLocationTextField() {
        let locationTextFieldIsSubView = sut.locationTextField.isDescendant(of: sut.view)
        XCTAssertTrue(locationTextFieldIsSubView)
    }
    
    func test_HasAddressTextField() {
        let addressTextFieldIsSubview = sut.addressTextField.isDescendant(of: sut.view)
        XCTAssertTrue(addressTextFieldIsSubview)
    }
    
    func test_HasDescriptionTextField() {
        let descriptionTextFieldIsSubview = sut.descriptionTextField.isDescendant(of: sut.view)
        XCTAssertTrue(descriptionTextFieldIsSubview)
    }
    
    func test_HasCancelButton() {
        let cancelButtonIsSubView = sut.cancelButton.isDescendant(of: sut.view)
        XCTAssertTrue(cancelButtonIsSubView)
    }
    
    func test_HasSaveButton() {
        let saveButtonIsSubView = sut.saveButton.isDescendant(of: sut.view)
        XCTAssertTrue(saveButtonIsSubView)
    }
    
    func test_SaveButtonHasSaveAction() {
        let saveButton: UIButton = sut.saveButton
        
        guard let actions = saveButton.actions(forTarget: sut, forControlEvent: .touchUpInside) else { XCTFail(); return }
        
        XCTAssertTrue(actions.contains("save"))
    }
    
    
    func test_Save_UsesGeocoderToGetCoordinateFromAddress() {
        let timestamp = 1456041600.0 //Carefull this rounds incorrectly when going from string -> timestamp
        let date = Date(timeIntervalSince1970: timestamp)
        
        sut.titleTextField.text = "Foo"
        sut.dateTextField.text = dateFormatter.string(from: date)
        sut.locationTextField.text = "Bar"
        sut.addressTextField.text = "Infinite Loop 1, Cupertino"
        sut.descriptionTextField.text = "Baz"
        
        let mockGeocoder = MockGeocoder()
        sut.geocoder = mockGeocoder
        
        sut.itemManager = ItemManager()
        
        sut.save()
        
        placemark = MockPlacemark()
        let coordinate = CLLocationCoordinate2D(latitude: 37.3316851, longitude: -122.0300674)
        placemark.mockCoordinate = coordinate
        
        mockGeocoder.completionHandler?([placemark],nil)
        
        let item = sut.itemManager?.item(at: 0)
        
        let testItem = ToDoItem(title: "Foo", itemDescription: "Baz", timestamp: timestamp, location: Location(name: "Bar", coordinate: coordinate))
        
        XCTAssertEqual(item, testItem)
    }
    
    func test_Geocoder_FetchesCoordinates() {
        
        let address = "Infinite Loop 1, Cupertino"
        
        let geocoderAnswered = expectation(description: "Geocoder")
        
        CLGeocoder().geocodeAddressString(address) { (placemarks, error) in
            
            let coordinate = placemarks?.first?.location?.coordinate
            guard let latitude = coordinate?.latitude else {
                XCTFail()
                return
            }
            guard let longitude = coordinate?.longitude else {
                XCTFail()
                return
            }
            XCTAssertEqual(latitude, 37.3316, accuracy: 0.001)
            XCTAssertEqual(longitude, -122.0300, accuracy: 0.001)
            
            geocoderAnswered.fulfill()
            
        }
        waitForExpectations(timeout: 3, handler: nil)
        
    }
    
    func testSave_DismissedViewController() {
        let mockInputViewController = MockInputViewController()
        mockInputViewController.titleTextField = UITextField()
        mockInputViewController.dateTextField = UITextField()
        mockInputViewController.locationTextField = UITextField()
        mockInputViewController.addressTextField = UITextField()
        mockInputViewController.descriptionTextField = UITextField()
        mockInputViewController.titleTextField.text = "Test Title"
        
        mockInputViewController.save()
        
        XCTAssertTrue(mockInputViewController.dismissGotCalled)
    }
    
}

extension InputViewControllerTests {
    class MockGeocoder: CLGeocoder {
        
        var completionHandler: CLGeocodeCompletionHandler?
        
        override func geocodeAddressString(_ addressString: String, completionHandler: @escaping CLGeocodeCompletionHandler) {
            self.completionHandler = completionHandler
        }
    }
    class MockPlacemark: CLPlacemark {
        
        var mockCoordinate: CLLocationCoordinate2D?
        
        override var location: CLLocation? {
            guard let coordinate = mockCoordinate else { return CLLocation() }
            return CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        }
        
        
    }
    
    class MockInputViewController: InputViewController {
        var dismissGotCalled = false
        
        override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
            dismissGotCalled = true
        }
    }
    
}
