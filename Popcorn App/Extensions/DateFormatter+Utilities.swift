//
//  DateFormatter+Utilities.swift
//  Popcorn App
//
//  Created by Lucas Pereira on 12.08.21.
//

import Foundation

extension DateFormatter {
    
    static func yearString(from stringDate: String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: stringDate) {
            formatter.dateFormat = "yyyy"
            return formatter.string(from: date)
        }
        return nil
    }
}
