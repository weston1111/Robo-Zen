//
//  ViewController.swift
//  Robo-Zen
//
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
        let imageName = "zen_garden_sand.jpg"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 0, y: 0, width: 500, height: 1600)
        view.addSubview(imageView)
        
        let titleLabel = UILabel()
        titleLabel.text = "Welcome to Robo-Zen"
        titleLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    
    func setupButtons() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        let buttonTitles = [
            " Control Robo-Zen ",
            "Create Design",
            "View Designs"
        ]
        
        for title in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 28)
            button.backgroundColor = UIColor.systemTeal
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 3
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
        case " Control Robo-Zen ":
            goToControlView()
        case "View Designs":
            goToViewDesigns()
        default:
            break
        }
    }

    @objc func goToDrawingView() {
        isDrawingAllowed = true
        navigationController?.pushViewController(RoboZenDrawingViewController(), animated: true)
    }
    
    @objc func goToControlView() {
        navigationController?.pushViewController(ControlRoboZenViewController(), animated: true)
    }
    
    @objc func goToViewDesigns() {
        isDrawingAllowed = false
        navigationController?.pushViewController(ViewDesignsViewController(), animated: true)
    }
}
