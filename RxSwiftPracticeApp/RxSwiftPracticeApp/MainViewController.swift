//
//  MainViewController.swift
//  RxSwiftPracticeApp
//
//  Created by siheo on 1/15/24.
//

import UIKit

class MainViewController: UIViewController {
    
    private var mainTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Main"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
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
            mainTitleLabel,
            buttonScrollView,
        ].forEach { self.view.addSubview($0) }
        
        [
            buttonStackView,
        ].forEach { self.buttonScrollView.addSubview($0) }
    }
    
    private func configureAutoLayout() {
        [
            mainTitleLabel,
            buttonScrollView,
            buttonStackView,
        ].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            self.mainTitleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.mainTitleLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0),
            self.mainTitleLabel.heightAnchor.constraint(equalToConstant: 30),
            self.mainTitleLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            
            self.buttonScrollView.topAnchor.constraint(equalTo: self.mainTitleLabel.bottomAnchor, constant: 20),
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
        [
        ].forEach { (title, selector) in
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
