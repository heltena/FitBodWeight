//
//  DateFormatter+Extension.swift
//  FitBodWeight
//
//  Created by Heliodoro Tejedor Navarro on 15/6/24.
//

import Foundation

extension DateFormatter {
    static func forWorkout() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd yyyy"
        dateFormatter.timeZone = .gmt
        return dateFormatter
    }
}
