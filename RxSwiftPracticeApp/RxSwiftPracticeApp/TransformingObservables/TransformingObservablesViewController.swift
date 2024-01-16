//
//  TransformingObservablesViewController.swift
//  RxSwiftPracticeApp
//
//  Created by siheo on 1/16/24.
//

import UIKit

class TransformingObservablesViewController: ButtonListViewController {
    
    override var buttons: [(String, Selector)] {
        get {
            [
                ("Buffer", #selector(routeToBuffer))
            ]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Transforming Observables"
    }
    
    @objc private func routeToBuffer(_ button: UIButton) {
        let vc = BufferViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
