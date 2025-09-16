//
//  ViewController.swift
//  RxSwiftTutorial
//
//  Created by 이병훈 on 9/16/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let label = UILabel()
        label.text = "Hello, SnapKit!"
        label.textAlignment = .center
        
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

