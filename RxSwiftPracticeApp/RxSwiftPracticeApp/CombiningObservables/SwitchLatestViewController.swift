//
//  SwitchLatestViewController.swift
//  RxSwiftPracticeApp
//
//  Created by siheo on 1/18/24.
//

import UIKit
import RxSwift

class SwitchLatestViewController: UIViewController {
    
    private var descLabel: UILabel = {
        let label = UILabel()
        label.text = "출력하기로 설정된 버튼의 결과만 나옵니다"
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
    
    private var redModeButton: UIButton  = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemGray3
        button.tintColor = .systemRed
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.setTitle("레드모드", for: .normal)
        return button
    }()
    
    private var blueModeButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemGray3
        button.tintColor = .systemBlue
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.setTitle("블루모드", for: .normal)
        return button
    }()
    
    private var modeButtonStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.distribution = .fillEqually
        return view
    }()
    
    private var currentModelLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.text = "모드 선택 안됨!!!"
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
    private var source = PublishSubject<Observable<String>>()
    
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
            self.modeButtonStackView,
            self.currentModelLabel,
            self.resultLabel,
        ].forEach { self.view.addSubview($0) }
        
        [
            self.redButton,
            self.blueButton,
        ].forEach { self.buttonStackView.addArrangedSubview($0) }
        
        [
            self.redModeButton,
            self.blueModeButton,
        ].forEach { self.modeButtonStackView.addArrangedSubview($0) }
        
        self.redButton.addTarget(self, action: #selector(redButtonTapped), for: .touchUpInside)
        self.blueButton.addTarget(self, action: #selector(blueButtonTapped), for: .touchUpInside)
        
        self.redModeButton.addTarget(self, action: #selector(redModeButtonTapped), for: .touchUpInside)
        self.blueModeButton.addTarget(self, action: #selector(blueModeButtonTapped), for: .touchUpInside)
    }
    
    private func configureAutoLayout() {
        [
            self.descLabel,
            self.buttonStackView,
            self.modeButtonStackView,
            self.currentModelLabel,
            self.resultLabel,
            self.redButton,
            self.blueButton,
            self.redModeButton,
            self.blueModeButton,
        ].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            self.descLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15),
            self.descLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            self.descLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            self.buttonStackView.topAnchor.constraint(equalTo: self.descLabel.bottomAnchor, constant: 15),
            self.buttonStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            self.buttonStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            self.buttonStackView.heightAnchor.constraint(equalToConstant: 60),
            
            self.modeButtonStackView.topAnchor.constraint(equalTo: self.buttonStackView.bottomAnchor, constant: 10),
            self.modeButtonStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            self.modeButtonStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            self.modeButtonStackView.heightAnchor.constraint(equalToConstant: 60),
            
            self.currentModelLabel.topAnchor.constraint(equalTo: self.modeButtonStackView.bottomAnchor, constant: 10),
            self.currentModelLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            self.currentModelLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            self.resultLabel.topAnchor.constraint(equalTo: self.currentModelLabel.bottomAnchor, constant: 10),
            self.resultLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            self.resultLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
        ])
    }
    
    private func configureDataBinding() {
        source
            .switchLatest()
            .subscribe(
                onNext: { [weak self] buttonStr in
                    guard let self = self else { return }
                    
                    if self.resultLabel.text == nil {
                        self.resultLabel.text = "\(buttonStr), "
                    } else {
                        self.resultLabel.text! += "\(buttonStr), "
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
    
    @objc private func redModeButtonTapped(_ button: UIButton) {
        self.currentModelLabel.text = "현재 모드 = 레드"
        
        self.source.onNext(self.redButtonObservable)
    }
    
    @objc private func blueModeButtonTapped(_ button: UIButton) {
        self.currentModelLabel.text = "현재 모드 = 블루"
        
        self.source.onNext(self.blueButtonObservable)
    }
    
}
