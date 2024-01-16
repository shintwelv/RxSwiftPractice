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
            ]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Transforming Observables"
    }
}
