//
//  ViewController.swift
//  Robo Zen
//
//  Created by Wes Cook on 10/14/24.
//


import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupButtons()
    }
    
    func setupView() {
        view.backgroundColor = UIColor(red: 0.9, green: 1.0, blue: 0.9, alpha: 1.0)
        let titleLabel = UILabel()
        titleLabel.text = "Welcome to Robo Zen"
        titleLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .left
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        let backgroundImageView = UIImageView(image: UIImage(named: "bamboo_background"))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(backgroundImageView, at: 0)
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupButtons() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        let buttonTitles = [
            "Create Design",
            "Control Robo-Zen",
            "View Designs",
            "Bluetooth Pairing"
        ]
        
        for title in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 28)
            button.backgroundColor = UIColor.systemTeal
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 10
            button.layer.borderColor = UIColor.black.cgColor
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)

        }
        
        
        NSLayoutConstraint.activate([
                    stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        switch sender.currentTitle {
        case "Create Design":
            goToDrawingView()
        case "Control Robo-Zen":
            goToControlView()
        case "View Designs":
            goToViewDesigns()
        case "Bluetooth Pairing":
            goToBluetoothSettings()
        default:
            break
        }
    }

    @objc func goToDrawingView() {
        isDrawingAllowed = true
        navigationController?.pushViewController(RoboZenDrawingViewController(), animated: true)
    }
    
    @objc func goToControlView() {
        if(!isBluetoothConnected) {
            navigationController?.pushViewController(ControlRoboZenViewController(), animated: true)
        } else {
            let alert = UIAlertController(title: "Access Restricted",
                                          message: "You must pair the Robo-Zen device before accessing this feature.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func goToViewDesigns() {
        isDrawingAllowed = false
        navigationController?.pushViewController(ViewDesignsViewController(), animated: true)
    }
    
    @objc func goToBluetoothSettings() {
        navigationController?.pushViewController(BluetoothSettingsViewController(), animated: true)
    }
}
