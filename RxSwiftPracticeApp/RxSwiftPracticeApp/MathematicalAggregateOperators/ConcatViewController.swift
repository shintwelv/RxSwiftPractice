//
//  ConcatViewController.swift
//  RxSwiftPracticeApp
//
//  Created by siheo on 1/24/24.
//

import UIKit
import RxSwift

class ConcatViewController: UIViewController {
    
    private var bag = DisposeBag()
    
    private var numberArr = Array(repeating: true, count: Int.random(in: 1...20)).map { _ in return Int.random(in: 1...100) }
    
    private let alphabet = "abcdefghijklmnopqrstuvwxyz"
    private lazy var alphabetArr = Array(repeating: true, count: Int.random(in: 1...100)).map { _ in
        let index = self.alphabet.index(self.alphabet.startIndex, offsetBy: Int.random(in: 0..<alphabet.count))
        return "\(self.alphabet[index])"
    }
    
    private lazy var numberObservable = {
        return Observable<String>.create { [weak self] observer in
            
            guard let self = self else {
                observer.onCompleted()
                return Disposables.create()
            }
            
            self.numberArr.forEach { observer.onNext("\($0)")}

            observer.onCompleted()
            
            return Disposables.create()
        }
    }()
    
    
    
    private lazy var alphabetObservable = {
        return Observable<String>.create {  [weak self] observer in
            
            guard let self = self else {
                observer.onCompleted()
                return Disposables.create()
            }
            
            self.alphabetArr.forEach { observer.onNext($0) }
            
            observer.onCompleted()
            
            return Disposables.create()
        }
    }()
    
    private var descLabel: UILabel = {
        let label = UILabel()
        label.text = "두 observable이 차례로 나옵니다"
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
        view.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
        return view
    }()
    
    private var contentView: UIView = UIView()
    
    private var numberEmissionHistoryLabel: UILabel = {
        let label = UILabel()
        label.text = "1번 observable 방출 => "
        label.tintColor = .black
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private var alphabetEmissionHistoryLabel: UILabel = {
        let label = UILabel()
        label.text = "2번 observable 방출 => "
        label.tintColor = .black
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "결과 observable 방출 => "
        label.tintColor = .black
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
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
            self.scrollView,
        ].forEach { self.view.addSubview($0) }
        
        self.scrollView.addSubview(self.contentView)
        
        [
            self.numberEmissionHistoryLabel,
            self.alphabetEmissionHistoryLabel,
            self.resultLabel,
        ].forEach { self.contentView.addSubview($0) }
    }
    
    private func configureAutoLayout() {
        [
            self.descLabel,
            self.scrollView,
            
            self.contentView,
            
            self.numberEmissionHistoryLabel,
            self.alphabetEmissionHistoryLabel,
            self.resultLabel,
        ].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            self.descLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15),
            self.descLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            self.descLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            self.scrollView.topAnchor.constraint(equalTo: self.descLabel.bottomAnchor, constant: 15),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.bottomAnchor),
            
            self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
        ])
        
        NSLayoutConstraint.activate([
            self.numberEmissionHistoryLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.numberEmissionHistoryLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.numberEmissionHistoryLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            self.alphabetEmissionHistoryLabel.topAnchor.constraint(equalTo: self.numberEmissionHistoryLabel.bottomAnchor, constant: 10),
            self.alphabetEmissionHistoryLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.alphabetEmissionHistoryLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            self.resultLabel.topAnchor.constraint(equalTo: self.alphabetEmissionHistoryLabel.bottomAnchor, constant: 10),
            self.resultLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.resultLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            self.contentView.bottomAnchor.constraint(equalTo: self.resultLabel.bottomAnchor),
        ])
    }
    
    private func configureDataBinding() {
        numberObservable
            .subscribe(
                onNext: { [weak self] num in
                    guard let self = self else { return }
                    
                    self.numberEmissionHistoryLabel.text = (self.numberEmissionHistoryLabel.text ?? "") + "\(num), "
                }
            )
            .disposed(by: self.bag)
        
        alphabetObservable
            .subscribe(
                onNext: { [weak self] alphabet in
                    guard let self = self else { return }
                    
                    self.alphabetEmissionHistoryLabel.text = (self.alphabetEmissionHistoryLabel.text ?? "") + "\(alphabet), "
                }
            )
            .disposed(by: self.bag)
        
        Observable<String>
            .concat([numberObservable, alphabetObservable])
            .subscribe(
                onNext: { [weak self] str in
                    guard let self = self else { return }
                    
                    self.resultLabel.text = (self.resultLabel.text ?? "") + "\(str), "
                }
            )
            .disposed(by: self.bag)
    }
}
