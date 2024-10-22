//
//  DrawingQueueViewController.swift
//  Robo Zen
//
//  Created by Wes Cook on 10/15/24.
//
import UIKit

class DrawingQueueViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView = UITableView()
    private let messageLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.8, green: 0.9, blue: 1.0, alpha: 1.0)
        setupView()
    }
    
    private func setupView() {
        let titleLabel = UILabel()
        titleLabel.text = "Drawing Queue"
        titleLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        

        messageLabel.text = "There are no drawings in the queue for Robo Zen currently!"
        messageLabel.font = UIFont.systemFont(ofSize: 20)
        messageLabel.textAlignment = .center
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.numberOfLines = 0
        view.addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        

        setupTableView()
        
 
        updateQueueDisplay()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DrawingCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isEditing = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func updateQueueDisplay() {
        if drawingQueue.isEmpty {
            messageLabel.isHidden = false
            tableView.isHidden = true
        } else {
            messageLabel.isHidden = true
            tableView.isHidden = false
            tableView.reloadData()
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drawingQueue.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DrawingCell", for: indexPath)
        let drawing = drawingQueue[indexPath.row]
        cell.textLabel?.text = drawing.name
        
        return cell
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedDrawing = drawingQueue[indexPath.row]
        

        let alert = UIAlertController(title: "Drawing Options",
                                      message: "What would you like to do with \(selectedDrawing.name)?",
                                      preferredStyle: .alert)
        
        
        alert.addAction(UIAlertAction(title: "View Drawing", style: .default, handler: { _ in
            let drawingDetailVC = DrawingDetailedViewController(drawing: selectedDrawing)
            self.navigationController?.pushViewController(drawingDetailVC, animated: true)
        }))
        
       
        alert.addAction(UIAlertAction(title: "Remove Drawing", style: .destructive, handler: { _ in
            self.confirmRemoveDrawing(at: indexPath)
        }))
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            tableView.deselectRow(at: indexPath, animated: true)
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    private func confirmRemoveDrawing(at indexPath: IndexPath) {
        let selectedDrawing = drawingQueue[indexPath.row]
        let confirmAlert = UIAlertController(title: "Confirm Removal",
                                              message: "Are you sure you want to remove \(selectedDrawing.name)?",
                                              preferredStyle: .alert)
        
        confirmAlert.addAction(UIAlertAction(title: "Remove", style: .destructive, handler: { _ in
            self.removeDrawing(at: indexPath)
        }))
        confirmAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(confirmAlert, animated: true, completion: nil)
    }
    
    private func removeDrawing(at indexPath: IndexPath) {
        let drawingToRemove = drawingQueue[indexPath.row]
        drawingQueue.remove(at: indexPath.row)
        
        let alert = UIAlertController(title: "Drawing Removed",
                                      message: "Successfully removed drawing: \(drawingToRemove.name)",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.updateQueueDisplay()
            self.tableView.reloadData()
        }))
        present(alert, animated: true, completion: nil)
    }
    func didDeleteDrawing(_ drawing: Drawing) {
        if let index = globalDrawings.firstIndex(where: { $0.id == drawing.id }) {
            globalDrawings.remove(at: index)
            tableView.reloadData()
        }
    }
}
