//
//  ReduceViewController.swift
//  RxSwiftPracticeApp
//
//  Created by siheo on 1/30/24.
//

import UIKit
import RxSwift

class ReduceViewController: UIViewController {
    
    private var bag = DisposeBag()
    
    private var numberArray = Array(repeating: true, count: Int.random(in: 5...20)).map { _ in return Int.random(in: 1...100) }
    private lazy var numberObservable = Observable.from(numberArray)
    
    private var descLabel: UILabel = {
        let label = UILabel()
        label.text = "숫자의 합이 출력됩니다"
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
            self.resultLabel,
        ].forEach { self.contentView.addSubview($0) }
    }
    
    private func configureAutoLayout() {
        [
            self.descLabel,
            self.scrollView,
            
            self.contentView,
            
            self.numberEmissionHistoryLabel,
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
            
            self.resultLabel.topAnchor.constraint(equalTo: self.numberEmissionHistoryLabel.bottomAnchor, constant: 10),
            self.resultLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.resultLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            self.contentView.bottomAnchor.constraint(equalTo: self.resultLabel.bottomAnchor),
        ])
    }
    
    private func configureDataBinding() {
        numberObservable
            .reduce(0) { accum, num in
            return accum + num
        }.subscribe(
            onNext: { sum in
                self.resultLabel.text = "결과 observable 방출 => \(sum)"
            }
        )
        .disposed(by: self.bag)
        
        numberObservable
            .subscribe(
                onNext: { [weak self] num in
                    guard let self = self else { return }
                    
                    self.numberEmissionHistoryLabel.text = (self.numberEmissionHistoryLabel.text ?? "") + "\(num), "
                }
            )
            .disposed(by: self.bag)
    }
}
