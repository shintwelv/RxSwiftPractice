//
//  MathematicalAggregateViewController.swift
//  RxSwiftPracticeApp
//
//  Created by siheo on 1/24/24.
//

import UIKit

class MathematicalAggregateViewController: ButtonListViewController {
    
    override var buttons: [(String, Selector)] {
        get {
            [
                ("concat", #selector(routeToConcat)),
                ("reduce", #selector(routeToReduce))
            ]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Math & Agg"
    }
    
    @objc private func routeToConcat() {
        let vc = ConcatViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func routeToReduce() {
        let vc = ReduceViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
