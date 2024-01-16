//
//  BufferViewController.swift
//  RxSwiftPracticeApp
//
//  Created by siheo on 1/16/24.
//

import UIKit
import RxSwift

class BufferViewController: UIViewController {

    let randomNumber = Int.random(in: 3...5)
    let groupNumber = Int.random(in: 1...10)
    
    private lazy var descLabel: UILabel = {
        let label = UILabel()
        label.text = "\(groupNumber)개의 값 혹은 \(randomNumber)초 동안 입력된 값을 묶습니다"
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
        label.numberOfLines = 0
        label.tintColor = .black
        return label
    }()
    
    private var bag = DisposeBag()
    private var numberObservable = PublishSubject<Int>()
    
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
    }
    
    private func configureAutoLayout() {
        [
            self.descLabel,
            self.buttonStackView,
            self.touchHistoryLabel,
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
            
            self.resultLabel.topAnchor.constraint(equalTo: self.touchHistoryLabel.bottomAnchor, constant: 10),
            self.resultLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            self.resultLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
        ])
    }
    
    private func configureDataBinding() {
        numberObservable
            .buffer(timeSpan: .seconds(randomNumber), count: groupNumber, scheduler: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] numbers in
                    guard let self = self else { return }
                    
                    if self.resultLabel.text == nil {
                        self.resultLabel.text = "\(numbers)\n"
                    } else {
                        self.resultLabel.text! += "\(numbers)\n"
                    }
                }
            )
            .disposed(by: self.bag)
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
