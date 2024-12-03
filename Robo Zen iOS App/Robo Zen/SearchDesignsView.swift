//
//  SearchDesignsView.swift
//  Robo-Zen
//
//


import UIKit

class ViewDesignsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DrawingDetailedViewControllerDelegate {
    
    private let tableView = UITableView()
    private let noDrawingsMessageLabel = UILabel() // will tell user if there are no drawings
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.8, green: 0.9, blue: 1.0, alpha: 1.0)
        setupView()
        if globalDrawings.isEmpty {
            noDrawingsMessage()
        } else {
            setupTableView()
        }
    }
    
    private func noDrawingsMessage() {
        
        noDrawingsMessageLabel.text = "No custom designs available. You can create one in the drawing creation from the home screen."
        noDrawingsMessageLabel.font = UIFont.systemFont(ofSize: 20)
        noDrawingsMessageLabel.textAlignment = .center
        noDrawingsMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        noDrawingsMessageLabel.numberOfLines = 0
        view.addSubview(noDrawingsMessageLabel)
        
        NSLayoutConstraint.activate([
            noDrawingsMessageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noDrawingsMessageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noDrawingsMessageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            noDrawingsMessageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
    }
    
    private func setupView() {
        let titleLabel = UILabel()
        titleLabel.text = "View Designs"
        titleLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .left
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
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
        cell.textLabel?.text = "Drawing " + String(drawing.id) + ": " + drawing.name
        
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
    

    func didDeleteDrawing(_ drawing: Drawing) {
        if let index = globalDrawings.firstIndex(where: { $0.id == drawing.id }) {
            globalDrawings.remove(at: index)
            tableView.reloadData()
            
            if globalDrawings.isEmpty {
                noDrawingsMessage()
            }
        }
    }
}
