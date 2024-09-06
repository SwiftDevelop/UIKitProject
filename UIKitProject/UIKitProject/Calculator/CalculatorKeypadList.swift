//
//  CalculatorKeypadList.swift
//  UIKitProject
//
//  Created by 장주표 on 9/6/24.
//

import UIKit

struct KeypadInfo {
    let title: String
    let titleColor: UIColor?
    let backgroundColor: UIColor?
}

let keypads: [[KeypadInfo]] = [
    [
        KeypadInfo(title: "AC", titleColor: .black, backgroundColor: UIColor(named: "KeypadColor2")),
        KeypadInfo(title: "\u{00B1}", titleColor: .black, backgroundColor: UIColor(named: "KeypadColor2")),
        KeypadInfo(title: "%", titleColor: .black, backgroundColor: UIColor(named: "KeypadColor2")),
        KeypadInfo(title: "\u{00F7}", titleColor: .white, backgroundColor: UIColor(named: "KeypadColor3")),
    ],
    [
        KeypadInfo(title: "7", titleColor: .white, backgroundColor: UIColor(named: "KeypadColor1")),
        KeypadInfo(title: "8", titleColor: .white, backgroundColor: UIColor(named: "KeypadColor1")),
        KeypadInfo(title: "9", titleColor: .white, backgroundColor: UIColor(named: "KeypadColor1")),
        KeypadInfo(title: "\u{00D7}", titleColor: .white, backgroundColor: UIColor(named: "KeypadColor3")),
    ],
    [
        KeypadInfo(title: "4", titleColor: .white, backgroundColor: UIColor(named: "KeypadColor1")),
        KeypadInfo(title: "5", titleColor: .white, backgroundColor: UIColor(named: "KeypadColor1")),
        KeypadInfo(title: "6", titleColor: .white, backgroundColor: UIColor(named: "KeypadColor1")),
        KeypadInfo(title: "\u{2212}", titleColor: .white, backgroundColor: UIColor(named: "KeypadColor3")),
    ],
    [
        KeypadInfo(title: "1", titleColor: .white, backgroundColor: UIColor(named: "KeypadColor1")),
        KeypadInfo(title: "2", titleColor: .white, backgroundColor: UIColor(named: "KeypadColor1")),
        KeypadInfo(title: "3", titleColor: .white, backgroundColor: UIColor(named: "KeypadColor1")),
        KeypadInfo(title: "\u{FF0B}", titleColor: .white, backgroundColor: UIColor(named: "KeypadColor3")),
    ],
    [
        KeypadInfo(title: "0", titleColor: .white, backgroundColor: UIColor(named: "KeypadColor1")),
        KeypadInfo(title: ".", titleColor: .white, backgroundColor: UIColor(named: "KeypadColor1")),
        KeypadInfo(title: "=", titleColor: .white, backgroundColor: UIColor(named: "KeypadColor3")),
    ],
]
