//
//  MergeViewController.swift
//  RxSwiftPracticeApp
//
//  Created by siheo on 1/16/24.
//

import UIKit
import RxSwift

class MergeViewController: UIViewController {
    
    private var descLabel: UILabel = {
        let label = UILabel()
        label.text = "버튼을 터치한 순서대로 결과가 나타납니다"
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
    
    private var buttonStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.distribution = .fillEqually
        return view
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
    private var redButtonObservable = PublishSubject<String>()
    private var blueButtonObservable = PublishSubject<String>()

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
            self.buttonStackView,
            self.resultLabel,
        ].forEach { self.view.addSubview($0) }
        
        [
            self.redButton,
            self.blueButton,
        ].forEach { self.buttonStackView.addArrangedSubview($0) }
        
        self.redButton.addTarget(self, action: #selector(redButtonTapped), for: .touchUpInside)
        self.blueButton.addTarget(self, action: #selector(blueButtonTapped), for: .touchUpInside)
    }
    
    private func configureAutoLayout() {
        [
            self.descLabel,
            self.buttonStackView,
            self.resultLabel,
            self.redButton,
            self.blueButton
        ].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            self.descLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15),
            self.descLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            self.descLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            self.buttonStackView.topAnchor.constraint(equalTo: self.descLabel.bottomAnchor, constant: 15),
            self.buttonStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            self.buttonStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            self.buttonStackView.heightAnchor.constraint(equalToConstant: 60),
            
            self.resultLabel.topAnchor.constraint(equalTo: self.buttonStackView.bottomAnchor, constant: 10),
            self.resultLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            self.resultLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
        ])
    }
    
    private func configureDataBinding() {
        Observable.of(self.redButtonObservable.asObservable(), self.blueButtonObservable.asObservable())
            .merge()
            .subscribe(
                onNext: { [weak self] buttonStr in
                    guard let self = self else { return }
                    
                    if self.resultLabel.text == nil {
                        self.resultLabel.text = "\(buttonStr) "
                    } else {
                        self.resultLabel.text! += "\(buttonStr) "
                    }
                }
            )
            .disposed(by: self.bag)
    }
    
    @objc private func redButtonTapped(_ button: UIButton) {
        self.redButtonObservable.onNext("RED")
    }
    
    @objc private func blueButtonTapped(_ button: UIButton) {
        self.blueButtonObservable.onNext("BLUE")
    }

}
