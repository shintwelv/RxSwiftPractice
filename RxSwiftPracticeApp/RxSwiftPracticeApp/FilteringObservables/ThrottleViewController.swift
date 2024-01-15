//
//  ThrottleViewController.swift
//  RxSwiftPracticeApp
//
//  Created by siheo on 1/15/24.
//

import UIKit
import RxSwift

class ThrottleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureAutoLayout()
        configureDataBinding()

        self.navigationItem.title = "Throttle"
    }
    
    private var sampleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("연타하세요", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    private var resultLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    private var buttonPressedCount: Int = 0
    
    private var bag = DisposeBag()
    private var buttonPressedObservable = PublishSubject<Void>()
    
    private func configureUI() {
        self.view.backgroundColor = .white
        
        [
            self.sampleButton,
            self.resultLabel,
        ].forEach { self.view.addSubview($0) }
        
        self.resultLabel.text = "버튼 터치 인정 횟수 = \(buttonPressedCount)"
        
        self.sampleButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    private func configureAutoLayout() {
        [
            self.sampleButton,
            self.resultLabel,
        ].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            self.sampleButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.sampleButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            self.sampleButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            self.sampleButton.heightAnchor.constraint(equalToConstant: 60),
            
            self.resultLabel.topAnchor.constraint(equalTo: self.sampleButton.bottomAnchor, constant: 10),
            self.resultLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            self.resultLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            self.resultLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    private func configureDataBinding() {
        buttonPressedObservable
            .throttle(.milliseconds(500), scheduler: MainScheduler.asyncInstance)
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }
                    
                    self.buttonPressedCount += 1
                    self.resultLabel.text = "버튼 터치 인정 횟수 = \(buttonPressedCount)"
                }
            ).disposed(by: self.bag)
    }
    
    @objc private func buttonPressed(_ button: UIButton) {
        buttonPressedObservable.onNext(())
    }
}
