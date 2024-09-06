//
//  MainViewController.swift
//  UIKitProject
//
//  Created by 장주표 on 9/6/24.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: UI Components
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 40
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(MainCell.self, forCellReuseIdentifier: "MainCell")
        return tableView
    }()
    
    // MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInit()
        setupUI()
        setupContraints()
    }

}

// MARK: - Setup

private extension MainViewController {
    
    func setupInit() {
        title = "Projects"
    }
    
    func setupUI() {
        view.addSubview(tableView)
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        present(projects[indexPath.row].viewController, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as? MainCell else {
            return UITableViewCell()
        }
        cell.configure(info: projects[indexPath.row])
        return cell
    }
}
