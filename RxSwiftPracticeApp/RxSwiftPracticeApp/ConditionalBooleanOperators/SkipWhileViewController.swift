//
//  SkipWhileViewController.swift
//  RxSwiftPracticeApp
//
//  Created by siheo on 1/24/24.
//

import UIKit
import RxSwift

class SkipWhileViewController: UIViewController {
    
    private var descLabel: UILabel = {
        let label = UILabel()
        label.text = "GO 버튼을 터치한 이후부터 값이 나옵니다"
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private var redButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemRed
        return button
    }()
    
    private var blueButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    private var colorButtonStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.distribution = .fillEqually
        return view
    }()
    
    private var unblockButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GO", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemGray3
        return button
    }()
    
    private var resultLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.text = "받아온 값 =\n"
        label.numberOfLines = 0
        label.tintColor = .black
        return label
    }()
    
    private var bag = DisposeBag()
    private var colorButtonObservable = PublishSubject<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureAutoLayout()
        configureDataBinding()
    }
    
    private func configureUI() {
        self.view.backgroundColor = .white
        
        [
            self.descLabel,
            self.colorButtonStackView,
            self.unblockButton,
            self.resultLabel,
        ].forEach { self.view.addSubview($0) }
        
        [
            self.redButton,
            self.blueButton,
        ].forEach { self.colorButtonStackView.addArrangedSubview($0) }
        
        self.redButton.addTarget(self, action: #selector(redButtonTapped), for: .touchUpInside)
        self.blueButton.addTarget(self, action: #selector(blueButtonTapped), for: .touchUpInside)
        self.unblockButton.addTarget(self, action: #selector(unblockButtonTapped), for: .touchUpInside)
    }
    
    private func configureAutoLayout() {
        [
            self.descLabel,
            self.colorButtonStackView,
            self.unblockButton,
            self.resultLabel,
            self.redButton,
            self.blueButton,
        ].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            self.descLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15),
            self.descLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            self.descLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            self.colorButtonStackView.topAnchor.constraint(equalTo: self.descLabel.bottomAnchor, constant: 15),
            self.colorButtonStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            self.colorButtonStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            self.colorButtonStackView.heightAnchor.constraint(equalToConstant: 60),
            
            self.unblockButton.topAnchor.constraint(equalTo: self.colorButtonStackView.bottomAnchor, constant: 10),
            self.unblockButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            self.unblockButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            self.unblockButton.heightAnchor.constraint(equalToConstant: 60),
            
            self.resultLabel.topAnchor.constraint(equalTo: self.unblockButton.bottomAnchor, constant: 10),
            self.resultLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            self.resultLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
        ])
    }
    
    private func configureDataBinding() {
        colorButtonObservable
            .skip { [weak self] _ in
                guard let self = self else { return false }
                
                return self.unblockButton.isHidden == false
            }
            .subscribe(
                onNext: { [weak self] resultStr in
                    guard let self = self else { return }
                    
                    if self.resultLabel.text == nil {
                        self.resultLabel.text = "\(resultStr), "
                    } else {
                        self.resultLabel.text! += "\(resultStr), "
                    }
                }
            )
            .disposed(by: self.bag)
    }
    
    @objc private func redButtonTapped(_ button: UIButton) {
        self.colorButtonObservable.onNext("RED")
    }
    
    @objc private func blueButtonTapped(_ button: UIButton) {
        self.colorButtonObservable.onNext("BLUE")
    }
    
    @objc private func unblockButtonTapped(_ button: UIButton) {
        self.unblockButton.isHidden = true
    }
}
