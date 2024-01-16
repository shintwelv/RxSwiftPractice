//
//  FlatMapViewController.swift
//  RxSwiftPracticeApp
//
//  Created by siheo on 1/16/24.
//

import UIKit
import RxSwift

class FlatMapViewController: UIViewController {

    private var descLabel: UILabel = {
        let label = UILabel()
        label.text = "숫자값과 알파벳 값을 조합합니다"
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 1
        label.textColor = .black
        return label
    }()
    
    private var numbereButtonStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 10
        return view
    }()
    
    private var alphabetButtonStackView: UIStackView = {
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
    
    private var buttonA: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("A", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.backgroundColor = .systemBlue
        button.tag = 1001
        return button
    }()
    
    private var buttonB: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("B", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.backgroundColor = .systemBlue
        button.tag = 1002
        return button
    }()
    
    private var numberButtonTouchHistoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.text = "터치한 값 = "
        label.numberOfLines = 0
        label.tintColor = .black
        return label
    }()
    
    private var alphabetButtonTouchHistoryLabel: UILabel = {
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
        label.numberOfLines = 0
        label.tintColor = .black
        return label
    }()
    
    private var bag = DisposeBag()
    private var numberObservable = PublishSubject<Int>()
    private var alphabetObservable = PublishSubject<String>()
    
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
            self.numbereButtonStackView,
            self.alphabetButtonStackView,
            self.numberButtonTouchHistoryLabel,
            self.alphabetButtonTouchHistoryLabel,
            self.resultLabel,
        ].forEach { self.view.addSubview($0) }
        
        [
            self.button1,
            self.button2,
            self.button3,
            self.button4,
        ].forEach {
            $0.addTarget(self, action: #selector(numberButtonTapped), for: .touchUpInside)
            self.numbereButtonStackView.addArrangedSubview($0)
        }
        
        [
            self.buttonA,
            self.buttonB,
        ].forEach {
            $0.addTarget(self, action: #selector(alphabetButtonTapped), for: .touchUpInside)
            self.alphabetButtonStackView.addArrangedSubview($0)
        }
    }
    
    private func configureAutoLayout() {
        [
            self.descLabel,
            self.numbereButtonStackView,
            self.alphabetButtonStackView,
            self.numberButtonTouchHistoryLabel,
            self.alphabetButtonTouchHistoryLabel,
            self.resultLabel,
            
            self.button1,
            self.button2,
            self.button3,
            self.button4,
            
            self.buttonA,
            self.buttonB,
        ].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            self.descLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15),
            self.descLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            self.descLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            self.descLabel.heightAnchor.constraint(equalToConstant: 30),
            
            self.numbereButtonStackView.topAnchor.constraint(equalTo: self.descLabel.bottomAnchor, constant: 15),
            self.numbereButtonStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            self.numbereButtonStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            self.numbereButtonStackView.heightAnchor.constraint(equalToConstant: 60),
            
            self.numberButtonTouchHistoryLabel.topAnchor.constraint(equalTo: self.numbereButtonStackView.bottomAnchor, constant: 10),
            self.numberButtonTouchHistoryLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            self.numberButtonTouchHistoryLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),

            self.alphabetButtonStackView.topAnchor.constraint(equalTo: self.numberButtonTouchHistoryLabel.bottomAnchor, constant: 15),
            self.alphabetButtonStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            self.alphabetButtonStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            self.alphabetButtonStackView.heightAnchor.constraint(equalToConstant: 60),
            
            self.alphabetButtonTouchHistoryLabel.topAnchor.constraint(equalTo: self.alphabetButtonStackView.bottomAnchor, constant: 10),
            self.alphabetButtonTouchHistoryLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            self.alphabetButtonTouchHistoryLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            self.resultLabel.topAnchor.constraint(equalTo: self.alphabetButtonTouchHistoryLabel.bottomAnchor, constant: 10),
            self.resultLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            self.resultLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
        ])
    }
    
    private func configureDataBinding() {
        numberObservable
            .flatMap{ [weak self] (number: Int) -> Observable<String> in
                guard let self = self else {
                    return Observable<String>.create { observer in
                        observer.onNext("\(number)")
                        observer.onCompleted()
                        
                        return Disposables.create()
                    }
                }
                return self.alphabetObservable.map { "\($0)\(number)" }
            }
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
    
    @objc private func alphabetButtonTapped(_ button: UIButton) {
        let tag = button.tag
        
        
        switch tag {
        case 1001:
            if self.alphabetButtonTouchHistoryLabel.text == nil {
                self.alphabetButtonTouchHistoryLabel.text = "터치한 값: A"
            } else {
                self.alphabetButtonTouchHistoryLabel.text! += "A"
            }
            
            alphabetObservable.onNext("A")
        case 1002:
            if self.alphabetButtonTouchHistoryLabel.text == nil {
                self.alphabetButtonTouchHistoryLabel.text = "터치한 값: B"
            } else {
                self.alphabetButtonTouchHistoryLabel.text! += "B"
            }
            
            alphabetObservable.onNext("B")
        default: break
        }
    }
    
    @objc private func numberButtonTapped(_ button: UIButton) {
        let tag = button.tag
        
        if self.numberButtonTouchHistoryLabel.text == nil {
            self.numberButtonTouchHistoryLabel.text = "터치한 값: \(tag)"
        } else {
            self.numberButtonTouchHistoryLabel.text! += "\(tag)"
        }
        
        numberObservable.onNext(tag)
    }
}
