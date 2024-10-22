//
//  ControlView.swift
//  Robo Zen
//
//  Created by Wes Cook on 10/14/24.
//


import UIKit

var drawingQueue: [Drawing] = []

class ControlRoboZenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.8, green: 0.9, blue: 1.0, alpha: 1.0)
        setupNavigationBar()
        setupControlButtons()
    }
    
    private func setupNavigationBar() {
        
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "AvenirNext-Bold", size: 24)!,
            .foregroundColor: UIColor.black
        ]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        title = "Control Robo-Zen"
    }
    
    func setupControlButtons() {

        let premadeButton = createStyledButton(withTitle: "Select Premade Design")
        premadeButton.addTarget(self, action: #selector(selectPremadeDesign), for: .touchUpInside)
        
        let customButton = createStyledButton(withTitle: "Select Custom Design")
        customButton.addTarget(self, action: #selector(selectCustomDesign), for: .touchUpInside)
        
        let startButton = createStyledButton(withTitle: "Start Drawing")
        startButton.addTarget(self, action: #selector(startDrawing), for: .touchUpInside)
        
        let stopButton = createStyledButton(withTitle: "Stop Drawing")
        stopButton.addTarget(self, action: #selector(stopDrawing), for: .touchUpInside)
        
        let resetButton = createStyledButton(withTitle: "Reset Sand")
        resetButton.addTarget(self, action: #selector(resetSand), for: .touchUpInside)
        

        let queueButton = createStyledButton(withTitle: "View Drawing Queue")
        queueButton.addTarget(self, action: #selector(viewDrawingQueue), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [premadeButton, customButton, startButton, stopButton, resetButton, queueButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func createStyledButton(withTitle title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 28)
        button.backgroundColor = UIColor.systemTeal
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.black.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }
    
    @objc func selectPremadeDesign() {
        print("Premade design selected!")
    }
    
    @objc func selectCustomDesign() {
        let selectCustomDesignVC = SelectCustomDesignViewController()
        navigationController?.pushViewController(selectCustomDesignVC, animated: true)
    }
    
    @objc func startDrawing() {
        showAlert(title: "Drawing Started", message: "Drawing has been successfully started!")
    }
    
    @objc func stopDrawing() {
        showAlert(title: "Drawing Stopped", message: "Drawing has been successfully stopped!")
    }
    
    @objc func resetSand() {
        showAlert(title: "Sand Reset", message: "Sand has been successfully reset!")
    }
    
    @objc func viewDrawingQueue() {
        let queueVC = DrawingQueueViewController()
        navigationController?.pushViewController(queueVC, animated: true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
