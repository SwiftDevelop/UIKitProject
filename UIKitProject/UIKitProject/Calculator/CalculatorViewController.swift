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
            case "\u{00F7}", "\u{00D7}", "\u{2212}", "\u{FF0B}":
                currentOperation = title
                firstNumber = Double(displayLabel.text!)
                displayLabel.text = "0"
            case "=":
                guard let operation = currentOperation, let first = firstNumber else { return }
                secondNumber = Double(displayLabel.text!)
                performOperation(operation, first, secondNumber!)
            case "\u{00B1}":
                toggleSign()
            case "%":
                applyPercentage()
            default:
                appendNumber(title)
            }
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
    
    private func performOperation(_ operation: String, _ first: Double, _ second: Double) {
        var result: Double = 0
        
        switch operation {
        case "\u{FF0B}":
            result = first + second
        case "\u{2212}":
            result = first - second
        case "\u{00D7}":
            result = first * second
        case "\u{00F7}":
            result = first / second
        default:
            break
        }
        
        displayLabel.text = formatNumber(result)
        currentOperation = nil
        firstNumber = result
        secondNumber = nil
    }
    
    private func toggleSign() {
        guard let text = displayLabel.text, let value = Double(text) else { return }
        displayLabel.text = formatNumber(value * -1)
    }
    
    private func applyPercentage() {
        guard let text = displayLabel.text, let value = Double(text) else { return }
        displayLabel.text = formatNumber(value / 100)
    }
    
    private func appendNumber(_ number: String) {
        if displayLabel.text == "0" {
            displayLabel.text = number
        } else {
            displayLabel.text?.append(number)
        }
    }
    
    private func formatNumber(_ value: Double) -> String {
        return value == floor(value) ? String(format: "%.0f", value) : String(value)
    }
}
