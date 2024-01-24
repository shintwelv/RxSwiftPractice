//
//  CombineLatestViewController.swift
//  RxSwiftPracticeApp
//
//  Created by siheo on 1/24/24.
//

import UIKit
import RxSwift

class CombineLatestViewController: UIViewController {
    
    private var descLabel: UILabel = {
        let label = UILabel()
        label.text = "버튼 터치시 다른 버튼 그룹의 마지막 터치 값과 같이 나옵니다"
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
    
    private var colorButtonHistoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.text = "색 버튼 이력 = "
        label.numberOfLines = 0
        label.tintColor = .black
        return label
    }()
    
    private var number1Button: UIButton  = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemGray3
        button.tintColor = .black
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.setTitle("1", for: .normal)
        button.tag = 1
        return button
    }()
    
    private var number2Button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemGray3
        button.tintColor = .black
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.setTitle("2", for: .normal)
        button.tag = 2
        return button
    }()
    
    private var number3Button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemGray3
        button.tintColor = .black
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.setTitle("3", for: .normal)
        button.tag = 3
        return button
    }()
    
    private var numberButtonStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.distribution = .fillEqually
        return view
    }()
    
    private var numberButtonHistoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.text = "숫자 버튼 이력 = "
        label.numberOfLines = 0
        label.tintColor = .black
        return label
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
    private var numberButtonObservable = PublishSubject<String>()
    
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
            self.colorButtonHistoryLabel,
            self.numberButtonStackView,
            self.numberButtonHistoryLabel,
            self.resultLabel,
        ].forEach { self.view.addSubview($0) }
        
        [
            self.redButton,
            self.blueButton,
        ].forEach { self.colorButtonStackView.addArrangedSubview($0) }
        
        [
            self.number1Button,
            self.number2Button,
            self.number3Button,
        ].forEach {
            $0.addTarget(self, action: #selector(numberButtonTapped), for: .touchUpInside)
            self.numberButtonStackView.addArrangedSubview($0)
        }
        
        self.redButton.addTarget(self, action: #selector(redButtonTapped), for: .touchUpInside)
        self.blueButton.addTarget(self, action: #selector(blueButtonTapped), for: .touchUpInside)
    }
    
    private func configureAutoLayout() {
        [
            self.descLabel,
            self.colorButtonStackView,
            self.colorButtonHistoryLabel,
            self.numberButtonStackView,
            self.numberButtonHistoryLabel,
            self.resultLabel,
            self.redButton,
            self.blueButton,
            self.number1Button,
            self.number2Button,
        ].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            self.descLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15),
            self.descLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            self.descLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            self.colorButtonStackView.topAnchor.constraint(equalTo: self.descLabel.bottomAnchor, constant: 15),
            self.colorButtonStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            self.colorButtonStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            self.colorButtonStackView.heightAnchor.constraint(equalToConstant: 60),
            
            self.colorButtonHistoryLabel.topAnchor.constraint(equalTo: self.colorButtonStackView.bottomAnchor, constant: 10),
            self.colorButtonHistoryLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            self.colorButtonHistoryLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            self.numberButtonStackView.topAnchor.constraint(equalTo: self.colorButtonHistoryLabel.bottomAnchor, constant: 10),
            self.numberButtonStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            self.numberButtonStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            self.numberButtonStackView.heightAnchor.constraint(equalToConstant: 60),
            
            self.numberButtonHistoryLabel.topAnchor.constraint(equalTo: self.numberButtonStackView.bottomAnchor, constant: 10),
            self.numberButtonHistoryLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            self.numberButtonHistoryLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            self.resultLabel.topAnchor.constraint(equalTo: self.numberButtonHistoryLabel.bottomAnchor, constant: 10),
            self.resultLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            self.resultLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
        ])
    }
    
    private func configureDataBinding() {
        Observable
            .combineLatest(colorButtonObservable, numberButtonObservable, resultSelector: { colorButtonValue, numberButtonValue in
                return ("(\(colorButtonValue) & \(numberButtonValue))")
            })
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
        if self.colorButtonHistoryLabel.text == nil {
            self.colorButtonHistoryLabel.text = "RED, "
        } else {
            self.colorButtonHistoryLabel.text! += "RED, "
        }
        
        self.colorButtonObservable.onNext("RED")
    }
    
    @objc private func blueButtonTapped(_ button: UIButton) {
        if self.colorButtonHistoryLabel.text == nil {
            self.colorButtonHistoryLabel.text = "BLUE, "
        } else {
            self.colorButtonHistoryLabel.text! += "BLUE, "
        }
        
        self.colorButtonObservable.onNext("BLUE")
    }
    
    @objc private func numberButtonTapped(_ button: UIButton) {
        if self.numberButtonHistoryLabel.text == nil {
            self.numberButtonHistoryLabel.text = "\(button.tag), "
        } else {
            self.numberButtonHistoryLabel.text! += "\(button.tag), "
        }
        
        self.numberButtonObservable.onNext("\(button.tag)")
    }
}
