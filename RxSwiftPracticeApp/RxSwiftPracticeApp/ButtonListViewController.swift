//
//  ButtonListViewController.swift
//  RxSwiftPracticeApp
//
//  Created by siheo on 1/15/24.
//

import UIKit

class ButtonListViewController: UIViewController {
    
    var buttons: [(String, Selector)] {
        get {
            []
        }
    }
    
    private var buttonScrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
        view.bounces = true
        view.contentOffset = CGPoint(x: 0, y: 10)
        view.isScrollEnabled = true
        return view
    }()
    
    private var buttonStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        configureUI()
        configureAutoLayout()
        attachButtons()
    }
    
    private func configureUI() {
        [
            buttonScrollView,
        ].forEach { self.view.addSubview($0) }
        
        [
            buttonStackView,
        ].forEach { self.buttonScrollView.addSubview($0) }
    }
    
    private func configureAutoLayout() {
        [
            buttonScrollView,
            buttonStackView,
        ].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            self.buttonScrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.buttonScrollView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            self.buttonScrollView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.buttonScrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            self.buttonStackView.topAnchor.constraint(equalTo: self.buttonScrollView.topAnchor),
            self.buttonStackView.leadingAnchor.constraint(equalTo: self.buttonScrollView.leadingAnchor),
            self.buttonStackView.trailingAnchor.constraint(equalTo: self.buttonScrollView.trailingAnchor),
            self.buttonStackView.bottomAnchor.constraint(equalTo: self.buttonScrollView.bottomAnchor),
            
            self.buttonStackView.widthAnchor.constraint(equalTo: self.buttonScrollView.widthAnchor)
        ])
    }
    
    private func attachButtons() {
        self.buttons.forEach { (title, selector) in
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.tintColor = .white
            button.backgroundColor = .systemBlue
            button.addTarget(self, action: selector, for: .touchUpInside)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            
            self.buttonStackView.addArrangedSubview(button)
            
            NSLayoutConstraint.activate([
                button.heightAnchor.constraint(equalToConstant: 60)
            ])
        }
    }
}
