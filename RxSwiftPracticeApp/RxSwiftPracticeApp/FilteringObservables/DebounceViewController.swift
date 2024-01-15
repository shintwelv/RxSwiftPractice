//
//  DebounceViewController.swift
//  RxSwiftPracticeApp
//
//  Created by siheo on 1/15/24.
//

import UIKit
import RxSwift

class DebounceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureAutoLayout()
        configureDataBinding()
        
        self.navigationItem.title = "debounce"
    }
    
    private var searchKeywordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "검색어를 입력하세요"
        tf.textColor = .black
        tf.font = .systemFont(ofSize: 16)
        return tf
    }()
    
    private var resultLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private var bag = DisposeBag()
    private var searchKeywordObservable: PublishSubject<String> = PublishSubject()
    
    private func configureUI() {
        self.view.backgroundColor = .white
        
        [
            self.searchKeywordTextField,
            self.resultLabel,
        ].forEach {
            self.view.addSubview($0)
        }
        
        self.searchKeywordTextField.delegate = self
    }
    
    private func configureAutoLayout() {
        [
            self.searchKeywordTextField,
            self.resultLabel,
        ].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            self.searchKeywordTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.searchKeywordTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            self.searchKeywordTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            self.searchKeywordTextField.heightAnchor.constraint(equalToConstant: 24),
            
            self.resultLabel.topAnchor.constraint(equalTo: self.searchKeywordTextField.bottomAnchor, constant: 10),
            self.resultLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            self.resultLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            self.resultLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    private func configureDataBinding() {
        searchKeywordObservable
            .debounce(.milliseconds(200), scheduler: MainScheduler.asyncInstance)
            .subscribe(
                onNext: { [weak self] keyword in
                    guard let self = self else { return }
                    self.resultLabel.text = "서버에 전송될 검색어는 \"\(keyword)\"입니다"
                }
            )
            .disposed(by: self.bag)
    }
}

extension DebounceViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.searchKeywordObservable.onNext(textField.text ?? "")
    }
    
}
