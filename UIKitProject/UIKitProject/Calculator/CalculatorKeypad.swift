//
//  CalculatorKeypad.swift
//  UIKitProject
//
//  Created by 장주표 on 9/6/24.
//

import UIKit

final class CalculatorKeypad: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        adjustFontSizeToFit()
    }
}

// MARK: - Private Method

private extension CalculatorKeypad {
    
    func adjustFontSizeToFit() {
        guard let titleLabel = titleLabel else { return }
        
        let buttonWidth = bounds.width
        let buttonHeight = bounds.height
        let minFontSize: CGFloat = 20
        let maxFontSize: CGFloat = 35
        
        let titleSize = titleLabel.intrinsicContentSize
        let widthRatio = buttonWidth / titleSize.width
        let heightRatio = buttonHeight / titleSize.height
        let scaleFactor = min(widthRatio, heightRatio)
        
        let newFontSize = max(minFontSize, min(maxFontSize, titleLabel.font.pointSize * scaleFactor))
        titleLabel.font = titleLabel.font.withSize(newFontSize)
    }
}
