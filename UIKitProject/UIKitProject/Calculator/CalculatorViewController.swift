//
//  CalculatorViewController.swift
//  UIKitProject
//
//  Created by 장주표 on 9/6/24.
//

import UIKit

final class CalculatorViewController: UIViewController {
    
    // MARK: UI Components
    
    private let displayLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .right
        label.textColor = .white
        label.font = .systemFont(ofSize: 80, weight: .thin)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: Properties
    
    private var selectedKeypad: String?
    private var currentOperation: String?
    private var firstNumber: Double?
    private var secondNumber: Double?
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInit()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupConstraints()
    }
}

// MARK: - Setup

private extension CalculatorViewController {
    
    func setupInit() {
        view.backgroundColor = .black
    }
    
    func setupUI() {
        view.addSubview(displayLabel)
        view.addSubview(vStackView)
        
        for info in keypads {
            let hStackView = UIStackView()
            hStackView.axis = .horizontal
            hStackView.distribution = .fillProportionally
            hStackView.spacing = 16
            
            info.forEach {
                let button = CalculatorKeypad(type: .system)
                button.setTitle($0.title, for: .normal)
                button.setTitleColor($0.titleColor, for: .normal)
                button.backgroundColor = $0.backgroundColor
                button.addAction(keypadAction, for: .touchUpInside)
                
                let buttonWidth = (view.bounds.size.width - (16 * 5)) / 4
                button.layer.cornerRadius = buttonWidth / 2
                
                if $0.title != "0" {
                    button.translatesAutoresizingMaskIntoConstraints = false
                    
                    NSLayoutConstraint.activate([
                        button.widthAnchor.constraint(equalToConstant: buttonWidth),
                        button.heightAnchor.constraint(equalToConstant: buttonWidth)
                    ])
                }
                
                hStackView.addArrangedSubview(button)
            }
            
            vStackView.addArrangedSubview(hStackView)
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            displayLabel.bottomAnchor.constraint(equalTo: vStackView.topAnchor, constant: -16),
            displayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            displayLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            vStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.safeAreaInsets.bottom),
            vStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            vStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}

// MARK: - Action Handler

private extension CalculatorViewController {
    
    var keypadAction: UIAction {
        UIAction { [weak self] action in
            guard let self,
                  let sender = action.sender as? CalculatorKeypad,
                  let title = sender.titleLabel?.text else { return }
            
            switch title {
            case "AC":
                resetCalculator()
            case plusUnicode, minusUnicode, multiplyUnicode, divideUnicode, plusMinusUnicode:
                handleOperation(title)
            case "=":
                handleEquals()
            case plusMinusUnicode:
                toggleSign()
            case "%":
                applyPercentage()
            default:
                appendNumber(title)
            }
            
            selectedKeypad = title
        }
    }
}

// MARK: - Private Method

private extension CalculatorViewController {
    
    func resetCalculator() {
        displayLabel.text = "0"
        currentOperation = nil
        firstNumber = nil
        secondNumber = nil
    }
    
    func performOperation(_ operation: String, _ first: Double, _ second: Double) -> Double {
        var result: Double = 0
        
        switch operation {
        case plusUnicode:
            result = first + second
        case minusUnicode:
            result = first - second
        case multiplyUnicode:
            result = first * second
        case divideUnicode:
            result = first / second
        default:
            break
        }
        
        return result
    }
    
    func handleOperation(_ operation: String) {
        currentOperation = operation
        
        let currentNumber = Double(displayLabel.text!)
        
        if firstNumber == nil {
            firstNumber = currentNumber
        } else {
            let result = performOperation(currentOperation!, firstNumber!, currentNumber!)
            displayLabel.text = formatNumber(result)
            firstNumber = result
        }
    }
    
    func handleEquals() {
        guard let currentOperation, let firstNumber else { return }
        let currentNumber = Double(displayLabel.text!) ?? 0
        let result = performOperation(currentOperation, currentNumber, firstNumber)
        displayLabel.text = formatNumber(result)
    }
    
    func toggleSign() {
        guard let text = displayLabel.text, let value = Double(text) else { return }
        displayLabel.text = formatNumber(value * -1)
    }
    
    func applyPercentage() {
        guard let text = displayLabel.text, let value = Double(text) else { return }
        displayLabel.text = formatNumber(value / 100)
    }
    
    func appendNumber(_ number: String) {
        if displayLabel.text == "0" || selectedKeypad == currentOperation {
            displayLabel.text = number
        } else {
            let currentText = (displayLabel.text ?? "") + number
            let currentNumber = Double(currentText.replacingOccurrences(of: ",", with: "")) ?? 0
            displayLabel.text = formatNumber(currentNumber)
        }
    }
    
    func formatNumber(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        
        if let formattedNumber = formatter.string(from: NSNumber(value: value)) {
            return formattedNumber
        } else {
            return String(value)
        }
    }

}
