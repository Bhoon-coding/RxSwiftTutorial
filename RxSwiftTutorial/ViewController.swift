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
    
    let disposeBag = DisposeBag()
    
    let allNames = BehaviorRelay<[String]>(value: [
        "김철수", "이영희", "박민준", "최지우", "정수빈",
        "강현우", "조은지", "윤도현", "임서연", "한지훈",
        "안유진", "오세훈", "배현진", "신짱구", "유리"
    ])
    
    // UI
    let searchBar: UISearchBar = .init()
    let tableView: UITableView = .init()
    
    // LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.bind()
    }
    
    private func setupUI() {
        self.view.backgroundColor = .white
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.view.addSubview(self.searchBar)
        self.view.addSubview(self.tableView)
        
        self.searchBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        self.tableView.snp.makeConstraints {
            $0.top.equalTo(self.searchBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func bind() {
        let searchTextObservable: Observable = self.searchBar.rx.text.orEmpty
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
        
        let filteredNamesObservable: Observable = .combineLatest(
            self.allNames,
            searchTextObservable) { allNames, searchText -> [String] in
                if searchText.isEmpty {
                    return allNames
                }
                return allNames.filter { $0.contains(searchText) }
            }
        
        filteredNamesObservable
            .bind(to: self.tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { row, name, cell in
                cell.textLabel?.text = name
            }
            .disposed(by: self.disposeBag)
    }
}
