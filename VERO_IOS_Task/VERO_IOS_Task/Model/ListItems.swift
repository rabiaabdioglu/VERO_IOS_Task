//
//  ListItems.swift
//  VERO_IOS_Task
//
//  Created by Rabia Abdioğlu on 3.11.2023.
//

import Foundation
struct Task: Identifiable, Codable {
    var id: UUID?
    let task: String
    let title: String
    let taskDescription: String? // Update property name
    let sort: String
    let wageType: String
    let businessUnitKey: String?
    let businessUnit: String
    let parentTaskID: String
    let preplanningBoardQuickSelect: String?
    let colorCode: String
    let workingTime: String?
    let isAvailableInTimeTrackingKioskMode: Bool

    enum CodingKeys: String, CodingKey {
        case id, task, title
        case taskDescription = "description" // Map 'description' to 'taskDescription'
        case sort, wageType, businessUnitKey, businessUnit, parentTaskID
        case preplanningBoardQuickSelect, colorCode, workingTime, isAvailableInTimeTrackingKioskMode
    }
}
