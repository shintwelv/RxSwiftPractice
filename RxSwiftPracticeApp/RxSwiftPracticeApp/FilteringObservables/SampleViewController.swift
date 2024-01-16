//
//  SampleViewController.swift
//  RxSwiftPracticeApp
//
//  Created by siheo on 1/16/24.
//

import UIKit
import RxSwift
import RxCocoa

class SampleViewController: UIViewController {
    
    private var descLabel: UILabel = {
        let label = UILabel()
        label.text = "Go 버튼을 눌렀을 때 가장 최근값을 받아옵니다"
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 1
        label.textColor = .black
        return label
    }()
    
    private var buttonStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 10
        return view
    }()
    
    private var button1: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("1", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.backgroundColor = .systemBlue
        button.tag = 1
        return button
    }()
    
    private var button2: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("2", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.backgroundColor = .systemBlue
        button.tag = 2
        return button
    }()
    
    private var button3: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("3", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.backgroundColor = .systemBlue
        button.tag = 3
        return button
    }()
    
    private var button4: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("4", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.backgroundColor = .systemBlue
        button.tag = 4
        return button
    }()
    
    private var touchHistoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.text = "터치한 값 = "
        label.numberOfLines = 0
        label.tintColor = .black
        return label
    }()
    
    private var resultLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.text = "받아온 값 = "
        label.numberOfLines = 1
        label.tintColor = .black
        return label
    }()
    
    private var goButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GO", for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.backgroundColor = .systemGray4
        return button
    }()
    
    private var bag = DisposeBag()
    private var numberObservable = PublishSubject<Int>()
    private var buttonPressObservable = PublishSubject<Void>()
    
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
            self.touchHistoryLabel,
            self.goButton,
            self.resultLabel,
        ].forEach { self.view.addSubview($0) }
        
        [
            self.button1,
            self.button2,
            self.button3,
            self.button4,
        ].forEach {
            $0.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            self.buttonStackView.addArrangedSubview($0)
        }
        
        self.goButton.addTarget(self, action: #selector(goButtonTapped), for: .touchUpInside)
    }
    
    private func configureAutoLayout() {
        [
            self.descLabel,
            self.buttonStackView,
            self.touchHistoryLabel,
            self.goButton,
            self.resultLabel,
            self.button1,
            self.button2,
            self.button3,
            self.button4,
        ].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            self.descLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15),
            self.descLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            self.descLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            self.descLabel.heightAnchor.constraint(equalToConstant: 30),
            
            self.buttonStackView.topAnchor.constraint(equalTo: self.descLabel.bottomAnchor, constant: 15),
            self.buttonStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            self.buttonStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            self.buttonStackView.heightAnchor.constraint(equalToConstant: 60),
            
            self.touchHistoryLabel.topAnchor.constraint(equalTo: self.buttonStackView.bottomAnchor, constant: 10),
            self.touchHistoryLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            self.touchHistoryLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            self.goButton.topAnchor.constraint(equalTo: self.touchHistoryLabel.bottomAnchor, constant: 10),
            self.goButton.widthAnchor.constraint(equalToConstant: 80),
            self.goButton.heightAnchor.constraint(equalToConstant: 60),
            self.goButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            
            self.resultLabel.topAnchor.constraint(equalTo: self.goButton.bottomAnchor, constant: 10),
            self.resultLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            self.resultLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
        ])
    }
    
    private func configureDataBinding() {
        numberObservable
            .sample(buttonPressObservable.asObservable())
            .subscribe(
                onNext: { [weak self] number in
                    guard let self = self else { return }
                    
                    if self.resultLabel.text == nil {
                        self.resultLabel.text = "\(number)"
                    } else {
                        self.resultLabel.text! += "\(number)"
                    }
                }
            )
            .disposed(by: self.bag)
    }
    
    @objc private func goButtonTapped(_ button: UIButton) {
        buttonPressObservable.onNext(())
    }
    
    @objc private func buttonTapped(_ button: UIButton) {
        let tag = button.tag
        
        if self.touchHistoryLabel.text == nil {
            self.touchHistoryLabel.text = "터치한 값: \(tag)"
        } else {
            self.touchHistoryLabel.text! += "\(tag)"
        }
        
        numberObservable.onNext(tag)
    }
}
