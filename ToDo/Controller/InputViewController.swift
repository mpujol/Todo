//
//  InputViewController.swift
//  ToDo
//
//  Created by Michael Pujol on 9/24/18.
//  Copyright © 2018 Michael Pujol. All rights reserved.
//

import UIKit
import CoreLocation

class InputViewController: UIViewController {

    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var addressTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var saveButton: UIButton!
    
    lazy var geocoder = CLGeocoder()
    var itemManager: ItemManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
        
    @IBAction func save() {
        guard let titleString = self.titleTextField.text, titleString.count > 0 else { return }
        let date: Date?
        if let dateText = self.dateTextField.text, dateText.count > 0 {
            date = DateFormatter().createDateFormatter().date(from: dateText)
        } else {
            date = nil
        }
        let descriptionString = descriptionTextField.text
        if let locationName = locationTextField.text, locationName.count > 0 {
            if let address = addressTextField.text, address.count > 0 {
                geocoder.geocodeAddressString(address) { (placemarks, error) in
                    let placemMark = placemarks?.first
                    
                    let item = ToDoItem(title: titleString,
                                        itemDescription: descriptionString,
                                        timestamp: date?.timeIntervalSince1970,
                                        location: Location(name: locationName, coordinate: placemMark?.location?.coordinate))
                    
                    self.itemManager?.add(item)
                }
            }
        }
    }

    
}
