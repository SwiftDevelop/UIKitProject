//
//  MainCell.swift
//  UIKitProject
//
//  Created by 장주표 on 9/6/24.
//

import UIKit

final class MainCell: UITableViewCell {
    
    // MARK: UI Components
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "NameColor")
        label.font = .systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let madeByLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupInit()
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup

private extension MainCell {
    
    func setupInit() {
        selectionStyle = .none
    }
    
    func setupUI() {
        addSubview(nameLabel)
        addSubview(madeByLabel)
        addSubview(statusLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            madeByLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            madeByLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            madeByLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            statusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            statusLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

// MARK: - Public

extension MainCell {
    
    func configure(info: ProjectInfo) {
        nameLabel.text = info.name
        madeByLabel.text = "by \(info.madeBy)"
        statusLabel.text = info.status.rawValue
    }
}
