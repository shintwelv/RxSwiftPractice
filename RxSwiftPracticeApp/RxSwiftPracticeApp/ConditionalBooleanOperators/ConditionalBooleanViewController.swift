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
            ]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Cond..."
    }
}
