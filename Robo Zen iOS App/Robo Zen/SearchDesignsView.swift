//
//  SearchDesignsView.swift
//  Robo Zen
//
//  Created by Wes Cook on 10/14/24.
//


import UIKit

class ViewDesignsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DrawingDetailedViewControllerDelegate {
    
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.8, green: 0.9, blue: 1.0, alpha: 1.0)
        setupNavigationBar()
        if globalDrawings.isEmpty {
            emptyMessage()
        } else {
            setupTableView()
        }
    }
    
    private func emptyMessage() {
        let emptyMessageLabel = UILabel()
        emptyMessageLabel.text = "No drawings have been created yet!"
        emptyMessageLabel.textColor = .black
        emptyMessageLabel.font = UIFont(name: "AvenirNext-Regular", size: 18)
        emptyMessageLabel.textAlignment = .center
        emptyMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptyMessageLabel)
        

        NSLayoutConstraint.activate([
            emptyMessageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyMessageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyMessageLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            emptyMessageLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupNavigationBar() {

        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "AvenirNext-Bold", size: 24)!,
            .foregroundColor: UIColor.black
        ]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        title = "View Designs"
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DrawingCell")
        tableView.backgroundColor = UIColor.clear
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return globalDrawings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DrawingCell", for: indexPath)
        let drawing = globalDrawings[indexPath.row]
        cell.textLabel?.text = drawing.name
        
        cell.textLabel?.font = UIFont(name: "AvenirNext-Regular", size: 18)
        cell.textLabel?.textColor = .black
        cell.backgroundColor = UIColor.clear
        return cell
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedDrawing = globalDrawings[indexPath.row]
        let detailVC = DrawingDetailedViewController(drawing: selectedDrawing)
        detailVC.delegate = self
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // Delegate method to handle deletion
    func didDeleteDrawing(_ drawing: Drawing) {
        if let index = globalDrawings.firstIndex(where: { $0.id == drawing.id }) {
            globalDrawings.remove(at: index)
            tableView.reloadData()
            

            if globalDrawings.isEmpty {
                emptyMessage()
            }
        }
    }
}
