//
//  Extension.swift
//  VERO_IOS_Task
//
//  Created by Rabia Abdioğlu on 3.11.2023.
//

import Foundation
import SwiftUI

extension Color {
    static let customText = Color(red: 0.30, green: 0.30, blue: 0.30)
    static let customCircle = Color.yellow

    init(hex: String) {
        var hexSanitized = hex
        if hexSanitized.hasPrefix("#") {
            hexSanitized = String(hexSanitized.dropFirst())
        }
        
        var rgb: UInt64 = 0
        
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}

extension CDTask {
    func update(with task: Task) {
        self.id = task.id ?? UUID()
        self.task = task.task
        self.title = task.title
        self.taskDescription = task.taskDescription
        self.sort = task.sort
        self.wageType = task.wageType
        self.businessUnitKey = task.businessUnitKey
        self.businessUnit = task.businessUnit
        self.parentTaskID = task.parentTaskID
        self.preplanningBoardQuickSelect = task.preplanningBoardQuickSelect
        self.colorCode = task.colorCode
        self.workingTime = task.workingTime
        self.isAvailableInTimeTrackingKioskMode = task.isAvailableInTimeTrackingKioskMode
    }
}
