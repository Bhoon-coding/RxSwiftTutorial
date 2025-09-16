//
//  ViewController.swift
//  RxSwiftTutorial
//
//  Created by 이병훈 on 9/16/25.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit


class ViewController: UIViewController {
    
    // 4. DisposeBag: 구독을 관리할 가방을 만듭니다.
    let disposeBag = DisposeBag()
    
    let label = UILabel()
    let button = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        // 1. Observable: 버튼 탭 이벤트를 감지하는 Observable
        let buttonTapObservable = self.button.rx.tap
        
        buttonTapObservable
        // 2. Operator: 탭 이벤트를 "버튼 클릭!"이라는 텍스트로 변환(map)합니다.
            .map { "버튼 클릭!" }
        // 3. Subscriber: 변환된 텍스트를 받아서 레이블에 바인딩(구독)합니다.
            .bind(to: label.rx.text)
        // 4. DisposeBag: 구독이 끝났을 때 메모리에서 해제되도록 disposeBag에 추가합니다.
            .disposed(by: disposeBag)
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        self.label.text = "버튼을 눌러주세요."
        label.textAlignment = .center
        
        button.setTitle("클릭", for: .normal)
        
        view.addSubview(label)
        view.addSubview(button)
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        button.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
}
