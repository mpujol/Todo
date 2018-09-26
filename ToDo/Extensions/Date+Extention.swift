//
//  Date+Extention.swift
//  ToDo
//
//  Created by Michael Pujol on 9/25/18.
//  Copyright © 2018 Michael Pujol. All rights reserved.
//

import Foundation

extension DateFormatter {
    func createDateFormatter() -> DateFormatter {
        let dateFormatter: DateFormatter = {
            let dF = DateFormatter()
            dF.dateFormat = "MM/dd/yyyy"
            return dF
        }()
        return dateFormatter
    }
}
