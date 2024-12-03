//
//  ControlView.swift
//  Robo-Zen
//
//


import UIKit

var drawingQueue: [Drawing] = [] // global drawing queue so we can delete drawings from it from the queue from other views

class ControlRoboZenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.8, green: 0.9, blue: 1.0, alpha: 1.0)
        //setupNavigationBar()
        setupView()
        setupControlButtons()
    }
    
//    private func setupNavigationBar() {
//        
//        let titleAttributes: [NSAttributedString.Key: Any] = [
//            .font: UIFont(name: "AvenirNext-Bold", size: 24)!,
//            .foregroundColor: UIColor.black
//        ]
//        navigationController?.navigationBar.titleTextAttributes = titleAttributes
//        title = "Control Robo-Zen"
//    }
    
    private func setupView(){
        view.backgroundColor = UIColor(red: 0.8, green: 0.9, blue: 1.0, alpha: 1.0)
        let titleLabel = UILabel()
        titleLabel.text = "Control Robo-Zen"
        titleLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .left
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupControlButtons() {
        let customButton = createStyledButton(withTitle: " Select Custom Design ")
        customButton.addTarget(self, action: #selector(selectCustomDesign), for: .touchUpInside)

        let premadeButton = createStyledButton(withTitle: " Select Premade Design ")
        premadeButton.addTarget(self, action: #selector(selectPremadeDesign), for: .touchUpInside)
                
        let startButton = createStyledButton(withTitle: " Start Drawing ")
        startButton.addTarget(self, action: #selector(startDrawing), for: .touchUpInside)
        
        let stopButton = createStyledButton(withTitle: " Stop Drawing ")
        stopButton.addTarget(self, action: #selector(stopDrawing), for: .touchUpInside)
        
        let resetButton = createStyledButton(withTitle: " Reset Sand ")
        resetButton.addTarget(self, action: #selector(resetSand), for: .touchUpInside)

        let queueButton = createStyledButton(withTitle: " View Drawing Queue ")
        queueButton.addTarget(self, action: #selector(viewDrawingQueue), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [customButton, premadeButton, startButton, stopButton, resetButton, queueButton])
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
        button.layer.cornerRadius = 3
        button.layer.borderColor = UIColor.black.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }
    @objc func selectCustomDesign() {
        let selectCustomDesignVC = SelectCustomDesignViewController()
        navigationController?.pushViewController(selectCustomDesignVC, animated: true)
    }
    
    @objc func selectPremadeDesign() {
        print("Premade design selected!")
    }
    
    @objc func startDrawing() {
        showAlert(title: "Error", message: "Sorry, this is not ready to use!")
    }
    
    @objc func stopDrawing() {
        showAlert(title: "Error", message: "Sorry, this is not ready to use!")
    }
    
    @objc func resetSand() {
        showAlert(title: "Error", message: "Sorry, this is not ready to use!")
    }
    
    @objc func viewDrawingQueue() {
        showAlert(title: "Error", message: "Sorry, this is not ready to use!")
        //let queueVC = DrawingQueueViewController()
        //navigationController?.pushViewController(queueVC, animated: true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
