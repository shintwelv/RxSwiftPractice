//
//  ConditionalBooleanViewController.swift
//  RxSwiftPracticeApp
//
//  Created by siheo on 1/24/24.
//

import UIKit

class ConditionalBooleanViewController: ButtonListViewController {
    
    override var buttons: [(String, Selector)] {
        get {
            [
                ("amb", #selector(routeToAmb)),
                ("skipWhile", #selector(routeToSkipWhile)),
                ("skipUntil", #selector(routeToSkipUntil)),
                ("takeWhile", #selector(routeToTakeWhile)),
                ("takeUntil", #selector(routeToTakeUntil)),
            ]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Cond..."
    }
    
    @objc private func routeToAmb() {
        let vc = AmbViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func routeToSkipWhile() {
        let vc = SkipWhileViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func routeToSkipUntil() {
        let vc = SkipUntilViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func routeToTakeWhile() {
        let vc = TakeWhileViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func routeToTakeUntil() {
        let vc = TakeUntilViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
