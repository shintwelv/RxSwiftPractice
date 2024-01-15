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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        configureUI()
        configureAutoLayout()
    }
    
    private func configureUI() {
        [
            mainTitleLabel
        ].forEach { self.view.addSubview($0) }
    }
    
    private func configureAutoLayout() {
        [
            mainTitleLabel
        ].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            self.mainTitleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.mainTitleLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0),
            self.mainTitleLabel.heightAnchor.constraint(equalToConstant: 30),
            self.mainTitleLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
}
