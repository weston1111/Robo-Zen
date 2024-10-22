//
//  SelectCutomDesignView.swift
//  Robo Zen
//
//  Created by Wes Cook on 10/15/24.
//

import UIKit

class SelectCustomDesignViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView = UITableView()
    private let emptyMessageLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.8, green: 0.9, blue: 1.0, alpha: 1.0)
        setupNavigationBar()
        setupTableView()
        showEmptyMessageIfNeeded()
    }
    
    private func setupNavigationBar() {
        title = "Select Custom Design"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupTableView() {
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
    
    private func showEmptyMessageIfNeeded() {
        if globalDrawings.isEmpty {
            emptyMessageLabel.text = "No custom designs available. You can create one in the drawing creation from the home screen."
            emptyMessageLabel.textColor = .black
            emptyMessageLabel.font = UIFont(name: "AvenirNext-Regular", size: 18)
            emptyMessageLabel.textAlignment = .center
            emptyMessageLabel.numberOfLines = 0
            emptyMessageLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(emptyMessageLabel)

            NSLayoutConstraint.activate([
                emptyMessageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                emptyMessageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                emptyMessageLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
                emptyMessageLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
            ])
        }
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
        confirmDrawingSelection(drawing: selectedDrawing)
    }
    
    private func confirmDrawingSelection(drawing: Drawing) {
        let alert = UIAlertController(title: "Confirm Selection",
                                      message: "Do you want to select the drawing '\(drawing.name)'?",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Select", style: .default, handler: { _ in
            self.finalizeSelection(drawing: drawing)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func finalizeSelection(drawing: Drawing) {

        drawingQueue.append(drawing)
        
        let successAlert = UIAlertController(title: "Success!",
                                             message: "Successfully added drawing '\(drawing.name)' to the queue!",
                                             preferredStyle: .alert)
        successAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        successAlert.addAction(UIAlertAction(title: "Go Back", style: .cancel, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        present(successAlert, animated: true, completion: nil)
    }
}
