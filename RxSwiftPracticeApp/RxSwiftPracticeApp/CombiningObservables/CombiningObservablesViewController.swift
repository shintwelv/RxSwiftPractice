//
//  CombiningObservablesViewController.swift
//  RxSwiftPracticeApp
//
//  Created by siheo on 1/16/24.
//

import UIKit

class CombiningObservablesViewController: ButtonListViewController {
    
    override var buttons: [(String, Selector)] {
        get {
            [
                ("Merge", #selector(routeToMerge)),
            ]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Combining Observables"
    }
    
    @objc private func routeToMerge(_ button: UIButton) {
        let vc = MergeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
