//
//  DrawingDetailedView.swift
//  Robo Zen
//
//  Created by Wes Cook on 10/15/24.
//


import UIKit


protocol DrawingDetailedViewControllerDelegate: AnyObject {
    func didDeleteDrawing(_ drawing: Drawing)
}

class DrawingDetailedViewController: UIViewController {
    
    var drawing: Drawing
    let drawingView = DrawingView()
    weak var delegate: DrawingDetailedViewControllerDelegate? 

    init(drawing: Drawing) {
        self.drawing = drawing
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = drawing.name
        
        setupDrawingView()
        displayDrawing()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deleteDrawing))
    }

    private func setupDrawingView() {
        view.backgroundColor = UIColor(red: 0.8, green: 0.9, blue: 1.0, alpha: 1.0)
        drawingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(drawingView)
        
        NSLayoutConstraint.activate([
            drawingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            drawingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            drawingView.widthAnchor.constraint(equalToConstant: 300),
            drawingView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        isDrawingAllowed = false
    }

    private func displayDrawing() {

        drawingView.lines = drawing.points
        drawingView.setNeedsDisplay()
    }

    @objc private func deleteDrawing() {
        delegate?.didDeleteDrawing(drawing)
        
        navigationController?.popViewController(animated: true)
    }
    
}
