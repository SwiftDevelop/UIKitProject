//
//  Projects.swift
//  UIKitProject
//
//  Created by 장주표 on 9/6/24.
//

import UIKit

struct ProjectInfo {
    let name: String
    let base: String
    let status: ProjectStatus
    let viewController: UIViewController
}

enum ProjectStatus: String {
    case notStarted = "Not Ready"
    case inProgress = "Progressing"
    case completed = "Completed"
}

let projects: [ProjectInfo] = [
    ProjectInfo(name: "Calculator", base: "Apple", status: .completed, viewController: CalculatorViewController())
]
